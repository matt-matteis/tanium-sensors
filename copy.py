def create_ip_info_artifact(action=None, success=None, container=None, results=None, handle=None, filtered_artifacts=None, filtered_results=None):
    import json
    import requests

    # Used for testiing - remove this hardcoded auth key and store elsewhere
    AUTH_TOKEN = ''
    PH_SERVER = '10.255.2.66'

    def write_to_phantom(server, token, artifact):

        url = 'https://{}/rest/artifact'.format(server)
        headers = { 'ph-auth-token': token}
        data = json.dumps(artifact)
        r = requests.post(url, data=data, headers=headers, verify=False)

        if (r is None or r.status_code != 200):
            if r is None:
                print('error adding artifact')
            else:
                print('error {} {}'.format(r.status_code,json.loads(r.text)['message']))

            return False

        return r.json().get('id')

    phantom.debug('create_ip_info_artifact() called')
    whois_params = [
        'whois_info:action_result.data.*.nets.*.address',
        'whois_info:action_result.data.*.nets.*.city',
        'whois_info:action_result.data.*.nets.*.state',
        'whois_info:action_result.data.*.nets.*.postal_code',
        'whois_info:action_result.data.*.nets.*.country',
        'whois_info:action_result.data.*.nets.*.name',
        'whois_info:action_result.data.*.nets.*.cidr'
    ]

    ip_params = ['destination_ip_rep:action_result.summary.total_count']

    whois_info = phantom.collect2(container=container, datapath=whois_params, action_results=results)[0]

    ip_rep_info = phantom.collect2(container=container, datapath=ip_params, action_results=results)[0][0]

    whois_return = {
        'address': whois_info[0],
        'city': whois_info[1],
        'state': whois_info[2],
        'postal_code': whois_info[3],
        'country': whois_info[4],
        'name': whois_info[5],
        'cidr': whois_info[6]
    }

    cef = {}
    cef['reputation_score'] = ip_rep_info
    cef['whois_info'] = whois_return

    artifact = {}
    artifact['container_id'] = container['id']
    artifact['run_automation'] = False
    artifact['cef'] = cef
    artifact['name'] = 'IP Reputation Information'
    artifact['label'] = 'event'
    artifact['source_data_identifier'] = '100000'

    phantom.debug(artifact)
    artifact_id = write_to_phantom(PH_SERVER, AUTH_TOKEN, artifact)
    phantom.debug(artifact_id)
    return

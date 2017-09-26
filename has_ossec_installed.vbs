Function ReadFileText (sFile)
    Dim objFSO 'As FileSystemObject
    dim oTS
    dim sText
   
    Set objFSO = CreateObject("Scripting.FileSystemObject")

    Set oTS = objFSO.OpenTextFile(sFile)
    sText = oTS.ReadAll

    oTS.close
    set oTS = nothing
    Set objFSO = nothing
 
    ReadFileText = sText
    
end Function 

Dim FSO
Set FSO = CreateObject("Scripting.FileSystemObject")

if FSO.FileExists("C:\Program Files\ossec-agent\VERSION.txt") Or FSO.FileExists("C:\Program Files (x86)\ossec-agent\VERSION.txt") Then
    Wscript.Echo "Installed"
Else
    Wscript.Echo "Not Installed"
End If
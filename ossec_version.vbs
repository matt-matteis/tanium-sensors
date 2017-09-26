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

if FSO.FileExists("C:\Program Files\ossec-agent\VERSION.txt") Then
    ossecVersion = ReadFileText("C:\Program Files\ossec-agent\VERSION.txt")
    Dim cleanVersion
    cleanVersion=Split(ossecVersion," ")(2)
    cleanVersion=Right(cleanVersion,LEN(cleanVersion)-1)
    Wscript.Echo cleanVersion
Else
    ossecVersion86 = ReadFileText("C:\Program Files (x86)\ossec-agent\VERSION.txt")
    Dim cleanVersion86
    cleanVersion86=Split(ossecVersion86," ")(2)
    cleanVersion86=Right(cleanVersion86,LEN(cleanVersion86)-1)
    Wscript.Echo cleanVersion86
End If
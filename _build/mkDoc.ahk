#Include %A_ScriptDir%\..\lib\PathAPI.ahk  ; Where to get version to be used within documentation
#include %A_ScriptDir%\lib\BuildTools.ahk

DocuUpdateVersion(release_version())
DocuGenerate()

ExitApp
#include %A_ScriptDir%\..\..\lib\PathAPI.ahk
#Warn All

OutputDebug "DBGVIEWCLEAR"

; -----------------------------------------------------
strRef := "C:\tmp\test.txt"

OutputDebug "**********************************************************************"
OutputDebug "****** Testing functional interface **********************************"
OutputDebug "**********************************************************************"
strResult := PathCanonicalize("C:/tmp/..\test/../tmp/test.txt")
assert(StrCompare(strResult,strRef) = 0, "Funtional interface <PathCanonicalize> (Result <" strResult "> <=> Reference <" strRef ">)")

strResult := PathCombine("C:\tmp", "test.txt")
assert(StrCompare(strResult,strRef) = 0, "Functional interface <PathCombine> (Result <" strResult "> <=> Reference <" strRef ">)")

res := PathIsDirectory("C:\Program Files")
assert(res = FILE_ATTRIBUTE.DIRECTORY , "Functional interface <PathIsDirectory> (Input <C:\Program Files>)")
res := PathIsDirectory("C:\X1234")
assert(res != FILE_ATTRIBUTE.DIRECTORY, "Functional interface <PathIsDirectory> (Input <C:\X1234>)")

return

assert(test_ok, message) {
	static n_assert := 0
	n_assert++
	str := "SUCCESS"
	If (test_ok != 1)
		str := "FAIL"

	OutputDebug ("(" n_assert ") " str " - " message) 
}

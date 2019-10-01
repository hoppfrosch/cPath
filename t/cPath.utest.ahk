#include %A_ScriptDir%\..\lib\cPath.ahk
#Warn All

OutputDebug "DBGVIEWCLEAR"

OutputDebug "**********************************************************************"
OutputDebug "****** Testing class interface ***************************************"
OutputDebug "**********************************************************************"

; -----------------------------------------------------
strRef := "C:\tmp\test.txt"

strResult := path("C:/tmp/..\test", "../tmp", "test.txt").canonpath
assert(StrCompare(strResult,strRef) = 0, "Property <canonpath> using function constructor (Result <" strResult "> <=> Reference <" strRef ">)")

strResult := Path.new("C:/tmp/..\test", "../tmp", "test.txt").canonpath
assert(StrCompare(strResult,strRef) = 0, "Property <canonpath> using class constructor (Result <" strResult "> <=> Reference <" strRef ">)")

return

assert(test_ok, message) {
	static n_assert := 0
	n_assert++
	str := "SUCCESS"
	If (test_ok != 1)
		str := "FAIL"

	OutputDebug ("(" n_assert ") " str " - " message) 
}
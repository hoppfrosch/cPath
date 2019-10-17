#include %A_ScriptDir%\..\lib\cPath.ahk
#Warn All

global n_assert_fail := 0
global n_assert_success := 0
global n_assert := 0

OutputDebug "DBGVIEWCLEAR"

OutputDebug "*********************************************************************************************************"
OutputDebug "****** Testing class interface **************************************************************************"
OutputDebug "*********************************************************************************************************"

; /* -------------------------- path(args).canonpath -------------------------- */
data := Array()
data.push Map("arg1", "C:/tmp/..\test", "arg2", "../tmp", "arg3", "test.txt", "expected", "C:\tmp\test.txt")

Loop data.Length {
	res := path(data[A_Index]["arg1"], data[A_Index]["arg2"], data[A_Index]["arg3"]).canonpath
	assert(StrCompare(res,data[A_Index]["expected"]) = 0, "path('" data[A_Index]["arg1"] "', '" data[A_Index]["arg2"] "', '" data[A_Index]["arg3"] "').canonpath -> " res)
}

; /* ------------------------ path.new(args).canonpath ------------------------ */
data.push Map("arg1", "C:/tmp/..\test", "arg2", "../tmp", "arg3", "test.txtx", "expected", "C:\tmp\test.txt")

Loop data.Length {
	res := path.new(data[A_Index]["arg1"], data[A_Index]["arg2"], data[A_Index]["arg3"]).canonpath
	assert(StrCompare(res,data[A_Index]["expected"]) = 0, "path.new('" data[A_Index]["arg1"] "', '" data[A_Index]["arg2"] "', '" data[A_Index]["arg3"] "').canonpath -> " res)
}
; -------------------------------------------------------------------------- 
;                                   Summary                                 
; -------------------------------------------------------------------------- 
OutputDebug "*********************************************************************************************************"
OutputDebug "*** UnitTest-Summary: " n_assert " overall - " n_assert_fail " fail - " n_assert_success " pass *********"
OutputDebug "*********************************************************************************************************"
return

assert(test_ok, message) {
	global 
	n_assert++
	str := "PASS"
	If (test_ok != 1) {
		str := "FAIL"
		n_assert_fail++
	}
	else {
		n_assert_success++
	}

	OutputDebug ("(" n_assert ") " str " - " message) 
}
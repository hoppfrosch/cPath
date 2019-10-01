#include %A_ScriptDir%\..\lib\PathAPI.ahk
#Warn All

OutputDebug "DBGVIEWCLEAR"

; -----------------------------------------------------
expected := "C:\tmp\test.txt"

OutputDebug "**********************************************************************"
OutputDebug "****** Testing functional interface **********************************"
OutputDebug "**********************************************************************"

; ---------------------------- PathCanonicalize ---------------------------- 
strResult := PathCanonicalize("C:/tmp/..\test/../tmp/test.txt")
assert(StrCompare(strResult,expected) = 0, "<PathCanonicalize> (Result <" strResult "> <=> Expected <" expected ">)")

; ------------------------------- PathCombine ------------------------------
strResult := PathCombine("C:\tmp", "test.txt")
assert(StrCompare(strResult,expected) = 0, "<PathCombine> (Result <" strResult "> <=> Expected <" expected ">)")

; ----------------------------- PathFileExists -----------------------------
res := PathFileExists("c:\Windows\regedit.exe")
assert(res = 1, "<PathFileExists> (Input <c:\Windows\regedit.exe)")
res := PathFileExists("c:\Windows\XXregedit.exeXX")
assert(res = 0, "<PathFileExists> (Input <c:\Windows\XXregeditXX.exe)")

; ----------------------------- PathIsDirectory ----------------------------
res := PathIsDirectory("C:\Program Files")
assert(res = FILE_ATTRIBUTE.DIRECTORY , "<PathIsDirectory> (Input <C:\Program Files>)")
res := PathIsDirectory("C:\X1234")
assert(res != FILE_ATTRIBUTE.DIRECTORY, "<PathIsDirectory> (Input <C:\X1234>)")

; --------------------------- PathRelativePathTo ---------------------------
expected := "..\temp3\temp4"
strResult := PathRelativePathTo("C:\Temp1\Temp2",FILE_ATTRIBUTE.DIRECTORY,"C:\Temp1\Temp3\Temp4",FILE_ATTRIBUTE.DIRECTORY) 
assert(StrCompare(strResult,expected) = 0, "<PathRelativePathTo> (Result <" strResult "> <=> Expected <" expected ">)")

return

assert(test_ok, message) {
	static n_assert := 0
	n_assert++
	str := "SUCCESS"
	If (test_ok != 1)
		str := "FAIL"

	OutputDebug ("(" n_assert ") " str " - " message) 
}

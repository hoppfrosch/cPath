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
data := Map()
data["C:\Program Files"] := FILE_ATTRIBUTE.DIRECTORY
data["C:\X1234"] := 0

for test, expected in data {
	res := PathIsDirectory(test)
	assert(res = expected, "PathIsDirectory('" test "') -> " res)
}

; ----------------------------- PathIsFileSpec -----------------------------
data := Map()
data["sample"] := 1
data["C:\TEST\sample"] := 0

for test, expected in data {
	res := PathIsFileSpec(test)
	assert(res = expected, "PathIsFileSpec('" test "') -> " res)
}

; --------------------------- PathIsSystemFolder ---------------------------
data := Map()
data["c:\Windows\assembly\"] := 1
data["c:\temp\"] := 0
data["C:"] := 0

for test, expected in data {
	res := PathIsSystemFolder(test)
	assert(res = expected, "PathIsSystemFolder('" test "') -> " res)
} 

; ------------------------------- PathIsUNC --------------------------------
data := Map()
data["\\path1\path2"] := 1
data["\\path1"] := 1
data["acme\path4\path5"] := 0
data["\\"] := 1
data["\\?\UNC\path1\path2"] := 1
data["\\?\UNC\path1"] := 1
data["\\?\UNC\"] := 1
data["\path1"] := 0
data["path1"] := 0
data["c:\path1"] := 0
data["\\?\c:\path1"] := 0

for test, expected in data {
	res := PathIsUNC(test)
	assert(res = expected, "PathIsUNC('" test "') -> " res)
} 

; ------------------------------- PathIsUNCServer --------------------------
data := Map()
data["\\path1"] := 1
data["\\"] := 1
data["acme\path4\path5"] := 0

for test, expected in data {
	res := PathIsUNCServer(test)
	assert(res = expected, "PathIsUNCServer('" test "') -> " res)
} 

; ------------------------------- PathIsUNCServerShare ---------------------
data := Map()
data["\\path1\path2"] := 1
data["\\path3"] := 0
data["acme\path4\path5"] := 0

for test, expected in data {
	res := PathIsUNCServerShare(test)
	assert(res = expected, "PathIsUNCServerShare('" test "') -> " res)
} 

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

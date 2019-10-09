#include %A_ScriptDir%\..\lib\PathAPI.ahk
#Warn All

global n_assert_fail := 0
global n_assert_success := 0
global n_assert := 0

OutputDebug "DBGVIEWCLEAR"

OutputDebug "**********************************************************************"
OutputDebug "****** Testing functional interface **********************************"
OutputDebug "**********************************************************************"

; /* ---------------------------- PathAddBackslash ---------------------------- */
data := Map()
data["C:\dir_name\dir_name\file_name"] := "C:\dir_name\dir_name\file_name\"
data["C:\dir_name\dir_name\file_name\"] := "C:\dir_name\dir_name\file_name\"

for test, expected in data {
	res := PathAddBackslash(test)
	assert(StrCompare(res,expected) = 0, "PathAddBackslash('" test "') -> " res)
}

; /* ---------------------------- PathAppend ---------------------------- */
data := Array()
data.push Map("arg1", "name_1\name_2", "arg2", "name3", "expected", "name_1\name_2\name3")
data.push Map("arg1", "..\name_1\name_2", "arg2", "name3", "expected", "name_1\name_2\name3")

Loop data.Length {
	res := PathAppend(data[A_Index]["arg1"], data[A_Index]["arg2"])
	assert(StrCompare(res,data[A_Index]["expected"]) = 0, "PathAppend('" data[A_Index]["arg1"] "', '" data[A_Index]["arg2"] "') -> " res)
}
; ---------------------------- PathCanonicalize ---------------------------- 
expected := "C:\tmp\test.txt"
strResult := PathCanonicalize("C:/tmp/..\test/../tmp/test.txt")
assert(StrCompare(strResult,expected) = 0, "<PathCanonicalize> (Result <" strResult "> <=> Expected <" expected ">)")

; ------------------------------- PathCombine ------------------------------
expected := "C:\tmp\test.txt"
strResult := PathCombine("C:\tmp", "test.txt")
assert(StrCompare(strResult,expected) = 0, "<PathCombine> (Result <" strResult "> <=> Expected <" expected ">)")

; ----------------------------- PathFileExists -----------------------------
data := Map()
data["c:\Windows\regedit.exe"] := 1
data["c:\Windows\MyFantasy.exe"] := 0

for test, expected in data {
	res := PathFileExists(test)
	assert(res = expected, "PathFileExists('" test "') -> " res)
}

; ----------------------------- PathIsDirectory ----------------------------
data := Map()
data["C:\Program Files"] := FILE_ATTRIBUTE.DIRECTORY
data["C:\X1234"] := 0

for test, expected in data {
	res := PathIsDirectory(test)
	assert(res = expected, "PathIsDirectory('" test "') -> " res)
}

;/* -------------------------- PathIsDirectoryEmpty -------------------------- */
data := Map()
data["C:\Program Files"] := 0

for test, expected in data {
	res := PathIsDirectoryEmpty(test)
	assert(res = expected, "PathIsDirectoryEmpty('" test "') -> " res)
}

; ----------------------------- PathIsFileSpec -----------------------------
data := Map()
data["sample"] := 1
data["C:\TEST\sample"] := 0

for test, expected in data {
	res := PathIsFileSpec(test)
	assert(res = expected, "PathIsFileSpec('" test "') -> " res)
}

;/* ---------------------------- PathIsNetworkPath --------------------------- */
data := Map()
data["C:\"] := 0
data["X:\"] := 0
data["\\test\"] := 1

for test, expected in data {
	res := PathIsNetworkPath(test)
	assert(res = expected, "PathIsNetworkPath('" test "') -> " res)
}

; ------------------------------ PathIsPrefix ------------------------------ 
arg1 := "C:\"
arg2 := "C:\test\Some\sample"
expected := 1
res := PathIsPrefix(arg1, arg2)
assert(res = expected, "PathIsPrefix('" arg1 "', '" arg2 "') -> " res)

arg2 := "sample"
expected := 0
res := PathIsPrefix(arg1, arg2)
assert(res = expected, "PathIsPrefix('" arg1 "', '" arg2 "') -> " res)

;/* ----------------------------- PathIsRelative ----------------------------- */
data := Map()
data["test.exe"] := 1
data["C:\test.exe"] := 0
data[".\test.exe"] := 1
data["..\test.exe"] := 1
data["\\test\test.exe"] := 0

for test, expected in data {
	res := PathIsRelative(test)
	assert(res = expected, "PathIsRelative('" test "') -> " res)
} 

;/* ------------------------------- PathIsRoot ------------------------------- */
data := Map()
data["C:\"] := 1
data["\\test\"] := 0
data["\\test\path"] := 1
data["..\test.exe"] := 0

for test, expected in data {
	res := PathIsRoot(test)
	assert(res = expected, "PathIsRoot('" test "') -> " res)
} 

;/* ----------------------------- PathIsSameRoot ----------------------------- */
arg1 := "C:\path1\one"
arg2 := "C:\path2\two"
expected := 1
res := PathIsSameRoot(arg1, arg2)
assert(res = expected, "PathIsSameRoot ('" arg1 "', '" arg2 "') -> " res)

arg2 := "E:\acme\three"
expected := 0
res := PathIsSameRoot(arg1, arg2)
assert(res = expected, "PathIsSameRoot ('" arg1 "', '" arg2 "') -> " res)

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


; -------------------------------------------------------------------------- 
;                                   Summary                                 
; -------------------------------------------------------------------------- 
OutputDebug "*********************************************************************************************************"
OutputDebug "*** UnitTest-Summary: " n_assert " overall - " n_assert_fail " fail - " n_assert_success " success *****"
OutputDebug "*********************************************************************************************************"
return

assert(test_ok, message) {
	global 
	n_assert++
	str := "SUCCESS"
	If (test_ok != 1) {
		str := "FAIL"
		n_assert_fail++
	}
	else {
		n_assert_success++
	}

	OutputDebug ("(" n_assert ") " str " - " message) 
}

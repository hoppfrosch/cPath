#Warn All

release_version() {
	return "0.1.1"
}

develop := 1

if (develop) {
OutputDebug "DBGVIEWCLEAR"

; -----------------------------------------------------
strRef := "C:\tmp\test.txt"

strResult := path("C:/tmp/..\test", "../tmp", "test.txt").canonpath
assert(StrCompare(strResult,strRef), "Property <canonpath> using function constructor (Result <" strResult "> <=> Reference <" strRef ">)")

strResult := Path.new("C:/tmp/..\test", "../tmp", "test.txt").canonpath
assert(StrCompare(strResult,strRef), "Property <canonpath> using class constructor (Result <" strResult "> <=> Reference <" strRef ">)")

OutputDebug "**********************************************************************"
OutputDebug "****** Testing functional interface **********************************"
OutputDebug "**********************************************************************"
strResult := PathCanonicalize("C:/tmp/..\test/../tmp/test.txt")
assert(StrCompare(strResult,strRef), "Funtional interface <PathCanonicalize> (Result <" strResult "> <=> Reference <" strRef ">)")

strResult := PathCombine("C:\tmp", "test.txt")
assert(StrCompare(strResult,strRef), "Functional interface <PathCombine> (Result <" strResult "> <=> Reference <" strRef ">)")

}

return

assert(test_ok, message) {
	static n_assert := 0
	n_assert++
	str := "SUCCESS"
	If (test_ok != 0)
		str := "FAIL"

	OutputDebug ("(" n_assert ") " str " - " message) 
}

; ***************************************************************************************************************
; Klassen
; ***************************************************************************************************************
;========================================================================
class Path {
	/* Class: Path
    	class for working with file paths

		It is build after Perl's <Path\:\:Tiny: https://metacpan.org/pod/Path::Tiny> module.

	Authors:	<hoppfrosch at hoppfrosch@gmx.de>: Original
	*/
	 _path := ""
	

	; ===== Methods ===============================================================
	canonpath[] {
	/* -------------------------------------------------------------------------------
	Property: canonpath [get]
	Returns the canonicalized path

	See:
	<stringify>, <value>

	Examples: 
	> MsgBox(path("C:/tmp/..\test", "../tmp", "test.txt").canonpath)
	*/
		get {
			return PathCanonicalize(this._path)
		}
	}

	; ===== Properties ===============================================================#
	/* 	Constructor: __New

	Konstruktor for Class <Path>

	Parameters: 
		path - path 
		params* - more pathes. All pathes are used to build the final path

	Returns:
		class <Path>
	*/
	__New(vPath, params*) {
		vPath := PathFixSlashes(vPath)

		for index,param in params {	
			vPath := PathCombine(vPath, param)
		}
		this._path := vPath
		return this
	}
}

;========================================================================
class RE_PATH {
	/* Class: RE_PATH

	Helper Class with Constants, defining required regular expressions

	Authors:	<hoppfrosch at hoppfrosch@gmx.de>: Original
	*/
	/* Variable: SLASH
	   RegEx describing Slashes
	   --- Code
		static SLASH := "[\\/]"
	   ---
	*/
	static SLASH						:= "[\\/]"
	/* Variable: NOTSLASH
	   RegEx describing Not-Slashes
	   --- Code
		static NOTSLASH := "^" RE_PATH.SLASH
	   ---
	*/
	static NOTSLASH					    := "^" RE_PATH.SLASH
	/* Variable: DRV_VOL
	   RegEx describing Drive-volume of a Windows-Path
	   --- Code
		static DRV_VOL := "[A-Za-z]:"
	   ---
	*/
	static DRV_VOL						:= "[A-Za-z]:"
	/* Variable: UNC_VOL
	   RegEx describing Drive-volume of a Windows-Path, i.e. "\\pcjok/test"
	   --- Code
		static UNC_VOL := RE_PATH.SLASH RE_PATH.SLASH RE_PATH.NOTSLASH "+" RE_PATH.SLASH RE_PATH.NOTSLASH "+"
	   ---
	*/
	static UNC_VOL						:= RE_PATH.SLASH RE_PATH.SLASH RE_PATH.NOTSLASH "+" RE_PATH.SLASH RE_PATH.NOTSLASH "+"
	/* Variable: WIN32_ROOT
	   RegEx describing valid rootdir on windows systems
	   --- Code
		static WIN32_ROOT := "(?:" RE_PATH.UNC_VOL RE_PATH.SLASH "|" RE_PATH.DRV_VOL RE_PATH.SLASH ")"
	   ---
	*/
	static WIN32_ROOT					:= "(?:" RE_PATH.UNC_VOL RE_PATH.SLASH "|" RE_PATH.DRV_VOL RE_PATH.SLASH ")"
}

; ***************************************************************************************************************
; Section: Globals
; ***************************************************************************************************************
;========================================================================
/* 	Function: Path

Konstruktor for Class <Path>

Parameters: 
	path - path 
	params* - more pathes. All pathes are used to build the final path

Returns:
    class <Path>

AutoHotkey Version:
	Tested & developed with Autohotkey 2.0-a104

Encoding:
	Unicode / ASCII
*/
Path(vPath, params*) {
	return Path.new(vPath, params*)
}

; ***************************************************************************************************************
; *** Functional interface to WIN API
; ***************************************************************************************************************

;========================================================================
/* 	Function: PathCanonicalize

Simplifies a path by removing navigation elements such as "." and ".." to produce a direct, well-formed path.

Parameters: 
	path - path to be canonicalized

Returns:
    canonicalized path

Encoding:
	Unicode / ASCII

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathCanonicalize(vPath) {
	MAX_PATH := 255
	vPath := PathFixSlashes(vPath)
	VarSetCapacity(Dest, (A_IsUnicode ? 2 : 1) * MAX_PATH, 0)
	dllCall("shlwapi.dll\PathCanonicalize", "Str", Dest, "Str", vPath)	
	return Dest
}

;========================================================================
/* 	Function: PathCombine

Concatenates two strings that represent properly formed paths into one path; also concatenates any relative path elements.

Parameters: 
	dirname - first path
	filename - second path

Returns:
    concatenated path string

Encoding:
	Unicode / ASCII

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathCombine(dirname, filename) {
	static MAX_PATH := 255
	VarSetCapacity(Dest, (A_IsUnicode ? 2 : 1) * MAX_PATH, 1)
	dllCall("shlwapi.dll\PathCombine", "Str", Dest, "Str", dirname, "Str", filename)	
	return Dest
}

;========================================================================
/* 	Function: PathFileExists

Determines whether a path to a file system object such as a file or folder is valid.

Parameters: 
	path - full path of the object to verify.

Returns:
    1 (TRUE) if the file exists; otherwise, 0 (FALSE).

Encoding:
	Unicode / ASCII

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathFileExists(vPath) {
	vPath := PathFixSlashes(vPath)
    Return DllCall("SHLWAPI.DLL\PathFileExists", "Str", vPath)
}


; ***************************************************************************************************************
; *** Tool - Functions
; ***************************************************************************************************************

;========================================================================
/* 	Function: PathFixSlashes

Fixes slashes in path by replacing forwarslashes with backslashes

Parameters: 
	path - path to be fixed

Returns:
    path with fixed Slashes

Encoding:
	Unicode / ASCII
*/
PathFixSlashes(vPath) {
	return RegExReplace(vPath,"\/","\")
}
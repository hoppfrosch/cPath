develop := 0

if (develop) {

MsgBox RE_PATH.UNC_VOL
MsgBox RE_PATH.WIN32_ROOT

x := path("C:/tmp/..\test", "../tmp", "test.txt")
MsgBox x 

}

return

release_version() {
	return "0.1.0"
}



class Path {
	path := ""

}

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
	vPath := PathFixSlashes(vPath)

	for index,param in params {
		vPath := PathCombine(vPath, param)
	}
	return vPath
}

;========================================================================
/* 	Function: PathCanonicalize

Simplifies a path by removing navigation elements such as "." and ".." to produce a direct, well-formed path.

Parameters: 
	path - path to be canonicalized

Returns:
    canonicalized path

AutoHotkey Version:
	Tested & developed with Autohotkey 2.0-a104

Encoding:
	Unicode / ASCII

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathCanonicalize(path) {
	static MAX_PATH := 255
	path := PathFixSlashes(path)
	VarSetCapacity(Dest, (A_IsUnicode ? 2 : 1) * MAX_PATH, 0)
	dllCall("shlwapi.dll\PathCanonicalize", "UInt", &Dest, "UInt", &path)	
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

AutoHotkey Version:
	Tested & developed with Autohotkey 2.0-a104

Encoding:
	Unicode / ASCII

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathCombine(dirname, filename) {
	static MAX_PATH := 255
	dirname := PathFixSlashes(dirname)
	filename := PathFixSlashes(filename)
	VarSetCapacity(Dest, (A_IsUnicode ? 2 : 1) * MAX_PATH, 1)
	dllCall("shlwapi.dll\PathCombine", "UInt", &Dest, "UInt", &dirname, "UInt", &filename)	

	return Dest
}

;========================================================================
/* 	Function: PathFileExists

Determines whether a path to a file system object such as a file or folder is valid.

Parameters: 
	path - full path of the object to verify.

Returns:
    1 (TRUE) if the file exists; otherwise, 0 (FALSE).

AutoHotkey Version:
	Tested & developed with Autohotkey 2.0-a104

Encoding:
	Unicode / ASCII

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathFileExists(path) {
	path := PathFixSlashes(path)
    Return DllCall("SHLWAPI.DLL\PathFileExists", "UInt", &path)
}


;========================================================================
/* 	Function: PathFixSlashes

Fixes slashes in path by replacing forwarslashes with backslashes

Parameters: 
	path - path to be fixed

Returns:
    path with fixed Slashes

AutoHotkey Version:
	Tested & developed with Autohotkey 2.0-a104

Encoding:
	Unicode / ASCII
*/
PathFixSlashes(path) {
	return RegExReplace(path,"\/","\")
}

/* Class: RE_PATH

Helper Class with Constants, defining required regular expressions
*/
class RE_PATH {
	; Variable: SLASH
	; RegEx describing Slashes
	static SLASH						:= "[\\/]"
	; Variable: NOTSLASH
	; RegEx describing Not-Slashes
	static NOTSLASH					    := "^" RE_PATH.SLASH
	; Variable: DRV_VOL
	; RegEx describing Drive-volume of a Windows-Path
	static DRV_VOL						:= "[A-Za-z]:"
	; Variable: UNC_VOL
	; RegEx describing Drive-volume of a Windows-Path, i.e. "\\pcjok/test"
	static UNC_VOL						:= RE_PATH.SLASH RE_PATH.SLASH RE_PATH.NOTSLASH "+" RE_PATH.SLASH RE_PATH.NOTSLASH "+"
	; Variable: WIN32_ROOT
	; RegEx describing valid rootdir on windows systems
	static WIN32_ROOT					:= "(?:" RE_PATH.UNC_VOL RE_PATH.SLASH "|" RE_PATH.DRV_VOL RE_PATH.SLASH ")"
}
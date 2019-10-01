#include %A_LineFile%\..\PathAPI.ahk

#Warn All

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
	 _parts := Array()
	

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

	parts[] {
	/* -------------------------------------------------------------------------------
	Property: parts [get]
	Returns the initial parts of the path

	Examples: 
	> arr := Array()
	> arr := path("C:/tmp/..\test", "../tmp", "test.txt").parts
	*/
		get {
			return this._parts
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
		this._parts.push(vPath)

		for index,param in params {	
			vPath := PathCombine(vPath, param)
			this._parts.push(PathFixSlashes(param))
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
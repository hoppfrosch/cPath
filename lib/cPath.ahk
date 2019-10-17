#include %A_LineFile%\..\PathAPI.ahk

#Warn All

; ***************************************************************************************************************
; Klassen
; ***************************************************************************************************************
;========================================================================
class Path {
	/* Class: Path
    	class for working with file paths

		It is build after Perl's <Path::Tiny: https://metacpan.org/pod/Path::Tiny> module.

	Authors:	<hoppfrosch at hoppfrosch@gmx.de>: Original
	*/
	 _path := ""
	 _parts := Array()
	

	; ===== Properties ===============================================================
	canonpath[] {
	/* -------------------------------------------------------------------------------
	Property: canonpath [get]
	Returns the canonicalized path

	See:
	<stringify>, <value>

	Examples: 
	> MsgBox(path.new("C:/tmp/..\test", "../tmp", "test.txt").canonpath)
	*/
		get {
			return PathCanonicalize(this._path)
		}
	}

	exists[] {
	/* -------------------------------------------------------------------------------
	Property: exists [get]
	Checks for the existence of a file or folder

	Examples: 
	> res := (path("c:\Windows\explorer.exe").exists)
	*/
		get {
			if (FileExist(this._path)) {
				return True
			}
			return False
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

	; ===== Methods ===============================================================#
	/* 	Constructor: __New

	Konstruktor for Class <Path>. This constructor does not needed to be called directly.
	To shorten the call and to mimic Perl's <Path::Tiny: https://metacpan.org/pod/Path::Tiny>,
	a function as constructor was provided instead:

	> x := path("C:/tmp/..\test", "../tmp", "test.txt") ; notice the missing call to <new>

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
; Section: Global Functions
; ***************************************************************************************************************
;========================================================================
/* 	Function: Path

Constructor for Class <Path>.
It was implemented to mimic Perl's <Path::Tiny: https://metacpan.org/pod/Path::Tiny>,

Parameters: 
	path - path 
	params* - more pathes. All pathes are used to build the final path

Returns:
    class <Path>

Examples: 
	> MsgBox(path("C:/tmp/..\test", "../tmp", "test.txt").canonpath)
*/
Path(vPath, params*) {
	return Path.new(vPath, params*)
}
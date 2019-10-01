#Warn All

release_version() {
	return "0.2.0"
}

; ***************************************************************************************************************
; *** Helper Classes defining relevant constants
; ***************************************************************************************************************

; File Attribute Constants ======================================================================================
class FILE_ATTRIBUTE {
	/* Class: FILE_ATTRIBUTE
	Helper Class to define FILE ATTRIBUTE CONSTANTS

	This class does not have any method but rather defines only file attribute constants.

	Authors:	<hoppfrosch at hoppfrosch@gmx.de>: Original

	References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants>, 

	Example
	--- Code
	MsgBox FILE_ATTRIBUTE.DIRECTORY
	---
	*/

	; Constant: ARCHIVE
	; A file or directory that is an archive file or directory. Applications typically use this attribute to mark files for backup or removal . 
	static ARCHIVE						:= 0x20
	; Constant: COMPRESSED
	; A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.
	static COMPRESSED					:= 0x800
	; Constant: DEVICE
	; This value is reserved for system use.
	static DEVICE						:= 0x40
	; Constant: DIRECTORY
	; The handle that identifies a directory.
	static DIRECTORY					:= 0x10
	; Constant: ENCRYPTED
	; A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.
	static ENCRYPTED					:= 0x4000
	; Constant: HIDDEN
	; The file or directory is hidden. It is not included in an ordinary directory listing.
	static HIDDEN						:= 0x2
	; Constant: INTEGRITY_STREAM
	; The directory or user data stream is configured with integrity (only supported on ReFS volumes). It is not included in an ordinary directory listing. The integrity setting persists with the file if it's renamed. If a file is copied the destination file will have integrity set if either the source file or destination directory have integrity set.
	static INTEGRITY_STREAM				:= 0x8000
	; Constant: NORMAL
	; A file that does not have other attributes set. This attribute is valid only when used alone.
	static NORMAL						:= 0x80
	; Constant: NOT_CONTENT_INDEXED
	; The file or directory is not to be indexed by the content indexing service.
	static NOT_CONTENT_INDEXED          := 0x2000
	; Constant: NO_SCRUB_DATA
	; The user data stream not to be read by the background data integrity scanner (AKA scrubber). When set on a directory it only provides inheritance. This flag is only supported on Storage Spaces and ReFS volumes. It is not included in an ordinary directory listing.
	static NO_SCRUB_DATA                := 0x20000
	; Constant: OFFLINE
	; The data of a file is not available immediately. This attribute indicates that the file data is physically moved to offline storage. This attribute is used by Remote Storage, which is the hierarchical storage management software. Applications should not arbitrarily change this attribute.
	static OFFLINE						:= 0x1000
	; Constant: READONLY
	; A file that is read-only. Applications can read the file, but cannot write to it or delete it. This attribute is not honored on directories.
	static READONLY						:= 0x1
	; Constant: RECALL_ON_DATA_ACCESS
	; When this attribute is set, it means that the file or directory is not fully present locally. For a file that means that not all of its data is on local storage (e.g. it may be sparse with some data still in remote storage). For a directory it means that some of the directory contents are being virtualized from another location. Reading the file / enumerating the directory will be more expensive than normal, e.g. it will cause at least some of the file/directory content to be fetched from a remote store. Only kernel-mode callers can set this bit.
	static RECALL_ON_DATA_ACCESS        := 0x400000
	; Constant: RECALL_ON_OPEN
	; This attribute only appears in directory enumeration classes (FILE_DIRECTORY_INFORMATION, FILE_BOTH_DIR_INFORMATION, etc.). When this attribute is set, it means that the file or directory has no physical representation on the local system; the item is virtual. Opening the item will be more expensive than normal, e.g. it will cause at least some of it to be fetched from a remote store.
	static RECALL_ON_OPEN				:= 0x40000
	; Constant: REPARSE_POINT
	; A file or directory that has an associated reparse point, or a file that is a symbolic link.
	static REPARSE_POINT				:= 0x400
	; Constant: SPARSE_FILE
	; A file that is a sparse file.
	static SPARSE_FILE					:= 0x200
	; Constant: SYSTEM
	; A file or directory that the operating system uses a part of, or uses exclusively.
	static SYSTEM						:= 0x4
	; Constant: TEMPORARY
	; A file that is being used for temporary storage. File systems avoid writing data back to mass storage if sufficient cache memory is available, because typically, an application deletes a temporary file after the handle is closed. In that scenario, the system can entirely avoid writing the data. Otherwise, the data is written after the handle is closed.
	static TEMPORARY					:= 0x100
	; Constant: VIRTUAL
	; This value is reserved for system use.
	static VIRTUAL						:= 0x10000
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

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 

*/
PathFileExists(vPath) {
	vPath := PathFixSlashes(vPath)
    Return DllCall("SHLWAPI.DLL\PathFileExists", "Str", vPath)
}

;========================================================================
/* 	Function: PathIsDirectory

Verifies that a path is a valid directory.

Parameters: 
	vPath - full path of the object to verify.

Returns:
    16 (FILE_ATTRIBUTE.DIRECTORY) if the path is a valid directory; otherwise, 0 (FALSE).

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 
*/
PathIsDirectory(vPath)  {
	vPath := PathFixSlashes(vPath)
	ret := DllCall("SHLWAPI.DLL\PathIsDirectory", "Str", vpath)
    Return ret
}

;========================================================================
/* 	Function: PathIsUNC

Determines if a path string is a valid Universal Naming Convention (UNC) path, as opposed to a path based on a drive letter.

Parameters: 
	vPath - full path to verify.

Returns:
	Returns 1 (TRUE) if the string is a valid UNC path; otherwise, 0 (FALSE)

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 
*/
PathIsUNC(vPath)    {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsUNC", "Str", vPath)
	return ret
}

;========================================================================
/* 	Function: PathRelativePathTo

Creates a relative path from one file or folder to another.
For file attributes see <FILE_ATTRIBUTE>

Parameters: 
	from - contains the path that defines the start of the relative path.
	atrFrom - file attributes of <from>. If this value contains FILE_ATTRIBUTE_DIRECTORY, <From> is assumed to be a directory; otherwise, <From> is assumed to be a file.
	to - contains the path that defines the endpoint of the relative 
	atrTo - file attributes of <To>. If this value contains FILE_ATTRIBUTE_DIRECTORY, <To> is assumed to be directory; otherwise, <To> is assumed to be a file.

Returns:
    resulting relative path

References:
	* <Microsoft shlwapi-Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path>, 
*/
PathRelativePathTo(From,atrFrom,To,atrTo)  {
    static MAX_PATH := 255
	VarSetCapacity(Dest, (A_IsUnicode ? 2 : 1) * MAX_PATH, 0)
	From := PathFixSlashes(From)
	To := PathFixSlashes(To)

    DllCall("SHLWAPI.DLL\PathRelativePathTo" 
	        , "Str" ,Dest
            , "Str", From, "Uint", atrFrom
            , "Str", To,   "Uint", atrTo)
    return Dest
}


; ***************************************************************************************************************
; *** Tool - Functions
; ***************************************************************************************************************

;========================================================================
/* 	Function: PathCat

Concatenates a path from several components using a variadic function

Parameters: 
	path - basepath
    params * - Array of path elements to be concatenated

Returns:
    concatenated path
*/
PathCat(path, params *) { ; variadic function
    local ret := path
     for index,param in params
        ret := PathCombine(ret, param)

    ret := PathCanonicalize(ret)
    return ret
}

;========================================================================
/* 	Function: PathFixSlashes

Fixes slashes in path by replacing forwarslashes with backslashes

Parameters: 
	path - path to be fixed

Returns:
    path with fixed Slashes
*/
PathFixSlashes(vPath) {
	return RegExReplace(vPath,"\/","\")
}

;========================================================================
/* 	Function: PathRelative

Creates a relative path from one file or folder to another.

Parameters: 
	from - contains the path that defines the start of the relative path.
	to - contains the path that defines the endpoint of the relative 

Returns:
    resulting relative path
*/
PathRelative(From,To)  { 
	local atrFrom := FILE_ATTRIBUTE.DIRECTORY
	if (!PathIsDirectory(From)) {
		atrFrom := FILE_ATTRIBUTE.NORMAL
	}
	local atrTo := FILE_ATTRIBUTE.DIRECTORY
	if (!PathIsDirectory(To)) {
		atrTo := FILE_ATTRIBUTE.NORMAL
	}
	return(PathRelativePathTo(From, atrFrom, To, atrTo))
}
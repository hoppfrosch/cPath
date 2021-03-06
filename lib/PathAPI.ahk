#Warn All

release_version() {
	return "0.3.0"
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

/* ********************************************************************** 
Section: Shell Path Handling Functions

Windows Shell path handling functions. The programming elements implemented here are exported by Shlwapi.dll 
and defined in Shlwapi.h and Shlwapi.lib.

References:
	* <Microsoft Documentation: https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-path> 
*/

;========================================================================
/* 	Function: PathAddBackslash

Adds a backslash to the end of a string to create the correct syntax for a path. If the source path already has a 
trailing backslash, no backslash will be added.

Note:
Misuse of this function can lead to a buffer overrun. We recommend the use of the safer <PathCchAddBackslash> 
or <PathCchAddBackslashEx> function in its place.

Parameters: 
	path - full path. The size of this buffer must be set to MAX_PATH to ensure that it is large enough to hold the returned string.

Returns:
    when this function returns successfully, points to the new string's terminating null character. If the backslash 
	could not be appended due to inadequate buffer size, this value is NULL.

References:
	* <PathAddBackslash: https://technet.microsoft.com/de-de/evalcenter/bb773561(v=vs.80)> 
*/
PathAddBackslash(vPath) {
	vPath := PathFixSlashes(vPath)
    Ret := DllCall("SHLWAPI.DLL\PathAddBackslash", "Str", vPath)
	Return vPath
}

;========================================================================
/* 	Function: PathAppend

Appends one path to the end of another.

Note:
Misuse of this function can lead to a buffer overrun. We recommend the use of the safer <PathCchAppend> 
or <PathCchAppendEx> function in its place.

Parameters: 
	dirname - string of maximum length MAX_PATH that contains the path to be appendeded to.
	dirmore - string of maximum length MAX_PATH that contains the path to be appended.

Returns:
    concatenated path string

References:
	* <PathAppend: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathappenda>
*/
PathAppend(dirname, dirmore) {
	ret := dllCall("shlwapi.dll\PathAppend", "Str", dirname, "Str", dirmore)	
	return dirname
}

;========================================================================
/* 	Function: PathCanonicalize

Simplifies a path by removing navigation elements such as "." and ".." to produce a direct, well-formed path.

Parameters: 
	path - path to be canonicalized

Returns:
    canonicalized path

References:
	* <PathCanonicalize: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathcanonicalizea>
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
	* <PathCombine: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathcombinea>
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
	* <PathFileExists: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathfileexistsa>

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
	* <PathIsDirectory function: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathisdirectorya>
*/
PathIsDirectory(vPath)  {
	vPath := PathFixSlashes(vPath)
	ret := DllCall("SHLWAPI.DLL\PathIsDirectory", "Str", vpath)
    Return ret
}

;========================================================================
/* 	Function: PathIsDirectoryEmpty

Determines whether a specified path is an empty directory.

Parameters: 
	vPath - contains the path to be tested.

Returns:
Returns (1) TRUE if vPath is an empty directory. Returns (0) FALSE if Path is not a directory, 
or if it contains at least one file other than "." or "..".

Remarks:
	"C:\" is considered a directory.

References:
	* <PathIsDirectoryEmpty function: https://msdn.microsoft.com/en-us/ie/bb773623(v=vs.80)>
*/
PathIsDirectoryEmpty(vPath)  {
	vPath := PathFixSlashes(vPath)
	ret := DllCall("SHLWAPI.DLL\PathIsDirectoryEmpty", "Str", vpath)
    Return ret
}

;========================================================================
/* 	Function: PathIsFileSpec

Searches a path for any path-delimiting characters (for example, ':' or '\' ). If there 
are no path-delimiting characters present, the path is considered to be a File Spec path.

Parameters: 
	vPath - full path of the object to verify.

Returns:
    Returns (1) TRUE if there are no path-delimiting characters within the path, 
	or (0) FALSE if there are path-delimiting characters.

References:
	* <PathIsFileSpec function: https://technet.microsoft.com/de-de/office/bb773627(v=vs.71)>
*/
PathIsFileSpec(vPath)   {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsFileSpec", "Str", vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsNetworkPath

Determines whether a path string represents a network resource.

Parameters: 
	vPath - contains the path to be validated.

Returns:
    Returns 1 (TRUE) if the string represents a network resource,, or 0 (FALSE) otherwise.

Remarks:
	PathIsNetworkPath interprets the following two types of paths as network paths.
	
		* Paths that begin with two backslash characters (\\) are interpreted as Universal Naming Convention (UNC) paths.
    	* Paths that begin with a letter followed by a colon (:) are interpreted as a mounted network drive. However, 
		PathIsNetworkPath cannot recognize a network drive mapped to a drive letter through the Microsoft MS-DOS SUBST 
		command or the DefineDosDevice function.

Note:
	The function does not verify that the specified network resource exists, is currently accessible, or that the user has sufficient permissions to access it.

References:
	* <PathIsNetworkPath function: https://msdn.microsoft.com/en-us/ie/bb773640(v=vs.80)>
*/
PathIsNetworkPath(vPath)   {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsNetworkPath", "Str" , vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsPrefix

Searches a path to determine if it contains a valid prefix of the type passed by pszPrefix. 
A prefix is one of these types: "C:\\", ".", "..", "..\\".

Parameters: 
	prefix - prefix for which to search.
	vPath - full path for which to search.

Returns:
    Returns 1 (TRUE) if the compared path is the full prefix for the path, or 0 (FALSE) otherwise.

References:
	* <PathIsPrefix function: https://technet.microsoft.com/de-de/office/bb773650(v=vs.80).aspx>
*/
PathIsPrefix(prefix,vPath)  {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsPrefix", "Str", prefix, "Str", vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsRelative

Searches a path and determines if it is relative.

Parameters: 
	vPath - full path for which to search.

Returns:
    Returns 1 (TRUE) if the path is relative, or 0 (FALSE) if it is absolute.

References:
	* <PathIsRelative function: https://msdn.microsoft.com/en-us/data/bb773660(v=vs.96).aspx>
*/
PathIsRelative(vPath)   {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsRelative", "Str", vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsRoot

Determines whether a path string refers to the root of a volume.

Parameters: 
	vPath - contains the path to be validated.

Returns:
    Returns 1 (TRUE) if the specified path is a root, or 0 (FALSE) otherwise.

References:
	* <PathIsRoot function: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathisroota>
*/
PathIsRoot(vPath)   {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsRoot", "Str" , vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsSameRoot 

Compares two paths to determine if they have a common root component.

Parameters: 
	vPath1 - contains the first path to be validated.
	vPath2 - contains the second path to be validated.

Returns:
    Returns 1 (TRUE) if both strings have the same root component, or 0 (FALSE) otherwise. 
	If vPath1 contains only the server and share, this function also returns 0 (FALSE).

References:
	* <PathIsSameRoot  function: https://technet.microsoft.com/de-de/sysinternals/bb773687(v=vs.100)>
*/
PathIsSameRoot(vPath1, vPath2)   {
	vPath1 := PathFixSlashes(vPath1)
	vPath2 := PathFixSlashes(vPath2)
    ret := DllCall("SHLWAPI.DLL\PathIsSameRoot", "Str", vPath1, "Str", vPath2)
	return ret
}

;========================================================================
/* 	Function: PathIsSystemFolder

Determines if an existing folder contains the attributes that make it a system folder. Alternately, 
this function indicates if certain attributes qualify a folder to be a system folder.

Parameters: 
	vPath - A pointer to a null-terminated string of maximum length MAX_PATH that contains the 
	name of an existing folder. The attributes for this folder will be retrieved and compared with 
	those that define a system folder. If this folder contains the attributes to make it a system 
	folder, the function returns nonzero. If this value is NULL, this function determines if the 
	attributes passed in <Attr> qualify it to be a system folder.

	Attr - The file attributes to be compared. Used only if pszPath is NULL. In that case, the 
	attributes passed in this value are compared with those that qualify a folder as a system folder. 
	If the attributes are sufficient to make this a system folder, this function returns nonzero. These 
	attributes are the attributes that are returned from GetFileAttributes.

Returns:
    Returns nonzero if the vPath or Attr represent a system folder, or 0 (zero) otherwise.

References:
	* <PathIsSystemFolder function: https://docs.microsoft.com/de-de/windows/win32/api/shlwapi/nf-shlwapi-pathissystemfoldera>
*/
PathIsSystemFolder(vPath := "",Attr := 0) {
	vPath := PathFixSlashes(vPath)
   	ret := DllCall("SHLWAPI.DLL\PathIsSystemFolder", "Str", vPath, "UInt", Attr)
	return ret
}

;========================================================================
/* 	Function: PathIsUNC

Determines if a path string is a valid Universal Naming Convention (UNC) path, as opposed to a path based on a drive letter.

Parameters: 
	vPath - full path to verify.

Returns:
	Returns 1 (TRUE) if the string is a valid UNC path; otherwise, 0 (FALSE)

References:
	* <PathIsUNC: https://msdn.microsoft.com/en-us/data/bb773712(v=vs.95).aspx>
*/
PathIsUNC(vPath)    {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsUNC", "Str", vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsUNCServer

Determines if a string is a valid Universal Naming Convention (UNC) for a server path only.

Parameters: 
	vPath - full path to verify.

Returns:
	Returns 1 (TRUE) if the string is a valid UNC path for a server only (no share name); otherwise, 0 (FALSE)

References:
	* <PathIsUNCServer function: https://technet.microsoft.com/de-de/office/bb773722(v=vs.80).aspx>
*/
PathIsUNCServer(vPath)  {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsUNCServer", "Str",vPath)
	return ret
}

;========================================================================
/* 	Function: PathIsUNCServerShare

Determines if a string is a valid Universal Naming Convention (UNC) share path, \\server\share.

Parameters: 
	vPath - full path to verify.

Returns:
	Returns 1 (TRUE) if the string is in the form \\server\share; otherwise, 0 (FALSE)

References:
	* <PathIsUNCServerShare function: https://msdn.microsoft.com/en-us/ie/bb773723(v=vs.80)>
*/
PathIsUNCServerShare(vPath) {
	vPath := PathFixSlashes(vPath)
    ret := DllCall("SHLWAPI.DLL\PathIsUNCServerShare", "Str",vPath)
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
	* <PathRelativePathTo: https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-pathrelativepathtoa>
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


/* ********************************************************************** 
Section: Additional Path Handling Functions

Additional path handling functions, which might be useful but not covered by shlwapi-path functionality
*/
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
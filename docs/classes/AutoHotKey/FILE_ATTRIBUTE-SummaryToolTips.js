NDSummary.OnToolTipsLoaded("AutoHotKeyClass:FILE_ATTRIBUTE",{6:"<div class=\"NDToolTip TClass LAutoHotKey\"><div class=\"TTSummary\">Helper Class to define FILE ATTRIBUTE CONSTANTS</div></div>",8:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that is an archive file or directory. Applications typically use this attribute to mark files for backup or removal</div></div>",9:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.</div></div>",10:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">This value is reserved for system use.</div></div>",11:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The handle that identifies a directory.</div></div>",12:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.</div></div>",13:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The file or directory is hidden. It is not included in an ordinary directory listing.</div></div>",14:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The directory or user data stream is configured with integrity (only supported on ReFS volumes). It is not included in an ordinary directory listing. The integrity setting persists with the file if it\'s renamed. If a file is copied the destination file will have integrity set if either the source file or destination directory have integrity set.</div></div>",15:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that does not have other attributes set. This attribute is valid only when used alone.</div></div>",16:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The file or directory is not to be indexed by the content indexing service.</div></div>",17:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The user data stream not to be read by the background data integrity scanner (AKA scrubber). When set on a directory it only provides inheritance. This flag is only supported on Storage Spaces and ReFS volumes. It is not included in an ordinary directory listing.</div></div>",18:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The data of a file is not available immediately. This attribute indicates that the file data is physically moved to offline storage. This attribute is used by Remote Storage, which is the hierarchical storage management software. Applications should not arbitrarily change this attribute.</div></div>",19:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that is read-only. Applications can read the file, but cannot write to it or delete it. This attribute is not honored on directories.</div></div>",20:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">When this attribute is set, it means that the file or directory is not fully present locally. For a file that means that not all of its data is on local storage (e.g. it may be sparse with some data still in remote storage). For a directory it means that some of the directory contents are being virtualized from another location. Reading the file / enumerating the directory will be more expensive than normal, e.g. it will cause at least some of the file/directory content to be fetched from a remote store. Only kernel-mode callers can set this bit.</div></div>",21:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">This attribute only appears in directory enumeration classes (FILE_DIRECTORY_INFORMATION, FILE_BOTH_DIR_INFORMATION, etc.). When this attribute is set, it means that the file or directory has no physical representation on the local system; the item is virtual. Opening the item will be more expensive than normal, e.g. it will cause at least some of it to be fetched from a remote store.</div></div>",22:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that has an associated reparse point, or a file that is a symbolic link.</div></div>",23:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that is a sparse file.</div></div>",24:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that the operating system uses a part of, or uses exclusively.</div></div>",25:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that is being used for temporary storage. File systems avoid writing data back to mass storage if sufficient cache memory is available, because typically, an application deletes a temporary file after the handle is closed. In that scenario, the system can entirely avoid writing the data. Otherwise, the data is written after the handle is closed.</div></div>",26:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">This value is reserved for system use.</div></div>",28:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype28\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathCanonicalize(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Simplifies a path by removing navigation elements such as &quot;.&quot; and &quot;..&quot; to produce a direct, well-formed path.</div></div>",29:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype29\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathCombine(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">dirname,</td></tr><tr><td class=\"PName first last\">filename</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Concatenates two strings that represent properly formed paths into one path; also concatenates any relative path elements.</div></div>",30:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype30\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathFileExists(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Determines whether a path to a file system object such as a file or folder is valid.</div></div>",31:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype31\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsDirectory(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Verifies that a path is a valid directory.</div></div>",32:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype32\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsFileSpec(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Searches a path for any path-delimiting characters (for example, \':\' or \'\\\' ). If there are no path-delimiting characters present, the path is considered to be a File Spec path.</div></div>",33:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype33\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsPrefix(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">prefix,</td></tr><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Searches a path to determine if it contains a valid prefix of the type passed by pszPrefix.&nbsp; A prefix is one of these types: &quot;C:\\\\&quot;, &quot;.&quot;, &quot;..&quot;, &quot;..\\\\&quot;.</div></div>",34:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype34\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsSystemFolder(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">vPath&nbsp;</td><td class=\"PDefaultValueSeparator\">:=&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHString\">&quot;&quot;</span>,</td></tr><tr><td class=\"PName first\">Attr&nbsp;</td><td class=\"PDefaultValueSeparator\">:=&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHNumber\">0</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Determines if an existing folder contains the attributes that make it a system folder. Alternately, this function indicates if certain attributes qualify a folder to be a system folder.</div></div>",35:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype35\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsUNC(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Determines if a path string is a valid Universal Naming Convention (UNC) path, as opposed to a path based on a drive letter.</div></div>",36:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype36\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsUNCServer(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Determines if a string is a valid Universal Naming Convention (UNC) for a server path only.</div></div>",37:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype37\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathIsUNCServerShare(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Determines if a string is a valid Universal Naming Convention (UNC) share path, \\\\server\\share.</div></div>",38:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype38\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathRelativePathTo(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">From,</td></tr><tr><td class=\"PName first last\">atrFrom,</td></tr><tr><td class=\"PName first last\">To,</td></tr><tr><td class=\"PName first last\">atrTo</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Creates a relative path from one file or folder to another.&nbsp; For file attributes see FILE_ATTRIBUTE</div></div>",39:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype39\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathCat(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">path,</td></tr><tr><td class=\"PName first last\">params *</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Concatenates a path from several components using a variadic function</div></div>",40:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype40\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathFixSlashes(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">vPath</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Fixes slashes in path by replacing forwarslashes with backslashes</div></div>",41:"<div class=\"NDToolTip TFunction LAutoHotKey\"><div id=\"NDPrototype41\" class=\"NDPrototype WideForm CStyle\"><table><tr><td class=\"PBeforeParameters\">PathRelative(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first last\">From,</td></tr><tr><td class=\"PName first last\">To</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"TTSummary\">Creates a relative path from one file or folder to another.</div></div>"});
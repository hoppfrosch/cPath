NDSummary.OnToolTipsLoaded("AutoHotKeyClass:FILE_ATTRIBUTE",{6:"<div class=\"NDToolTip TClass LAutoHotKey\"><div class=\"TTSummary\">Helper Class to define FILE ATTRIBUTE CONSTANTS</div></div>",8:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that is an archive file or directory. Applications typically use this attribute to mark files for backup or removal</div></div>",9:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.</div></div>",10:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">This value is reserved for system use.</div></div>",11:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The handle that identifies a directory.</div></div>",12:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.</div></div>",13:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The file or directory is hidden. It is not included in an ordinary directory listing.</div></div>",14:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The directory or user data stream is configured with integrity (only supported on ReFS volumes). It is not included in an ordinary directory listing. The integrity setting persists with the file if it\'s renamed. If a file is copied the destination file will have integrity set if either the source file or destination directory have integrity set.</div></div>",15:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that does not have other attributes set. This attribute is valid only when used alone.</div></div>",16:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The file or directory is not to be indexed by the content indexing service.</div></div>",17:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The user data stream not to be read by the background data integrity scanner (AKA scrubber). When set on a directory it only provides inheritance. This flag is only supported on Storage Spaces and ReFS volumes. It is not included in an ordinary directory listing.</div></div>",18:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">The data of a file is not available immediately. This attribute indicates that the file data is physically moved to offline storage. This attribute is used by Remote Storage, which is the hierarchical storage management software. Applications should not arbitrarily change this attribute.</div></div>",19:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that is read-only. Applications can read the file, but cannot write to it or delete it. This attribute is not honored on directories.</div></div>",20:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">When this attribute is set, it means that the file or directory is not fully present locally. For a file that means that not all of its data is on local storage (e.g. it may be sparse with some data still in remote storage). For a directory it means that some of the directory contents are being virtualized from another location. Reading the file / enumerating the directory will be more expensive than normal, e.g. it will cause at least some of the file/directory content to be fetched from a remote store. Only kernel-mode callers can set this bit.</div></div>",21:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">This attribute only appears in directory enumeration classes (FILE_DIRECTORY_INFORMATION, FILE_BOTH_DIR_INFORMATION, etc.). When this attribute is set, it means that the file or directory has no physical representation on the local system; the item is virtual. Opening the item will be more expensive than normal, e.g. it will cause at least some of it to be fetched from a remote store.</div></div>",22:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that has an associated reparse point, or a file that is a symbolic link.</div></div>",23:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that is a sparse file.</div></div>",24:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file or directory that the operating system uses a part of, or uses exclusively.</div></div>",25:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">A file that is being used for temporary storage. File systems avoid writing data back to mass storage if sufficient cache memory is available, because typically, an application deletes a temporary file after the handle is closed. In that scenario, the system can entirely avoid writing the data. Otherwise, the data is written after the handle is closed.</div></div>",26:"<div class=\"NDToolTip TConstant LAutoHotKey\"><div class=\"TTSummary\">This value is reserved for system use.</div></div>"});
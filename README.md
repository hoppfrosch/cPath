# cPath [![AutoHotkey2](https://img.shields.io/badge/Language-AutoHotkey2-red.svg)](https://autohotkey.com/)

This library uses [AutoHotkey Version 2](https://autohotkey.com/v2/). (Tested and developed with [v2.0-a104 x64 Unicode](https://www.autohotkey.com/boards/viewtopic.php?p=288705#p288705)) 

## Description

AHK class [Path](https://hoppfrosch.github.io/cPath/#AutoHotKeyClass:Path) for working with Pathes in Windows. It relies heavily on Win-API functionality, which is exposed by several functions (within module [PathAPI.ahk](https://hoppfrosch.github.io/cPath/#File:PathAPI.ahk)) and offers an additional class encapsulating these functionality.

The class [Path](https://hoppfrosch.github.io/cPath/#AutoHotKeyClass:Path) tries to mimic Perls [Path::Tiny](https://metacpan.org/pod/Path::Tiny).

## Usage 

Include `cPath.ahk` from the `lib` folder into your project using standard AutoHotkey-include methods.

```autohotkey
#include <cPath.ahk>
mypath := path("C:/tmp/..\test", "../tmp", "test.txt")
doesExist := mypath.exists
isDir := path("C:\Windows).is_dir
```

## Further Information

 * [License](https://hoppfrosch.github.io/cPath/#File:Readme.txt:License)
 * Author: [hoppfrosch@gmx.de](mailto:hoppfrosch@gmx.de)

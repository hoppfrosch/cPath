# cPath [![AutoHotkey2](https://img.shields.io/badge/Language-AutoHotkey2-red.svg)](https://autohotkey.com/)

This library uses [AutoHotkey Version 2](https://autohotkey.com/v2/). (Tested with [v2.0-a104 x64 Unicode](https://www.autohotkey.com/boards/viewtopic.php?p=288705#p288705) or later) 


## Description

AHK class **Path** for working with Pathes in Windows from AHK. It's relies heavily on Win-API functionality, which is exposed by several functions and offers a additional class encapsulating these functionality. 

The class **Path** is build according to Perls [Path::Tiny](https://metacpan.org/pod/Path::Tiny)

## Usage 

Include `cPass.ahk`from the `lib` folder into your project using standard AutoHotkey-include methods.

```autohotkey
#include <cPass.ahk>
mypath := path("C:/tmp/..\test", "../tmp", "test.txt")
```

## Author

[hoppfrosch@gmx.de](mailto:hoppfrosch@gmx.de)

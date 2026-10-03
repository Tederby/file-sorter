# File Sorter

A tiny Windows batch script that sorts a messy folder (looking at you, Downloads) into categorized subfolders by file extension. No installs, no dependencies, just `cmd`.

## Features

- Sorts files into folders by extension (images, documents, video, audio, and more)
- Creates target folders only when needed, so no empty folders are left around
- **Never overwrites existing files.** If a name is already taken, the incoming file is renamed with a numeric suffix
- Easy to customize: folder names and extensions are declared at the top of the script

## Usage

1. Copy `sort_files.bat` into the folder you want to sort.
2. Double-click it (or run it from a terminal inside that folder).
3. Done. Files are moved into their category folders.

The script only looks at files **directly inside its own folder**. Existing subfolders and their contents are left untouched.

## Default Categories

| Folder          | Extensions                                                  |
| --------------- | ----------------------------------------------------------- |
| `Images`        | jpg, jpeg, png, gif, webp, ico, svg, heic                   |
| `Documents`     | pdf, docx, doc, xlsx, xls, pptx, ppt, ppsx, txt, drawio     |
| `Video`         | mp4, mkv, avi, mov, m4v                                     |
| `Audio`         | mp3, wav, mid                                               |
| `Compressed`    | zip, rar, 7z, tgz                                           |
| `Programs`      | exe, msi                                                    |
| `Subtitles`     | srt, sbv                                                    |
| `Programming`   | cpp, py, html, css, json, js, ron, vsix                     |
| `Game Files`    | osz, jar                                                    |
| `Android Apps`  | apk                                                         |

Files with an extension that isn't listed are left where they are.

## Name Conflicts

If a file with the same name already exists in the target folder, the incoming file gets a `_1`, `_2`, `_3`... suffix until a free name is found. Nothing is ever overwritten, and the script prints a message whenever it renames something.

Example: the folder `Images` already contains `photo.jpg` and `photo_2.jpg`, and a new `photo.jpg` comes in.

| Attempt      | Result                          |
| ------------ | ------------------------------- |
| `photo.jpg`  | taken                           |
| `photo_1.jpg`| free, so it's used              |

If another `photo.jpg` comes in later, `photo_1.jpg` and `photo_2.jpg` are both skipped and it becomes `photo_3.jpg`.

Note that the suffix is simply appended to the full original name. If the incoming file is already called `photo_1.jpg` and that name is taken, it becomes `photo_1_1.jpg`, not `photo_2.jpg`.

## Customization

Everything lives at the top of `sort_files.bat`.

**Rename a folder:** change the value of the matching variable.

```bat
set "FOLDER_IMAGES=Pictures"
```

**Add an extension:** append it to the matching `call :sortcat` line, separated by spaces.

```bat
call :sortcat "%FOLDER_IMAGES%"    jpg jpeg png gif webp ico svg heic bmp
```

**Add a new category:** declare a folder variable and add a new `call :sortcat` line.

```bat
set "FOLDER_FONTS=Fonts"
call :sortcat "%FOLDER_FONTS%"     ttf otf woff woff2
```

## Limitations

- Conflicts are detected by **name only**, not by content. Two identical files with the same name will both be kept (as `file.ext` and `file_1.ext`).
- Files with `%` in their name may behave unexpectedly due to how batch scripts handle that character.
- Windows only (`cmd`). No PowerShell or Linux/macOS support.

## Tip

Try it on a dummy folder with a few test files first before pointing it at something important.

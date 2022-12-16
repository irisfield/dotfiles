The `xdg-open` program will open files and URLs in an application of choice. This is done based on each file's mime type. To set default applications, refer to the manual page for`xdg-mime(1)`, `xdg-icon-resource(1)`, and `xdg-desktop-menu(1).

# MIME types
The command to get a file's mime type is `file -b --mime-type` or `file -i`.

# Default applications
To check the default application to open PNGs, run `xdg-mime query default image/png`.
To change the default application for a mime type5

# Install
To install a single `.desktop` file:
```
xdg-mime default sxiv.desktop image/png image/jpeg image/gif image/webp image/svg+xml image/tiff
```

The command to install all desktop files in a directory at once is:
```
xdg-mime install *.desktop
```
See also [default applications](https://wiki.archlinux.org/title/Default_applications).

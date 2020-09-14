# ramdisk 🐏

Convenience wrapper for managing RAM disks across different operating systems
with a consistent interface.

## Usage

Help screen:

```console
$ ramdisk -h
ramdisk 0.2.0 🐏

Usage:
  ramdisk [options] create [<mount-path>]
  ramdisk destroy <device-path>

Options:
  -h -help      Show this screen.
  -d            Print the resulting device path to stdout.
  -v            Verbose output.
  -size=<mb>    Size in megabytes [default: 32].
```

Creating a new ram disk with a specified size:

```console
$ device_name=$(ramdisk -size=512 -d create)
512MB ramdisk created as /dev/disk4, mounted at /tmp/ramdisk-325620223
To later remove do: `ramdisk destroy /dev/disk4`
$ echo "${device_name}"
/dev/disk4
```

## Installation

* 📦 Compile via Go toolchain: `go get github.com/carterjones/ramdisk/cmd/ramdisk`

## Platform Support

### macOS ✅

Works great and does not require superuser access.

The basic steps followed are:

* Create an unmounted but attached device in RAM that consists of the
  appropriate number of device blocks via `hdiutil`.
* Format a new uniquely named HFS+ volume on that device via `newfs_hfs`.
* Mounts the volume at a uniquely generated path within the `/tmp` filesystem,
  via `mount`.

This normally requires a sequence of arcane commands on the macOS command line
which I can never remember, and thus was the primary reason I created this
wrapper.

### Linux ✅

Things are quite simple and work great via `tmpfs` on Linux! (But note that most
Linux implementations unfortunately requires sudo access to mount new volumes.)

If you prefer a sudo-less route, most modern Linux on kernel 2.6+ often
_already_ has `/dev/shm` mounted, which is memory backed, so you can also just
use that without any initialization at all.

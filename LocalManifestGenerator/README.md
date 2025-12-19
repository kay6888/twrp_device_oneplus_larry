# Local Manifest Generator APK

This is an Android application that generates local_manifests XML files for building TWRP for the OnePlus Larry (CPH2515) device.

## Purpose

When building custom Android ROMs or TWRP recovery, you need to sync device-specific repositories. This app generates the necessary manifest files that tell the build system which repositories to sync.

## Features

- Generate `roomservice.xml` - Standard manifest file for device trees
- Generate `local_manifests.xml` - Alternative manifest file format
- Files are saved to `/sdcard/local_manifests/` directory

## Usage

1. Install the APK on your Android device
2. Launch "Local Manifest Generator"
3. Tap either:
   - "Generate roomservice.xml" to create a roomservice.xml file
   - "Generate local_manifests.xml" to create a local_manifests.xml file
4. Files will be saved to your device's external storage in the `local_manifests` folder

## Building the APK

This app is built as part of the Android AOSP/TWRP build system:

```bash
# From your AOSP/TWRP build environment
. build/envsetup.sh
lunch twrp_larry-eng
make LocalManifestGenerator
```

The compiled APK will be available in:
`out/target/product/larry/system/app/LocalManifestGenerator/LocalManifestGenerator.apk`

## Generated Manifest Content

The generated XML files contain repository information for:
- Device tree: `device/oneplus/larry`
- Kernel sources: `kernel/oneplus/sm6375`
- Vendor blobs: `vendor/oneplus/larry`

## Using Generated Files

Copy the generated `roomservice.xml` or `local_manifests.xml` to your build environment:

```bash
# Copy from device to your build machine
adb pull /sdcard/local_manifests/roomservice.xml .repo/local_manifests/

# Then sync
repo sync
```

## Permissions

The app requires:
- `WRITE_EXTERNAL_STORAGE` - To save XML files
- `READ_EXTERNAL_STORAGE` - To read from storage

## License

```
Copyright (C) 2024 The Android Open Source Project
SPDX-License-Identifier: Apache-2.0
```

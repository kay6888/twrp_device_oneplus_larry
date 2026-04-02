# Android device tree for OnePlus CPH2515 (OP5958L1)
## OnePlus Nord N30 5G — TWRP device tree with KernelSU support

```
#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
```

## Kernel — KernelSU support

This device tree is configured to build the kernel **from source** with
[KernelSU](https://github.com/tiann/KernelSU) support enabled.

| Variable | Value |
|---|---|
| `TARGET_KERNEL_SOURCE` | `kernel/oneplus/sm6375` |
| `TARGET_KERNEL_CONFIG` | `holi_QGKI.config vendor/debugfs.config vendor/ksu.config` |
| `TARGET_FORCE_PREBUILT_KERNEL` | `false` |

### KernelSU config fragment

The file `kernel/ksu.config` (located in this device tree) is the KernelSU
kernel-config fragment.  It enables the following options that are required by
KernelSU:

* `CONFIG_KSU` — KernelSU core driver
* `CONFIG_KALLSYMS` / `CONFIG_KALLSYMS_ALL` — symbol resolution
* `CONFIG_KPROBES` — hook mechanism
* `CONFIG_OVERLAY_FS` — module mounting
* `CONFIG_USER_NS` — namespace isolation
* `CONFIG_BPF_SYSCALL` / `CONFIG_BPF_JIT` — eBPF support

### Building

Clone the SM6375 kernel source (with KernelSU patches applied) into
`kernel/oneplus/sm6375` relative to your AOSP/TWRP build root, then sync the
kernel config fragment:

```bash
# Copy the KernelSU config fragment to the kernel vendor config location
cp device/oneplus/larry/kernel/ksu.config \
   kernel/oneplus/sm6375/arch/arm64/configs/vendor/ksu.config
```

Then build as usual:

```bash
lunch twrp_larry-eng
mka bootimage
```

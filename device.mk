#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from the proprietary version
$(call inherit-product, device/oneplus/OP5958L1/device.mk)

LOCAL_PATH := device/oneplus/larry

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B
AB_OTA_UPDATER := true

# A/B Partitions
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Crypto
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# OTA Assert
TARGET_OTA_ASSERT_DEVICE := CPH2515

# Copy bootconfig
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/etc/bootconfig:$(TARGET_COPY_OUT_RECOVERY)/root/etc/bootconfig

# Prebuilt kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
  TARGET_FORCE_PREBUILT_KERNEL := true
  LOCAL_KERNEL := device/oneplus/CPH2515/prebuilt/Image.gz-dtb
else
  TARGET_FORCE_PREBUILT_KERNEL := true
  LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# AVB
PRODUCT_PACKAGES += \
    libavb_atx \
    libavb_cert \
    libavb_crypto \
    libavb_keymaster \
    libavb_rsa \
    libavb_sha256 \
    libavb_utils \
    libavb_adb_auth

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# DTBO
PRODUCT_KERNEL_DTBO := $(DEVICE_PATH)/prebuilt/dtbo.img


# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Recovery
TARGET_RECOVERY_FSTAB := device/oneplus/OP5958L1/recovery.fstab

# Additional vendor binaries
PRODUCT_PACKAGES += \
    charger_res_images

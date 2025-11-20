#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit some common Twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from OP5958L1 device
$(call inherit-product, device/oneplus/larry/device.mk)

PRODUCT_DEVICE := OP5958L1
PRODUCT_NAME := twrp_OP5958L1
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := CPH2515
PRODUCT_MANUFACTURER := oneplus

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="CPH2515-user 13 T.V3.23.3.BT04 release-keys"

BUILD_FINGERPRINT := OnePlus/CPH2515/CPH2515:13/T.V3.23.3.BT04/231023:user/release-keys

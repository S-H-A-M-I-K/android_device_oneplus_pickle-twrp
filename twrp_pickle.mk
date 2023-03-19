# Device Path
DEVICE_PATH := device/oneplus/pickle

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

#Virtual A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Apex
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Device specific configs
$(call inherit-product, device/oneplus/pickle/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := pickle
PRODUCT_NAME := twrp_pickle
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := CPH2423
PRODUCT_MANUFACTURER := OnePlus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE=OP5567L1 \
    PRODUCT_NAME=CPH2423IND

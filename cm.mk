
# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720
TARGET_BOOTANIMATION_HALF_RES := true

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full.mk)

# Inherit device configuration
$(call inherit-product, device/qcom/msm8916_64/msm8916_64.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := msm8916_64
PRODUCT_NAME := cm_msm8916_64
PRODUCT_BRAND := Android
PRODUCT_MODEL := MSM8916 for arm64
PRODUCT_MANUFACTURER := qualcomm

# Inherit mini common Awaken stuff
$(call inherit-product, vendor/awaken/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/awaken/config/wifionly.mk)

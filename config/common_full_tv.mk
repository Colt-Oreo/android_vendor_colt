# Inherit full common Colt stuff
$(call inherit-product, vendor/colt/config/common_full.mk)

PRODUCT_PACKAGES += TvSettings

DEVICE_PACKAGE_OVERLAYS += vendor/lineage/overlay/tv

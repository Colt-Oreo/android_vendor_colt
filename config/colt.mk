# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell date +"%s")

COLT_TAG=Cookie

# COLT RELEASE VERSION
COLT_VERSION_MAJOR = 2
COLT_VERSION_MINOR = 1
COLT_VERSION_MAINTENANCE =

VERSION := $(COLT_VERSION_MAJOR).$(COLT_VERSION_MINOR)$(COLT_VERSION_MAINTENANCE)


ifndef COLT_BUILDTYPE
    ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^COLT_||g')
        COLT_BUILDTYPE := $(RELEASE_TYPE)
    else
        COLT_BUILDTYPE := UNOFFICIAL
    endif
endif

ifdef COLT_BUILDTYPE
    ifeq ($(COLT_BUILDTYPE), RELEASE)
       COLT_VERSION := $(TARGET_PRODUCT)_$(COLT_TAG)-$(VERSION)-RELEASE-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(COLT_BUILDTYPE), NIGHTLY)
        COLT_VERSION := $(TARGET_PRODUCT)_$(COLT_TAG)-$(VERSION)-NIGHTLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(COLT_BUILDTYPE), EXPERIMENTAL)
        COLT_VERSION := $(TARGET_PRODUCT)_$(COLT_TAG)-$(VERSION)-EXPERIMENTAL-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(COLT_BUILDTYPE), UNOFFICIAL)
        COLT_VERSION := $(TARGET_PRODUCT)_$(COLT_TAG)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
    endif
else
#We reset back to UNOFFICIAL
        COLT_VERSION := $(TARGET_PRODUCT)_$(COLT_TAG)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(COLT_VERSION) \
    ro.colt.version=$(VERSION)-$(COLT_BUILDTYPE)

# needed for statistics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.romstats.name=COLT \
    ro.romstats.buildtype=$(COLT_BUILDTYPE) \
    ro.romstats.version=$(VERSION) \
    ro.romstats.tframe=1 \
    ro.romstats.askfirst=1 \
    ro.romstats.ga=UA-48128535-2

# Camera shutter sound property
PRODUCT_PROPERTY_OVERRIDES += \
persist.sys.camera-sound=1

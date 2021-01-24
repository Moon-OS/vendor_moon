# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
ifneq ($(filter OFFICIAL,$(MOON_BUILD_TYPE)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(TARGET_DEVICE)/$(TARGET_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.recovery_update=true
endif

# Branding
MOON_BUILD_TYPE ?= UNOFFICIAL

CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

CUSTOM_PLATFORM_VERSION := 11.0
CUSTOM_MOON_VERSION := v1.0
CUSTOM_MOON_VERSION_NAME := $(CUSTOM_MOON_VERSION)-$(MOON_BUILD_TYPE)-$(CUSTOM_BUILD_DATE)
TARGET_PRODUCT_SHORT := $(subst moon_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := MoonOS_$(CUSTOM_BUILD)-$(CUSTOM_MOON_VERSION)-$(CUSTOM_BUILD_DATE)-$(MOON_BUILD_TYPE)
CUSTOM_VERSION_PROP := eleven

ADDITIONAL_BUILD_PROPERTIES += \
    ro.moon.version=$(CUSTOM_VERSION_PROP) \
    ro.moon.version.display=$(CUSTOM_VERSION) \
    ro.moon.version.number=$(CUSTOM_MOON_VERSION) \
    ro.moon.version.name=$(CUSTOM_MOON_VERSION_NAME) \
    ro.moon.build_date=$(CUSTOM_BUILD_DATE) \
    ro.moon.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    ro.moon.build_type=$(MOON_BUILD_TYPE)

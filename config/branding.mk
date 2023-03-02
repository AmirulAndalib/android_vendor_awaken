# Copyright (C) 2016-2017 AOSiP
# Copyright (C) 2020 Fluid
# Copyright (C) 2021 AwakenOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
AWAKEN_CODENAME := ursa
AWAKEN_NUM_VER := 4.5

TARGET_PRODUCT_SHORT := $(subst awaken_,,$(AWAKEN_BUILD_TYPE))

AWAKEN_BUILD_TYPE ?= unofficial

# Only include Updater for official  build
ifeq ($(filter-out official,$(AWAKEN_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater

PRODUCT_COPY_FILES += \
    vendor/awaken/prebuilt/common/etc/init/init.awaken-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.awaken-updater.rc
endif

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/awaken/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/awaken/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/awaken/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/awaken/signing/keys/otakey.x509.pem
endif
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
AWAKEN_BUILD_VERSION := $(AWAKEN_NUM_VER)-$(AWAKEN_CODENAME)
AWAKEN_VERSION := $(AWAKEN_BUILD_VERSION)-$(AWAKEN_BUILD)-$(AWAKEN_BUILD_TYPE)-$(BUILD_TIME)-$(BUILD_DATE)
ROM_FINGERPRINT := awaken/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BUILD_TIME)
AWAKEN_DISPLAY_VERSION := $(AWAKEN_VERSION)
RELEASE_TYPE := $(AWAKEN_BUILD_TYPE)

# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2018 The PixelExperience Project
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

CUSTOM_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CUSTOM_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_OS)-x86/md5sum

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(CUSTOM_TARGET_PACKAGE)
	$(hide) $(MD5) $(CUSTOM_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CUSTOM_TARGET_PACKAGE).md5sum
	@echo "Package Complete: $(CUSTOM_TARGET_PACKAGE)" >&2

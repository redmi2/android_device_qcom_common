ifeq ($(TARGET_INIT_VENDOR_LIB),libinit_msm)

LOCAL_PATH := $(call my-dir)
LIBINIT_MSM_PATH := $(call my-dir)

LIBINIT_USE_MSM_DEFAULT := $(shell if [ ! -f "$(LIBINIT_MSM_PATH)/init_$(TARGET_BOARD_PLATFORM).cpp" ]; then echo true; fi)

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := \
    system/core/init \
    system/core/base/include \
    external/selinux/libselinux/include
LOCAL_CPPFLAGS := \
    -Wall \
    -DANDROID_TARGET=\"$(TARGET_BOARD_PLATFORM)\"
LOCAL_SRC_FILES := init_msm.cpp
ifeq ($(LIBINIT_USE_MSM_DEFAULT),true)
  LOCAL_SRC_FILES += init_msmdefault.cpp
else
  ifneq ($(TARGET_LIBINIT_DEFINES_FILE),)
    LOCAL_SRC_FILES += ../../../../$(TARGET_LIBINIT_DEFINES_FILE)
  else
    LOCAL_SRC_FILES += init_$(TARGET_BOARD_PLATFORM).cpp
  endif
endif
LOCAL_MODULE := libinit_msm
LOCAL_STATIC_LIBRARIES := libbase libselinux
include $(BUILD_STATIC_LIBRARY)

endif

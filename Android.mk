# Copyright (C) 2015 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

define tlsdate_common
  LOCAL_CFLAGS += \
      -DWITH_EVENTS -DHAVE_DBUS -DHAVE_CROS -DHAVE_PV_UIO \
      -DRECENT_COMPILE_DATE=$(shell date +%sL) \
      -DTARGET_OS_LINUX -Wall -Werror -Wno-unused-parameter
endef


include $(CLEAR_VARS)
LOCAL_MODULE := tlsdate
LOCAL_SRC_FILES := src/tlsdate.c
$(eval $(tlsdate_common))
include $(BUILD_EXECUTABLE)


#include $(CLEAR_VARS)
#LOCAL_MODULE := tlsdate-helper
#LOCAL_SRC_FILES := \
#    src/proxy-bio.c \
#    src/seccomp.c \
#    src/tlsdate-helper.c \
#    src/util.c
#LOCAL_SHARED_LIBRARIES := libcrypto libevent
#$(eval $(tlsdate_common))
#include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_MODULE := tlsdated
LOCAL_SRC_FILES := \
    src/conf.c \
    src/dbus.c \
    src/events/check_continuity.c \
    src/events/kickoff_time_sync.c \
    src/events/route_up.c \
    src/events/run_tlsdate.c \
    src/events/save.c \
    src/events/sigchld.c \
    src/events/sigterm.c \
    src/events/time_set.c \
    src/events/tlsdate_status.c \
    src/platform-cros.c \
    src/routeup.c \
    src/seccomp.c \
    src/tlsdate-monitor.c \
    src/tlsdate-setter.c \
    src/tlsdated.c \
    src/util.c
LOCAL_CFLAGS := -DTLSDATED_MAIN
LOCAL_SHARED_LIBRARIES := libcrypto libdbus libevent
$(eval $(tlsdate_common))
include $(BUILD_EXECUTABLE)

# config.mk
#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := msm8916
TARGET_BOOTLOADER_BOARD_NAME := msm8916

TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_APPEND_DTB := true

BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true

-include $(QCPATH)/common/msm8916/BoardConfigVendor.mk

# bring-up overrides
BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false

BOOTLOADER_GCC_VERSION := arm-eabi-4.8
BOOTLOADER_PLATFORM := msm8916# use msm8952 LK configuration

MALLOC_IMPL := dlmalloc

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x02000000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x02000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1288491008
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1860632576
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := false

TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := true
TARGET_NO_RPC := true

# Enable CSVT
TARGET_USES_CSVT := true

BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk
BOARD_KERNEL_SEPARATED_DT := true

BOARD_KERNEL_BASE        := 0x80000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_USES_UNCOMPRESSED_KERNEL := false


# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

BOARD_EGL_CFG := device/qcom/msm8916_64/egl.cfg
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
# Add NON-HLOS files for ota upgrade
ADD_RADIO_FILES := true
TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_msm

#add suffix variable to uniquely identify the board
TARGET_BOARD_SUFFIX := _64

TARGET_LDPRELOAD := libNimsWrap.so

#Enable HW based full disk encryption
TARGET_HW_DISK_ENCRYPTION := false

#Enable SW based full disk encryption
TARGET_SWV8_DISK_ENCRYPTION := true

TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

MAX_VIRTUAL_DISPLAY_DIMENSION := 2048

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

FEATURE_QCRIL_UIM_SAP_SERVER_MODE := true

# Control flag between KM versions
TARGET_HW_KEYMASTER_V03 := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

# CM build
BOARD_USES_QCOM_HARDWARE := true

# CM kernel build
TARGET_CUSTOM_DTBTOOL := dtbTool
TARGET_KERNEL_CONFIG := msm_defconfig
TARGET_KERNEL_SOURCE := kernel/qcom/msm

# CM healthd
BOARD_NO_CHARGER_LED := true
BOARD_HAL_STATIC_LIBRARIES := libhealthd.qcom

# Module build with CM kernel
ifneq ($(QCPATH),)
CORE_CTL_ROOT := $(QCPATH)/android-perf/core-ctl
CORE_CTL_MODULE:
	$(hide) mkdir -p $(KERNEL_OUT)/$(CORE_CTL_ROOT)
	$(hide) cp -f $(CORE_CTL_ROOT)/Kbuild $(KERNEL_OUT)/$(CORE_CTL_ROOT)/Makefile
	$(hide) cp -f $(CORE_CTL_ROOT)/core_ctl.c $(KERNEL_OUT)/$(CORE_CTL_ROOT)/core_ctl.c
	$(hide) $(MAKE) $(MAKE_FLAGS) -C $(KERNEL_OUT) M=$(KERNEL_OUT)/$(CORE_CTL_ROOT) ARCH=$(TARGET_ARCH) $(KERNEL_CROSS_COMPILE) modules
	$(hide) $(TARGET_KERNEL_CROSS_COMPILE_PREFIX)strip --strip-debug $(KERNEL_OUT)/$(CORE_CTL_ROOT)/core_ctl.ko
	$(hide) mkdir -p $(KERNEL_MODULES_OUT)
	$(hide) cp -f $(KERNEL_OUT)/$(CORE_CTL_ROOT)/core_ctl.ko $(KERNEL_MODULES_OUT)
TARGET_KERNEL_MODULES += CORE_CTL_MODULE
endif

PRIMA_ROOT := vendor/qcom/opensource/wlan/prima
PRIMA_MODULE:
	$(hide) mkdir -p $(KERNEL_OUT)/$(PRIMA_ROOT)
	$(hide) cp -f $(PRIMA_ROOT)/Kbuild $(KERNEL_OUT)/$(PRIMA_ROOT)/Makefile
	$(hide) cp -rf $(PRIMA_ROOT)/CORE $(KERNEL_OUT)/$(PRIMA_ROOT)/CORE
	$(hide) cp -rf $(PRIMA_ROOT)/riva $(KERNEL_OUT)/$(PRIMA_ROOT)/riva
	$(hide) $(MAKE) $(MAKE_FLAGS) -C $(KERNEL_OUT) M=$(KERNEL_OUT)/$(PRIMA_ROOT) ARCH=$(TARGET_ARCH) $(KERNEL_CROSS_COMPILE) MODNAME=wlan CONFIG_PRONTO_WLAN=m WLAN_ROOT=$(PRIMA_ROOT) modules
	$(hide) $(TARGET_KERNEL_CROSS_COMPILE_PREFIX)strip --strip-debug $(KERNEL_OUT)/$(PRIMA_ROOT)/wlan.ko
	$(hide) mkdir -p $(KERNEL_MODULES_OUT)/pronto
	$(hide) cp -f $(KERNEL_OUT)/$(PRIMA_ROOT)/wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko
TARGET_KERNEL_MODULES += PRIMA_MODULE

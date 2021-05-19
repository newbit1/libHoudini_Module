#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc
#mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
cp /system/vendor/etc/binfmt_misc/arm_exe /proc/sys/fs/binfmt_misc/register
cp /system/vendor/etc/binfmt_misc/arm_dyn /proc/sys/fs/binfmt_misc/register
cp /system/vendor/etc/binfmt_misc/arm64_exe /proc/sys/fs/binfmt_misc/register
cp /system/vendor/etc/binfmt_misc/arm64_dyn /proc/sys/fs/binfmt_misc/register

# This script will be executed in late_start service mode

# Lib Houdini 9 for arm64-v8a,armeabi-v7a,armeabi
### newbit @ xda-developers
Installs the Lib Houdini 9 functions into your AVD.

### Description
Installs the Lib Houdini 9 functions into your AVD, Android 10 API 29

### Notes
houdini + houdini64 are accessable via shell
```
generic_x86_64:/ $ houdini(64) --version                                                                                          
[5598] 
[5598] Houdini version: 9.0.5c_y.51331
```
/proc/sys/fs/binfmt_misc + arm files are registered...

```
generic_x86_64:/ # ls -lZ /proc/sys/fs/binfmt_misc                                                                            
-rw-r--r-- 1 root root u:object_r:binfmt_miscfs:s0 0 2021-05-19 20:53 arm64_dyn
-rw-r--r-- 1 root root u:object_r:binfmt_miscfs:s0 0 2021-05-19 20:53 arm64_exe
-rw-r--r-- 1 root root u:object_r:binfmt_miscfs:s0 0 2021-05-19 20:53 arm_dyn
-rw-r--r-- 1 root root u:object_r:binfmt_miscfs:s0 0 2021-05-19 20:53 arm_exe
--w------- 1 root root u:object_r:binfmt_miscfs:s0 0 2021-05-19 20:53 register
-rw-r--r-- 1 root root u:object_r:binfmt_miscfs:s0 0 2021-05-19 20:53 status
generic_x86_64:/ # cat /proc/sys/fs/binfmt_misc/status                                                                      
enabled
```
`adb logcat | grep houdini` shows:
```
1785  1785 I zygote64: option[41]=-XX:NativeBridge=libhoudini.so
1786  1786 I zygote  : option[41]=-XX:NativeBridge=libhoudini.so
```
But it doesn't show:
```
2223  2223 D houdini : [2223] Initialize library(version: 9.0.6_y.51472 RELEASE)... successfully.
2316  2316 D houdini : [2316] Initialize library(version: 9.0.6_y.51472 RELEASE)... successfully.
2759  2759 D houdini : [2759] Initialize library(version: 9.0.6_z.51472 RELEASE)... successfully.
2894  2894 D houdini : [2894] Initialize library(version: 9.0.6_z.51472 RELEASE)... successfully.
```
Arm APKs don't start, the crashing immediately. Issues found so far:

```
generic_x86_64:/ # dmesg | grep arm64                                                                                       
[    6.432139] selinux: SELinux: Skipping restorecon on directory(/data/dalvik-cache/arm)\x0a
[    6.433625] selinux: SELinux: Skipping restorecon on directory(/data/dalvik-cache/arm64)\x0a

1786  1786 I zygote  : option[42]=--cpu-abilist=x86,armeabi-v7a,armeabi
1907  2114 E installd: Failed to unlink /data//dalvik-cache/arm64/.booting: No such file or directory
2013  2061 W ActivityManager: Unable to mark boot complete for abi: arm64-v8a (android.os.ServiceSpecificException: Failed to unlink /data//dalvik-cache/arm64/.booting (code 2))
1907  2114 E installd: Failed to unlink /data//dalvik-cache/arm/.booting: No such file or directory
2013  2061 W ActivityManager: Unable to mark boot complete for abi: armeabi-v7a (android.os.ServiceSpecificException: Failed to unlink /data//dalvik-cache/arm/.booting (code 2))
1785  1785 W zygote64: Unexpected CPU variant for X86 using defaults: x86_64
1786  1786 W zygote  : Unexpected CPU variant for X86 using defaults: x86_64
```
### Links
* [ChromeOS R90 Stable Rammus](https://dl.google.com/dl/edgedl/chromeos/recovery/chromeos_13816.64.0_rammus_recovery_stable-channel_mp-v2.bin.zip)

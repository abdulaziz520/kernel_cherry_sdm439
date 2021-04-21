# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Cherry Kernel - by @AkiraNoSushi & @SimplyJoel
do.devicecheck=1
do.modules=1
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=pine
device.name2=olive
device.name3=olivelite
device.name4=olivewood
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
split_boot;
flash_boot;
flash_dtbo;

# Patches
ui_print "Mounting /system..."
mount -o rw,remount /system
# Prevent init from overriding kernel tweaks.
ui_print "Patching init..."
# IMO this is kinda destructive but works
find /system/etc/init/ -type f | while read file; do 
sed -Ei 's;[^#](write /proc/sys/(kernel|vm)/(sched|dirty|perf_cpu|page-cluster|stat|swappiness|vfs));#\1;g' $file
done
## end install

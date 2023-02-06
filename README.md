Device configuration for Oneplus 10R
=========================================

The Oneplus 10R (codenamed _"Pickle"_) is a high-end smartphone from Oneplus.

Oneplus 10R was announced and release on April 2022.

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | 4x2.85 GHz Cortex-A78 & 4x2.0 GHz Cortex-A55
Chipset | Mediatek Dimensity 8100-Max (5 nm)
GPU     | Mali-G610 MC6
Memory  | 8 & 12 GB RAM
Shipped Android Version | Oxygen OS 12(android-12)
Storage | 128/256 GB (UFS 3.1)
Battery | Non-removable Li-Po 4800/5000 mAh (QC 150W/80W)
Dimension | 163.3 x 75.5 x 8.2 mm
Display | 1080 x 2412 pixels, 6.7 inches (~394 ppi density)
Rear camera 1 | 50 MP, f/1.8, 24mm (wide), 1/1.56", 1.0µm, PDAF, OIS
Rear camera 2 | 8 MP, f/2.2, 15mm, 120˚ (ultrawide), 1/4.0", 1.12µm
Rear camera 3 | 2 MP, f/2.4, (macro)
Front camera | 16 MP, f/2.4, 26mm (wide), 1/3.09", 1.0µm

## Device picture

![Oneplus 10R](https://m.media-amazon.com/images/I/716uVx3Wr5L._SX679_.jpg "Oneplus 10R in Forest Green")

### BOARD_USES_RECOVERY_AS_BOOT

Keep in mind, `pickle` has NO `recovery` partition.
Recovery is part of the boot partition, so it takes care of normal boot and recovery.

**SO MAKE SURE YOU HAVE A BACKUP `boot.img`**

### Building

Basic instructions. From there you'll need to research.

1. Get started with https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp/tree/twrp-12.1
   ```
   repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
   repo sync -j5 --current-branch --no-clone-bundle --no-tags
   ```

1. Add this device tree to `device/oneplus/pickle`.
   ```
   mkdir -p device/oneplus
   cd device/oneplus
   git clone https://github.com/oneplus-pickle-roms/android_device_oneplus_pickle-twrp.git pickle
   cd ../..
   ```

1. Try an `eng` build.
   ```
   export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch twrp_pickle-eng
   make bootimage
   ```

1. You should now be able to flash `out/target/product/pickle/boot.img`
   ```
   cd out/target/product/pickle
   fastboot flash boot boot.img
   ```

### Experimental builds

#### 1. Flash *just* TWRP

https://github.com/oneplus-pickle-roms/android_device_oneplus_pickle-twrp/releases

Find the `.img` files under a releases' assets.
And flash like normal. `fastboot flash boot twrp-boot-xxx.img`

#### 2. Install the ramdisk

Boot into TWRP, then:
- `adb push stock-boot.img /sdcard/stock-boot.img` (get this from an official OTA file).
- `adb push twrp-boot-xxx.img /sdcard/twrp-boot-xxx.img`
- Install the **Stock** `stock-boot.img` for your OS version. **DO NOT** reboot yet.
- Install the ramdisk from `/sdcard/twrp-boot-xxx.img`. **DO NOT** reboot yet.
- `adb shell` -> `dd if=/dev/block/by-name/boot of=/sdcard/boot-plus-twrp.img` (You will need this for rooting).
- `adb reboot`

#### 3. Rooting

Booting the phone normally:
- Open the Magisk app.
- Choose `/sdcard/boot-plus-twrp.img` to be patched.
- Note the filename you get in the log `/sdcard/Download/magisk_patched-XXXXXXX.img`
- `adb reboot recovery`

When rebooted to TWRP:
- Install the file you got `/sdcard/Download/magisk_patched-XXXXXXX.img` to Boot.
- Reboot! You're done!

#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery:9570304:3469f214d59524dee86e7a9acf9a4b0256f6a29b; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/boot:8378368:445ff3dcb04da41c86c38b3cd51d9a6207c80a18 EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery a67c3366579fccb8aa3d42bca59dc38ceceb3124 9568256 445ff3dcb04da41c86c38b3cd51d9a6207c80a18:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery bs=1 seek=9568256 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi

#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery:9568256:e6e1bc67c15828c6bcac50f638563b6cfc08ad77; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/boot:8376320:c146a5aa77e0d7495c8a29edfc4b1204e8749c07 EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery 0fb9568ef3318983c2127a545621433ce5abcc63 9566208 c146a5aa77e0d7495c8a29edfc4b1204e8749c07:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery bs=1 seek=9566208 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi

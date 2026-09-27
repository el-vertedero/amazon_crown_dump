#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery:9568256:5034802bcc96ec715da32ac5987e3dd0372a7dea; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/boot:8376320:53906302be2e8ff47a07e453ffe7391d1231e19a EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery 8556b2d5cdc2d4d71c12c15509ad3a4853475e21 9566208 53906302be2e8ff47a07e453ffe7391d1231e19a:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery bs=1 seek=9566208 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi

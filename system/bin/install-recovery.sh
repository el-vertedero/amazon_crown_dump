#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery:9568256:ee3a675bfb992b07623a575e9a6ea9ccd83fbf1d; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/boot:8376320:ce982f51e5da23c8826a19c519ef935bdd814858 EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery 0ded0ab1f3d02fa5791aa4122820bbd5b135728d 9566208 ce982f51e5da23c8826a19c519ef935bdd814858:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery bs=1 seek=9566208 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi

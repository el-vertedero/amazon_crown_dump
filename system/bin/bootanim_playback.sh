#!/system/bin/sh

# The intention of this script to play audio during bootanimation.
# This script gets called when the audio flinger initialzation is completed.
# Makes sure that the bootanimation is running and play the audio using stagefright.
# Due to historical reason from Knight, the same file is now played for both oobe
# and reboot. Checkers is following the same scheme to provide feature parity
# with existing products. Simply change the filename here instead of changing
# the code logic in case the files are different in the future. See CHECKERS-1737
# for detail explanation.

REBOOT_FILE_PATH=/system/media/med_state_boot_up_regular.wav
OOBE_FILE_PATH=/system/media/med_state_boot_up_regular.wav
RUNNING="running"
OOBE_RUN=1
DND_ENABLED=1
LOG=/system/bin/log
TAG=BootanimPlayback
bootanimstate=`getprop init.svc.bootanim`
oobestate=`getprop persist.boot.oobe`
knightfingerprint=`getprop ro.build.fingerprint`
donotdisturb=`getprop persist.sys.ecs.SCREEN_IDLE`

print() {
     $LOG -t $TAG $1
}
print "DND Value Outside is: ${donotdisturb}"

if [ "${bootanimstate}" == "${RUNNING}" ] && [ "${donotdisturb}" -ne "${DND_ENABLED}" ] ; then

        print "DND Value Inside is: ${donotdisturb}"

        if [ "${oobestate}" -ne "${OOBE_RUN}" ]; then
                print "Play bootanim oobe audio"
                setprop persist.boot.oobe 1
                setprop persist.knight.fingerprint ""
                bootsound -ao $OOBE_FILE_PATH
        else
                print "Play bootanim reboot audio"
                bootsound -ao $REBOOT_FILE_PATH
        fi
else
        print "bootanim not running/ DND mode is enabled. Do not play the audio"
        setprop persist.knight.fingerprint $knightfingerprint
fi

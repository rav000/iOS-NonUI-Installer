#!/bin/zsh
echo "iOS-NonUI-Installer"
echo "Written by @whosdraaa and @rav000"

echo "Make sure you are in Semaphorin ramdisk."
echo "Waiting 10 seconds before continuing"
echo "This part is copying files from device"
sleep 10
#copy files from device
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/usr/bin/mount_filesystems"
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 root@localhost:/mnt1/usr/standalone/firmware/sep-firmware.img4 ./files/sep-firmware.img4
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/standalone/firmware/FUD ./files/FUD
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/local/standalone/firmware/Baseband ./files/Baseband
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/share/firmware/multitouch ./files/multitouch
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "reboot"
echo "Done copying files from /mnt1 and /mnt2."
echo "Run ./install.sh to install desired build."
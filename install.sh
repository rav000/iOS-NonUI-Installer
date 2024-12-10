#!/bin/zsh
echo "iOS-NonUI-Installer"
echo "Written by @whosdraaa and @rav000"

read -p "Press enter if you are in a ramdisk." r1
echo "Waiting 6 seconds before continuing.."
sleep 6
#copy files from device
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/usr/bin/mount_filesystems"
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 root@localhost:/mnt1/usr/standalone/firmware/sep-firmware.img4 ./files/sep-firmware.img4
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/standalone/firmware/FUD ./files/FUD
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/local/standalone/firmware/Baseband ./files/Baseband
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/share/firmware/multitouch ./files/multitouch

#install, modify, and delete nonUI files
echo "Done copying files from /mnt1 and /mnt2."
read -p "Press enter if you are ready to install NonUI. Don't forget to copy NonUI 11.0 dump in tar/tgz/tar.gz" r1
echo "Waiting 6 seconds before continuing.."
sleep 6
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "newfs_apfs -A -v SystemB /dev/disk0s1"
sleep 3
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "newfs_apfs -A -v DataB /dev/disk0s1"
sleep 3
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mount_apfs /dev/disk0s1s4 /mnt4"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mount_apfs /dev/disk0s1s5 /mnt5"
if [[ ./build.tar ]]; then
    ./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tar root@localhost:/mnt4
elif [[ ./build.tgz ]]; then
    ./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tgz root@localhost:/mnt4
elif [[ ./build.tar.gz ]]; then
    ./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tar.gz root@localhost:/mnt4
fi
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/etc/fstab"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/usr/standalone/firmware/sep-firmware.img4"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/usr/standalone/firmware/FUD"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/System/Library/Caches/apticket.der"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/usr/local/standalone/firmware/Baseband"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64.development"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt5/keybags"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mv /mnt4/usr/libexec/keybagd /mnt1/usr/libexec/keybagd_bak"

#send files to device
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/fstab root@localhost:/mnt4/etc
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/sep-firmware.img4 root@localhost:/mnt4/usr/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/Baseband root@localhost:/mnt4/usr/local/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/keybagd root@localhost:/mnt4/usr/libexec
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/FUD root@localhost:/mnt4/usr/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/multitouch root@localhost:/mnt4/usr/share/firmware

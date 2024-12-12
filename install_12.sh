#!/bin/zsh
echo "iOS-NonUI-Installer"
echo "Written by @whosdraaa and @rav000"

echo "Make sure you are in Semaphorin ramdisk."
echo "Waiting 6 seconds before continuing..."
sleep 6
#copy files from device
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/usr/bin/mount_filesystems"
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 root@localhost:/mnt1/usr/standalone/firmware/sep-firmware.img4 ./files/sep-firmware.img4
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/standalone/firmware/FUD ./files/FUD
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/local/standalone/firmware/Baseband ./files/Baseband
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 root@localhost:/mnt1/usr/share/firmware/multitouch ./files/multitouch

#meow
echo "Done copying files from /mnt1 and /mnt2."
echo "Please wait while NonUI is being installed."
echo "Waiting 6 seconds before continuing..."
sleep 6
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/newfs_apfs -A -v SystemB /dev/disk0s1"
sleep 3
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/newfs_apfs -A -v DataB /dev/disk0s1"
sleep 3
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/mount_apfs /dev/disk0s1s4 /mnt4"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/mount_apfs /dev/disk0s1s5 /mnt5"
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tar root@localhost:/mnt5 #if exist, then
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tar.gz root@localhost:/mnt5 #if exist, then
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tgz root@localhost:/mnt5 #if all not exist, then exit
#install nonUI
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "tar -xvf /mnt5/build.tar -C /mnt4" #if exist, then
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "tar -xvf /mnt5/build.tar.gz -C /mnt4" #if exist, then
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "tar -xvf /mnt5/build.tgz -C /mnt4" #if all not exist, then exit
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mv -v /mnt4/private/var/* /mnt5"
#edit shit
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/etc/fstab"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/usr/standalone/firmware/sep-firmware.img4"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/usr/standalone/firmware/FUD"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/System/Library/Caches/apticket.der"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/usr/local/standalone/firmware/Baseband"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt4/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64.development"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt5/keybags"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mv /mnt4/usr/libexec/keybagd /mnt4/usr/libexec/keybagd_bak"

#send files to device
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/fstab root@localhost:/mnt4/etc
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/sep-firmware.img4 root@localhost:/mnt4/usr/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/Baseband root@localhost:/mnt4/usr/local/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/keybagd root@localhost:/mnt4/usr/libexec
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/FUD root@localhost:/mnt4/usr/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/multitouch root@localhost:/mnt4/usr/share/firmware

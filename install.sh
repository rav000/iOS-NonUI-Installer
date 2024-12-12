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

#u(n)mount
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "umount /mnt1"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "umount /mnt2"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "umount /mnt3"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s7"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s6"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s5"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s4"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s3"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s2"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "apfs_deletefs /dev/disk0s1s1"


#meow
echo "Done copying files from /mnt1 and /mnt2."
echo "Please wait while NonUI is being installed."
echo "Waiting 6 seconds before continuing..."
sleep 6
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/newfs_apfs -A -v SystemB /dev/disk0s1"
sleep 3
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/newfs_apfs -A -v DataB /dev/disk0s1"
sleep 3
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/mount_apfs /dev/disk0s1s1 /mnt1"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "/sbin/mount_apfs /dev/disk0s1s2 /mnt2"
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tar root@localhost:/mnt2 #if exist, then
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tar.gz root@localhost:/mnt2 #if exist, then
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./build.tgz root@localhost:/mnt2 #if all not exist, then exit
#install nonUI
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "tar -xvf /mnt2/build.tar -C /mnt1" #if exist, then
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "tar -xvf /mnt2/build.tar.gz -C /mnt1" #if exist, then
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "tar -xvf /mnt2/build.tgz -C /mnt1" #if all not exist, then exit
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mv -v /mnt1/private/var/* /mnt2"
#edit shit
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt1/etc/fstab"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt1/usr/standalone/firmware/sep-firmware.img4"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt1/usr/standalone/firmware/FUD"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt1/System/Library/Caches/apticket.der"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt1/usr/local/standalone/firmware/Baseband"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt1/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64.development"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "rm -rf /mnt2/keybags"
./bin/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "mv /mnt1/usr/libexec/keybagd /mnt1/usr/libexec/keybagd_bak"

#send files to device
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/fstab root@localhost:/mnt1/etc
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/sep-firmware.img4 root@localhost:/mnt1/usr/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/Baseband root@localhost:/mnt1/usr/local/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -P 2222 ./files/keybagd root@localhost:/mnt1/usr/libexec
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/FUD root@localhost:/mnt1/usr/standalone/firmware
./bin/sshpass -p "alpine" scp -o StrictHostKeyChecking=no -r -P 2222 ./files/multitouch root@localhost:/mnt1/usr/share/firmware

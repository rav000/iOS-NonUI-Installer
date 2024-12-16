echo "Patching iBSS"
./bin/iBoot64Patcher ./boot/iBSS.dec ./boot/iBSS.patched
./bin/img4 -i ./boot/iBSS.patched -o ./boot/iBSS.img4 -M IM4M -A -T ibss
echo "Patching iBEC"
./bin/iBoot64Patcher /boot/iBEC.dec ./boot/iBEC.patched -b "rd=disk0s1s4 wdt=-1 debug=0x2014e -v"
./bin/img4 -i ./boot/iBSS.patched -o ./boot/iBSS.img4 -M IM4M -A -T ibss

echo "Patching kernelcache"
./bin/img4 -i kernelcache.release -o kcache.raw
./bin/seprmvr64 ./boot/kcache.raw ./boot/kcache.patched
./bin/sepless ./boot/kcache.patched ./boot/kcache.patched2
./bin/kerneldiff ./boot/kcache.raw ./boot/kcache.patched2 kc.bpatch
./bin/img4 -i ./boot/kernelcache.release -o ./boot/kernelcache.img4 -M IM4M -T rkrn -P kc.bpatch

echo "Patching devicetre"
./bin/dtree_patcher ./boot/dtree.raw ./boot/dtree.patched -n
./bin/img4 -i ./boot/dtree.patched -o ./boot/devicetree.img4 -M IM4M -A -T rdtr

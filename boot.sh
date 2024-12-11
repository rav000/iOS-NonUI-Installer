./boot/ipwnder32 -p
sleep 2
./boot/gaster pwn 
sleep 2
./boot/gaster reset
irecovery -f ./boot/iBSS.img4
if [ -f "./boot/ipwnder32" ]; then
    irecovery -f ./boot/iBSS.img4
fi
irecovery -f ./boot/iBEC.img4
irecovery -f ./boot/devicetree.img4
irecovery -c devicetree
if [ -f "trustcache.img4" ]; then
    irecovery -f trustcache.img4
    irecovery -c firmware
fi
irecovery -f ./boot/kernelcache.img4
irecovery -c bootx

./boot/gaster pwn 
sleep 2
./boot/ipwnder32 -p
sleep 2
./boot/gaster reset
irecovery -f iBSS.img4
if [ -f "./boot/ipwnder32" ]; then
    irecovery -f iBSS.img4
fi
irecovery -f iBEC.img4
irecovery -f devicetree.img4
irecovery -c devicetree
if [ -f "trustcache.img4" ]; then
    irecovery -f trustcache.img4
    irecovery -c firmware
fi
irecovery -f kernelcache.img4
irecovery -c bootx

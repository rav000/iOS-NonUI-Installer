Project is still on WIP, updated as fast as possible

Also lmk if something wrong is happening, I'll fix it asap

Forget about iOS 15+ support
# iOS-NonUI-Installer
Quickly install or dualboot NonUI on checkm8 devices!

## Features

- Install iOS 10.3(.x)/11.0 NonUI build
- Dualboot NonUI with stock iOS for 32GB devices
- Tethered install for 16GB devices
- Tethered downgrade for NonUI 10.3 install

## Supported versions and devices

<table>
    <thead>
        <tr>
            <th>Target Version</th>
            <th>Supported Devices</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=4>iOS 10.3</td>
            <td>A7 devices</td>
        </tr>
        <tr><td>A8(X) devices</td></tr>
        <tr><td>A9(X) devices</td></tr>
        <tr><td>A10(X) devices</td></tr>
        <tr>
            <td rowspan=4>iOS 10.3.2</td>
            <td>A7 devices</td>
        </tr>
        <tr><td>A8(X) devices</td></tr>
        <tr><td>A9(X) devices</td></tr>
        <tr><td>A10(X) devices</td></tr>
        <tr>
            <td rowspan=6>iOS 11.0</td>
            <td>A7 devices</td>
        </tr>
        <tr><td>A8(X) devices</td></tr>
        <tr><td>A9(X) devices</td></tr>
        <tr><td>A10 devices</td></tr>
        <tr><td>A11 devices</td></tr>
    </tbody>
</table>

# How to use

1. SSH ramdisk using Semaphorin
2. Make placeholder partition `newfs_apfs -A /dev/disk0s1` (only if you are using A7, Wi-Fi only iPads, and iPod touch)
3. Download NonUI dump, rename it to `build.tar` or `build.tar.gz` or `build.tgz`
4. Run `./install.sh` and let it do its own thing
5. Decrypt ibss, ibec, and dtree and put it into `boot` folder
6. Rename kernelcache.release.boardconfig to kernelcache.release and put it into `boot` folder
7. Put your im4m besides `./make_bootchain.sh`
8. Generate bootchain files using `./make_bootchain.sh`
9. Boot NonUI useing `./boot.sh`

# SSH into the device while SwitchBoard is running

1. Make sure the device booted into SwitchBoard and plugged into your Mac
2. Open terminal windor and run `iproxy 2223 22`
3. Open another terinal window and run `ssh -oHostKeyAlgorithms=+ssh-rsa -oKexAlgorithms=+diffie-hellman-group1-sha1 -p 2223 root@localhost`
4. If it asks for password, use `alpine` as the password

# Notes

This script are only tested on iOS 12 devices, not iOS 15+. Please only use it on iOS 12 devices. Make sure to backup all of your data before using this script, **I am not responsible for any data loss or damaging the device with this script**.
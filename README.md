Project is still on WIP, updated as fast as possible

Also lmk if something wrong is happening, I'll fix it asap
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
5. For bootchain, do it on your own (gonna add it soon™)
6. To boot it, add your patched bootchain files into `boot` folder
7. To boot NonUI, use `./boot.sh`
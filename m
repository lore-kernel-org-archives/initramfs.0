From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 035
Date: Tue, 28 Jan 2014 15:36:22 +0100
Message-ID: <52E7C066.9020402@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here comes a new dracut version. Thanks to all who have contributed to this release.

The tarball can be found here:
        http://www.kernel.org/pub/linux/utils/boot/dracut/
        ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/

Git:
        git://git.kernel.org/pub/scm/boot/dracut/dracut.git
        http://git.kernel.org/pub/scm/boot/dracut/dracut.git
        https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Git Web:
        http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS



dracut-035
==========
- - changed dracut tarball compression to xz
- - new argument "--rebuild"
- - add lzo, lz4 compression
- - install: install all binaries with <name> found in PATH
- - lsinitrd can now handle initramfs images with an early cpio prepended
  (microcode, ACPI tables)
- - mkinitrd-suse added as a compat stub for dracut
- - lvm: install thin utils for non-hostonly
- - resume: fix swap detection in hostonly
- - avoid loading unnecessary 32-bit libraries for 64-bit initrds
- - crypt: wait for systemd password agents
- - crypt: skip crypt swaps with password files
- - network: before doing dhcp, dracut now checks, if the link has a carrier
- - network: dhclient-script.sh now sets the lease time
- - network: include usbnet drivers
- - network: include all ethernet drivers
- - network: add rd.bootif=0 to ignore BOOTIF
- - i18n: introduce i18n_install_all, to install everything i18n related
- - support SuSE DASD configurations
- - support SuSE zfcp configurations
- - support SuSE compressed KEYMAP= setting
- - usrmount: always install the module,
  so always mount /usr from within the initramfs
- - test/TEST-17-LVM-THIN: new test case for lvm thin pools
- - "halt" the machine in systemd mode for die()
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS58BlAAoJEANOs3ABTfJwEkoQAI0VHw7tIFXSbLHY4jAL1uMC
tYJdJTAhgcLvcGvgwwLpQIGLYB4d1JhKn7Y1Aeo+m46S4SRms+GiFv75ExJfZg6N
SAB4mE86c7fosz/T/ZAcmWKdeXTx23EYxSXTzcJNs4bOECBAnL6spvVwzBomECLm
Iz0wIYS7cjENEfv2oAEwcBZW22Mg1qM/2ro+o5MMdbpgjNM0n5XTWihpWvOvJJzd
t8N3YUI2bPrIvT2eZsxKH915rT/4j+f9Npggbt+S4maVlNfApkUVaSYnZZhcFxHa
SSTaFB88SO18aSUSqS76n60//gAQorNOw2FEIAlmHZfAtBES5jepipw0wcXPT4W8
YdBpoJL+5dgirPIjB7phmr/0lk/7t9HROCRqqpoRWV4NTrCa+gQz6LzIMS1NkTZ/
gb5vssJvoQcAgKC7gLQXtHCqR4xI3/W6JpCC1Q0PFkS2U2DHTNaSov1lzlbky++l
O3hgAtO/NfSa+gMXpBUOMoKVHBI6gLwpWnsv0Zr5jM1pVoTrJeQe2lY2rC7P978n
KAm4ZLKSdcXfhw9YHEFfo311vc/Bxw6Ul+J+pUDmRLMBk8uqu0Obf+RkSQHG8YDj
wwDqFehSUnf622WGVRPXG3NzCJx4m1vTCuEiqm6CsThVFFPBb2HbTrVXcpSIAOD8
8taESk+W9FFT8/zEKJox
=59TE
-----END PGP SIGNATURE-----

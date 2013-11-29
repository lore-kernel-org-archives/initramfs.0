From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 10/13] mkinitrd-suse.8.asc: Add manpage for SUSE compat mkinitrd
Date: Fri, 29 Nov 2013 13:13:51 +0100
Message-ID: <1385727234-5001-11-git-send-email-hare@suse.de>
References: <1385727234-5001-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385727234-5001-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 Makefile            |   1 +
 mkinitrd-suse.8.asc | 106 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 mkinitrd-suse.8.asc

diff --git a/Makefile b/Makefile
index e7da948..ba551cf 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,7 @@ man7pages =3D dracut.cmdline.7 \
 man8pages =3D dracut.8 \
             dracut-catimages.8 \
             mkinitrd.8 \
+            mkinitrd-suse.8 \
             modules.d/98systemd/dracut-cmdline.service.8 \
             modules.d/98systemd/dracut-initqueue.service.8 \
             modules.d/98systemd/dracut-mount.service.8 \
diff --git a/mkinitrd-suse.8.asc b/mkinitrd-suse.8.asc
new file mode 100644
index 0000000..9eb8fc9
--- /dev/null
+++ b/mkinitrd-suse.8.asc
@@ -0,0 +1,106 @@
+MKINITRD(8)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+:doctype: manpage
+:man source:   dracut
+:man manual:   dracut
+
+NAME
+----
+mkinitrd-suse - is a compat wrapper, which calls dracut to generate an=
 initramfs
+
+SYNOPSIS
+--------
+*mkinitrd* ['OPTION...']
+
+DESCRIPTION
+-----------
+*mkinitrd* creates an initramfs image <initrd-image> for the kernel wi=
th
+version <kernel-version> by calling *dracut*.
+
+[IMPORTANT]
+This version of mkinitrd is provided for compability with older
+versions of mkinitrd. If a more fine grained control over the
+resulting image is needed, *dracut* should be called directly.
+
+OPTIONS
+-------
+**-R, --version**::
+    print info about the version
+
+**-k**=C2=A0_<kernel_list>_::
+    List of kernel images for which initrd files are created (relative
+    to _boot_dir_), defaults to _vmlinux_ on ppc/ppc64, _image_ on s39=
0/s390x
+    and _vmlinuz_ for everything else.
+
+**-i**=C2=A0_<initrd_list>_::
+    List of file names (relative to _boot_dir_) for the initrd; positi=
ons
+    have to match the _kernel_list_. Defaults to _initrd_.
+
+**-m**=C2=A0_<module_list>_::
+    Modules to include in initrd, defaults to _INITRD_MODULES_ variabl=
e
+    in */etc/sysconfig/kernel*.
+
+**-f**=C2=A0_<feature_list>_::
+    Features to be enabled for the initrd. In general mkinitrd
+    configures the initrd for the root device it is started from. With
+    this option additional feature can be enabled.
+
+**-b**=C2=A0_<bootdir>_::
+    Boot directory, defaults to */boot*, where the initrd is created.
+
+**-d**=C2=A0_<root_device>_::
+    Root device, defaults to the device from which the root_dir is
+    mounted; overwrites the rootdev enviroment variable if set
+
+**-s**=C2=A0_<size>_::
+    Add splash animation and bootscreen to initrd.
+
+**-D**=C2=A0_<interface>::
+    Run dhcp on the specified interface (for example "eth0").
+
+**-I**=C2=A0_<interface>::
+    Configure the specified interface statically.
+
+**-a**=C2=A0_<acpi_dsdt>::
+    Attach compiled ACPI DSDT (Differentiated System Description Table=
)
+    to initrd. This replaces the DSDT of the BIOS. Defaults to the
+    _ACPI_DSDT_ variable in */etc/sysconfig/kernel*.
+
+**-M**=C2=A0_<map>::
+    System.map file to use.
+
+**-B**::
+    Don=E2=80=99t run the *update-bootloader(8)* script after the init=
rd(s) have
+    been created. This is useful if you call mkinitrd(8) for anything
+    else than the running system.
+
+**-A**::
+    Create a so called "monster initrd" which includes all available
+    features and modules.
+
+**-v, --verbose**::
+    increase verbosity level
+
+**-L**::
+    Disable logging to _/var/log/YaST2/mkinitrd.log_. This is useful f=
or
+    testing if you don=E2=80=99t want to clutter the system log.
+
+**--force**::
+    overwrite existing initramfs file.
+
+**--help**::
+    print a help message and exit.
+
+AVAILABILITY
+------------
+The mkinitrd command is part of the dracut package and is available fr=
om
+link:$$https://dracut.wiki.kernel.org$$[https://dracut.wiki.kernel.org=
]
+
+AUTHORS
+-------
+Harald Hoyer, Hannes Reinecke
+
+SEE ALSO
+--------
+*dracut*(8)
+*update-bootloader*(8)
--=20
1.8.1.4

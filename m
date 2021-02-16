From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 052
Date: Tue, 16 Feb 2021 08:38:42 +0100
Message-ID: <a7b095bf-8aca-3854-ba62-181b4587377c@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613461130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=be+deLT7H4U+XFQInxJYf/Q4RsdNNfB1+xpz+ag1jgs=;
        b=iV3BqzclmHUPFbWgQ/DA2Lok+lqVl1aLUNuJFbecn0mz8JLp0C5q8VSyf+FlxypHRvWc5V
        uK+VpAMiGkrXOtWXBcf6PooScyN1m50anQct8UM/a7+b+j2GWYibWYWubChmV5XJCATrD2
        oCxuEFsI1rnbUt+hxKdNTeWGwcfcNMY=
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to this
release.

The tarball can be found here:
        http://www.kernel.org/pub/linux/utils/boot/dracut/
        ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
        https://github.com/dracutdevs/dracut/releases/

Report Issues:
        https://github.com/dracutdevs/dracut/issues

File Pull Requests:
        https://github.com/dracutdevs/dracut/pulls

Git:
        git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dracut.git
        https://github.com/dracutdevs/dracut.git

        git://git.kernel.org/pub/scm/boot/dracut/dracut.git
        https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS.md


Rendered view: https://github.com/dracutdevs/dracut/blob/master/NEWS.md

dracut-052
==========

#### Features

- **dracut:**
  - allow overriding the systemctl command for sysroot with `$SYSTEMCTL` for cross compilation
  - add additional global variables

     Variables like `dbusconfdir` or `systemdnetwork` are now exported
     to the individual modules as global variables. If they are not set
     in the distribution dracut config files, they are set via `pkg-config`

  - A `--no-uefi` option as been added to the CLI options to disable a default `uefi=yes`
    set by a configuration file.

- **kernel-modules:**  add modules from `drivers/memory` for arm
- **network-legacy:**  send dhcp in parallel on all devices via the `single-dhcp` option
- **dbus:**  introduce a meta module for dbus
- **dbus-broker:**  introduce the dbus-broker module
- **dbus-daemon:**  introduce the dbus-daemon module
- **systemd-ask-password:**  introduce the systemd-ask-password module
- **systemd-coredump:**  introduce the systemd-coredump module
- **systemd-modules-load:**  introduce the systemd-modules-load module
- **systemd-repart:**  introduce the systemd-repart module
- **systemd-sysctl:**  introduce the systemd-sysctl module
- **systemd-sysusers:** introduce the systemd-sysuser module

#### Bug Fixes

-   first round of shellcheck for all shell scripts
-   revise all module checks to not error out about missing dependencies
-   use the top-level `/efi` path to address the EFI partition
-   correct the squash quirk
-   use `find_binary` instead of other methods, because `find_binary` honors `dracutsysrootdir`
-   quote globbing in module-setup.sh for `inst_multiple`
-   move ldconfig after library workaround
-   do not set cmdline for uefi images unless asked
- **dracut:**  don't override `PATH`, if `dracutsysrootdir` is set
- **dracut-functions.sh:**  check kernel config from `dracutsysrootdir`
- **dracut-init.sh:**  make inst_libdir_file work with `dracutsysrootdir` set
- **dracut-install:**  allow globbing for multiple sources
- **06dbus:**
  -  do not hardcode path to dbus utils
  -  do not hardcode path to systemd unit
- **uefi**  use efivars fs over the deprecated sysfs entries
- **keyring**  adding shared keyring mode to systemd unit `dracut-pre-pivot.service`
- **35network-manager:**  avoid restarting NetworkManager
- **90kernel-modules:**  install generic crypto modules with hostonly unset
- **99squash:**  use kernel config instead of modprobe to check modules
- **dbus-daemon:**  use uid/gid from sysroot if `dracutsysrootdir` is set
- **kernel-modules:**  add reset controllers for arm
- **kernel-network-modules:**  also install modules from mdio subdirectory
- **mdraid:**
  -  remove the `offroot` option (long deprecated)
  -  add the grow continue service `mdadm-grow-continue`
- **network-legacy:**  silent the check for dhcp leaseinfo
- **network-manager:**  allow override network manager version
- **plymouth:**  install binaries with dependencies
- **shutdown:**  add timeout to umount calls
- **watchdog:**  fix dependencies in `module-setup.sh`

#### Contributors

- Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Jóhann B. Guðmundsson <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>
- Alexey Shabalin <shaba-u2l5PoMzF/Vg9hUCZPvPmw@public.gmane.org>
- Daniel Molkentin <daniel.molkentin-IBi9RG/b67k@public.gmane.org>
- Luiz Angelo Daros de Luca <luizluca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Mariusz Tkaczyk <mariusz.tkaczyk-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
- Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
- Anjali Kulkarni <anjali.k.kulkarni-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
- Beniamino Galvani <bgalvani-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- David Tardon <dtardon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Lukas Nykryn <lnykryn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Matthew Thode <mthode-sh12bNGkds0dnm+yROfE0A@public.gmane.org>
- Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
- Ondrej Mosnacek <omosnace-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Peter Levine <plevine457-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Petr Pavlu <petr.pavlu-IBi9RG/b67k@public.gmane.org>
- Vladius25 <vkorol2509-mVuRI66OGLPQT0dZR+AlfA@public.gmane.org>
- Yang Liu <50459973+ly4096x-KJX8L1YACloTKYOLMXNBRxrm3jAUxWOA@public.gmane.org>
- foopub <45460217+foopub-KJX8L1YACloTKYOLMXNBRxrm3jAUxWOA@public.gmane.org>
- realtime-neil <neil-BUf1+7jZtJs@public.gmane.org>


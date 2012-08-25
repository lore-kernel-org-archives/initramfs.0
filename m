From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: NBD boot problem
Date: Sat, 25 Aug 2012 16:21:14 +0200
Message-ID: <CAKzfqkcPKGzWKd+xFnhfh4fN1y70+foYyTSqEQTE-B70uod1GA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=QaQ6t0GJ1/6rzrOr0zudHoSI9bjjeVK6JzDQd6AgZbI=;
        b=DrmIxWKENa78IE1SPbysjdGoCfbPOpSc0O/Eqx5T9/XDE2xk5V6TI2zfGFgWVxAALe
         ZwDiwbiDCNfhir5dQRn+TRoOQB/KM6Z+i09SAGSNHxD1YOvKqXwaa+YfmF9PsyBG+YNN
         HI62jaPG1aDTWeJ98BmexDVkqrIK1msEQGfkbgMaiVgYrp2byrQzBH0GDDJMOyWW+4lk
         T1cK+OzigmLC8MU3wlUmk7n9InW2tOdGtAARCW+wyCqvlpElOhcyyfn7aMjwt4UM103C
         WwhZSjN5yEGWYu/+5pTuMzz9ERtGSmBclwBxbIpA1lyOLp2u97orfobxoMlBmZsK9w2C
         yT5Q==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

My Gentoo Dracut 023 image won't boot from an nbd block device.

The booting image connects to the nbd export, but continues looping
some checks until it says it won't boot. The the correct mount command
shows up in /lib/dracut/hooks/mount/01-1151-nbd.sh and I can even use
that command to actually mount the disk when I get dropped to the
shell:
/bin/mount -t squashfs -o ro /dev/nbd0 /sysroot

pxelinux append: APPEND initrd=ltsp/i686/nbdtest-initramfs-3.3.8
root=dhcp init=/sbin/init-ltsp
dnsmasq http opt: option:root-path,nbd:192.168.0.1:ltsp:squashfs:ro


The loop (with help of rdinitdebug and rdudevdebug flags)
/lib/dracut-lib.sh@319(check_finished): local f
/lib/dracut-lib.sh@320(check_finished): for f in
'$hookdir/initqueue/finished/*.sh'
/lib/dracut-lib.sh@321(check_finished): '['
/lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh = '/li$
/lib/dracut-lib.sh@322(check_finished): '[' -e
/lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh ']'
/lib/dracut-lib.sh@322(check_finished): .
/lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh
//lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh@1(source): '['
-f /tmp/setup_net_eth0.ok ']'
/lib/dracut-lib.sh@320(check_finished): for f in
'$hookdir/initqueue/finished/*.sh'
/lib/dracut-lib.sh@321(check_finished): '['
/lib/dracut/hooks/initqueue/finished/dhcp.sh = '/lib/dracut/$
/lib/dracut-lib.sh@322(check_finished): '[' -e
/lib/dracut/hooks/initqueue/finished/dhcp.sh ']'
/lib/dracut-lib.sh@322(check_finished): .
/lib/dracut/hooks/initqueue/finished/dhcp.sh
//lib/dracut/hooks/initqueue/finished/dhcp.sh@1(source): '[' -d
/sysroot/proc -o -e /dev/root ']'
/lib/dracut-lib.sh@322(check_finished): return 1
/init@172(): udevadm settle --timeout=0
/init@174(): for job in '$hookdir/initqueue/settled/*.sh'
/init@175(): '[' -e /lib/dracut/hooks/initqueue/settled/nbd.sh ']'
/init@176(): job=/lib/dracut/hooks/initqueue/settled/nbd.sh
/init@176(): . /lib/dracut/hooks/initqueue/settled/nbd.sh
//lib/dracut/hooks/initqueue/settled/nbd.sh@1(): '[' -e /dev/root ']'
///lib/dracut/hooks/initqueue/settled/nbd.sh@1(): udevadm info
--query=env --name=/dev/nbd0
//lib/dracut/hooks/initqueue/settled/nbd.sh@1(): info='UDEV_LOG=3
DEVPATH=/devices/virtual/block/nbd0
MAJOR=43
MINOR=0
DEVNAME=nbd0
DEVTYPE=disk
SUBSYSTEM=block'
//lib/dracut/hooks/initqueue/settled/nbd.sh@1(): '[' -z 'UDEV_LOG=3
DEVPATH=/devices/virtual/block/nbd0
MAJOR=43
MINOR=0
DEVNAME=nbd0
DEVTYPE=disk
SUBSYSTEM=block' ']'
/init@177(): check_finished
/lib/dracut-lib.sh@319(check_finished): local f
/lib/dracut-lib.sh@320(check_finished): for f in
'$hookdir/initqueue/finished/*.sh'
/lib/dracut-lib.sh@321(check_finished): '['
/lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh = '/li$
/lib/dracut-lib.sh@322(check_finished): '[' -e
/lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh ']'
/lib/dracut-lib.sh@322(check_finished): .
/lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh
//lib/dracut/hooks/initqueue/finished/dhclient-eth0.sh@1(source): '['
-f /tmp/setup_net_eth0.ok ']'
/lib/dracut-lib.sh@320(check_finished): for f in
'$hookdir/initqueue/finished/*.sh'
/lib/dracut-lib.sh@321(check_finished): '['
/lib/dracut/hooks/initqueue/finished/dhcp.sh = '/lib/dracut/$
/lib/dracut-lib.sh@322(check_finished): '[' -e
/lib/dracut/hooks/initqueue/finished/dhcp.sh ']'
/lib/dracut-lib.sh@322(check_finished): .
/lib/dracut/hooks/initqueue/finished/dhcp.sh
//lib/dracut/hooks/initqueue/finished/dhcp.sh@1(source): '[' -d
/sysroot/proc -o -e /dev/root ']'
/lib/dracut-lib.sh@322(check_finished): return 1
/init@180(): udevadm settle --timeout=0
/init@183(): sleep 0.5
/init@186(): '[' 1 -gt 40 ']'
/init@194(): main_loop=2
/init@195(): '[' 2 -gt 60 ']'
/init@154(): :
/init@156(): check_finished

Not sure if a bug or me doing something wrong.

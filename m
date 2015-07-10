From: Frank Steiner <fsteiner-mail1-G0GEQqhI7DhYiKXMg8wJIg@public.gmane.org>
Subject: swap device reference causes problem with initramfs for diskless
 clients
Date: Fri, 10 Jul 2015 17:01:12 +0200
Message-ID: <559FDE38.2080808@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

when trying to create a initramfs for a diskless client with dracut like

dracut -f initrd.diskless --kver=blabla--add nfs --add disklessmount 
  --kernel-cmdline "ip=eth0:dhcp root=nfs:<some ip>:/"

dracut will include a lot of references to the swap device of the host
where we execute this command. The /lib/dracut/hooks/initqueue/finished/devexists-<uuid>
will cause the diskless client to hang waiting for this device to show up.

The hard encoded swap device makes it impossible to create a initrd for
a host other than the one it is created on. The only workaround is to
comment out the line for the swap device in /etc/fstab, create the
initramfs and uncomment the line again. Not a good solution, though, as
we usually create the initrds automatically in %post sections of kernel rpms
and I don't want a script to mess around with the fstab.

As was proposed in http://thread.gmane.org/gmane.linux.kernel.initramfs/4111/focus=4112
there really should be a way to tweak the swap handling or at least to
disable it completely. I don't understand why I need a running swap
in the initramfs anyway, but if you see any interesting cases for this, 
please let me choose if I want it or not by default! For all our hosts
it would be ok if swap was only activated after chroot to /sysroot, and
all the "I cannot boot after I deleted/changed my swap space" posts you
find googling seem to indicate that many people could benefit from an 
easy way to disable swap in dracut.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *

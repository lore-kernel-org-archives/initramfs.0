From: Marcos Dione <mdione-od3Ii2+oAupd+7ixHBZSzg@public.gmane.org>
Subject: mdadm after disk detection / hook customization?
Date: Wed, 5 Aug 2009 15:17:59 +0200
Message-ID: <20090805131759.GT25022@mustang.grulicueva.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


    is this the proper list to discuss initramfs-tools? if not, I apologize
for the mistake.

    I'm having a problem booting a debian lenny machine. what's happening is
that mdadm is run half a second befor the scsi hard disks are detected, so
it doesn't find them, so the boot fails. when I get dumped to the emergency
shell, I can run mdadm --assemble --scan it correctly assembles the raid
arrays, and quiting the emergency shell it continues booting without
problem.

    well, I thought, let's add a delay just before mdadm is run. that's how
I got introduced in the great world ot initramfs-tools. first I tried just
puting the delay[1] in /etc/initramfs-tools/conf.d/md, but then I discovered
that the final file (/conf/conf.d/md in the initrd file) is overwriten by
/usr/share/initramfs-tools/hooks/mdadm.

    fine, let's just add a new hook in
/etc/initramfs-tools/hooks/mdadm-delay that depends on the mdadm hook which
appends the delay in that config file. the code is this:

--- cut here ---
#! /bin/sh

PREREQ="mdadm"
prereqs()
{
     echo "$PREREQ"
}

case $1 in
prereqs)
     prereqs
     exit 0
     ;;
esac

# from /usr/share/initramfs-tools/hooks/mdadm
DESTCONFIG=$DESTDIR/conf/conf.d/md

# HACK: mdadm is run before the scsi disks are detected
# HACK: add some delay by inserting sleep in the mdadm boot script config file
echo 'sleep 5' >> $DESTCONFIG
--- cut here ---

    no surprises, of course. I update the initrd[2] just to discover that my
script doesn't seem to be run, even if it perms are 755 (this is not
documented in the initramfs-tools manpage). I run the command under strace
to discover that, precisely, my script is not run, even when the
aforementioned manpage implies that hooks in that dir are used. 

    fine, maybe some mistake in the doc. I moved the script to
/usr/share/initramfs-tools/hooks and rerun the command, but no cigar.
running it again with strace I see that /usr/sbin/mkinitramfs actually opens
the directory, but then happily and thoroughly ignores my mdadm-delay
script. it doesn't even stat the file. here's the relevant output of strace:

[pid 23960] execve("/usr/sbin/mkinitramfs", ["mkinitramfs", "-o", "/boot/initrd.img-2.6.26-2-686.ne"..., "2.6.26-2-686"], [/* 20 vars */]) = 0
[...]
[pid 23960] open("/usr/share/initramfs-tools/hooks/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
[pid 23960] getdents64(3, /* 10 entries */, 4096) = 296
[pid 23960] getdents64(3, /* 0 entries */, 4096) = 0
[...]

    here's the current contents of the dir:

beinginstalled1:~/tmp# ls -la /usr/share/initramfs-tools/hooks
total 56
drwxr-xr-x 2 root root  4096 2009-08-05 14:39 .
drwxr-xr-x 7 root root  4096 2009-08-03 17:29 ..
-rwxr-xr-x 1 root root   498 2007-12-25 17:03 kernelextras
-rwxr-xr-x 1 root root   981 2008-08-13 15:23 keymap
-rwxr-xr-x 1 root root   444 2008-08-13 15:23 legacylvm
-rwxr-xr-x 1 root root  7980 2009-06-12 11:18 mdadm
-rwxr-xr-x 1 root root   369 2009-08-05 14:16 mdadm-delay
-rwxr-xr-x 1 root root   844 2007-12-25 17:03 thermal
-rwxr-xr-x 1 root root   654 2009-04-15 23:05 udev
-rwxr-xr-x 1 root root   563 2008-08-13 15:23 udevhelper
beinginstalled1:~/tmp# ls -la /usr/share/initramfs-tools/hooks | grep -v total | wc -l
10

    that's the 10 entries allright.

    so, after all this, here come the questions.

    a) is there any proper way to make the initrd run mdadm after the disks
have been detected?

    b) which is the proper way to customize a initrd? I thought putting
things in /etc/initramfs-tools/ would be enough. did I miss something?

    c) why my script not being picked up?

--
[1] just a simple 'sleep 5'. I prefer haviing 5 more seconds of boottime
    instead of no boot at all.

[2] for the curious, the command I use is: 
    dpkg-reconfigure linux-image-$(uname -r)
-- 
(Not so) Random fortune:
13:30 < Irii3sha> al final que fue de #grulic y #grulic-cafe?
13:31 < Irii3sha> supongo que #grulic esta muerto y #grulic-cafe es el
    bar de la esquina de los carbel
	    -- Los nicks han sido cambiados para proteger a los inocentes.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

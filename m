From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Dracut and other distributions - an experiment
Date: Wed, 11 Feb 2009 10:39:30 -0200
Message-ID: <82ecf08e0902110439i1835b946p8491e809d17703fa@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=PSJkH/5WYJ1OWgUykLK+Ajz+jexAH8L7kvUfy0kfW6E=;
        b=X7juJFkMw02ZLnQLWzdDb8J8MBQfrLpER/L/C2l3NupzTN9gKitjUwNEEnoNDiy8Lz
         iBdPiOe6OSRLVF32IrNH0CV8QkVqfVMGte2mBErshcfnF5EZ8jM4Ks64s8eZchcZgTPC
         ZckW+SRuvEdS/0qHrSaqM/piEMR4KlzKGti9E=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I've been trying to run dracut in other distributions (both generating
and booting with the generated initrd) and there are several problems
to be tackled (most of them I don't have a clue how to solve them
properly).for testing purposes I've been using of non portable fixes
(hence no patches - yet - until there's a way to solve them properly )

This is very preliminary still, more problems will come, for sure.

Here's a rundown of the problems I found

in dracut

- Some distros use switch_root, others pivot_root (and this has to be
copied from somewhere when generating, unless dracut comes with its
own set of tools)

I guess the best solution would be to import a switch_root.c to dracut
and bundle that (like it was suggested somewhere else)

- Tools that are copied from the fs, like $exe, $debugexe, the problem
there is libraries... Ok, some distros offer
/usr/lib/klibc/bin/sh.shared, a bash that doesn't depend on any
libraries, but running bash per se (and other things like ls) in the
emergency console was not possible for the time being

Maybe consider busybox for the initrd

Also, if you remove $exe from the for, you end up with /bin as a file,
not as a directory (oh well...)

- udev rules are located in /etc/udev/rules.d/

Maybe detect its location and copy everything / copy files from
dracut.conf ?? (more of that later)

- udevd won't run without libs! F10 example

ldd $(which udevd)
        linux-vdso.so.1 =>  (0x00007fff3bbff000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003b68600000)
        libc.so.6 => /lib64/libc.so.6 (0x0000003b67600000)
        libdl.so.2 => /lib64/libdl.so.2 (0x0000003b67e00000)
        /lib64/ld-linux-x86-64.so.2 (0x0000003b67200000)

Oh well...

In init

- no /dev/console is created

At least in my tests I had to create it by hand

- udev won't run without libs /o\

- The tiny shell I used (sh.shared) barfed on  "label=${l//\//\\x2f}"
where it checks LABEL= for root

Also, without udev, I had to create /dev/hda1 by hand

Some tiny mounts don't like mount --bind /dev $NEWROOT/dev, we'll
probably have to go with the full-blown mount

This was mostly based on Ubunty Hardy, some things work the same on
MDV2008 (I checked) but those are the distributions I have access
right now (as well as F8 and F10)

-- 
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

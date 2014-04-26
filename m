From: shubham sharma <newbie.shubham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: initramfs build issue
Date: Sat, 26 Apr 2014 16:49:17 +0530
Message-ID: <CAJT_ubY-2ezZ3jD24zp0yvhto3U6Pr3oP0ut18cTgE76Yfxo9Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ni/Kuq9+bcpieWqhBSqfh5uWkCCNe6hRdl2288ugbm0=;
        b=WKrk6R/w/6UeZVDYNygDkHK3BNlOqJ1A68HygxM8OJdJEYhXQxo66ojAWsHtfH3F+S
         qjG40z4w7HUp4Jfh0cl5EcidL5iOe5VGyU71D/i6WH/6Fu1KCNUPaM+w25Ti+OKR0CEk
         J4krVrrLtnKNiBf5rTY1wVQ03YI9UJJ1Qm0CPYy6yIeKnWtwIB6Fm3A32JJIkHR4iQ51
         ncbgmhqwmnxyx7MiceYLFMPmZwtMKQJfAiu82qaJbRlA74BZKItPDkmuMN//cXg0fD/J
         coqx5RSVidw+r4U9fT+yxaNU9TVYT6bgKLPaPSsg1bmzGnI9y+nCtzHVqyc/0lE+x2Ak
         pcdg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I am trying to build a custom initramfs on RHEL7 using dracut. I
created my custom modules (which i want to get executed when the udev
event settles down) and placed them in the /usr/lib/dracut/modules.d
directory. The initramfs got created successfully but when i boot the
box with it, i am seeing that the boot process goes into the following
loop:

----8<----

[   18.072983] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@69(): '[' 27 -gt 360 ']'
[   18.080265] libl038 dracut-initqueue[338]: /bin/dracut-initqueue@24(): :
[   18.087346] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@26(): check_finished
[   18.094250] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@408(check_finished): local f
[   18.100993] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@409(check_finished): for f in
'$hookdir/initqueue/finished/*.sh'
[   18.107673] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@410(check_finished): '['
'/lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7eb-9fc82452c31a.sh'
= '/lib/dracut/hooks/initqueue/finished/*.sh' ']'
[   18.114435] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@411(check_finished): '[' -e
'/lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7eb-9fc82452c31a.sh'
']'
[   18.120823] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@411(check_finished): .
'/lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7eb-9fc82452c31a.sh'
[   18.127617] libl038 dracut-initqueue[338]:
//lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7'['
-e /dev/disk/by-uuid/e96b3d2c-7379-4ffd-a7eb-9fc82452c31a ']'
[   18.134334] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@411(check_finished): return 1
[   18.141341] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@28(): udevadm settle
--exit-if-exists=/lib/dracut/hooks/initqueue/work
[   18.148367] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@30(): check_finished
[   18.155647] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@408(check_finished): local f
[   18.162898] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@409(check_finished): for f in
'$hookdir/initqueue/finished/*.sh'
[   18.170328] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@410(check_finished): '['
'/lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7eb-9fc82452c31a.sh'
= '/lib/dracut/hooks/initqueue/finished/*.sh' ']'
[   18.177756] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@411(check_finished): '[' -e
'/lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7eb-9fc82452c31a.sh'
']'
[   18.185244] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@411(check_finished): .
'/lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7eb-9fc82452c31a.sh'
[   18.192645] libl038 dracut-initqueue[338]:
//lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2fe96b3d2c-7379-4ffd-a7'['
-e /dev/disk/by-uuid/e96b3d2c-7379-4ffd-a7eb-9fc82452c31a ']'
[   18.200228] libl038 dracut-initqueue[338]:
/lib/dracut-lib.sh@411(check_finished): return 1
[   18.207877] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@32(): '[' -f /lib/dracut/hooks/initqueue/work
']'
[   18.215479] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@36(): for job in '$hookdir/initqueue/*.sh'
[   18.223451] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@37(): '[' -e '/lib/dracut/hooks/initqueue/*.sh'
']'
[   18.231351] libl038 dracut-initqueue[338]: /bin/dracut-initqueue@37(): break
[   18.239718] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@42(): udevadm settle --timeout=0
[   18.247964] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@44(): for job in
'$hookdir/initqueue/settled/*.sh'
[   18.256643] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@45(): '[' -e
'/lib/dracut/hooks/initqueue/settled/*.sh' ']'
[   18.265291] libl038 dracut-initqueue[338]: /bin/dracut-initqueue@45(): break
[   18.273956] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@50(): udevadm settle --timeout=0
[   18.282659] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@53(): sleep 0.5
[   18.556978] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@55(): for i in '/run/systemd/ask-password/ask.*'
[   18.564651] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@56(): '[' -e '/run/systemd/ask-password/ask.*'
']'
[   18.572314] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@59(): '[' 27 -gt 240 ']'
[   18.579813] libl038 dracut-initqueue[338]:
/bin/dracut-initqueue@68(): main_loop=28


----8<----

This loop goes on till the main_loop reaches the value 360 and then
the emergency shell of dracut comes up. Is there some special option i
need to give in my modules to prevent this?

Regards,
Shubham

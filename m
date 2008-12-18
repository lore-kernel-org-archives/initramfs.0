From: "=?ISO-8859-1?Q?Lo=EFc_Greni=E9?=" <loic.grenie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Thu, 18 Dec 2008 10:27:40 +0100
Message-ID: <9b06e8d20812180127s2b6cdbl410333336c7c9beb__4232.81161715767$1232286223$gmane$org@mail.gmail.com>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217193151.GA7356@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com;
 s=gamma; h=domainkey-signature:received:received:message-id:date:from:to
 :subject:cc:in-reply-to:mime-version:content-type
 :content-transfer-encoding:content-disposition:references;
 bh=pmXJeOXg/Hgl3cTCe2Lm1XBs2H0tqLoGqcU/R1zhlnE=;
 b=C5qn9NFbOoVNCLxyO4c/H7bEkUNWNgQ/EAVCZ0OqzxiPtcirqj1+v51n/ozR5fjOga
 iuNFpYjA4NrXWPKSBk8I0yOpNlFv2+I8OOsJGMU/jFxybdzz7tCViReEU+WVq0b8/UDF
 zp5uZ6VJHvtYVkRdYS4uquYfqYzUniLhQb7Go=
In-Reply-To: <20081217193151.GA7356-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org

2008/12/17 Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>:
> On Wed, Dec 17, 2008 at 01:54:54PM -0500, Jeremy Katz wrote:

[snip]

>> Therefore I've started on a new project, dracut, to try to be a new
>> initramfs tool that can be used across various distributions.  From the
>> README...
>>
>> Unlike existing initramfs's, this is an attempt at having as little as
>> possible hard-coded into the initramfs as possible.  The initramfs has
>> (basically) one purpose in life -- getting the rootfs mounted so that we
>> can transition to the real rootfs.

[snip]

> Not that I don't think a unifying tool to create an initramfs is a bad id=
ea
> (quite the contrary, I think it would be great), but I'd like to point ou=
t that
> one of your underlying premises is a bit shaky.  That an initramfs has one
> purpose, that being to get the rootfs mounted, isn't entirely accurate.  =
Kdump
> and various embedded systems being the prime examples here.  Many embedded
> systems run entirely out of the initramfs, and contain all the code they =
need to
> do so in them.  Additionally, kdump in most environments, attemps to capt=
ure
> core files entirely from the initramfs as well, operating under the assum=
ption
> that the rootfs may not be functioning properly after a crash.  By and la=
rge
> these initramfs images tend to be larger and offer a more typical (if not
> standard) user operating environment.  I'm looking at your tree now, and =
it
> looks like a good start on standardizing the initramfs for the nominal ca=
se.  Do
> you have plans to include (or are you interested in including) support for
> alternate infrastructure (like busybox instead of nash), interactive setu=
p, etc?

    Seconded: as a user of (various) distributions, I've come across
the following
  problem: sometimes the initramfs, for whatever reason, does not manage to
  find or mount the rootfs. In those cases I hate the developpers of
the distribution
  because there is basically nothing that can be done in the initramfs
to see, test,
  try, mount, modprobe, umount, ping, telnet, etc... Please, please, throw =
in a
  full-featured busybox. Here is a good compromise I use:

Currently defined functions:
        [, [[, arp, arping, ash, awk, basename, brctl, bunzip2, bzcat,
        bzip2, cat, chgrp, chmod, chown, chroot, chvt, clear, cmp, comm,
        cp, cpio, cut, date, dc, dd, deallocvt, depmod, df, diff, dirname,
        dmesg, dos2unix, dpkg, dpkg-deb, du, dumpkmap, echo, egrep, eject,
        env, expr, false, fbset, fdflush, fdformat, fdisk, fgrep, find,
        findfs, ftpget, ftpput, grep, gunzip, gzip, halt, head, hexdump,
        hostname, hwclock, ifconfig, ifenslave, insmod, ip, ipcalc, kbd_mod=
e,
        kill, killall, killall5, less, linux32, linux64, ln, loadfont,
        loadkmap, losetup, ls, lsmod, md5sum, microcom, mkdir, mkfifo,
        mknod, mkswap, mktemp, more, mount, mv, nice, od, openvt, patch,
        pgrep, pidof, ping, ping6, pivot_root, pkill, poweroff, printf,
        ps, pwd, readlink, reboot, reset, rm, rmdir, rmmod, route, rpm2cpio,
        rtcwake, sed, setarch, setkeycodes, sh, sha1sum, sleep, sort,
        stat, strings, stty, su, swapoff, swapon, switch_root, sync, tac,
        tail, tar, tee, telnet, test, touch, tr, traceroute, true, tty,
        udhcpc, umount, uname, uniq, unix2dos, unzip, vi, wc, wget, which,
        xargs, yes, zcat

  (linux32 and linux64 are probably not useful for general initramfs). With=
 that
  configuration, busybox (v1.13.0.svn, x86-32 executable) is 416224 bytes l=
ong
  (dynamically linked with libc as only library needed).

          Lo=EFc Greni=E9
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

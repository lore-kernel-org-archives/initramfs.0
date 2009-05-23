From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 07:48:01 -0500
Message-ID: <1243082881.29452.45.camel@sentry-no.us.dell.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=cnTeu38Fa5QZ7c1eObPlUYrlK+TIdKtg5HJlQ4uO5G4=;
        b=jXsr1MJC/TjYE/BWs3PDVg9F4Qv7OKZMZJSR6i/3akMcPAmn6wulQhUxkXEqjcYKor
         jsgtm7xsQx55UvQHRWrqMgrmrYhfRpf4noaLNpJ4IwvdCLEQjRfVdxbXM4tnsCi4yi0S
         WxdKEuBXks0fjjjDsvTgdXtJ+MoQQBFa/hCOU=
In-Reply-To: <Pine.LNX.4.58.0905231331400.2058-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 2009-05-23 at 13:34 +0200, Andreas Thienemann wrote:
> When using the 00dash module in dracut, the emergency_shell currently has 
> no stderr.
> 
> Problem is related to dash closing stderr if opening /dev/tty fails.
> 
> I just triggered an update to dash in fedora F11 and rawhide fixing this 
> behaviour.
> This should make the emergency shell much easier to work with.

In the meantime, though...

diff --git a/modules.d/99base/init b/modules.d/99base/init
index ac6a2d8..fbebff1 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -35,6 +35,7 @@ NEWROOT="/sysroot"
 
 trap "emergency_shell" 0
 
+# we need /dev/null really early
 mknod /dev/null c 1 3
 
 # mount some important things
@@ -42,15 +43,17 @@ mount -t proc /proc /proc >/dev/null 2>&1
 mount -t sysfs /sys /sys >/dev/null 2>&1
 mount -t tmpfs -omode=0755 udev /dev >/dev/null 2>&1
 
-read CMDLINE </proc/cmdline;
-getarg ramfsdebug && set -x
 # Make some basic devices first, let udev handle the rest
 mknod /dev/null c 1 3
 mknod /dev/ptmx c 5 2
 mknod /dev/console c 5 1
+mknod /dev/tty c 5 0
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 
+read CMDLINE </proc/cmdline;
+getarg ramfsdebug && set -x
+
 # pre-udev scripts run before udev starts, and are run only once.
 getarg 'break=pre-udev' && emergency_shell
 source_all pre-udev


> regards,
>  andreas
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 12:58:20 +0000
Message-ID: <20101109125820.GO19612@vostochny.stro.at>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com> <4CD9102B.7030702@bfh.ch> <AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Nov 09, 2010 at 12:11:58PM +0100, Jon Ander Hernandez wrote:
> diff -urN dracut/dracut-postinst.d dracut-007/dracut-postinst.d
> --- dracut/dracut-postinst.d	1970-01-01 01:00:00.000000000 +0100
> +++ dracut-007/dracut-postinst.d	2010-10-21 02:49:45.714564995 +0200
> @@ -0,0 +1,4 @@
> +#!/bin/bash
> +
> +version=$1
> +dracut-update-initramfs -c -k ${version}

please have a look at /etc/kernel/postinst.d/initramfs-tools this
is far from complete.

> diff -urN dracut/dracut-prerm.d dracut-007/dracut-prerm.d
> --- dracut/dracut-prerm.d	1970-01-01 01:00:00.000000000 +0100
> +++ dracut-007/dracut-prerm.d	2010-10-21 02:49:45.714564995 +0200
postrm.d is the right dir.
> @@ -0,0 +1,4 @@
> +#!/bin/bash
> +
> +version=$1
> +dracut-update-initramfs -d -k ${version}

same comment as aboves, see /etc/kernel/postrm.d/initramfs-tools
 
 
> - Postinst script can be executed when installing first time dracut,
> and when we are upgrading Dracut. Check if it should create a new
> initramfs or if it should upgrade it.
> 
> diff -urN dracut/debian/dracut.postinst dracut-007/debian/dracut.postinst
> --- dracut/debian/dracut.postinst	2010-08-09 16:13:51.000000000 +0200
> +++ dracut-007/debian/dracut.postinst	2010-10-21 02:49:45.714564995 +0200
> @@ -2,7 +2,11 @@
> 
>  set -e
> 
> -# Regenerate initramfs when we're `installed`
> -DPKG_MAINTSCRIPT_PACKAGE='' dracut-update-initramfs -u
> +if [ -f /boot/dracut.img-`uname -r` ]; then
> +    # Regenerate initramfs when we're `installed`
> +    DPKG_MAINTSCRIPT_PACKAGE='' dracut-update-initramfs -t -u
> +else
> +    dracut-update-initramfs -c -k `uname -r`
> +fi

not sure why you want a create at all here, create should be called
by linux-2.6 images not the wrapper script itself.
> 
> 
> - Create the man files when building the package. Make
> dpkg-buildpackage execute make all, instead of just make.
> The override_dh_auto_test line, prevents dpkg-buildpackage from
> executing make test.
> 
> diff -urN dracut/debian/rules dracut-007/debian/rules
> --- dracut/debian/rules	2010-08-09 16:13:51.000000000 +0200
> +++ dracut-007/debian/rules	2010-10-21 02:49:45.714564995 +0200
> @@ -1,3 +1,10 @@
>  #!/usr/bin/make -f
> 
> -include /usr/share/cdbs/1/rules/debhelper.mk
> +%:
> +	dh $@
> +
> +override_dh_auto_build:
> +	dh_auto_build -- all
> +
> +override_dh_auto_test:
> +

the changelog vor this change is very confusing,
essentialy you change here from a cdbs source package to a dh one.
 
-- 
maks

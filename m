From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] run-qemu Enhancements
Date: Fri, 22 May 2009 20:33:11 -0500
Message-ID: <1243042394.29452.36.camel@sentry-no.us.dell.com>
References: <Pine.LNX.4.58.0905211222460.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=xqAU680i12Kyi3avFfFif7qtf1IRFgWzHZ4JIq2CSfc=;
        b=UBsuEE+w0i9Uj7E8RVkoqMvZivG2wAzimOS89iRwdaMEBI/ksewPnnGwH/FkQVqbJy
         aRndGFwOCpDIxXgocERBILSGv0+zoIALxGZQ/vlNhO+1PVIgGID1aJDfUC6lPc3TpEsA
         NaQ3/lP+mBBLzq0An03DoIXg+Oym4iOUublnM=
In-Reply-To: <Pine.LNX.4.58.0905211222460.7805-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2009-05-21 at 12:24 +0200, Andreas Thienemann wrote:
> Support different virtualization technologies for run-qemu. This patch 
> should be applied on top of the patchset from Victor Lowther.
> 
> If the host supports kvm, use is. If this is not the case but the kqemu
> module is loaded, run qemu with kqemu optimization. Otherwise fall-back to
> pure usermode qemu.
> 
> diffstat dracut-run-qemu-enhancements.patch 
>  run-qemu |   24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff -up dracut/test/run-qemu.orig dracut/test/run-qemu
> --- dracut/test/run-qemu.orig	2009-05-21 12:16:14.622759670 +0200
> +++ dracut/test/run-qemu	2009-05-21 12:16:22.858798678 +0200
> @@ -1,9 +1,17 @@
>  #!/bin/bash
> -for f in kvm qemu-kvm qemu; do
> -    type $f >/dev/null 2>&1 || continue
> -    $f "$@"
> -    exit
> -done
> -echo "Could not find a working KVM or QEMU to test with!"
> -echo "Please install kvm or qemu."
> -exit 1
> \ No newline at end of file
> +
> +# Check which virtualization technology to use
> +# We prefer kvm, kqemu, userspace in that order.
> +[[ -x /usr/bin/qemu ]] && BIN=/usr/bin/qemu && ARGS=""
> +$(lsmod | grep -q '^kqemu ') && BIN=/usr/bin/qemu && ARGS="-kernel-kqemu "
> +[[ -b /dev/kvm && -x /usr/bin/kvm ]] && BIN=/usr/bin/kvm && ARGS=""
> +[[ -b /dev/kvm && -x /usr/bin/qemu-kvm ]] && BIN=/usr/bin/qemu-kvm && ARGS=""

Why hardcode the locations of qemu and kvm?  As long as they are on the
path, that should be sufficient.

> +[[ $BIN ]] || {
> +   echo "Could not find a working KVM or QEMU to test with!" >&2
> +   echo "Please install kvm or qemu." >&2
> +   exit 1
> +}
> +
> +echo "Running $BIN $ARGS"
> +$BIN $ARGS "$@"

Why the extra verbosity?  I prefer to complain only if somehting went
wrong -- if we found a working qemu, the results will speak for
themselves.

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

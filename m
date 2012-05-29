From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] dmsquash-live: do not hardcode path to mount(8) in
 generated hook.
Date: Tue, 29 May 2012 09:13:27 +0200
Message-ID: <4FC47717.1040009@redhat.com>
References: <20120528161728.3425f35f.xtraeme@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120528161728.3425f35f.xtraeme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Juan RP <xtraeme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 28.05.2012 16:17, schrieb Juan RP:
> 
> In some cases (at least in mine) mount(8) is in /usr/bin/mount and
> not in /bin/mount as dmsquash-live-root.sh expects. PATH is set to
> /usr/bin:/usr/sbin:/sbin:/bin in that script anyway.
> ---
>  modules.d/90dmsquash-live/dmsquash-live-root.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> index fdbd6f5..990a55b 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> @@ -204,7 +204,7 @@ if [ -b "$BASE_LOOPDEV" ]; then
>      ln -s $BASE_LOOPDEV /run/initramfs/live-baseloop
>  fi
>  ln -s /dev/mapper/live-rw /dev/root
> -printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT" > $hookdir/mount/01-$$-live.sh
> +printf 'mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT" > $hookdir/mount/01-$$-live.sh
>  
>  need_shutdown
>  

Thanks!

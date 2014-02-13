From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add fsck passno to dracut --mount args
Date: Thu, 13 Feb 2014 09:42:23 -0500
Message-ID: <20140213144222.GG30844@redhat.com>
References: <20140212072229.GA15908@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140212072229.GA15908-je1gSBvt1TcFLmT5oZ11vB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kexec-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Feb 12, 2014 at 03:22:30PM +0800, Dave Young wrote:
> We are using dracut --mount to pass fstab lines for mounting filesystems
> other than rootfs. But we did not provide passno for filesystem checking.
> 
> Add passno '2' for all the --mount targets.
> 
> Tested in F19 guest.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  mkdumprd |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- kexec-tools.orig/mkdumprd
> +++ kexec-tools/mkdumprd
> @@ -104,7 +104,7 @@ to_mount() {
>      _o=$(findmnt -k -f -n -r -o OPTIONS $_dev)
>      _o=${_o/#ro/rw} #mount fs target as rw in 2nd kernel
>      _o="${_o},nofail" #with nofail set, systemd won't block for mount failure
> -    _mntopts="$_t $_o"
> +    _mntopts="$_t $_o 0 2"

What is 0 here. I think you are trying to emulate the format of an fstab
file and passing 5th and 6th field.

I don't think they are filesystem options. If you trying to mount a file
system with 0 and 2 passed as additional parameters, mount will complain
that what is 0 and 2 it does not understand.

I am CCing harald. He might have thoughts on what's the better way to
pass the fsck_passno of filesystem being mounted. I would not mind of
passno 2 is hardcoded for anything passed in using --mount option in
dracut.

Thanks
Vivek

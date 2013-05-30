From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] 99fs-lib/fs-lib.sh: Let user specify the action after
 fail for fsck
Date: Thu, 30 May 2013 08:28:51 +0200
Message-ID: <51A6F1A3.3070503@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369809156.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369809156.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 08:33 AM, Baoquan He wrote:
> The fsck is ignored when replace emergency_shell with action_on_fail,
> now add it.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/99fs-lib/fs-lib.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
> index e1f3074..88e7348 100755
> --- a/modules.d/99fs-lib/fs-lib.sh
> +++ b/modules.d/99fs-lib/fs-lib.sh
> @@ -7,14 +7,14 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>  fsck_ask_reboot() {
>      info "note - fsck suggests reboot, if you"
>      info "leave shell, booting will continue normally"
> -    emergency_shell -n "(reboot ?)"
> +    action_on_fail -n "(reboot ?)"
>  }
>  
>  fsck_ask_err() {
>      warn "*** An error occurred during the file system check."
>      warn "*** Dropping you to a shell; the system will try"
>      warn "*** to mount the filesystem(s), when you leave the shell."
> -    emergency_shell -n "(Repair filesystem)"
> +    action_on_fail -n "(Repair filesystem)"
>  }
>  
>  # inherits: _ret _drv _out
> 

Applied, thanks!

commit 679fa7ed3c0f4c827bfc6885d34f56713fe85c1e

From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] resume from any suspend partition
Date: Thu, 18 Jun 2009 13:50:39 +0200
Message-ID: <20090618115039.GA6431@nb.net.home>
References: <1245313401-4185-1-git-send-email-harald@redhat.com> <1245313401-4185-2-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1245313401-4185-2-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jun 18, 2009 at 10:23:21AM +0200, Harald Hoyer wrote:
> If not "noresume" is specified and no explicit "resume=" given, try to resume
> from any partition with type "suspend"
> ---
>  modules.d/95resume/resume-genrules.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
> index 13b91a5..5ff4efe 100755
> --- a/modules.d/95resume/resume-genrules.sh
> +++ b/modules.d/95resume/resume-genrules.sh
> @@ -5,4 +5,7 @@ if [ -n "$resume" ]; then
>      printf "SYMLINK==\"%s\", RUN+=\"/bin/sh -c 'echo %%M:%%m > /sys/power/resume'\"\n" \
>  		${resume#/dev/}
>      ) >> /etc/udev/rules.d/99-resume.rules
> +elif  ! getarg noresume; then
> +    echo "SUBSYSTEM==\"block\", ACTION==\"add\", ENV{ID_FS_TYPE}==\"suspend\", RUN+=\"/bin/sh -c 'echo %M:%m > /sys/power/resume'\"" \
> +    >> /etc/udev/rules.d/99-resume.rules
>  fi

 Unfortunately, obsolete libvolume_id uses "suspend", but all versions of
 libblkid uses "swsuspend". 
 
 You have to fix this rule after update to the latest udev that is
 without vol_id.

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

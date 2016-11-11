From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] dracut-install: preserve extended attributes when
 copying files
Date: Fri, 11 Nov 2016 14:11:40 -0500
Message-ID: <1478891500.31015.52.camel@linux.vnet.ibm.com>
References: <1477422589-21327-1-git-send-email-stefanb@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477422589-21327-1-git-send-email-stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Hi Harold,

Thank you for upstreaming commit 479b5cd "98integrity: support
validating the IMA policy file signature".   Do you have any
comments/concerns about this patch?

thanks,

Mimi

On Tue, 2016-10-25 at 15:09 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
> 
> Preserve extended attributes when copying files using dracut-install.
> 
> The copying of extended attributes avoids file execution denials when
> the Linux Integrity Measurement's Appraisal mode is active. In that mode
> executables need their file signatures copied. In particular, this patch
> solves the problem that dependent libaries are not included in the
> initramfs since the copied programs could not be executed due to missing
> signatures. The following audit record shows the type of failure that
> is now prevented:
> 
> type=INTEGRITY_DATA msg=audit(1477409025.492:30065): pid=922 uid=0
>  auid=4294967295 ses=4294967295
>  subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>  op="appraise_data" cause="IMA-signature-required"
>  comm="ld-linux-x86-64"
>  name="/var/tmp/dracut.R6ySa4/initramfs/usr/bin/journalctl"
>  dev="dm-0" ino=37136 res=0
> 
> Signed-off-by: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> ---
>  install/dracut-install.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/install/dracut-install.c b/install/dracut-install.c
> index fe30bba..c0f1c17 100644
> --- a/install/dracut-install.c
> +++ b/install/dracut-install.c
> @@ -294,7 +294,7 @@ static int cp(const char *src, const char *dst)
>   normal_copy:
>          pid = fork();
>          if (pid == 0) {
> -                execlp("cp", "cp", "--reflink=auto", "--sparse=auto", "--preserve=mode,timestamps", "-fL", src, dst,
> +                execlp("cp", "cp", "--reflink=auto", "--sparse=auto", "--preserve=mode,timestamps,xattr", "-fL", src, dst,
>                         NULL);
>                  _exit(EXIT_FAILURE);
>          }
> @@ -302,7 +302,7 @@ static int cp(const char *src, const char *dst)
>          while (waitpid(pid, &ret, 0) < 0) {
>                  if (errno != EINTR) {
>                          ret = -1;
> -                        log_error("Failed: cp --reflink=auto --sparse=auto --preserve=mode,timestamps -fL %s %s", src,
> +                        log_error("Failed: cp --reflink=auto --sparse=auto --preserve=mode,timestamps,xattr -fL %s %s", src,
>                                    dst);
>                          break;
>                  }


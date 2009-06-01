From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 5/9] resume: add support for labeled resume devices
Date: Mon, 01 Jun 2009 04:30:18 -0500
Message-ID: <1243848618.647.15.camel@sentry-no.fnordovax.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <9810ce7e38ec1ba52a9c2f5f5047ea779d1006a3.1243833882.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=wW6z3904YlrUMF3yHHpS/5Vd0gxacPdTtreTQHMSdQo=;
        b=pKURr5XMK998Q0MTbqgzfLdZE6ZHxO1rGHKa986qp+V/3uWd2HfLfvsLU8aeQLf0nq
         ip3/zesz15xfZ30mU7boq7HPUQahxsBnCvu7lArBlJJ82CgxiX/ObadFjNzZhsIAttqA
         /azAUe4cSHMI1o//98y6DVVYd4XSSdEig4EOo=
In-Reply-To: <9810ce7e38ec1ba52a9c2f5f5047ea779d1006a3.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 00:25 -0400, David Dillow wrote:
> I noticed when doing the block root= parser that resume
> didn't support labeled resume devices. Fix that up and
> get rid of a dependency on /bin/echo in the process.
> 
> Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
> ---
>  modules.d/95resume/install            |    1 -
>  modules.d/95resume/parse-resume.sh    |    8 ++++++++
>  modules.d/95resume/resume-genrules.sh |   14 ++++++++------
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/modules.d/95resume/install b/modules.d/95resume/install
> index 945611e..cecd2fc 100755
> --- a/modules.d/95resume/install
> +++ b/modules.d/95resume/install
> @@ -1,5 +1,4 @@
>  #!/bin/bash
> -dracut_install echo

erm, not exactly.

>  inst_hook cmdline 10 "$moddir/parse-resume.sh"
>  inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
>  inst_hook mount 90 "$moddir/resume.sh"
> diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/parse-resume.sh
> index 447e151..94d7112 100755
> --- a/modules.d/95resume/parse-resume.sh
> +++ b/modules.d/95resume/parse-resume.sh
> @@ -5,3 +5,11 @@ if resume=$(getarg resume=) && ! getarg noresume; then
>  else
>      unset resume
>  fi
> +
> +case "$resume" in
> +    LABEL=*)
> +	resume="$(echo $resume | sed 's,/,\\x2f,g')"
> +	resume="/dev/disk/by-label/${resume#LABEL=}" ;;
> +    UUID=*)
> +	resume="/dev/disk/by-uuid/${resume#UUID=}" ;;
> +esac
> diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
> index 108c3f7..7c95715 100755
> --- a/modules.d/95resume/resume-genrules.sh
> +++ b/modules.d/95resume/resume-genrules.sh
> @@ -1,6 +1,8 @@
> -resume=$(getarg resume=) && ! getarg noresume  && {
> -(
> -	/bin/echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
> -	/bin/echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
> -) >> /etc/udev/rules.d/99-resume.rules
> -}

The real dependency is in the RUN+= part.

> +if [ -n "$resume" ]; then
> +    (
> +    printf 'KERNEL=="%s", RUN+="/bin/echo %%M:%%m > /sys/power/resume"\n' \
> +		${resume#/dev/}
> +    printf 'SYMLINK=="%s", RUN+="/bin/echo %%M:%%m > /sys/power/resume"\n' \
> +		${resume#/dev/}
> +    ) >> /etc/udev/rules.d/99-resume.rules
> +fi
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

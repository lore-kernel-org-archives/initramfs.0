From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: build initramfs: unclear _mpargs in instmods()
Date: Tue, 30 Aug 2011 12:19:22 +0200
Message-ID: <4E5CB92A.4060700@gmail.com>
References: <4E5C07B7.4050907@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=73baky5A34uzH/48C/Yiw4eNzLc7umlYmn6NKp/tYwQ=;
        b=iRRYE/CHLdg+Nu2ZKg1+KkcUiyJo5q/Dv70ApZheJf2FXMu8ohuAMSqPqEBKZXrxLW
         1i1urwbrC38JW8nL/kj+Id/tQl4+fIB/BtNEi3oyVDo/B57hf+TYk8kPi7poqa19axqI
         iv1ORSp6op4QeDUaSiQsZSOfHGOqCvb9klhyQ=
In-Reply-To: <4E5C07B7.4050907-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 29.08.2011 23:42, John Reiser wrote:
> The local variable _mpargs in function instmods() in file dracut-functions
> looks peculiar.  The documentation is non-existent, but still ...
> 
> First, $_mpargs is not passed to modprobe via for_each_kmod_dep.
> This is strange because my guess is that "_mpargs" means
> "extra arguments for modprobe".
> 
> Second, the leading "--" will be lopped when a leading pathname
> is stripped via
> 	_mod=${_mod##*/}
> It seems to me that a leading "--" should inhibit modification.
> 
> Here's the corresponding patch to current HEAD (from dracut-013.)
> 
> diff --git a/dracut-functions b/dracut-functions
> index a3340e4..c28766e 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -919,7 +919,6 @@ instmods() {
>                  fi
>                  ;;
>              --*)
> -                _mod=${_mod##*/}
>                  _mpargs+=" $_mod";;
>              i2o_scsi) shift; continue;; # Do not load this diagnostic-only module
>              *)  _mod=${_mod##*/}
> @@ -942,7 +941,7 @@ instmods() {
>                  # ok, load the module, all its dependencies, and any firmware
>                  # it may require
>                  for_each_kmod_dep install_kmod_with_fw $_mod \
> -                    --set-version $kernel ${_moddirname}
> +                    --set-version $kernel ${_moddirname} $_mpargs
>                  ((_ret+=$?))
>                  ;;
>          esac
> 

git blame was my friend to find out, what the original intention of $_mpargs was:

modprobe $mpargs --set-version $kernel --show-depends $mod

so, your patch seems to be correct!

Thanks!

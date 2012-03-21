From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Avoid use of "export -n"
Date: Wed, 21 Mar 2012 13:07:37 +0100
Message-ID: <4F69C489.3050605@gmail.com>
References: <20120316211124.8FFC69D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hHiYMRylV1/qxd1R14k8aZsXn4HmujuW/NLAQxIq8qw=;
        b=XNlowZEDYmtFao3pvD6M9P9fsGEf/+O8eKLiCI92mrdyMQzk5+ajL9ukzttcow+pho
         goVE5krtWCMuFYvuNbCm2ROVzugzJseGWNoQk2atTIajDk5rRVqxml9HSZrBVpXIncVm
         R+uggKsLtiR8uIioUaOuhp9TLdrQEfQUg1O+UgAxWxOxpA4Nm191fiHoW6i6EbzkQ3ZJ
         /gVuooGDP499P63kgFMS1RaOdR6mE734K8xD7QbZ+TefQKAqkN6y3SoinhjSyzG8rR7g
         Xu/4ocv+sQXLBXaLB3cxMV6siAVY/FUE/bSlNi/wl5Ajwi/AJRtcbAtR/5NbCluWCY6/
         CdYQ==
In-Reply-To: <20120316211124.8FFC69D401E-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 16.03.2012 22:11, schrieb Daniel Drake:
> "export -n" is a bash extension, not part of POSIX, and is hence
> incompatible with the busybox shell.
> 
> This was breaking boot when the busybox module was used.
> 
> Reimplement the scope change in a few lines of standard shell code.
> ---
>  modules.d/99base/init.sh |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
> index 5d51c9d..f599fae 100755
> --- a/modules.d/99base/init.sh
> +++ b/modules.d/99base/init.sh
> @@ -263,8 +263,15 @@ else
>      udevadm info --cleanup-db
>  fi
>  
> +# Retain the values of these variables but ensure that they are unexported
> +# This is a POSIX-compliant equivalent of bash's "export -n"
> +for var in root rflags fstype netroot NEWROOT; do
> +    eval tmp=\$$var
> +    unset $var
> +    [ -n "$tmp" ] && eval $var=\"$tmp\"
> +done
> +
>  export RD_TIMESTAMP
> -export -n root rflags fstype netroot NEWROOT
>  set +x # Turn off debugging for this section
>  # Clean up the environment
>  for i in $(export -p); do

pushed

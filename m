From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 11/15] gen_init_cpio: add newcx format
Date: Thu, 25 Jan 2018 20:40:25 -0600
Message-ID: <b3451193-0666-d929-01f3-29d3872bd5d4@landley.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-12-git-send-email-takondra@cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZExr67sahsevP0Dy2UXwLIvVHxSBMpkamCPG5T114oE=;
        b=Mc/5FxjxzFgcgC9pxNqWbyzBVOoX8rtOOlGAWljvWb2Ocjybj4GVlSKF5yEv21pDe5
         9vhYUJDcktbskDdXDRUKD26+mPaGaY8m6pclRq2X7s6JdqFWj+Dy9xJL1d421oXTGMiq
         BflEj7ECPKkxLY9OPXgE1kcP0zMOULi2dHoX3n4c+qLAymhRjOKn+scBoAtO2ebFJ9Xk
         jT/h4uzj4W+mfRzVliAZskwNSs3K/n9cdHy6I8JiNWLaJ+Rm59Eof+bvFbyMp6/fWvR2
         zHs0E9BTBjSTTo+djHdJztd6E/5jaKuABnWOkn+dYWCZdxIbQKoXf6Xb8i+1+JfQxRRD
         ko/Q==
In-Reply-To: <1516850875-25066-12-git-send-email-takondra@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Taras Kondratiuk <takondra@cisco.com>, "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index 7a2a6d85345d..78a47a5bdcb1 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <assert.h>

You're adding an assert? Really?

>  	fputs(s, stdout);
> -	offset += 110;
> +	assert((offset & 3) == 0);
> +	offset += cpio_hdr_size;

Why?

Rob

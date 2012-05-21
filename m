From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] add option --printsize
Date: Mon, 21 May 2012 16:43:41 +0800
Message-ID: <4FBA003D.50103@gmail.com>
References: <20120521083706.GA3040@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=aNbJ5VO23fWNLFKXGZiWTBwbJF1VfPHJW/N5OhvbZpc=;
        b=iWkrflTMd1YbjaQS7BJEy8THUTXfiiijb1rQ5I/c3aexzutwcFCznUdRkc/vw6YcKh
         p1Wudx04dSxPkK4Yc/oyWgjqLf2zHQMV6c/ho4z2zXleFagTKlA+BPgoedtjA2SGRSI9
         ydeP32Apc+ke1tc+4Dj6lkQoX9U3ZqiCd/VhQ2t9tRIWfIU4yDpsrUjaUbtxRmSKWvWc
         qhcbIv9tuDZDt986cFO/8+xWisOm0+TvqYm+EKyNZyL6o16sJzFM8ij1yuTXCA1+RV5e
         lKwAgXnr8/ixW/4QYXdbq7ME9lNhsUSX3mTdDPVOrdfx8Swa3bUjKlW97jiwi9CA2G0G
         59OA==
In-Reply-To: <20120521083706.GA3040-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 05/21/2012 04:37 PM, Dave Young wrote:
> Add --printsize for measuring module installed size to initramfs
>
...
> +
> +        #print the module install size
> +        if [ -n "$printsize" ]; then
> +            _isize_new=$(du -sk ${initdir}|cut -f1)
> +            _isize_delta=$(($_isize_new - $_isize))
> +            echo "$_d_mod install size: ${_isize_delta}k"
> +            _isize=$_isize_new
> +        fi
>       fi

Yeah, it is a nice feature, to calculate the module installation size by 
delta of the whole initrd size.

Could you include the sample output in the changelog?

Thanks.

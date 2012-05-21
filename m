From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] Add vlan support in network module
Date: Mon, 21 May 2012 17:26:02 +0800
Message-ID: <4FBA0A2A.5040600@gmail.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <4FBA094B.5040303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FF1L/eUI3nVdJdb+DS85igkQQGioXQNz8E9LdkzdPyc=;
        b=rcF4w1FxMuFW1q7HZsPyVaWpPXl98L89EFISAQhj8514UjvSWLA7HkudqRzR+yDfwz
         iM5Gde42/mOL+Cz4k8c27Y8T2erQV8OaVpEe80QJ/gobEOxbzBCoeVCPWaTO9OqqRPFL
         PAumjJNodv0DzLYGrPyaRwnIf7XhIAZAgFKZX2BT+giIiyB9FsjMOY2Xpz0XDIg63kUr
         WHCfx/cXt+kIDePTUkvNUrrvDspcs29+GZmhSebQHmiAP2pLfu/ld1o6xz4AvkpYPOAE
         g9/yWHfJD1Kp6+ALu+fXjLr1pc6mZJjgoXtuxn5gBW1wqv/bqxngtHn0x46+grbG/EMj
         PtHQ==
In-Reply-To: <4FBA094B.5040303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 05/21/2012 05:22 PM, Harald Hoyer wrote:
> vconfig is deprecated. Please use iproute.
>
> -           /sbin/vconfig add ${PHYSDEV} ${VID}
> +           ip link add dev ${DEVICE} link ${PHYSDEV} type vlan id ${VID}
>

Fair enough, I will drop it. ;-)

BTW, I think ifenslave can be dropped too, as we can use the /proc 
interface to add slaves.

Thanks!

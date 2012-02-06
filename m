From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/7] auto setup network without netroot
Date: Mon, 06 Feb 2012 15:53:26 +0800
Message-ID: <4F2F86F6.5010007@gmail.com>
References: <20120202075952.GA12412@darkstar.nay.redhat.com> <1328510722.10153.13.camel@obelisk.thedillows.org> <4F2F8666.50907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=45yxFf2Rj6Ei72aYzLiczDGRUVab5XGggJLXpQXLJnA=;
        b=v6TpB5RjRMzQyd8MO/sB/zPSnloqodS9q0qyC18M3qU/ffAxhtY7gPhqL1oGEMXuU5
         js8ZGoyaV1DAc21vD7gmvGcoABOxrOOOJniO8HEOGfPIVTpUtlYr3tIDlbZrZJ/a02yL
         92HUaiTDEaKOuNia++5WmNaFXYrBwXY/8B2GU=
In-Reply-To: <4F2F8666.50907-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/06/2012 03:51 PM, Dave Young wrote:
> I think the key problem is the network setup code split. I would not
> insist on this although I don't like that we must add ip= to have
> network setup

With your patches, we must have rd.neednet=1. :) So, it is unfair to 
only blame ip= approach.

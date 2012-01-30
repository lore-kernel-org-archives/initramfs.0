From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Mon, 30 Jan 2012 17:31:53 +0800
Message-ID: <4F266389.70303@gmail.com>
References: <20120130064305.GA7108@darkstar.nay.redhat.com> <jg5kl4$3qk$4@dough.gmane.org> <4F265A0B.1000402@redhat.com> <4F265A22.2090407@gmail.com> <4F265C01.4010701@redhat.com> <4F265CDB.7070204@gmail.com> <4F266004.5080501@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X7AscVuaR1XyuVZ0+K1hssmdXbTeYevETzUe4/y8Okc=;
        b=nhzvR1r4e/YpAuZrHTqUel2d04RjhjlgapjuVdfID+tErcvj2WtVoxkEwBjDJrY7AY
         Ilg+od+3q8k9UnP78rSwSe1Ivvc4Iy3XzwF8n7jl5I3eXt7zE8WhO5jQjzrhYpPFvq4Q
         yKJ30kv93kbz9YF2WQsIB3nVKDa2NnxaPeH/8=
In-Reply-To: <4F266004.5080501-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 05:16 PM, Dave Young wrote:
>
> How to say...
> There's many different configs for network like:
> 1. ip={dhcp|on|any|dhcp6|auto6|ibft}
> 2. ip=<interface>:{dhcp|on|any|dhcp6|auto6}
> 3. ip=<client-IP>:[<server-id>
> ]:<gateway-IP>:<netmask>:<client_hostname>:<interface>:{none|off}
> 4. ifname=
> 5. bootdev=
> 6. root=nfs:[snip]
>
> They are all possibly be used, IHMO they are not good options for this
> patch using. For example there's no NIC specified in 1 and 3, we will
> still have to bring up the default


Kdump module can make sure that at least one NIC will be specified, if 
there is ip=.

>
> Also this is a general feature, maybe it will be used by users other
> than kdump. For kdump I think we can use proper ip= plus rd.neednet=1
>

Why? If we can re-use ip=, it will imply rd.neednet=1, so again, 
rd.neednet is not needed.

Thanks.

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] check kernel module existance
Date: Mon, 21 May 2012 17:42:15 +0800
Message-ID: <4FBA0DF7.5000903@gmail.com>
References: <1337062797-28629-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Tvy6mR275TI7cNOGAPPUYM/21paSeyg/X6r/Dh6+tz4=;
        b=IJMuclbecpnA/U6uixzjvbt4wmSj5xMFqsNSRxJ2VLVKWWjTH1GugAjqY00QT7fbzE
         b21pF1iYyXF8URwmOUsF7qk85jhXbExD/eSu+InIWq43BtGVWw6PtSwHcBLDQ/VS2Jhz
         YKN6/CaJCaDBvQTy6K2Hbnhwm8+jlBLXUIzar2WFnFmMMT+/loKB5QA68PjYhbTEYlOh
         2LlEIUCrqER48bVOsNdfDaJLq6QiKJYgu3Y6w8VtUgsVbF+be7uhEnKp+gGG14TbIVz2
         CnGN39zMlEY4rbBeZhLe47Ci9l/vmNVv5iIqlQwKU1h7P6dgjB+RwnzqVcQsFMlAYPIy
         jcZQ==
In-Reply-To: <1337062797-28629-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi, Harald,

Could you review these 2 patches please? Kdump needs these 2 patches, as 
Dave reported.

Thanks!

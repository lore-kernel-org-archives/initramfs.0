From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] split out nfs rpc process startup
Date: Mon, 30 Jan 2012 16:38:42 +0800
Message-ID: <4F265712.7090302@gmail.com>
References: <20120130064350.GA7114@darkstar.nay.redhat.com> <jg5jov$3qk$2@dough.gmane.org> <4F26572E.7030806@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UYcnLQOfr7Ap0VzhSEKqJ5zHjPniXOfLqa1THxUtQ8E=;
        b=nhIxYBaeUbUGF+C8QHyhXzyUHF3sye3ZvOmMGFkUd1jhr0iCQx1FX0fRkMsj6moXxj
         +W6SiSgskXjpy09xcCnCxbV0DgAm4KlQkG1HomL1KHXyLX81crgqHztDN9wfvFQZlg/b
         TjVaf1yZYPRBESppMv44ejOY4Bx91Jqg97DpE=
In-Reply-To: <4F26572E.7030806-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:39 PM, Dave Young wrote:
>
> no special reason for this, I'm fine to make it a script
>

Sourcing a script under /sbin is odd. Please make it a single script, 
for other scripts to call it more easily. :)

From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] 91crypt-loop: replace basename calls with string matching
Date: Tue, 24 Jul 2012 14:13:59 +0200
Message-ID: <500E9187.5020505@gmail.com>
References: <1343131020-12683-1-git-send-email-leho@kraav.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ELeHPNzPEq5lnUImHzmt6nrK5UKy3/v+xgBEOFz0KnI=;
        b=vkiGGCzwW3MkZ52Z22t4o0FdGYTXGH/jqA8nIKLxTgSEDfKq3ca2N7T20AdY6TQrNr
         cm3RaNO62ppKn6LmuEmLF6Rb9RrgovRPn/HNdFF7LEoUlDiYQjdyRYUwFWlLWFHpXlaw
         tpobLLRTyfe3uTHSryMBrDM0ClRCJUc+csMYvBClJ77sb3mmKPHWnXY0f3GFgUopf3yu
         Iu+RC/MG7yIh9bS5dcvR1ETSr1kb6FnG8QGroTfNTx9th42OFbwadTU2nW21IeSDjOLc
         cRI+zSO8X8lv6PBOjntPBVJU8i8OT421N8BbZJqj3285k+GA42msEgupN6zW7oAT/6c3
         JsPQ==
In-Reply-To: <1343131020-12683-1-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 24.07.2012 13:57, schrieb Leho Kraav:
> ---
>  modules.d/90crypt/crypt-lib.sh           |    2 +-
>  modules.d/91crypt-loop/crypt-loop-lib.sh |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

Your patch seems to be against a very old version of dracut. Nevertheless, I
removed all basename calls in git HEAD. Thanks for the reminder!

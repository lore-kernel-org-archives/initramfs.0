From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] remove the global --sshkey parameter
Date: Wed, 11 Jan 2012 17:54:44 +0800
Message-ID: <4F0D5C64.1080203@gmail.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <1326208786-24344-2-git-send-email-xiyou.wangcong@gmail.com> <4F0CFB08.6030800@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JqbnuZlkMfbGpNQnATajuChfu/q9VECW7MjtFlbIlBM=;
        b=pBke1PkFqyXmRsUba/lkPPXi5wJbyQjkAceGROrOM3pNwpg22REVyDJiErgDos+BgE
         rS5/dqWufkm1SGjjmZ/pQsNB6l3lFF/eprVDyanoYZnvPelSXxA0eu5vPbN1AMs2bIiw
         q8DsuAZ6lXMicPNs6iFyx/HnAn07Bio2KgZv4=
In-Reply-To: <4F0CFB08.6030800-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/11/2012 10:59 AM, Dave Young wrote:
>
> Hi,

Hi,

>
> After removing --sshkey we need to parse dracut_module_args for module
> use. Maybe in a general function of dracut-lib will be fine.
>
> Also need consider the multi-param case like below:
> module:a=b,c=d,e=f,...
>
> Ie. in ssh-client module we need to parse "sshkey=/root/.ssh/id_rsa" for
> installing sshkey
>

It is already done by the first patch. :)

Note that, I designed to use colons to separate parameters, not commas,
even if you pass multiple parameters.

Thanks.

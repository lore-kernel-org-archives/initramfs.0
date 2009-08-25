From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 19/18] Modify nbd hostonly checking to use check_block_and_slaves.
Date: Tue, 25 Aug 2009 11:52:13 -0500
Message-ID: <10ABB876-15C3-4DEE-8D47-20267593D143@gmail.com>
References: <1a4c4015bc85feeb9fbf95a9d1e9adfb2de8e897.1250465033.git.victor.lowther@gmail.com> <4A93FC92.1010305@redhat.com>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=LhLnmGMQh3AWte6Jk2w+zen0Ry7plXDI82OUtcIrzDQ=;
        b=NWlweM2DteguZ/wBDv77veJPidqotgdGDU1bgAYl3E7KPdttOPNGKwt3K2sVM3PKyj
         xknLQN8PZzcUBNkAimAILatB9sI3Kt/UbbXxybYoCBLxbVzmsDQgWY2liWv/tSiEJv5v
         68l5/jYDz7GLjseyLzAeaSTyF1px7iu9wGNZQ=
In-Reply-To: <4A93FC92.1010305-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Aug 25, 2009, at 10:00 AM, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On 08/16/2009 07:24 PM, Victor Lowther wrote:
>> +# if an nbd device is not somewhere in the chain of devices root  
>> is mounted on,
>> +# fail the hostonly check.
>> +[ "$1" = "-h" ]&&  {
>> +    rootdev=$(find_root_block_device)
>> +    [[ -b /dev/block/$rootdev ]] || exit 1
>> +    check_block_and_slaves is_nbd "$rootdev" || exit 1
>> +}
>
> When will this ever work?  More often than not you would be  
> generating a netboot in a chroot of the image.

Hmmm... I will have to think about that. Dracut needs to grow a -- 
root= option anyways, and mixing that functionality in with the -- 
hostonly functionality I have been working on seems like an obvious win.

>  You almost never generate the initrd on the running netbooted system.

This is not an area I work in too often, but is there a particular  
reason why not?

> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

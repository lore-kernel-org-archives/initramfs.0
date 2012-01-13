From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] allow ifup bring up network manually even without
 netroot
Date: Fri, 13 Jan 2012 16:58:42 +0800
Message-ID: <4F0FF242.506@gmail.com>
References: <20111230083858.GA13018@darkstar.nay.redhat.com> <jehm6n$7q8$1@dough.gmane.org> <4F0CEE74.6020102@redhat.com> <4F0D5ADE.4020800@gmail.com> <4F0E4055.90903@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GxxFXqBTKy1gwjdOzkcHCgbRkLyWxZCnVDY9eC/UOuM=;
        b=Gu3b00x9QzuCkcXjJ3NP0tXtzTc1A/pL3WZFACOyrqLr8/GBsEsnHdZLGiLvuIeHGl
         Qyswj93vUY0bErDRfEpHoJhMexpFfXh15thc91xtWFWHTh1DrtD1XZlPTv8WzaX8GGyH
         2SJvYNo64P8lo/EAfV0zV7hUVvqilfBXGTZEo=
In-Reply-To: <4F0E4055.90903-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/12/2012 10:07 AM, Dave Young wrote:
>>>> If we need to invoke `ifup` by
>>>> ourselves, then we also need to determine which NIC we should bring
>>>> up, this will make kdump code larger.
>>>>
>>>> So, I hope, we can have some kernel cmdline (like ip=...) to tell
>>>> dracut which NIC we want to bring up in the second kernel, provided by
>>>> either ssh-client module or nfs module.
>>>
>>>
>>> If we need to pass the nic name to cmdline then we still need to
>>> determine which one should be use.
>>
>>
>> Sure, but this will go to ssh-client or nfs module, not kdump.
>
>
> ssh-client does not pass any cmdline, instead the scripts of call dracut
> to generate initrd do this. In case of kdump it's the kdump init scripts
> or simplified mkdumprd, so we could not skip this step.

Well, I still think ssh-client or nfs module should handle the network, 
not kdump's mkdumprd, like lvm module for lvm.* cmdline.

But anyway, I will take this patch to my kdump tree.

Thanks.

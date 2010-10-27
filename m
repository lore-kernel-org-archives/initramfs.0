From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: crypt-cleanup.sh question
Date: Wed, 27 Oct 2010 13:07:00 +0100
Message-ID: <4CC815E4.4060705@googlemail.com>
References: <4CC6C571.8010406@googlemail.com> <4CC6E7C1.1050703@googlemail.com> <4CC7F15C.7090600@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=oSX9rSHaFK03juZ6JbKscREttaxV0thUC+/9WktWqNA=;
        b=ZFKUz/OLy4HoH8+FCaaMLl/4X9hV/ZK1N8F6QS3yh/90zTOvkpl2NF+LItMdpyltfJ
         5QAlEpPh1gu61fnJBnYW+0tk25yFxa2PI8mGrffgtuipVCkryPRo8wUxy+HWWnVcjoIe
         Kcdl0HnnRj+r6jF0j+YRipE/4moVwcXhoFwXI=
In-Reply-To: <4CC7F15C.7090600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>>> What is the rationale behind closing all /dev/mapper/luks-* devices 
>>> which are
>>> not 'busy' in this shell script? Why would they have to be 'busy' (I 
>>> presume
>>> already mapped) to be left open?
>>>
>>> I am asking this because when the smartcard module opens a LUKS 
>>> drive (not
>>> root - '/') - this drive later to be mapped from the actual root 
>>> /etc/fstab
>>> file as '/dev/mapper/luks-XXX /some/directory' - this operation does 
>>> not
>>> succeed and I presume crypt-cleanup.sh closes it up before the 
>>> actual root can
>>> get it and therefore it cannot be mapped.
>> Further to the above, I was able to verify that the above script is 
>> indeed to
>> blame for closing LUKS partitions. The only 'busy' partition at the time
>> crypt-cleanup.sh runs is the root (/sysroot) so I don't see how a 
>> LUKS partition
>> (other than root) specified at the kernel command line could be 
>> opened, unless I
>> am missing something obvious...
>
> So, what's the problem? You get real root and can do everything on the 
> real system afterwards...
Well, 'the problem' as you put it, is that when I open a LUKS partition 
within initramfs (which isn't root!) the crypt-cleanup.sh script in the 
crypt module closes it before switching the real root and therefore that 
partition is no longer available and cannot be mapped.

The same goes if I use the crypt module itself - it asks me for a 
password, opens the required partition and then promptly closes that 
same partition before switching root.

My original query (and the reason for starting this thread) is what is 
the rationale behind this - why not leave the LUKS partitions which were 
open within initramfs to stay open so that they could be mapped by the 
userspace tools/the kernel itself?

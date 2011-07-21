From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Unable to boot Fedora 15 Live iso image from grub2 (iso-scan/filename
 kernel parameter)
Date: Thu, 21 Jul 2011 10:57:45 +0200
Message-ID: <4E27EA09.3080302@gmail.com>
References: <CAC-ivu5wS+xGoekc_jjs72BC4=Dz+k3umnAdSHVu_vjGDva=rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7/CfPx06TvMRzWZ059b7tPx82eb0krow3VdZDI4ahu4=;
        b=sS/hrZ7veWfVy7R40ito33g5ClVQufMUfbxQRjlzLa/DgY/3orbvnjo2q1YrFUTKnF
         orq6hdzC8rBKM1hOBG1ARUP2GXJ0II2fBC0UbwtSd9ave1FwNzyJz+6KdgjYVw7vKWCG
         zjztsorq3YOzZjwibn6tXBtZ6+QkZkpf+U0+A=
In-Reply-To: <CAC-ivu5wS+xGoekc_jjs72BC4=Dz+k3umnAdSHVu_vjGDva=rQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 21.07.2011 10:53, jaivuk wrote:
> Hi guys,
> 
> I tried to boot Fedora live ISO in form of ISO image from USB
> partition (FAT32) where I have grub2 installed but still no luck.
> 
> I opened new ticket for this issue:
> https://bugzilla.redhat.com/show_bug.cgi?id=723801
> 
> I ended up in dracut shell and I tried to mount root manually - I was
> successful with that but I still cannot boot:
> 
> mkdir -p /liveiso
> mount /dev/disk/by-uuid/1234-ABCD /root
> losetup -f --show /root/Fedora-15-i686-Live-XFCE.iso
> #displayed: /dev/loop0
> mount -t auto -o -ro /dev/loop0 /liveiso
> #image is mounted to /liveiso
> exit
> #Now I get the same error message - No root device ... found
> 
> Do you think I'm missing some additional commands?
> 
> Thank you,
> 
> Jaiv
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I will implement the missing pieces.. stay tuned.
Btw, Fedora != Ubuntu... you are trying to use kernel command line parameter for
the ubuntu initramfs.

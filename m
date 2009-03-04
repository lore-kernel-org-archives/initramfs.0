From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Wed, 4 Mar 2009 13:20:23 -0300
Message-ID: <82ecf08e0903040820t42775dd8s56e32d9d5dd53c36@mail.gmail.com>
References: <49AE99D2.1000501@bfh.ch>
	 <0227279C-8C23-4501-B163-04470D0C0F35@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LuTA38XSVusnVJ+T1CysQ+T4pkJS4dhKpHycMwioB4M=;
        b=wuf/6tnz0H/Yc72sbRjUSjOAkSXXKCJ5cAywyRt1HVyygz5SU/q44e+Lva3EL+TITg
         uZqDOj9w53Y5BYDWXw7nZ1sGU6eVMIWaGuQJsraTVdblpvPeEXoVc/VeiWxrmltfB3Ye
         1DHT/RZLDVB6HqwqqilkyazuQrLkm987EC8sc=
In-Reply-To: <0227279C-8C23-4501-B163-04470D0C0F35-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

>
>> Certainly stupid me can't think of a way to be sure we "really really"
>> have all block drivers without including every single .ko. Leave it to the
>> user to specifically set drivers or the Distro to tell Dracut which drivers
>> to include.
>
> Indeed.
>

Isn't this two different things?

I mean, it's one thing to have a "generic" initrd for, I dunno, live
CDs, etc and another thing to generate for a specific
computer/installation. And even installation triggers run mkinitrd (or
similar), no?

Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

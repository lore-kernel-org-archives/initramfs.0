From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 13:31:47 -0300
Message-ID: <82ecf08e0902180831k8f3fe85hc6e72b9687faa35c@mail.gmail.com>
References: <1234960574-32612-1-git-send-email-ro@duskblue.org>
	 <9594AD60-9303-4345-8FC6-B59FAA2C60EE@gmail.com>
	 <82ecf08e0902180756u2e007426vdd7116c03e72925e@mail.gmail.com>
	 <ac3eb2510902180817y380a7cddh940ba268bb46da97@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M1EvG7Ho44pYvyG9JPsQWd4UscBFALlXhuSz+aB/cA4=;
        b=HdCJOhYHzGHgXbwWhlrz8hGu8DduhQv5oNVpa5hHZqpGVF66RZiv4n+Y5aWCkWUG6Z
         K+I81SNXE8/0vjgdFN2vxcJpHWIuL8z302pbTxv2PiPDMk7slhQ0AEuSlifUfPoo8xlR
         2c+QnuzlDL541UjBh53gI8Hh2g3QYVl1vSNOg=
In-Reply-To: <ac3eb2510902180817y380a7cddh940ba268bb46da97-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

>
> You mean:
>  for f in "$dsrc/modules"/*.sh; do
> ?

Silly, silly me :)
I was worried about the [^~] at the end , and couldn't make it work
with the sh but, of course, *.sh does the trick


-- 
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

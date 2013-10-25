From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 16:45:38 +0200
Message-ID: <526A8412.3040002@gmail.com>
References: <5253DD0C.7050506@redhat.com> <l4dk8e$fv8$1@ger.gmane.org> <526A7412.8030804@redhat.com> <l4dsjp$20r$1@ger.gmane.org> <526A80D9.4060907@gmail.com> <l4dvs8$g48$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Wd7BvJK+fExj+EsI9zTriMzXa9j6X6tW61DDBO77mXQ=;
        b=hQsIOsK5c4uVG8bFdvWdJW0BAUY4LT7NCUtjAeuBaVjIxP64MGd8yQcHiHLhNWMMEn
         QhUhTxJGfp8np8EXfO41m1eSk9cvscAEmvix/Spwz16QQ0dLEmu0N2DRYmuJR1Q0p/eH
         WDFZOwOVtdxAVnbGzKGHcyrbxR4bJHZtyzM5HGCbwJb4c1AuL4z6Y/nN7fX/jJOTYL20
         Zg6JavdMOzXf44AVEyXZ6MDqnEYdDf5vMU4JhssP7MYi5Ssx4VYhWzuFDU6kh7HpcqQK
         IXCKE1m9XorOxNXv4wJkYyzzLQu1ffebyytk0NTojuKpyzoL7i61nZoS/o+8LhPFUV7H
         E6LA==
In-Reply-To: <l4dvs8$g48$1@ger.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/25/2013 04:40 PM, EatDirt wrote:
> looks good; but usrmount does not get included (and is not banned in
> /etc/dracut.conf neither in /etc/drakcut.conf.d/*)

The output of:

# dracut --debug test.img

would be very interesting then.

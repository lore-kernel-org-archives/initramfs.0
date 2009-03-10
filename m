From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Tue, 10 Mar 2009 09:41:13 -0500
Message-ID: <20CAFEB8-7B05-4CFE-B727-20D4DBEF5D7B@gmail.com>
References: <49B1439A.7030208@redhat.com>  <20090306160822.GD10711@nostromo.devel.redhat.com>  <1236361391.6517.0.camel@sentry-no.fnordovax.org>  <20090306203921.GA28154@nostromo.devel.redhat.com>  <1236382532.5147.38.camel@sentry-no.fnordovax.org>  <20090309031111.GC3983@redhat.com>  <1236595028.14649.40.camel@sentry-no.fnordovax.org>  <49B61F89.4020902@spra.gg> <1236679030.14649.45.camel@sentry-no.fnordovax.org> <37747.87.194.176.107.1236682901.squirrel@work.arafel.org.uk>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=nWwY0c0ahS4ctA6Ot5z5VegEymrTLIm5nmxZ144gvQo=;
        b=PA1l6efNUiffxH53kKT92n1TG2VdNrFnA9tSN8IhZmgGxnLFQagFOJu67njKVUVI33
         ArSV4D+irFy3kdikG141l8uI9Guc1DCGrx1Fbof8DSjdfbqs/3WMu4nU7h0MhshwPrJs
         zj0iw4gD5QLe5EjjuRMhIATVqLhoGA8/tPcpE=
In-Reply-To: <37747.87.194.176.107.1236682901.squirrel-g8V2OS1ZTlk2rALx+bCG9rVCufUGDwFn@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Cc: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar 10, 2009, at 6:01 AM, "Adam Spragg" <adam-2iSS7ArDF14@public.gmane.org> wrote:

>> Nope, we import our rules from the host system,
>
> Ah, I misunderstood it as importing udev rules from the udev source  
> repo
> into dracut's repo.
>

I did have a patch to do that, but it was withdrawn after Kay  
explained why it was a bad idea.

> My bad. Apologies for the confusion.
>
> Adam
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

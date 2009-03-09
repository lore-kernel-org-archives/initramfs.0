From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Mon, 9 Mar 2009 15:02:06 -0400
Message-ID: <20090309190206.GF30046@nostromo.devel.redhat.com>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org> <20090306203921.GA28154@nostromo.devel.redhat.com> <49B239AF.3030609@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49B239AF.3030609-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
> Bill, a question: How far do you think the genericness of dracut should go?

At a minimum, anything block-based that doesn't require network setup
should be part of the generic case, whether that's disk, CD, usb, MD,
DM, etc.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

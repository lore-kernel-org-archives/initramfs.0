From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Tue, 10 Mar 2009 11:14:12 -0400
Message-ID: <20090310151412.GA2996@redhat.com>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org> <20090306203921.GA28154@nostromo.devel.redhat.com> <1236382532.5147.38.camel@sentry-no.fnordovax.org> <20090309031111.GC3983@redhat.com> <1236595028.14649.40.camel@sentry-no.fnordovax.org> <49B61F89.4020902@spra.gg>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49B61F89.4020902-2iSS7ArDF14@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Mar 10, 2009 at 08:06:33AM +0000, Adam Spragg wrote:
 
 > But one of the goals of dracut seems to be to become part of the kernel
 > source tree.

I'm beginning to have some second thoughts about the feasibility of this.
There are a number of use-cases where regeneration of the initramfs
is desirable, which would mean a standalone tool would be needed that
isn't shipped as part of the kernel package.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

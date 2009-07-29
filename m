From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: The (unnecessary) overhead of initramfs
Date: Wed, 29 Jul 2009 18:25:15 +0200
Message-ID: <20090729162515.GO16147@baikonur.stro.at>
References: <1248871245.23840.46.camel@quest> <20090729161655.GG20210@shadowen.org> <4A7076A9.2000608@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A7076A9.2000608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Jul 29, 2009 at 12:19:53PM -0400, Warren Togami wrote:
> On 07/29/2009 12:16 PM, Andy Whitcroft wrote:
> >On Wed, Jul 29, 2009 at 01:40:45PM +0100, Scott James Remnant wrote:
> >
> >>The initramfs scripts spend a lot of wasted time and effort doing things
> >>that really don't need to be done:
> >>
> >>In the "framebuffer" init-top script:
> >>
> >>   modprobe -q intel_agp
> >>   modprobe -q i915
> >>   modprobe -q ${FB} ${OPTS}
> >
> >These may be the source of an issue we are seeing with radeon drivers.
> >That when using a pure AMD system you get the i915 driver loaded for
> >no apparent reason.  I presume these should be -b even if they were
> >not redundant?
> >
> 
> Why is this being discussed on this list when this has nothing to do 
> with dracut?

afais this list is related to initramfs dev on Linux
and *not* dracut specific.

your question sounds like a request for a change of policy,
but then the list might better be named dracut@vger

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

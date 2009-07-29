From: Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: The (unnecessary) overhead of initramfs
Date: Wed, 29 Jul 2009 17:16:55 +0100
Message-ID: <20090729161655.GG20210@shadowen.org>
References: <1248871245.23840.46.camel@quest>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1248871245.23840.46.camel@quest>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott James Remnant <scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: ubuntu-boot-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maximilian attems <max-U9r9yeDMy7A@public.gmane.org>, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org

On Wed, Jul 29, 2009 at 01:40:45PM +0100, Scott James Remnant wrote:

> The initramfs scripts spend a lot of wasted time and effort doing things
> that really don't need to be done:
> 
> In the "framebuffer" init-top script:
> 
>   modprobe -q intel_agp
>   modprobe -q i915
>   modprobe -q ${FB} ${OPTS}

These may be the source of an issue we are seeing with radeon drivers.
That when using a pure AMD system you get the i915 driver loaded for
no apparent reason.  I presume these should be -b even if they were
not redundant?

-apw
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

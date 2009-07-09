From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Warn if defaulting to ip=dhcp
Date: Thu, 09 Jul 2009 17:02:28 -0400
Message-ID: <1247173348.8067.3.camel@lap75545.ornl.gov>
References: <4A5656A1.90703@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A5656A1.90703-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2009-07-09 at 16:44 -0400, Warren Togami wrote:
> 99parse-ip-opts.sh:
> > # Warn if defaulting to ip=dhcp
> > if [ -n "$netroot" ] && [ -z "$(getarg ip=)" ] ; then
> >     warn "No ip= argument(s) for netroot provided, defaulting to DHCP"
> >     return;
> > fi
> 
> Is this really necessary?  This is not a warning.  There is nothing 
> wrong with this.  Any objections to just removing this?

Please do! It's been low on my hit list for a while...
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the implementation of action_on_fail
Date: Wed, 31 Jul 2013 10:29:05 -0400
Message-ID: <20130731142905.GH31151@redhat.com>
References: <73cc07330929ba4b226f2a0623a5459cd42932b9.1374574542.git.bhe@redhat.com>
 <51F91A14.4020601@redhat.com>
 <20130731142050.GG31151@redhat.com>
 <51F91E75.3070102@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51F91E75.3070102-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Jul 31, 2013 at 04:25:57PM +0200, Harald Hoyer wrote:

[..]
> >> I like it.
> >>
> >> Vivek: would that solve one of your systemd problems?
> > 
> > Hi Harald,
> > 
> > Yes this should solve one of the problems of being able to call emergency
> > shell from kdump module.
> > 
> > I was thinking of modirying emergency.service on the fly and then reload
> > systemd config. But I guess this solution is simpler.
> > 
> > It also takes away the flexibility of being able to specify "reboot" or
> > some other actions as failure actions. But nobody as asked for those
> > yet.
> > 
> > So yes, agreed, this will solve atleast one problem. So makes sense
> > to take it in.
> > 
> > Thanks
> > Vivek
> > 
> 
> pushed, thanks!

Hi Harald,

Do you still like the parameter name "rd.action_on_fail". I think a new
parameter say, "rd.no_emergecny_shell" might make more sense to reflect
what we are doing.

If you like it, I can request bao to post a new patch and make appropriate
changes.

Thanks
Vivek

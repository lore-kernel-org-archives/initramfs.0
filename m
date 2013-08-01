From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the implementation of action_on_fail
Date: Thu, 1 Aug 2013 22:24:45 +0800
Message-ID: <20130801142445.GB8230@localhost.localdomain>
References: <73cc07330929ba4b226f2a0623a5459cd42932b9.1374574542.git.bhe@redhat.com>
 <51F91A14.4020601@redhat.com>
 <20130731142050.GG31151@redhat.com>
 <51F91E75.3070102@redhat.com>
 <20130731142905.GH31151@redhat.com>
 <51F91FAC.50706@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51F91FAC.50706-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 07/31/13 at 04:31pm, Harald Hoyer wrote:
> On 07/31/2013 04:29 PM, Vivek Goyal wrote:
> > On Wed, Jul 31, 2013 at 04:25:57PM +0200, Harald Hoyer wrote:
> > 
> > Hi Harald,
> > 
> > Do you still like the parameter name "rd.action_on_fail". I think a new
> > parameter say, "rd.no_emergecny_shell" might make more sense to reflect
> > what we are doing.
> > 
> > If you like it, I can request bao to post a new patch and make appropriate
> > changes.
> > 
> > Thanks
> > Vivek
> > 
> 
> You can add the rd.no_emergency_shell parser in your kdump module and touch the
> marker file. I think that gives you more flexibility for runtime decisions.
> You can just add and remove that file on will.
Hi Vivek,

I agree with Harald, there's no need to add a parameter into dracut any
more. Because currently only 2 actions are taken, 1 is emergency-shell,
the other is continue. We can just put a file as switch, if the file exists,
all failed action doesn't trigger emergency shell before Kdump, just
continue. 

If you want several more actions, E.g reboot or others, we can put them
into this file. Then in Kdump module, we can read the content and parse.
As for modules before Kdump, they don't feel it. I think this can extend
the 'default action' flexibly. This keep our reliability on dracut at the
least.

How do you think about it?

Baoquan
Thanks a lot

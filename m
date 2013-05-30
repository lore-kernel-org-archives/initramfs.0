From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Thu, 30 May 2013 10:23:18 -0400
Message-ID: <20130530142318.GC2864@redhat.com>
References: <20121128161234.GA8991@in.ibm.com>
 <50B73598.804@redhat.com>
 <50C03971.4050104@linux.vnet.ibm.com>
 <51A6E0E4.1000502@linux.vnet.ibm.com>
 <51A6F663.5030804@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51A6F663.5030804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On Thu, May 30, 2013 at 08:49:07AM +0200, Harald Hoyer wrote:

[..]
> > Sorry for restarting this discussion very late. I would like to know how
> > safe is to rebuild kernel's default (boot) initramfs for an already
> > installed kernel ?
> > 
> > Also, Does dracut provides any of following mechanism?
> > a) Mechanism where dracut can detect what options were used during first
> > build for a given (exsisting) initramfs. (This mechanism may help one to
> > regenerate similar initramfs with additional dracut modules.)
> 
> currently dracut only stores which modules were used to generate the image in
> usr/lib/dracut/modules.txt
> 
> But yes, you are right. Would be nice to save all the options and have a
> mechanism to regenerate it with those.
> 

I am not sure how well it will work in the context of kdump.  kdump
options and original options might conflict. kdump might drop some of
its own cmdline options in initramfs which might not make any sense
in regular boot.

Kdump will specify additional mount points. IIUC, then we will try
to bring up those targets in regular boot too and mount at user
specified mount point. And later init services might get confused
when respective daemon tries to bring up same targets again.

Thanks
Vivek

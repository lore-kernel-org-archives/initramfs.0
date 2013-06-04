From: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Tue, 4 Jun 2013 17:19:33 +0200
Message-ID: <20130604171933.00ac162c@holzheu>
References: <20121128161234.GA8991@in.ibm.com>
	<50B73598.804@redhat.com>
	<50C03971.4050104@linux.vnet.ibm.com>
	<51A6E0E4.1000502@linux.vnet.ibm.com>
	<51A6F663.5030804@redhat.com>
	<20130530142318.GC2864@redhat.com>
	<51ADA343.2070100@linux.vnet.ibm.com>
	<20130604141403.GG4799@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130604141403.GG4799-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On Tue, 4 Jun 2013 10:14:03 -0400
Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, Jun 04, 2013 at 01:50:19PM +0530, Mahesh Jagannath Salgaonkar
> wrote:
> > On 05/30/2013 07:53 PM, Vivek Goyal wrote:
> > > On Thu, May 30, 2013 at 08:49:07AM +0200, Harald Hoyer wrote:
> > > 
> > > [..]
> > >>> Sorry for restarting this discussion very late. I would like to
> > >>> know how safe is to rebuild kernel's default (boot) initramfs
> > >>> for an already installed kernel ?
> > >>>
> > >>> Also, Does dracut provides any of following mechanism?
> > >>> a) Mechanism where dracut can detect what options were used
> > >>> during first build for a given (exsisting) initramfs. (This
> > >>> mechanism may help one to regenerate similar initramfs with
> > >>> additional dracut modules.)
> > >>
> > >> currently dracut only stores which modules were used to generate
> > >> the image in usr/lib/dracut/modules.txt
> > >>
> > >> But yes, you are right. Would be nice to save all the options
> > >> and have a mechanism to regenerate it with those.
> > >>
> > > 
> > > I am not sure how well it will work in the context of kdump.
> > > kdump options and original options might conflict. kdump might
> > > drop some of its own cmdline options in initramfs which might not
> > > make any sense in regular boot.
> > > 
> > > Kdump will specify additional mount points. IIUC, then we will try
> > > to bring up those targets in regular boot too and mount at user
> > > specified mount point. And later init services might get confused
> > > when respective daemon tries to bring up same targets again.
> > 
> > I think we should be able differentiate between regular boot and
> > boot after crash by checking existence of '/proc/vmcore' file, and
> > do the kdump specific configs/mount if this file exists. In regular
> > boot we can mute the kdump code path.
> 
> Also what about kernel command line? Kernel command line can be very
> specific to kdump environment. It is atleast in x86. I am hoping
> that's not the case with firmware assisted dump.
> 
> Also can you point me to some writeup of fadump again. I want to
> refresh what fadump is doing and how firmware is assisting and how
> does it make better than regular kdump. 
> 
> I suspect it is very similar to s390 firmware dump (zfcpdump). Does
> s390 kdump or s390 zfcpdump reboot after saving dump or they have
> mechanism to continue to boot and hotplug memory after saving dump. I
> am wondering how do they do it.

Hello Vivek,

Currently s390 zfcpdump and kdump both reboot the production system
after dump.

But we also had discussed the option to write the dump in the background
while the production system already starts.

Best Regards,
Michael

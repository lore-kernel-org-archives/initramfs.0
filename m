From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Wed, 5 Jun 2013 10:55:04 -0400
Message-ID: <20130605145504.GE16339@redhat.com>
References: <20121128161234.GA8991@in.ibm.com>
 <50B73598.804@redhat.com>
 <50C03971.4050104@linux.vnet.ibm.com>
 <51A6E0E4.1000502@linux.vnet.ibm.com>
 <51A6F663.5030804@redhat.com>
 <20130530142318.GC2864@redhat.com>
 <51ADA343.2070100@linux.vnet.ibm.com>
 <20130604141403.GG4799@redhat.com>
 <20130604142123.GH4799@redhat.com>
 <51AF40BB.5010703@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AF40BB.5010703-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org

On Wed, Jun 05, 2013 at 07:14:27PM +0530, Mahesh Jagannath Salgaonkar wrote:
> On 06/04/2013 07:51 PM, Vivek Goyal wrote:
> > On Tue, Jun 04, 2013 at 10:14:03AM -0400, Vivek Goyal wrote:
> >> On Tue, Jun 04, 2013 at 01:50:19PM +0530, Mahesh Jagannath Salgaonkar wrote:
> >>> On 05/30/2013 07:53 PM, Vivek Goyal wrote:
> >>>> On Thu, May 30, 2013 at 08:49:07AM +0200, Harald Hoyer wrote:
> >>>>
> >>>> [..]
> >>>>>> Sorry for restarting this discussion very late. I would like to know how
> >>>>>> safe is to rebuild kernel's default (boot) initramfs for an already
> >>>>>> installed kernel ?
> >>>>>>
> >>>>>> Also, Does dracut provides any of following mechanism?
> >>>>>> a) Mechanism where dracut can detect what options were used during first
> >>>>>> build for a given (exsisting) initramfs. (This mechanism may help one to
> >>>>>> regenerate similar initramfs with additional dracut modules.)
> >>>>>
> >>>>> currently dracut only stores which modules were used to generate the image in
> >>>>> usr/lib/dracut/modules.txt
> >>>>>
> >>>>> But yes, you are right. Would be nice to save all the options and have a
> >>>>> mechanism to regenerate it with those.
> >>>>>
> >>>>
> >>>> I am not sure how well it will work in the context of kdump.  kdump
> >>>> options and original options might conflict. kdump might drop some of
> >>>> its own cmdline options in initramfs which might not make any sense
> >>>> in regular boot.
> >>>>
> >>>> Kdump will specify additional mount points. IIUC, then we will try
> >>>> to bring up those targets in regular boot too and mount at user
> >>>> specified mount point. And later init services might get confused
> >>>> when respective daemon tries to bring up same targets again.
> >>>
> >>> I think we should be able differentiate between regular boot and boot
> >>> after crash by checking existence of '/proc/vmcore' file, and do the
> >>> kdump specific configs/mount if this file exists. In regular boot we can
> >>> mute the kdump code path.
> >>
> >> Also what about kernel command line? Kernel command line can be very
> >> specific to kdump environment. It is atleast in x86. I am hoping that's
> >> not the case with firmware assisted dump.
> > 
> > If first kernel and kdump kernel command line are same in fadump and
> > boot environment is same, I think it is worth exploring the option
> > of saving kdump from kdump service when system boots back. That will
> > do away with any need to tweak initramfs.
> 
> This needs larger memory to be reserved. We may need to make sure that
> kdump service is invoked at very early stage before other services kicks
> in which may start requesting for memory and run into OOM issue. If we
> can make sure that no other services are invoked when kdump service is
> saving dump then it will help to fix the size of reserved memory. The
> systemd infrastructure provides aggressive parallelization capabilities.
> I am not expert on systemd but will need to explore whether with systemd
> is this possible.

I think we can create a new service for saving dump and make some of
the systemd services dependent on start of this service. 

Can't integrate with existing kdump service as that one can start
later and can take time in regenerating initramfs and holding back other
services for that duration will not make sense.

By creating a seprate service, delay will be introduced only when there
s dump to be saved. Before this we will have bring up all networking
and storage in the system so that we can save dump to intended target.

I think same service can be used to save dump from inside initramfs
too. (As systemd is now started inside initramfs too). 

Other appraoch is dumping through initramfs and if you do things
conditionally (if dump is available), then any dracut parameter
used by kdump will have to have a conditional version too. Something
like

mount=
mount.kdump_only=

mount.kdump_only will kick in only dump is available. Also we need to
make sure that effects of all kdump_only options are undone before
root is mounted or we create nice handover mechanism to systemd. I think
there handover mechanism already between initramfs and systemd for complex
storage targets like multipathd.

I will let harald comment on what does he think of kdump_only variant
options.

Thanks
Vivek

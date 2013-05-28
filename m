From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: why not install selinux with systemd being used
Date: Tue, 28 May 2013 09:21:48 -0400
Message-ID: <20130528132148.GA7088@redhat.com>
References: <519C9A2E.2080100@redhat.com>
 <519C9A7C.7080904@redhat.com>
 <51A34632.8040901@redhat.com>
 <51A413F4.40806@redhat.com>
 <51A4A228.9000507@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51A4A228.9000507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, May 28, 2013 at 02:25:12PM +0200, Harald Hoyer wrote:
> On 05/28/2013 04:18 AM, Dave Young wrote:
> > On 05/27/2013 07:40 PM, Harald Hoyer wrote:
> >> On 05/22/2013 12:14 PM, Dave Young wrote:
> >>> On 05/22/2013 06:13 PM, Dave Young wrote:
> >>>> Hi, Harald
> >>>>
> >>>> I have a question about selinux module.
> >>>>
> >>>> In dracut.spec there's below code:
> >>>>
> >>>> %if %{defined _unitdir}
> >>>> # with systemd IMA and selinux modules do not make sense
> >>>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/96securityfs
> >>>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/97masterkey
> >>>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/98integrity
> >>>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/98selinux
> >>>> %endif
> >>>>
> >>>> I'm confused why they are excluded for systemd?
> >>>>
> >>>> And how can we load selinux policy in initramfs without 98selinux now?
> >>
> >> Do you have to load the selinux policy in the initramfs?
> >> systemd does it after switching to the real root.
> >>
> > 
> > After crashing happens, under kdump kernel we need copy vmcore to
> > filesystem with right selinux attributes. But we are also discussing if
> > it's better to relabel them after machine restart..
> 
> What do you do, if the rootfs is broken?

Hi Harald,

I guess run fsck and try to repair it. If that does not work, I think 
all bets are off. One will not be able to boot that system back into
same rootfs.

> 
> Relabeling seems to be a better solution, IMHO.
> In theory the relabeling service can also be triggered, when the partition
> containing the crash is mounted.

I was hoping that people will put an entry into fstab file for crash
partition so that it automatically gets mounted every reboot. And kdump
service can possibly be launched after that.

> 
> I agree, that there is a problem, if the crash partition is mounted only readonly.

It indeed is a problem. Partners want crash partition mounted read only
to avoid any possibility of somebody writing to it and filling up the
space.

> 
> I will put selinux back in the fedora packages, if you really need it.

I think it is a good idea to put selinux back in atleast for the time
being. This will help with the default case atleast (dump to /var/crash).

For rest of the cases we will work on relabeling and hopefully that works
reasonably well. 

Thanks
Vivek

From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: EFI kdump without acpi_rsdp
Date: Thu, 1 Aug 2013 09:27:12 -0400
Message-ID: <20130801132712.GB15235@redhat.com>
References: <51F75AF2.9070805@redhat.com>
 <20130730200222.GD16769@redhat.com>
 <20130730204046.GE24730@redhat.com>
 <51F87E6B.6080301@redhat.com>
 <20130731204227.GG1577@redhat.com>
 <20130731204800.GH1577@redhat.com>
 <20130731205522.GI1577@redhat.com>
 <51F9C409.4020000@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51F9C409.4020000-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kexec-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, Daniel J Walsh <dwalsh-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eparis-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Aug 01, 2013 at 10:12:25AM +0800, Dave Young wrote:
> On 08/01/2013 04:55 AM, Vivek Goyal wrote:
> > On Wed, Jul 31, 2013 at 04:48:00PM -0400, Vivek Goyal wrote:
> >> On Wed, Jul 31, 2013 at 04:42:27PM -0400, Vivek Goyal wrote:
> >>
> >> [..]
> >>> This system is behaving strangely. Yesterday I tried everything and it 
> >>> did not work and today both 3.9 and 3.10 kernel seem to work (with
> >>> acpi_rsdp=). I am upgrading kexec-tools now and will try again. If
> >>> that works, then will try without acpi_rsdp.
> >>>
> >>> Well, with 3.10 kernel boots up device showsup but dump saving fails.
> >>> Looks like makedumpfile bailed out.
> >>>
> >>> Hopefully upgrading kexec-tools will fix it.
> >>
> >> Well now OOM killer trigger while loading selinux policy. Red flags,
> >> memory utilization of various components has gone up and even 128MB
> >> does not seem to be sufficient.
> > 
> > I upgraded from kexec-tools-2.0.3-71.fc19.x86_64 to
> > kexec-tools-2.0.4-5.fc19.x86_64 and memory problem started happening. Have
> > we done any significant change in kexec-tools which contributes to this.
> 

[ CC harald and initramfs list]
> The main contribute is Harald enabled 98selinux. Chaowang said selinux
> will use ~50M memory as the peak for load_policy. That is too much..

Hi Dave,

Have few questions. 

- I upgraded kexec-tools package and not dracut. So how did memory usage
  go up.

- Were we not always loading selinux polity in initramfs. Otherwise I will
  see relabeling happen when I boot back to first kernel. And In my
  testing I did not see any relabeling happen. (I will make sure I was
  not testing with selinux disabled).

- 50MB for selinux policy sounds too much. In RHEL6 this usage was around
  30MB and I remember in early fedora days it had dropped down to 18MB.
  Daniel, Eric, does selinux policy load memory consumption has to be
  this much. We reserve 128MB and 50MB is a huge chunk of that.

> 
> Ccing selinux peole Daniel and Eric. I wonder if there's a way we can
> use in kdump initrd for minimum memory footprint. Because we will not
> switch_root, so it will not influence the normal 1st kernel selinux.

I did not understand above statement Dave. Are you saying that we
can save vmcore on root filesystem without loading selinux policy and
still avoid relabeling in first kernel when it boots back. How?

Thanks
Vivek

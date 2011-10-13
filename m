From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Thu, 13 Oct 2011 10:43:03 -0400
Message-ID: <20111013144303.GA25588@redhat.com>
References: <4E848C48.6050506@redhat.com>
 <4E8526A6.30003@redhat.com>
 <4E85370A.7020509@redhat.com>
 <4E853A1C.5070905@redhat.com>
 <20110930183839.GF25891@redhat.com>
 <20110930190311.GH25891@redhat.com>
 <4E9557F2.2060209@redhat.com>
 <4E955C5A.1010406@redhat.com>
 <20111012190744.GG12845@redhat.com>
 <4E96AD07.6040806@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E96AD07.6040806-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Oct 13, 2011 at 11:19:03AM +0200, Harald Hoyer wrote:

[..]
> >> I will add /etc/cmdline.d/ as a drop in for configs. This can also be used
> >> easily for combined initramfs images.
> > 
> > Harald,
> > 
> > We need something so that we can specify top level block device/uuid/label
> > on either commandline or through /etc/cmdline.d/*.config and then dracut
> > automatically figures out all the dependencies and packs all the relevant
> > modules.
> > 
> > For example, one might say in kdump.conf that save the dump to a file
> > system with UUID=xyz. Now one needs to figure out underlying devices,
> > traverse through device stack, bring up associated networking and 
> > traverse through networking stack.
> > 
> > I see in dracut seems to look for root device, and traverses through
> > block device stack and every modules packs its relevant files if
> > that type of device is found in stack.
> > 
> > So something like "extra_mount=dev/uuid/label" kind of command line
> > will help where one can specify extra mount targets which are mounted.
> > 
> > Thanks
> > Vivek
> 
> dracut only does this in hostonly mode... I guess, you will need hostonly, too,
> to reduce the site of the initramfs.

Yes, we want to operate in host only mode (-H) as we want to build minimal
initramfs which is sufficient to take dump on that system for a specific
dump target.

Thanks
Vivek

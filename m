From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add option to bring up a device in initramfs
Date: Tue, 14 Aug 2012 15:36:07 -0400
Message-ID: <20120814193607.GB5760@redhat.com>
References: <20120809030848.GA10460@dhcp-16-143.nay.redhat.com>
 <20120813151029.GE24876@redhat.com>
 <5029EFCF.4060005@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5029EFCF.4060005-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Aug 14, 2012 at 02:27:27PM +0800, Dave Young wrote:
> On 08/13/2012 11:10 PM, Vivek Goyal wrote:
> 
> > On Thu, Aug 09, 2012 at 11:08:48AM +0800, Dave Young wrote:
> >>
> >> Kdump support dump to raw device which could be on top of complex storage
> >> such as multipath and iscsi which are standalone dracut modules.
> >>
> >> Add a --device option to dracut which will add the device to host_devs so
> >> dracut can add the dependent modules automaticlly and enable them in initramfs.
> >>
> > 
> > You have not specified any format for --device argument? What do you expect
> > there? Device name, UUID, udev persistent link, or what?
> 
> 
> It's a device name, should metion it in doc as well.
> 
> > 
> > Secondly, do we need some extra code to make sure somebody waits for
> > this device to come up? Who makes sure that initqueue does not exit
> > till this device node comes up.
> 
> 
> I see there's a wait-mount-dev.sh in 95fstab-sys module which is for
> waiting for the mount needed dev.
> 
> Currently dracut maintains host_devs and host_fs_types, host_fs_types
> are mainly used inst the fs kernel modules. Other than the filesystem
> modules we should use host_devs instead, ie. introduce
> for_each_host_devs for modules such as multipath and iscsi using.

I see that iscsi is using for_each_host_dev_fs, which has both device
and filesystem info. Same is the case with multipath.

May be add raw device in host_dev_fs with filesystem type as "raw" and
special case "raw" whoever relies on this info. There might be other
better ways to handle this though.

Thanks
Vivek

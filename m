From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Fri, 30 Sep 2011 15:03:11 -0400
Message-ID: <20110930190311.GH25891@redhat.com>
References: <4E83DE33.4020204@redhat.com>
 <4E848C48.6050506@redhat.com>
 <4E8526A6.30003@redhat.com>
 <4E85370A.7020509@redhat.com>
 <4E853A1C.5070905@redhat.com>
 <20110930183839.GF25891@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110930183839.GF25891-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Fri, Sep 30, 2011 at 02:38:39PM -0400, Vivek Goyal wrote:
> On Fri, Sep 30, 2011 at 11:40:12AM +0800, Dave Young wrote:
> 
> [..]
> > 
> > Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
> > being called automaticlly via dependencies it will be good. OTOH fstab
> > is better than cmdlines as an interface for multi-target dumping
> 
> Agreed that fstab.sys looks like a good interface to mouting non-root devices.

Having said that, looks like dracut builds all the state using command
line options. All the lvms, iscsi root, fcoe targets etc. So they might
expect everything to be passed on command line. In that case it will
become hard from kdump perspective.

Thanks
Vivek

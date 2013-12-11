From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: lvm thin_* binaries are installed in hostonly mode?
Date: Wed, 11 Dec 2013 19:05:45 +0800
Message-ID: <20131211110545.GA1537@dhcp-17-89.nay.redhat.com>
References: <20131204140517.GD3430@dhcp-17-89.nay.redhat.com>
 <20131204152011.GB15680@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131204152011.GB15680-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/04/13 at 10:20am, Vivek Goyal wrote:
> On Wed, Dec 04, 2013 at 10:05:17PM +0800, WANG Chao wrote:
> > Hi, Harald
> > 
> > I notice these thin_* binaries are installed to kdump initramfs in spite
> > of the fact that I don't use thinp lvm:
> > 
> > # ll sbin/thin_*
> > -rwxr-xr-x. 1 root root  384648 Dec  4 20:37 sbin/thin_check
> > -rwxr-xr-x. 1 root root 2184112 Dec  4 20:37 sbin/thin_dump
> > -rwxr-xr-x. 1 root root 2179792 Dec  4 20:37 sbin/thin_repair
> > -rwxr-xr-x. 1 root root 2179928 Dec  4 20:37 sbin/thin_restore
> > 
> > This is introduced here:
> > 
> > commit 5d623b1
> > Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Date:   Mon Oct 21 09:09:26 2013 +0200
> > 
> >     lvm: always install thin utils for lvm
> 
> I think we should install these only if thin device/volume is in the
> mount path.
> 
> Thanks
> Vivek

Thanks Harald. I see you have fixed it upstream and it's working.

commit c21c4dc
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Dec 5 15:57:42 2013 +0100

    lvm: install thin tools, only when needed in hostonly


Thanks,
Chao

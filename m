From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch v2 2/3] Add for_each_host_dev_and_slaves for device only
 checking
Date: Mon, 27 Aug 2012 11:03:59 -0400
Message-ID: <20120827150359.GB15369@redhat.com>
References: <20120823030221.587864989@redhat.com>
 <20120823030628.133563734@redhat.com>
 <20120823152631.GI12232@redhat.com>
 <503B1A62.4010905@redhat.com>
 <503B292A.70707@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <503B292A.70707-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Mon, Aug 27, 2012 at 04:00:42PM +0800, Dave Young wrote:

[..]
> Rethinking about this, it's not possible to fix this with host_fs_types.
> Because dracut.sh check_block_and_slaves then add them to host_devs, if
> we are going to use host_fs_types then we need push slaves into
> host_devs as well, thus the patch 1/3 will wait for all host devices
> including slaves...
> 
> This patchset works just because I created the new for_each_host_dev_and
> slaves so it does not need slaves in host_devs.
> 
> 
> So I would only split this patch into 2 patches without change the logic
> any more...

Looks like Harald has already pulled in this patch series. So if you
want to do any cleanup, it will have to be on top of this patch series.

Thanks
Vivek

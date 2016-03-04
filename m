From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 dracut 2/2] watchdog: install module for active
 watchdog
Date: Fri, 4 Mar 2016 16:18:03 +0800
Message-ID: <20160304081803.GA3466@dhcp-128-65.nay.redhat.com>
References: <cover.1456919929.git.panand@redhat.com>
 <0d7adcfdf08f4eb753a0e65e7e65d5fe0ef22f70.1456919929.git.panand@redhat.com>
 <20160304045610.GD3592@dhcp-128-65.nay.redhat.com>
 <20160304050914.GD7467@dhcppc3.redhat.com>
 <20160304073007.GB2909@dhcp-128-65.nay.redhat.com>
 <20160304074422.GG7467@dhcppc3.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160304074422.GG7467-AB7H14ik7lQf7BdofF/totBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 03/04/16 at 01:14pm, Pratyush Anand wrote:
> On 04/03/2016:03:30:07 PM, Dave Young wrote:
> > BTW, should we add the $wdtdrv $wdtpdrv info rd.driver.pre after the instmods in
> > another patch?
> 
> You mean to ensure that watchdog module is loaded as early as possible?
> Will do that.

Pratyush, yes.

Thanks a lot
Dave

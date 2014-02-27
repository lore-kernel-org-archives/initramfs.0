From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add default values in fstab_lines
Date: Thu, 27 Feb 2014 09:41:48 +0800
Message-ID: <20140227014148.GB2338@dhcp-16-126.nay.redhat.com>
References: <20140214084921.GA30064@dhcp-16-126.nay.redhat.com>
 <20140224015457.GA4043@dhcp-16-126.nay.redhat.com>
 <530DF559.70404@redhat.com>
 <530DF5B6.6070309@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <530DF5B6.6070309-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/26/14 at 03:09pm, Harald Hoyer wrote:
> On 02/26/2014 03:08 PM, Harald Hoyer wrote:
> > On 02/24/2014 02:54 AM, Dave Young wrote:
> >>> -**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_"::
> >>> +**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_ _<dump options>_ _<fsck order>_"::
> 
> maybe
> 
> ... [_<filesystem options>_ [_<dump options>_ [_<fsck order>_]]]"::
> 
> to indicate that they are optional

Good suggestion, thanks. I will also change "dump options" to "dump frequency"
as frequency is a little better.

Thanks
Dave

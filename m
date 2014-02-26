From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add default values in fstab_lines
Date: Wed, 26 Feb 2014 15:09:58 +0100
Message-ID: <530DF5B6.6070309@redhat.com>
References: <20140214084921.GA30064@dhcp-16-126.nay.redhat.com> <20140224015457.GA4043@dhcp-16-126.nay.redhat.com> <530DF559.70404@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <530DF559.70404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/26/2014 03:08 PM, Harald Hoyer wrote:
> On 02/24/2014 02:54 AM, Dave Young wrote:
>>> -**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_"::
>>> +**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_ _<dump options>_ _<fsck order>_"::

maybe

... [_<filesystem options>_ [_<dump options>_ [_<fsck order>_]]]"::

to indicate that they are optional



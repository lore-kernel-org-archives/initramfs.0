From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] ismounted fix
Date: Wed, 19 Sep 2012 18:00:30 +0200
Message-ID: <5059EC1E.3070604@redhat.com>
References: <20120917100103.GA18640@darkstar.nay.redhat.com> <20120919135906.GE31860@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120919135906.GE31860-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 19.09.2012 15:59, schrieb Vivek Goyal:
> On Mon, Sep 17, 2012 at 06:01:03PM +0800, Dave Young wrote:
>>
>> ismounted handles both find-by-dev and find-by-mnt, but there's two issues:
>> 1. for find-by-dev, it use readlink to get the canonical dev name, but
>>    lvm is different with other devices, the canonical name for lvm devices
>>    are symlinks like /dev/mapper/vg-lv00
>> 2. for nfs mounting, just use [ -b $dev ] is not enough, it need being handled
>>    seperately.
>>
>> Per Karel Zak's suggestion, findmnt util is suitable for this purpose, it
>> handles these cases well, so just use findmnt instead of implement all the
>> logic by ourselves. Thanks, Karel.
> 
> This patch looks reasonable to me. Harald, are you fine with it?
> 
> Vivek

Yes. Looks good!

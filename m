From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] LIBDIR detection without /proc
Date: Wed, 20 May 2009 18:02:27 -0400
Message-ID: <4A147DF3.4070108@redhat.com>
References: <4A146687.3020508@redhat.com> <Pine.LNX.4.58.0905202249560.7805@gate.bb.dicp.net> <4A146EBF.5060404@redhat.com> <Pine.LNX.4.58.0905202309060.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0905202309060.7805-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/20/2009 05:24 PM, Andreas Thienemann wrote:
> On Wed, 20 May 2009, Warren Togami wrote:
>
>> If you have 64bit plymouth it will be at that location.  If it isn't at
>> that location, then the previous lib vs lib64 check and subsequent
>> copying would have failed to do its job anyway.  So what is the possible
>> harm?
>
> For this specific case, it would work in hopefully all cases.
> I have no idea how common ia32 systems with amd64 binaries in addition to
> the used ia32 binaries are. This is something which would throw off the
> check.

If a 32bit system has 64bit binaries installed it is an error.

>
> I've seen such things on development systems, which is why I'm personally
> tending to favor uname output... In any case, it's Harald's call. :)

You cannot rely on detection of any aspect of the running system to 
decide what gets included in the initrd.  Isn't a big point of dracut to 
exist to have a generated initrd that can boot any system of the same arch?

The other case where it reads /proc/mounts to decide which filesystems 
to include in the initrd is another example of where we shouldn't be 
relying on the running system for detection.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

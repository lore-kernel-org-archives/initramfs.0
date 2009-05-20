From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] LIBDIR detection without /proc
Date: Wed, 20 May 2009 16:57:35 -0400
Message-ID: <4A146EBF.5060404@redhat.com>
References: <4A146687.3020508@redhat.com> <Pine.LNX.4.58.0905202249560.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0905202249560.7805-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/20/2009 04:52 PM, Andreas Thienemann wrote:
> On Wed, 20 May 2009, Warren Togami wrote:
>
>> Could we please not rely on /proc to detect anything?  Something like
>> the following would work fine.  It also has the benefit of being able to
>> run without /proc mounted, which is great for building initrd's within a
>> chroot.
>
> I'm not sure if checking for an installed file is going to work flawless.
> *shrug*

If you have 64bit plymouth it will be at that location.  If it isn't at 
that location, then the previous lib vs lib64 check and subsequent 
copying would have failed to do its job anyway.  So what is the possible 
harm?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

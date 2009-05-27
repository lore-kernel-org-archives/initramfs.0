From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Wed, 27 May 2009 16:26:42 -0400
Message-ID: <4A1DA202.5040509@redhat.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net> <1243305738.3584.40.camel@obelisk.thedillows.org> <20090526024454.GA10049@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090526024454.GA10049-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/25/2009 10:44 PM, Jeremy Katz wrote:
> On Monday, May 25 2009, David Dillow said:
>> dash gets upset when it cannot open /dev/tty, and we lose stderr. Even
>> if we make /dev/tty once we're in the initramfs, it will still be too
>> late for the inital dash shell running the init script. So, make a small
>> set of nodes in the dracut script while building the directory structure
>> of the initramfs.
>
> Creating the nodes in the dracut script means that you can't create the
> initramfs as non-root, though.  :(
>

Unless we write a separate program that outputs cpio files.  Perhaps not 
worth the effort?  How important is it to make initrd from non-root?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

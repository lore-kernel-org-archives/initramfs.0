From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Mon, 09 Mar 2009 11:49:35 +0100
Message-ID: <49B4F43F.6070304@redhat.com>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org> <20090306203921.GA28154@nostromo.devel.redhat.com> <1236382532.5147.38.camel@sentry-no.fnordovax.org> <20090309031111.GC3983@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090309031111.GC3983-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jeremy Katz wrote:
> On Friday, March 06 2009, Victor Lowther said:
>> On Fri, 2009-03-06 at 15:39 -0500, Bill Nottingham wrote:
>>> Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
>>>>>> http://git.surfsite.org/dracut.git
>>>>>> git://surfsite.org/pub/git/dracut.git
>>>>> Wasn't the entire point to make the initramfs generic?
>>>> No, to make the initramfs generator generic. A subtle but important
>>>> distinction.
>>> Nope. The plan was (quoting earlier mails to the list, from the
>>> creators...):
>>>
>>> ...
>>> [I]nstead of scripts hard-coded to do various things, we depend on
>>> udev to create device nodes for us and then when we have the
>>> rootfs's device node, we mount and carry on
>> We do this just fine.  Udev is the engine that drives everything in a
>> dracut-generated initramfs -- the additional scripts are there in the
>> initramfs to handle things that udev does not handle gracefully. If you
>> see some functionality currently handles in a script that udev could
>> handle better, please implement it.
> 
> The problem is the direction seems to be "hm, udev can't do this, guess
> we'll make a hook" rather than "fix udev and the underlying tools".
> Yes, it means it's harder.  And yes it means that distros have to get
> updates for everything to work.  But otherwise, we remain in the past
> with piles of scripts doing most things.
>

Problems so far:
	- dmraid (raid assembly)
	- device mapper handled /dev/ symlinks
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

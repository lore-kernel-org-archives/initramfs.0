From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Fri, 15 May 2009 14:16:12 +0200
Message-ID: <4A0D5D0C.5060800@redhat.com>
References: <4A098CB5.2070006@redhat.com>	 <1242351147.29452.2.camel@sentry-no.us.dell.com>	 <1242355988.5107.4.camel@obelisk.thedillows.org> <1242389030.29452.10.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242389030.29452.10.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/15/2009 02:03 PM, Victor Lowther wrote:
> On Thu, 2009-05-14 at 22:53 -0400, David Dillow wrote:
>> On Thu, 2009-05-14 at 20:32 -0500, Victor Lowther wrote:
>>> On Tue, 2009-05-12 at 16:50 +0200, Harald Hoyer wrote:
>>>> Today I updated http://apps.sourceforge.net/trac/dracut/ and the package README and TODO files.
>>>> The next days, I will add iSCSI support and test various network setups.
>>> Cool.  I ahve been working on some test suite improvements (lvm on
>>> cryptroot on software raid5), and am working on making dracut actually
>>> work in that configuration.  I will post patches to the mailing list
>>> once it works without manual hackery.
>>>
>>> Next stop, all that over iscsi.  Should be fun.
>> Glad to see this project isn't dead...
>
> I had a sudden attack of Real Life -- my daughter learned to crawl, so
> the tiny amounts of free time I once had vanished.

cool :-) not so good for dracut :-/

>
>> I've got a few boot-off-of-NFS patches together that use DHCP options to
>> find the root, and let it be overridden by the command line. I've also
>> got a piece that lets it boot over a bonded network. I'll try to circle
>> back to those and post them before Memorial Day (May 25h).
>
> Cool.  Can you also hack up a makefile target that tests it using kvm
> and/or qemu?
>
> I suppose I should post my more generic test suite improvements (making
> kvm/qemu work no matter what it is named on any given distro) to give
> you something a little easier to build with.

yes, just post them, no matter, if they apply to the actual tree.. I will merge 
them and clean them up.

>
>> These all trigger off of udev events, though I recall there was some
>> discussion about whether that was the way to go or not. In many ways,
>> they are just polish on some of the network patches that have been
>> posted here before (by you two, IIRC).
>
> I don't think we ever finally decided one way or the other, the
> conversations kind of died off without reaching a conclusion.
>

I think "all trigger off of udev events" is the way to go. If it doesn't work, 
try to fix the tools that do not work.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

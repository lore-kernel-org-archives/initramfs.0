From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Tue, 26 May 2009 18:15:23 +0200
Message-ID: <4A1C159B.1070009@redhat.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net> <1243305738.3584.40.camel@obelisk.thedillows.org> <20090526024454.GA10049@redhat.com> <1243306682.3584.42.camel@obelisk.thedillows.org> <Pine.LNX.4.58.0905261634470.2270@gate.bb.dicp.net> <1243349941.19603.5.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243349941.19603.5.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/26/2009 04:59 PM, David Dillow wrote:
> On Tue, 2009-05-26 at 16:36 +0200, Andreas Thienemann wrote:
>> On Mon, 25 May 2009, David Dillow wrote:
>>
>>> Bummer, that. And while it makes the initial dash able to give us
>>> stderr, it doesn't fix the emergency shell. Of course, I noticed this
>>> after hitting send... so bad patch all around. :(
>> I think the patch is unnecessary in any case.
>>
>> Dash loosing stderr when /dev/tty is unavailable is a dash bug. It's been
>> fixed in upstream git and the patch has been applied to rawhide and F11.
>>
>> I think the problem should be considered fixed and we won't have to
>> introduce workarounds like pre-creating device nodes.
>
> Some of us want to use dracut on F10, or better yet CentOS 5.3. And we
> test on released distros, not an unreleased one (albeit coming very
> soon).
>
> Does my later patch, that just makes /dev/tty point to /dev/console for
> the emergency shell seem unobtrusive enough to take upstream?
>
> If I need to carry this locally, I don't mind, but I figure others could
> use the fix when working on the initramfs.
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

just omit the dash module for debugging purposes :)

dracut --omit dash

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

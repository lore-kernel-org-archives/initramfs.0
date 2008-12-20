From: Daniel Pittman <daniel-zvVxMF7wGoXk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Sun, 21 Dec 2008 00:50:21 +1100
Message-ID: <87skojrm5e.fsf@rimspace.net>
References: <1229540094.28858.150.camel@aglarond.local>
	<20081217190700.GA15377@infradead.org> <4949FD67.6040906@suse.de>
	<494B5031.5080306@bfh.ch> <20081219091841.207bc951@kopernikus.site>
	<494BA7CE.2020007@suse.de> <20081219152708.GE9871@mit.edu>
	<9C4F1B7D-CCBC-48D7-8624-9A7C314C1590@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9C4F1B7D-CCBC-48D7-8624-9A7C314C1590-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> (Jeremy Katz's
	message of "Fri, 19 Dec 2008 11:56:47 -0500")
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:
> On Dec 19, 2008, at 10:27 AM, Theodore Tso wrote:
>> On Fri, Dec 19, 2008 at 02:55:26PM +0100, Hannes Reinecke wrote:
>>>
>>> The goal of the initrd is to activate and mount the root fs.
>>> And the root fs _only_. Every other system should be configured
>>> once the main system is running.

[...]

>> There may also be times when it is useful to operate on the root
>> filesystem in some way before it is mounted; in most cases the
>> operation can bedone on a filesystem mounted read-only, yes --- but =
at
>> the cost of needing to reboot afterwards if the root filesystem need=
s
>> to be modified by said userspace tool.
>
> I think that once you start getting into this realm, though, you end
> up with an incredibly over-complicated and slow initramfs.  If we
> instead focus on keeping things "fast", the reboot afterwards isn't
> that costly.

One of the features of the Debian / Ubuntu initramfs infrastructure,
which sounds remarkably like your design (or vice-versa), is that it
drops all the "standard" drivers into the initramfs.

This is, to me, worth several minutes of additional boot time, in terms
of flexibility: being able to modify the hardware and be confident that
the appropriate drivers are in place already makes life much, much
easier.

(In practice I doubt this adds more than a second or five to boot time;
 certainly, it takes no longer to get to rootfs mounted than the RHEL 4
 systems that have nothing but what is essential in the initrd...)


So, it would certainly be my hope =E2=80=94 with my systems administrat=
ion hat
on =E2=80=94 that your proposed system would support that similar opera=
tion as
an option, at least.

Personally, I think it makes the right default: better correct than
fast, but obviously tastes vary there.

Regards,
        Daniel
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

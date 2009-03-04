From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Wed, 4 Mar 2009 13:08:51 +0100
Message-ID: <ac3eb2510903040408w299b349aj791a2f9e0d154b9a@mail.gmail.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
	 <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
	 <20090304002535.GB96609@redhat.com>
	 <1236129369.6500.18.camel@sentry-no.fnordovax.org>
	 <ac3eb2510903040212m5d68d812kbce03d831e8c3d12@mail.gmail.com>
	 <1236166408.6500.37.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1236166408.6500.37.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Mar 4, 2009 at 12:33, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> On Wed, 2009-03-04 at 11:12 +0100, Kay Sievers wrote:

>> > Mmmm... sweet scent of politics. =C2=A0I get the feeling that many=
 kilobytes
>> > have been spent flaming^Wdiscussing this topic.
>>
>> Yeah, it seems hard for some kids to share their toys. :) But it's
>> pretty much over, there is not much to discuss anymore. We all ship
>> the same stuff, and share the same bugs. If you want "Debian" use
>> Ubuntu. It's part of the upstream development, ships recent versions
>> which other stuff can develop against, and can depend on. :)
>
> Good to know, but I think I will stick with Fedora for now.

Yeah, sorry, "you" did not mean you. :)

> It seems
> like we have enough patches floating around on the mailing list right
> now to have a good chance at making everything but Debian work withou=
t
> too many distro-specific workarounds

Sounds fine. After the next sync, and if we can resolve the libexec
thing, I'll make it work on SUSE.

> (or, at least we will once
> switch_root is rewritten in C and packaged into util-linux)

Does the tool already exist somewhere so that it can be merged? Is it
the busybox one?
Did someone send something Karel already?

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

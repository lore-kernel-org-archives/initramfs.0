From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] Multiple interfaces support and lots of
 cmdline parsing
Date: Sat, 13 Jun 2009 00:05:16 -0400
Message-ID: <1244865916.18551.20.camel@obelisk.thedillows.org>
References: <4A327030.1000803@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A327030.1000803-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-06-12 at 17:11 +0200, Seewer Philippe wrote:

> In order to ensure correct ip= lines I've added a lot of cmdline 
> parseing and some mostly minor rewrites of actual netroot handlers.
>
> Thanks for reviewing (or accepting) the stuff,
> Philippe

The series broke the NFS and NBD test suites, and I've not looked into
why yet. It dies on the first test.

I've started digging in and trying to review some of the changes, but
I'm just not going to have time before I leave; perhaps I can sneak away
for a bit next week.

Perhaps a theory of operation/design document as to what the flow is
expected to be, or what is handled where would help?

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

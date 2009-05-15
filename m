From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Fri, 15 May 2009 09:33:59 +0200
Message-ID: <4A0D1AE7.4060400@redhat.com>
References: <4A098CB5.2070006@redhat.com> <1242351147.29452.2.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242351147.29452.2.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/15/2009 03:32 AM, Victor Lowther wrote:
> On Tue, 2009-05-12 at 16:50 +0200, Harald Hoyer wrote:
>> Today I updated http://apps.sourceforge.net/trac/dracut/ and the package README and TODO files.
>> The next days, I will add iSCSI support and test various network setups.
>
> Cool.  I ahve been working on some test suite improvements (lvm on
> cryptroot on software raid5), and am working on making dracut actually
> work in that configuration.  I will post patches to the mailing list
> once it works without manual hackery.
>
> Next stop, all that over iscsi.  Should be fun.
>

With lvm and raid we should wait for the new versions of these tools.
The tools and udev rules have been revamped and the need for non-udev calls 
(like "dmraid -ay") should have been eliminated.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

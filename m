From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 1/1] Final fixups to make the full testsuite work.
Date: Fri, 29 May 2009 13:02:02 +0200
Message-ID: <4A1FC0AA.3050902@bfh.ch>
References: <151d32e89583815962af8d721b17d0b320f80a2f.1243306326.git.victor.lowther@gmail.com>	 <4A1BB5DE.3090206@redhat.com> <1243340142.4005.8.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243340142.4005.8.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Victor Lowther wrote:
> On Tue, 2009-05-26 at 11:26 +0200, Harald Hoyer wrote:
>> On 05/26/2009 04:57 AM, Victor Lowther wrote:
>>> test-10 now completes sucessfully.  What has changed:
>> hmm, it completed sucessfully on Fedora 11 without any problems..
> 
> Ah, distro issues.  I have been doing all my recent work using Ubuntu
> 9.04 x86_64.
> 
> I suppose that brings up another rather fundamental question -- what
> degree of cross-distro compatibility should we be building into dracut
> from the beginning?  I try to write things so that dracut will work on
> anything whose udev rules are reasonably in line with upstream -
> everything but Debian, these days
> 
> Is anyone besides me testing dracut on something that isn't Fedora?

Yes me! Currently that's Ubuntu 9.04 && Debian 5.0

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

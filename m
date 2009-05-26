From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] Final fixups to make the full testsuite work.
Date: Tue, 26 May 2009 11:26:54 +0200
Message-ID: <4A1BB5DE.3090206@redhat.com>
References: <151d32e89583815962af8d721b17d0b320f80a2f.1243306326.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <151d32e89583815962af8d721b17d0b320f80a2f.1243306326.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/26/2009 04:57 AM, Victor Lowther wrote:
> test-10 now completes sucessfully.  What has changed:

hmm, it completed sucessfully on Fedora 11 without any problems..

>
> Added some logging functionality.  All info, warning, and error messages
> are logged to a logfile, which is cleared on every dracut run.
>
> We no longer try to incrementally assemble mdraid arrays.  It did not
> work using Ubuntu 9.04 x86_64.  It is probably a bug in mdadm, but for
> now just fall back to auto assembly. A better fix would be appreciated, as
> long as it does not break the test suite and does not remove mdraid testing
> from the test suite.

worked on Fedora 11

$ rpm -qf /sbin/mdadm
mdadm-3.0-0.devel3.6.fc11.x86_64

>
> create-root.sh mounts the root filesystem straight away.
>
> It takes forever (or, at least 30 seconds) to actually unlock the LUKS device.
> This did not happen when the unlock was not done in a udev rule.
> It is either cryptseup behaving badly when called from udev, or demons.

huh? works instantly on Fedora 11

$ rpm -qf /sbin/cryptsetup
cryptsetup-luks-1.0.6-7.fc11.x86_64

>
> We should really not add all the network modules to the initramfs, at least for
> testing.  Doing so really bloats things.
>
> Anyways, I am throwing this out there for discussion and ideas on better
> ways of fixing these warts.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

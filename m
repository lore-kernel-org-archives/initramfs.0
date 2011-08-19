From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 09:03:32 +0200
Message-ID: <4E4E0AC4.1020709@redhat.com>
References: <4E4D5779.6090209@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E4D5779.6090209-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 18.08.2011 20:18, John Reiser wrote:
> Building an initramfs is unreasonably slow.  On Fedora 16
> dracut-011 takes almost a minute when installing a new kernel:
>    real   56s
>    user   20s   \__   dracut is CPU bound, not I/O bound.
>    sys    31s   /
> The final "gzip -9" takes 12 seconds, and the cpio 1 second,
> which leaves 43 seconds for the rest of dracut.  That's a
> factor of 3 or 4 too long.  The output initramfs is 14.9MB
> (41MB unzipped) and contains 1619 files, including 367 .ko
> kernel modules.

Some general thoughts.

1. speed at initramfs creation time is not sooo important. Normally this is only
done once in a while and not every day. Boot speed is more important.

2. if you care about speed of creation and size of the initramfs, turn on
"hostonly" in /etc/dracut.conf


> Yes, I'm going to work on it.
> 

That's cool! I accept patches :-)

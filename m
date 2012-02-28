From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Tue, 28 Feb 2012 08:58:09 -0800
Message-ID: <4F4D07A1.7010305@bitwagon.com>
References: <4F4BA634.5070804@gmail.com> <jiii51$5mc$1@dough.gmane.org>	 <4F4CEE33.3000906@bitwagon.com> <4F4CF2D1.8090704@redhat.com> <1330446443.1026.123.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1330446443.1026.123.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/28/2012 08:27 AM, David Dillow wrote:

> Is the purpose of this work to speed things up for the user, or for the
> developers? Your approach is correct for developers, since we're more
> likely to be making multiple dracut image with a warm cache. But users
> are more likely to hit the cold cache case.

Both users and developers.  However, the cache must be controlled
(or known) for any measurement, else there is no way to attribute
the effects of any measured change: the cache effect could be much
larger than any improvement (or degredation).  The easiest way
is to have a warm cache: discard the first run of a series because
of the unknown cache state.

The cold cache case can be approximated by:
    # echo 1 > /proc/sys/vm/drop_caches
    # time dracut ...
    # echo 1 > /proc/sys/vm/drop_caches    # each time!
    # time dracut ...
but that path /proc/sys/vm/drop_caches is harder to remember
(and harder to get correct in a sudo!)
It is also harder to guarantee consistency on a machine that is
not otherwise idle.

Running dracut after updating kernel and/or drivers is likely
to hit a mixed cache: the updated stuff will tend to be hot,
the not-updated stuff probably will be cold.

-- 

From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Tue, 28 Feb 2012 10:30:21 -0800
Message-ID: <4F4D1D3D.2070808@bitwagon.com>
References: <4F4BA634.5070804@gmail.com> <jiii51$5mc$1@dough.gmane.org>		 <4F4CEE33.3000906@bitwagon.com> <4F4CF2D1.8090704@redhat.com>	 <1330446443.1026.123.camel@obelisk.thedillows.org>	 <4F4D07A1.7010305@bitwagon.com> <1330451168.1026.139.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1330451168.1026.139.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/28/2012 09:46 AM, David Dillow wrote:

> I tend to agree that the ~2 second improvements reported so far are not
> compelling, but I see those as the developers case. I'm more interested
> in the users' case -- is that 14 seconds Cong reported real?

I suspect that the 14 seconds difference was between a cold cache (first run)
and a warm cache (third run).  There wasn't anything non-real about it,
but the cache effect was much larger than the lazy/non-lazy algorithm.
The measurements that I reported yesterday were all warm-cache cases,
and I saw much closer improvement in wall-clock time (several percent)
for lazy, in both testimage and hostimage.  This is consistent with
the hypothesis that the improvement was due to the lazy case using one
(or a small handful) cpio of many files at a time, versus the non-lazy
case doing one /bin/cp for each file.  The savings is in reduced
usage of fork[clone]+execve+ld_linux.so+wait.

-- 

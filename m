From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Tue, 28 Feb 2012 07:09:39 -0800
Message-ID: <4F4CEE33.3000906@bitwagon.com>
References: <4F4BA634.5070804@gmail.com> <jiii51$5mc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jiii51$5mc$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/28/2012 04:43 AM, Cong Wang wrote:

> [wangcong@cr0]~/dracut% git branch
>   lazyinstall
>   * master
> [wangcong@cr0]~/dracut% time sudo make testimage
> ...
> sudo make testimage  38.20s user 8.04s system 95% cpu 48.509 total

Was that run with a "cold cache"?  (What are the results for the
a second run on testimage, immediately after the first?)
I ask because the difference (48.5 - 34.5) between master and lazy
on testimage is much larger as a percentage than the (15.4 - 13.5)
difference for hostimage; and the testimage case was run first.

-- 

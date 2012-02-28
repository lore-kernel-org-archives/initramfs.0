From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Tue, 28 Feb 2012 12:43:14 +0000 (UTC)
Message-ID: <jiii51$5mc$1@dough.gmane.org>
References: <4F4BA634.5070804@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 27 Feb 2012 at 15:50 GMT, Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I am interested in:
>
> $ time sudo make testimage
> $ time sudo make hostimage
>
> Both with and without the patch.
>

[wangcong@cr0]~/dracut% git branch
  lazyinstall
  * master
[wangcong@cr0]~/dracut% time sudo make testimage
...
sudo make testimage  38.20s user 8.04s system 95% cpu 48.509 total

[wangcong@cr0]~/dracut% time sudo make hostimage
...
sudo make hostimage  11.69s user 4.00s system 101% cpu 15.401 total


[wangcong@cr0]~/dracut% git checkout lazyinstall
Switched to branch 'lazyinstall'
[wangcong@cr0]~/dracut% git branch
* lazyinstall
  master
[wangcong@cr0]~/dracut% time sudo make testimage
...
sudo make testimage  38.03s user 8.11s system 133% cpu 34.474 total

[wangcong@cr0]~/dracut% time sudo make hostimage
...
sudo make hostimage  11.36s user 3.45s system 109% cpu 13.478 total

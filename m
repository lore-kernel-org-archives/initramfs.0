From: covici-cDiIMnvS3U/1IL9EAbMJQA@public.gmane.org
Subject: dracut unable to boot zfs pool using dracut and systemd
Date: Mon, 18 Jan 2016 10:38:20 -0500
Message-ID: <10712.1453131500@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-ID: <10711.1453131500.1-cDiIMnvS3U/1IL9EAbMJQA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi.  I have been trying to get a zpool into a state where I can have zfs
as root  and /usr and other file systems, but Dracut does not play
nice.  It will not find the pool, unless I omit the root= variable from
the kernel command line and even then, it will not mount a separate /usr
zfs dataset.  The fstab entry for that file system is
rpool/usr /usr zfs defaults 0 2

So, am I doing something wrong, or is Dracut broken or what?

Thanks in advance for any suggestions.

-- 
Your life is like a penny.  You're going to lose it.  The question is:
How do
you spend it?

         John Covici
         covici-cDiIMnvS3U/1IL9EAbMJQA@public.gmane.org

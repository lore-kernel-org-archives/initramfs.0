From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Testers wanted: dracut lazy install with cpio
Date: Mon, 27 Feb 2012 16:50:12 +0100
Message-ID: <4F4BA634.5070804@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ouxDYwOYppDjkk9xAbZdNdVBTn0Z3tIOv3BMMi70Gcs=;
        b=L5BPBNB3K20koeZv9f52amn09TB8lxrn6b2/Ay3TLD+MMfRT5iBiIXVg5wloeTOEA2
         L2aF15Ks8prTxuWK8mgqkKHhUw5K5wJK+ZpzfJQ6VskUJ3RcXrZMoV8meT58hV3xYPWk
         BV2av8PTr/ga356s6WIXk8LuDgNmzm81z7N6o=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi guys,

I made a patch for lazy installing the files with cpio.

I am interested what the difference in speed is, to evaluate, if it is worth the
hazzle.

The patch:
http://git.surfsite.org/?p=dracut.git;a=commit;h=df512139fe9c23b84a2213c934e7a7feb354bdcc

can be found on git://git.surfsite.org/pub/git/dracut.git branch:lazyinstall

I am interested in:

$ time sudo make testimage
$ time sudo make hostimage

Both with and without the patch.

Thanks for testing!

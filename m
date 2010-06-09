From: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: How to make the scripts in /etc/init.d/rc3.d running in one diskless 
	system? The initrd.gz is genrated by dracut
Date: Thu, 10 Jun 2010 01:08:54 +0800
Message-ID: <AANLkTimoOOjT2HnrU1Xxcti9NjPUl11SVtqdMQqTwUmh@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=mkSq8VpHc82DCSC5LY8QLBS9TKCcm7LpHQWjiVyJJ44=;
        b=kWjtAhy0Xittvtb9QSNhYYQ9MmIzxgMb9PD/KifS6Ga24JC5hyiwZr9kVSq617oNI7
         y4UJsHaLKqTdTs0pWSsrHPaZ+lqEXuCQTzsXWIKHbLPDaKUyF49EllTPGOhcFenmL/UR
         B68TT5dM5UtsA5dYhV+3VOjPB9FAPERUJQlEQ=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi all,

I have one question, hope anyone can help me, thank you.

The root filesystem used by the kernel is specified to be nfs, I have
added the configuration to the boot configuration files, and I didn't
create my own dracut modules, I also updated the /etc/dracut.conf
file, finally I created the initrd.gz file using "dracut" command.

The kernel can be booted up and it use the specified nfs directory as
its root filesystem, but I have one question about the nfs rootfs
support. When we specify nfs as the root filesystem, when dracut
switch root to the nfs directory, what should I do to make all the
default boot scripts in /etc/init.d/rc3.d running? If I need to create
one new dracut module, can anyone give me a prototype? Thank you!

Best regards,
Min Jun, Xi

From: Daniel Podolsky <onokonem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: liveusb support
Date: Tue, 7 Sep 2010 02:48:37 +0400
Message-ID: <AANLkTinxxQNpgHMSeDKr+hbUpECKJbTMyjBRYVnshAsm@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=E6G7VJi3xtmOFnIfVNy4/fU6OwL7pamnXsjjbrSsxkw=;
        b=MdX9qurXY8om9AL1FAGW222slS7ngwhqosS7grnM5+mqnsBSGGJNJqSDi/4Q5TZBZM
         GomzTc7ZZGUZHLRc1Cyrs18eA1g3yj3PBPyTn8VvVmsZuw4VHH4En2zL5RpWdM+q6q7Z
         4dWCmQY/fCJqP/HcRYcs67prGOIlBI2w/4yao=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

HI!

My name is Daniel Podolsky and this is my first mail to this list.

I'm using dracut (as part of fedora12) in my own server-on-usb-stick project.

I would like to allow users to create bootable flash drive from
Windows, so I've decided to use FAT32 formatted flash and syslinux.
Root filesystem should be mounted from an image file placed on flash.

I did not find a way to implement this idea with current dracut. Even
"root=live:..." did not help as I do not want to use rw overlay but
mount fs directly from image.

So I've added the desired functionality myself.

The questions I have:

1) I suppose simple mount of rootfs image is not supported by dracut
at the moment. Am I right?
2) If yes can I contribute my simple modifications to the project? No
one existing file modified, 5 new (one module) added.

Thank you.

With best regards,
Daniel Podolsky

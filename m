From: Tony Wan <visual2me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: help about dracut
Date: Tue, 6 Apr 2010 20:11:51 +0800
Message-ID: <p2t69b8237b1004060511w87a32eb3qc6f4c273bd6bb121@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=Kktu66rupC9jT8GqGVJXdib/BURmaVkOwlrP7zG1HWA=;
        b=q7oAEaOmVqiLH90fDK4RdjDBtxiWPLQ0JKhUY1Jk5WOHO0X43M53Q5X07/bKzn/AFM
         o9Zh1QrC6IUKHYhOerNRyIbr7umKnCrtvZS9v12B+Z7QzkRkyJKHZoY/O1XKquD8avqO
         YT+E6fzUEAUSBf0Om5yFpoSBLhjPoY/4arZlc=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi List,

Sorry for interrupt. I'm totally a newbie for dracut and have no idea
how to make a customized initramfs with it on Fedora Core 12. I have a
luks-crypted partition, but I don't want to mount it at boot time, so
there's no need to ask for the password during the boot process. My
question is how to disable dracut to auto-detect crypto_LUKS
partitions and ask for the password during boot (or just for a
specific partition with a UUID). Anyone can give me help, since it's
really difficult to find a tutorial for dracut on internet. Thanks in
advance.

--
Best regards,
Tony Wan

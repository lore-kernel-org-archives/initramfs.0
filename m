From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: including python in the initramfs
Date: Tue, 16 Jun 2009 18:40:31 +0100
Message-ID: <1245174031.2150.67.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=F/hSxlKNcG0vUfgYNNZfGyzC0Rm5z24RHK0brbIbPXI=;
        b=UZnvbPOz57wIXSNCY1sLdPPSxkzjS6jTCYkOGmqLozQKVK5iCDLXwfyALJbFMRnD5i
         nuYSzgZLEa6YADpFr9dlqhximTB1h7AJ1WYOKAwsX4QuEbzpD0tFXjLgtf3gr+3M7A6o
         I+LAsEh8MoGn1NYvpVJvgam1Qhouwe517MgmQ=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

OLPC have a security client that runs pre-root-mount in the initramfs
which is quite complex. It is written in Python. As such, we need python
in the initramfs.

What's the best way to include python in a dracut initramfs?

One idea: we could create a separate module which installs all the files
identified by "rpm -q --filesbypkg python". But that's obviously not
distro-portable. It could work for us but I'd prefer that we're able to
share the work we're doing with others. Any other ideas?

Thanks,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

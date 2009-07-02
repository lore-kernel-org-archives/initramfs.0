From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: firmware loading
Date: Thu, 02 Jul 2009 14:32:10 +0100
Message-ID: <1246541530.2168.7.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=o8Zijj8cGDy3D2pEqHfy2zj4WTbsFroyhTctTbf6EXo=;
        b=tiC8il7nAAv1BGfnRibW6q04cLcVlSsI8rcRigd6DOHlZOTDOufUg3ZfNdxkZew92t
         EKqFStwfzrD4JpPcz+ZB4PWcCANfrif6fXdOrPDE6UtmLzOQYKxBEGxy6vEZPsSlPO4s
         WszCpNHqFnltR/a0TsKmUCsqSiBqFKp1YkPC8=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Dracut seems to lack a mechanism for firmware loading i.e. it doesn't
install the udev rules or the firmware loading helper.

Is this planned?

I'd be happy to come up with a patch. Would it be sensible to add it to
95udev-rules?

Thanks,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

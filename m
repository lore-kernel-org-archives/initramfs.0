From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: base module dependency on kernel-modules
Date: Fri, 12 Jun 2009 10:19:27 +0100
Message-ID: <1244798367.2217.14.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=SvQYYmf7jZ7d4j43JBTc4+cboO2ljQNtK3GGexUxaXc=;
        b=jr+UKntvVCboDOxKH+edYQgpYSCbDFPip6rZZUqG69ts7i+oCOE7A1hbI+RKwCtTSQ
         r0KLREuh0pCQoCxnTxsjP4obKI15opkyP5ujLlDOMBfuO3RfDNPf4gnvoNQxn1F6/XN7
         XvExArDOJUIIaY9hK5N//YsmNQ395SBaqp9E8=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

We're looking to use dracut for OLPC's initrd, it looks excellent!
Thanks for all the hard work.

We're interested in building a lean initrd, without any dependence on
kernel modules.

However, the 99base module includes a depedency on 90kernel-modules. The
assumption that kernel modules are always needed seems untrue. Would a
patch be accepted to remove this dependency, or am I missing some
reasoning here?

I should also mention that if I manually remove this dependency, dracut
fails to build because depmod isn't happy that there is
no /lib/modules/kernelver directory, but it would be easy to fix that
issue.

Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: crypt-cleanup.sh question
Date: Tue, 26 Oct 2010 13:11:29 +0100
Message-ID: <4CC6C571.8010406@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=EOZUsdz99MSxznWUrQx/ZNfr6fqQQqwdQgxCGTkvI1E=;
        b=ackb+XuDBG6HgvXRK/MzMLOPstpWfD7vSOOlE7E8lMG/JCL8UOKiHQXCgByXCe2uy5
         T4dHpDLlAoHRt+lR6LcB2k5UmG92raOVVqCBYzGzAXy3+y2Fnljz0pB2iyOxhs/Gvabz
         z4iMPi4FgDgli6BL5l7BnEQ/YzkdYTXvOMHbY=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

What is the rationale behind closing all /dev/mapper/luks-* devices 
which are not 'busy' in this shell script? Why would they have to be 
'busy' (I presume already mapped) to be left open?

I am asking this because when the smartcard module opens a LUKS drive 
(not root - '/') - this drive later to be mapped from the actual root 
/etc/fstab file as '/dev/mapper/luks-XXX /some/directory' - this 
operation does not succeed and I presume crypt-cleanup.sh closes it up 
before the actual root can get it and therefore it cannot be mapped.

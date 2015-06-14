From: poma <pomidorabelisima-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dmsquash-generator.sh - soon?
Date: Mon, 15 Jun 2015 00:06:21 +0200
Message-ID: <557DFADD.10506@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=OT4IkcFyS1WJQmLcY58EisfQVRLRdx6zupxH9vADf6g=;
        b=KXX0UIPMWqm+b67VaNjzpLYfZT0hK73IxHvE6k1Dk8TOKeSN5jOQFiQ37CTOKgoPXZ
         yOmyWkToww6+99w69e6ms2Ir2O/sFSWJ53BE5EUQHsmlbD3i6dUHU9NagZdw487mNztY
         KucWM81GoiG7gq0Iwap7qYGPwDgfQZ9/Tvc4/bubD1qpCH6NBuvlpdkoDJKTkacJdwYv
         ls4lh6X6f1OvZAxSpe83GnPrG2JPyMKoF1yMif/De9XpJWdbcjfqNRcgrLf9cn/wtXt0
         JGdPZJUsz9+IPYZuokTlE9jJmN4V35llYK6zkQ+ThxHSuyjFp3PyUWzleLQTRtvNhsG/
         Zwig==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/modules.d/90dmsquash-live/module-setup.sh#n34
inst_script "$moddir/dmsquash-generator.sh" $systemdutildir/system-generators/dracut-dmsquash-generator

http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/modules.d/90dmsquash-live

-rwxr-xr-x	apply-live-updates.sh
-rw-r--r--	checkisomd5@.service
-rwxr-xr-x	dmsquash-live-genrules.sh
-rwxr-xr-x	dmsquash-live-root.sh
-rwxr-xr-x	dmsquash-liveiso-genrules.sh
-rwxr-xr-x	iso-scan.sh
-rwxr-xr-x	module-setup.sh
-rwxr-xr-x	parse-dmsquash-live.sh
-rwxr-xr-x	parse-iso-scan.sh

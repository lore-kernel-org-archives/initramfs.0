From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [systemd-devel] Second (erroneous) check of rootfs?
Date: Wed, 07 Jan 2015 23:23:27 -0300
Message-ID: <54ADEA1F.3080908@opensuse.org>
References: <54ADD119.2050906@yandex.ru> <20150108004352.GA22800@gardel-login> <54ADD98D.9080608@opensuse.org> <54ADE3A1.6060107@yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020303090303060008010305"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type;
        bh=tPwTqDlTLzFwE4+2HxccG0YzGCGGUM8VOv7sBM2gohY=;
        b=JSbfxqu8qzRLAiwe5SR0zTAGV9as6phQdpmX70ij0BNPAfw0aI9KmCJeRnUR/MEjUQ
         Q/Fkl5mDjQEKOW46GDklktkUW2svlir+Ofo96D63rYCT7EcDsx7UwRDDzQFjKJOjKNp0
         y1lG1GzWruARkmMVjFbqVCUBkJL8FTSS2RmlQ=
In-Reply-To: <54ADE3A1.6060107-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------020303090303060008010305
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

El 07/01/15 a las 22:55, Nikolai Zhubr escribió:
> 08.01.2015 4:12, Cristian Rodríguez:
>> El 07/01/15 a las 21:43, Lennart Poettering escribió:
>>
>>> Maybe suse forgot to include this service file in the initrd or so?
>>
>> Correct. It appears to be a bug in the dracut package. I wonder why ..
>
> Ok. So should I file a report to opensuse bugtracker? I have no idea if
> the issue is suse-specific actually... Although I know that dracut is
> very new for suse, that might explain it...

Hrmm.. looking at the dracut upstream sources.. this service is not 
included in the required file list. so it is an upstream problem.

Attached is a patch to fix the problem.



--------------020303090303060008010305
Content-Type: text/x-patch;
 name="0001-98systemd-Include-systemd-root-fsck.service-too.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-98systemd-Include-systemd-root-fsck.service-too.patch"

From 81b8f407d84cb60e9d4df0e2f68b4bd3850448f5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Date: Wed, 7 Jan 2015 23:22:00 -0300
Subject: [PATCH] 98systemd: Include systemd-root-fsck.service too

---
 modules.d/98systemd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index 51ea288..a28df30 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -91,6 +91,7 @@ install() {
         $systemdsystemunitdir/systemd-reboot.service \
         $systemdsystemunitdir/systemd-kexec.service \
         $systemdsystemunitdir/systemd-fsck@.service \
+        $systemdsystemunitdir/systemd-fsck-root.service \
         $systemdsystemunitdir/systemd-udevd.service \
         $systemdsystemunitdir/systemd-udev-trigger.service \
         $systemdsystemunitdir/systemd-udev-settle.service \
-- 
2.2.1


--------------020303090303060008010305--

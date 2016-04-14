From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: 99base: do not mount /run with the "noexec"
 option
Date: Thu, 14 Apr 2016 12:33:33 +0200
Message-ID: <570F71FD.3020101@redhat.com>
References: <1460470060.3152.3.camel@trentalancia.net>
 <570D0533.6070704@redhat.com> <1460472110.3152.14.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460472110.3152.14.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.04.2016 16:41, Guido Trentalancia wrote:
> On mar, 2016-04-12 at 16:24 +0200, Harald Hoyer wrote:
>> Am 12.04.2016 um 16:07 schrieb Guido Trentalancia:
>>> Do not mount the /run directory with the "noexec" option, otherwise
>>> the
>>> system bootup fails (no binary can be executed, everything fails
>>> with
>>> permission denied errors).
>>>
>>> The bug was introduced in version 042 (11 Jun 2015) and affects all
>>> versions up to 044 (latest) and including git checked out on 12 Apr
>>> 2016.
>>>
>>> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
>>> ---
>>>  modules.d/99base/init.sh |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- dracut-044/modules.d/99base/init.sh	2015-11-25
>>> 14:22:28.000000000 +0100
>>> +++ dracut-044-99base-init-should-mount-newrun-as-
>>> exec/modules.d/99base/init.sh	2016-04-12 15:37:44.163185387
>>> +0200
>>> @@ -64,7 +64,7 @@ fi
>>>  
>>>  if ! ismounted /run; then
>>>      mkdir -m 0755 /newrun
>>> -    mount -t tmpfs -o mode=0755,noexec,nosuid,nodev,strictatime
>>> tmpfs /newrun >/dev/null
>>> +    mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs
>>> /newrun >/dev/null
>>>      cp -a /run/* /newrun >/dev/null 2>&1
>>>      mount --move /newrun /run
>>>      rm -fr -- /newrun
>>>
>>
>> Which binary resides in /run ??
> 
> 
> The whole initram filesystem binaries, including (/run/initramfs)/bin,
> (/run/initramfs)/sbin, (/run/initramfs)/usr/bin and
> (/run/initramfs)/usr/sbin.
> 
> It starts to break immediately after mount at line 70 of 99base/init.sh
> (rm -fr -- /newrun) up to and including 99base/udevsettle() (loops the
> "permission denied" failure on execution of udevadm).
> 
> The patch has been tested and it works fine. Without the patch, dracut
> is unusable (the system cannot be booted).
> 
> Regards,
> 
> Guido

I would prefer something like this. Care to check, if that solves it?

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index bd7ef70..31126d6 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -64,7 +64,12 @@ fi

 if ! ismounted /run; then
     mkdir -m 0755 /newrun
-    mount -t tmpfs -o mode=0755,noexec,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
+    if ! str_starts "$(readlink -f /bin/sh)" "/run"; then
+        mount -t tmpfs -o mode=0755,noexec,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
+    else
+        # the initramfs is based in /run, so don't mount it with noexec
+        mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
+    fi
     cp -a /run/* /newrun >/dev/null 2>&1
     mount --move /newrun /run
     rm -fr -- /newrun

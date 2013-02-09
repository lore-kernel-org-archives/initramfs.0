From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] make nbd port check more robust
Date: Sat, 9 Feb 2013 12:54:20 +0100
Message-ID: <CAKzfqketd_0n7x2tuPXRg5UtxOReDBhDCxELnOiEOE4Bjt0fSg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=2ROiIq4uYxodhIXM+y5v7ZHOeZ5qkyjTCtZYvc2Anvk=;
        b=e3NokxaytPdvY5c3hm5SJXpz73Yw0nEZ9F/xmkL/NFQM8DkTe4QZgN5d4sW1sh239t
         X4hWMNEV/SnelIxW2MFbb5ofEfm3QKNBe9yrM2QKAuRELYKWf5pVY8J7KqPuwbwQzDIX
         5PVFM4KCcNkpaLLGCz43meQdVzV71D0KGlmUygPM5RFhD6WWCs93gTHELTmpwJrmrrvk
         YNmw6L/2+E0stc4FgrsRVNlyXNkjDcn9FZX9MHKiV1mdOULewEbLQBmOliOM/KWya5Pn
         Pv147x0ePZO4PzaQq7Brz5Dr/HJIWyeFRs9fH6UE8W61U8GadyVUYhZ+63WUOBf45dWV
         UzUw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The following change makes the check for the nbd port or named export
more robust.
I wasn't sure whether to include sed in the dracut_install() of
module-setup.sh since net already does that (and nbd depends on that).

--- modules.d/95nbd/nbdroot.sh.orig     2013-02-09 12:37:26.804648073 +0100
+++ modules.d/95nbd/nbdroot.sh  2013-02-09 12:41:55.522345127 +0100
@@ -31,7 +31,7 @@
 nbdopts=${root#*:}

 # If nbdport not an integer, then assume name based import
-if [ "${nbdport%[0-9]}" = "$nbdport" ]; then
+if [ ! -z $(echo "$nbdport" | sed s/[0-9]//g) ]; then
     nbdport="-N $nbdport"
 fi

regards, Wim

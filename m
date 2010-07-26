From: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: patches
Date: Mon, 26 Jul 2010 09:58:44 +0200
Message-ID: <201007260958.44928.maarten.vanraes@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0AUTMsvFLI5J3eF"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:from:date
         :mime-version:content-type:message-id;
        bh=XJM17/AkQNk+dAJk6GLgSEZW5ixTO1AC9buJMYI9oy4=;
        b=nuPUvghvnoKVwFUHmfw+KB3xJJi43JA8/5m8CCAiBKso1P3Be/dEVmZJ0H+liRZ80Y
         mRtzaPa5+pXSZJhW/kfVkTDLC3ojaMppKlJ/DR+6oyqSJTbmpUgsfWQjEQ9g4OylnjOG
         bHfgvD7NO4Chola/aUOyIHKR+BR5f8cK0js14=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Boundary-00=_0AUTMsvFLI5J3eF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

another small patch.

Kind regards,

Maarten Vanraes

--Boundary-00=_0AUTMsvFLI5J3eF
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0004-not-remove-unloaded-modules.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0004-not-remove-unloaded-modules.patch"

=46rom 4ef6f01f12874dde73025e890b012d443b355766 Mon Sep 17 00:00:00 2001
=46rom: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 26 Jul 2010 09:49:06 +0200
Subject: [PATCH 4/4] not remove unloaded modules

Currently unloaded kernel modules can't be removed, because this would
break kernel module renames or newer modules for certain hardware, this
also has problems for chrooted installs.

Signed-off-by: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=2D--
 dracut-functions |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index be6b2e9..47a958d 100755
=2D-- a/dracut-functions
+++ b/dracut-functions
@@ -607,10 +607,13 @@ instmods() {
 	        [[ -f $initdir/$1 ]] && { shift; continue; }
 		# If we are building a host-specific initramfs and this
 		# module is not already loaded, move on to the next one.
=2D		[[ $hostonly ]] && ! grep -q "${mod//-/_}" /proc/modules && \
=2D	        ! echo $add_drivers | grep -qe "\<${mod}\>" &&	{
=2D		    shift; continue;=20
=2D		}
+		# NOTE: This is not desirable, if a new kernel has a renamed
+		# module or it has a new module with better support, that module
+		# won't be used here.
+		#[[ $hostonly ]] && ! grep -q "${mod//-/_}" /proc/modules && \
+	        #! echo $add_drivers | grep -qe "\<${mod}\>" &&	{
+		#    shift; continue;=20
+		#}
=20
 		# We use '-d' option in modprobe only if modules prefix path
 		# differs from default '/'.  This allows us to use Dracut with
=2D-=20
1.6.4.4


--Boundary-00=_0AUTMsvFLI5J3eF--

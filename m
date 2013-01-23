From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH 2/2] gentoo.conf: let udevdir= be handled by pkg-config
 and use udevaltdirs
Date: Wed, 23 Jan 2013 19:45:13 +0000
Message-ID: <kdpek7$b01$1@ger.gmane.org>
References: <1358966239-19496-1-git-send-email-aidecoe@aidecoe.name> <1358966239-19496-2-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000407020006010704090005"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358966239-19496-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------000407020006010704090005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

'Twas brillig, and Amadeusz Żołnowski at 23/01/13 18:37 did gyre and gimble:
> To avoid need of rebuild after udev update/downgrade let udevdir= be set
> dynamically with pkg-config.  Use udevaltdirs to search for rules both
> in old and new locations.
> ---
>  dracut.conf.d/gentoo.conf.example | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo.conf.example
> index 1361a30..b78e5c6 100644
> --- a/dracut.conf.d/gentoo.conf.example
> +++ b/dracut.conf.d/gentoo.conf.example
> @@ -1,7 +1,8 @@
>  # /etc/dracut.conf.d/gentoo.conf
>  # dracut config file customized for Gentoo Base System release 2
>  
> -udevdir=/lib/udev
> +udevdir=
> +udevaltdirs="/lib/udev /usr/lib/udev"
>  ro_mnt=yes


FWIW, I carry a couple patches downstream for this too in Mageia.

Due to their transnational nature, I figured it wasn't something that
would be wanted upstream (it was only needed during a window when users
had updates some packages which moved their udev rules to /usr/lib
rather than /lib, but hadn't yet completed the usrmove (which isn't
wise/advisable/supported, but some users did it so I didn't want to
actively break initrd building, especially as this was a key part of
actually performing the usrmove ;))

Attached is the patch I use for this which is much the same but doesn't
require any specific config. It might not work in your case if /lib is
not a symlink to /usr/lib.

I wouldn't recommend this is committed as it is purely transitional as I
said.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/

--------------000407020006010704090005
Content-Type: text/x-patch;
 name="0511-udev-rules-Pre-usrmove-systemd-installs-might-not-fi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0511-udev-rules-Pre-usrmove-systemd-installs-might-not-fi.pa";
 filename*1="tch"

From a04eb301f3f1d64361886e13acc10f0d3b701c9e Mon Sep 17 00:00:00 2001
From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Date: Thu, 16 Aug 2012 14:27:22 +0100
Subject: [PATCH 511/511] udev-rules: Pre usrmove systemd installs might not
 find system udev rules.

If users had switched to systemd-183+ but have not completed
the usrmove, the udevdir variable might not properly point to
where the system rules are really kept, so include another
path in the search there if needed.

If the user systemd has been half updated (e.g. some packages using the
new udev rules dir, but some olders ones not) before the usrmove is
completed then we want this patch. It's arguably one that is not needed
upstream however.
---
 dracut-functions.sh | 7 +++++--
 dracut.sh           | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index e23db76..b28eff5 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -935,13 +935,16 @@ inst_rule_group_owner() {
 # udev rules always get installed in the same place, so
 # create a function to install them to make life simpler.
 inst_rules() {
-    local _target=/etc/udev/rules.d _rule _found
+    local _target=/etc/udev/rules.d _rule _found _extrapath=""
 
     inst_dir "${udevdir}/rules.d"
     inst_dir "$_target"
+    if [ "${udevdir}" = "/lib/udev" -a -d "/usr/lib/udev/rules.d" ]; then
+        _extrapath="/usr/lib/udev/rules.d"
+    fi
     for _rule in "$@"; do
         if [ "${_rule#/}" = "$_rule" ]; then
-            for r in ${udevdir}/rules.d /etc/udev/rules.d; do
+            for r in ${udevdir}/rules.d ${_extrapath} /etc/udev/rules.d; do
                 if [[ -f $r/$_rule ]]; then
                     _found="$r/$_rule"
                     inst_rule_programs "$_found"
diff --git a/dracut.sh b/dracut.sh
index 9941caa..c8b1676 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -812,8 +812,8 @@ done
 [[ -d $udevdir ]] \
     || udevdir=$(pkg-config udev --variable=udevdir 2>/dev/null)
 if ! [[ -d "$udevdir" ]]; then
-    [[ -d /lib/udev ]] && udevdir=/lib/udev
     [[ -d /usr/lib/udev ]] && udevdir=/usr/lib/udev
+    [[ ! -L /lib ]] && [[ -d /lib/udev ]] && udevdir=/lib/udev
 fi
 
 [[ -d $systemdutildir ]] \
-- 
1.8.1


--------------000407020006010704090005--

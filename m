From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 1/5] dracut-funtions: fix 'instmods =modname'
Date: Fri, 22 May 2009 22:12:08 -0400
Message-ID: <74a3d115c4583f034af8c6890206298b181f1f57.1243053563.git.dave@thedillows.org>
References: <cover.1243053563.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243053563.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

Move srcmods definition into the function, as $kernel isn't defined yet when
dracut-functions is sourced from dracut.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 2beaef2..36f1a96 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -202,9 +202,9 @@ dracut_install() {
 }
 
 # install modules, and handle installing all their dependencies as well.
-srcmods="/lib/modules/$kernel/"
 instmods() {
     local mod mpargs modpath modname cmd
+    local srcmods="/lib/modules/$kernel/"
     while (($# > 0)); do
 	mod=${1%.ko}
 	case $mod in
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

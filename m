From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/5] dracut-lib: add str_ends, to go along with str_starts
Date: Thu,  5 Apr 2012 13:01:35 -0400
Message-ID: <1333645299-16837-2-git-send-email-wwoods@redhat.com>
References: <1333645299-16837-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1333645299-16837-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/99base/dracut-lib.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index cb2e4dc..1ecd286 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -12,6 +12,11 @@ str_starts() {
     [ "${1#$2*}" != "$1" ]
 }
 
+# returns OK if $1 contains $2 at the end
+str_ends() {
+    [ "${1%*$2}" != "$1" ]
+}
+
 # replaces all occurrences of 'search' in 'str' with 'replacement'
 #
 # str_replace str search replacement
-- 
1.7.7.6

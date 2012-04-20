From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] url-lib: don't add existing handlers multiple times
Date: Fri, 20 Apr 2012 16:20:24 -0400
Message-ID: <1334953225-28832-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Every time url-lib gets imported we end up making the list of handlers
longer with redundant entries. That's silly - we shouldn't add items
that already exist.

Note that this means you'll have to manipulate the handler list yourself
if you want to change the position/priority of existing handlers.
---
 modules.d/45url-lib/url-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index e305a68..7930146 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -43,6 +43,7 @@ add_url_handler() {
     local schemes="$@" scheme=""
     set --
     for scheme in $schemes; do
+        [ "$(get_url_handler $scheme)" = "$handler" ] && continue
         set -- "$@" "$scheme:$handler"
     done
     set -- $@ $url_handler_map # add new items to *front* of list
-- 
1.7.7.6

From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/9] add module 45url-lib
Date: Tue, 14 Feb 2012 12:38:05 -0500
Message-ID: <1329241090-26908-5-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

url-lib adds some functions for dealing with URLs (mostly for fetching
files, for the moment).

It uses curl to handle http/https/ftp URLs, but it can be extended by other
modules at runtime by using the "add_url_handler" function.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/45url-lib/module-setup.sh |   24 +++++++++++++
 modules.d/45url-lib/url-lib.sh      |   66 +++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/45url-lib/module-setup.sh
 create mode 100755 modules.d/45url-lib/url-lib.sh

diff --git a/modules.d/45url-lib/module-setup.sh b/modules.d/45url-lib/module-setup.sh
new file mode 100755
index 0000000..eab9f25
--- /dev/null
+++ b/modules.d/45url-lib/module-setup.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# module-setup for url-lib
+
+check() {
+    command -v curl >/dev/null || return 1
+    return 255
+}
+
+depends() {
+    echo network
+    return 0
+}
+
+install() {
+    inst "$moddir/url-lib.sh" "/lib/url-lib.sh"
+    dracut_install curl
+    mkdir -m 0755 -p "$initdir/etc/ssl/certs"
+    if ! inst_any -t /etc/ssl/certs/ca-bundle.crt \
+            /etc/ssl/certs/ca-bundle.crt \
+            /etc/ssl/certs/ca-certificates.crt; then
+        dwarn "Couldn't find SSL CA cert bundle; HTTPS won't work."
+    fi
+}
+
diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
new file mode 100755
index 0000000..51340d5
--- /dev/null
+++ b/modules.d/45url-lib/url-lib.sh
@@ -0,0 +1,66 @@
+#!/bin/bash
+# url-lib.sh - functions for handling URLs (file fetching etc.)
+#
+# Authors:
+#   Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+type mkuniqdir >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+# fetch_url URL [OUTFILE]
+#   fetch the given URL to a locally-visible location.
+#   if OUTFILE is given, the URL will be fetched to that filename,
+#   overwriting it if present.
+#   the return values are as follows:
+#   0: success
+#   253: unknown error (file missing)
+#   254: unhandled URL scheme / protocol
+#   255: bad arguments / unparseable URLs
+#   other: fetch command failure (whatever curl/mount/etc return)
+fetch_url() {
+    local url="$1" outloc="$2"
+    local handler="$(get_url_handler $url)"
+    [ -n "$handler" ] || return 254
+    [ -n "$url" ] || return 255
+    $handler "$url" "$outloc"
+}
+
+# get_url_handler URL
+#   returns the first HANDLERNAME corresponding to the URL's scheme
+get_url_handler() {
+    local scheme="${1%%:*}" item=""
+    for item in $url_handler_map; do
+        [ "$scheme" = "${item%%:*}" ] && echo "${item#*:}" && return 0
+    done
+    return 1
+}
+
+# add_url_handler HANDLERNAME SCHEME [SCHEME...]
+#   associate the named handler with the named scheme(s).
+add_url_handler() {
+    local handler="$1"; shift
+    local schemes="$@" scheme=""
+    set --
+    for scheme in $schemes; do
+        set -- "$@" "$scheme:$handler"
+    done
+    set -- $@ $url_handler_map # add new items to *front* of list
+    url_handler_map="$@"
+}
+
+curl_args="--location --retry 3 --fail --show-error"
+curl_fetch_url() {
+    local url="$1" outloc="$2"
+    if [ -n "$outloc" ]; then
+        curl $curl_args --output "$outloc" "$url" || return $?
+    else
+        local outdir="$(mkuniqdir /tmp curl_fetch_url)"
+        local cwd="$(pwd)"
+        cd "$outdir"
+        curl $curl_args --remote-name "$url" || return $?
+        cd "$cwd"
+        outloc="$(echo $outdir/*)"
+    fi
+    [ -f "$outloc" ] || return 253
+    echo "$outloc"
+}
+add_url_handler curl_fetch_url http https ftp
-- 
1.7.7.6

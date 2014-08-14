From: Antony Messerli <antony-M9eEzXzj57sUjmZRR9AIpQ@public.gmane.org>
Subject: [PATCH] Adds bittorrent support to 45url-lib for live images
Date: Thu, 14 Aug 2014 15:31:09 -0500
Message-ID: <CAGgovyGokHpfq8oVfQMi9XCKAhpDK4N1t11KbDdDr2pckc=bDg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch adds bittorrent support to 45url-lib for those that might want to
retrive the same live image for multiple systems at once without
saturating the network.
This patch requires ctorrent to be installed into initramfs.

Torrent kernel command line format:
root=live:torrent://image_location/image.torrent

Start a tracker:
bttrack --bind <tracker_ip> --port 6969 --dfile dstate --reannounce_interval 60

Create the torrent:
ctorrent -t live_image -u http://<tracker_ip>:6969/announce -s
live_image.torrent

Seed the initial torrent:
ctorrent live_image.torrent

Boot the live image.
---
 modules.d/45url-lib/url-lib.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index c9d143a..d9cebd4 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -82,6 +82,36 @@ set_http_header() {
     echo "header = \"$1: $2\"" >> $CURL_HOME/.curlrc
 }

+### TORRENT ##########################################################
+
+ctorrent_args="-E 0 -e 0"
+
+ctorrent_fetch_url() {
+    local url="$1" outloc="$2"
+    url=${url#*//}
+    torrent_outloc="$outloc.torrent"
+    echo "$url" > /proc/self/fd/0
+    if [ -n "$outloc" ]; then
+        curl $curl_args --output - -- "$url" > "$torrent_outloc" || return $?
+    else
+        local outdir="$(mkuniqdir /tmp torrent_fetch_url)"
+        ( cd "$outdir"; curl $curl_args --remote-name "$url" || return $? )
+        torrent_outloc="$outdir/$(ls -A $outdir)"
+        outloc=${torrent_outloc%.*}
+    fi
+    if ! [ -f "$torrent_outloc" ]; then
+        warn "Downloading '$url' failed!"
+        return 253
+    fi
+    ctorrent $ctorrent_args -s $outloc $torrent_outloc >&2
+    if ! [ -f "$outloc" ]; then
+        warn "Torrent download of '$url' failed!"
+        return 253
+    fi
+    if [ -z "$2" ]; then echo "$outloc" ; fi
+}
+add_url_handler ctorrent_fetch_url torrent
+
 ### NFS ##############################################################

 [ -e /lib/nfs-lib.sh ] && . /lib/nfs-lib.sh
--
2.0.4

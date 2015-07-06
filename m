From: poma <pomidorabelisima-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fix for CD/DVD media check
Date: Mon, 6 Jul 2015 15:16:54 +0200
Message-ID: <559A7FC6.1000608@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=I7h2RUxW3atxExQAVt/RasQB08E3mpFmyi8jvTpt4dg=;
        b=jtqjk2sLd90Ky2j9D4VLMgSZazlooUKppbFI6u7meIN8SJrnADwOLQTarodH0nSy5F
         B1zUFsqk+OmJw/AR/W1XRoiiN9fjEP6cW9H2313oqeNRkJb7voGdGY9H6+v4ne/3DF2S
         wUcupvZ9RsyrFh3KZURSBFbiaJaKziDaUNbt7c4y0zfRfNLCGtLSebMAAjCtxt2fnYKZ
         CoVUiVM6j0/LLCXNsJGk5jZDVynE/WJBxdmNFA+BqPXMjCwdsNaEPZ4gn0ZI4eeUZHhP
         DCjj+XJk2IPKsnOtHBX6Jbw9vPfDH6DO3bbnbBeSitX0f67KJ5H2pkMWk93DaTDkvE2f
         RSfQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


Fix for "CD/DVD media check" i.e. checkisomd5@.service

"the issue is systemd related. absolute paths for systemd unit templates shouldn't start anymore by - (/). (they should be the ouptut of systemd-escape -p ${PATH}). in practice one just has to cut 1st char."
AntonioMeireles
https://github.com/pires/kubernetes-vagrant-coreos-cluster/issues/123

"rd.live.check - [FAILED] Failed to start checkisomd5@-dev-sr0.service"
https://bugzilla.redhat.com/show_bug.cgi?id=1239226

---
 modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index a0a9ab9..9159a92 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -41,7 +41,7 @@ getarg rd.live.check -d check || check=""
 if [ -n "$check" ]; then
     type plymouth >/dev/null 2>&1 && plymouth --hide-splash
     if [ -n "$DRACUT_SYSTEMD" ]; then
-        p=$(str_replace "$livedev" "-" '\x2d')
+        p=$(str_replace "${livedev#*/}" "-" '\x2d')
         systemctl start checkisomd5@${p}.service
     else
         checkisomd5 --verbose $livedev
-- 
2.4.5

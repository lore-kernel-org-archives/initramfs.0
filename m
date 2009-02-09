From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 19/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:06 -0800 (PST)
Message-ID: <c9c08caac3a7de04162ea2ba6a385482bbbd127c.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=R3uWLixkuUja6ZpqLCL5EZZlfrzIN7rP/JMNgA2rEKU=;
        b=ENzSwmMD+LnawZSk8YsYfr6xwgcMpdJdbEQWk1hjaqxeqOy8uqLzIVX6H4hIhwyWPL
         M2Cui5bQCN6wxJwwxN/2OmYWYiyRl7OjRK1RR/YyiLR2NFmaS5wmhyapASWdJvAfLSHF
         zoMMMqgEQ9KDs0+E23wCjlyXRyvpsBpvTsxl4=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The function keyword is deprecated.  Get rid of it.

---
 dracut-functions |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 8f12021..7f9dfcd 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,13 +24,13 @@
 #
 #
 
-function set_verbose() {
+set_verbose() {
     foo=""
 }
 
 IF_RTLD=""
 IF_dynamic=""
-function get_dso_deps() {
+get_dso_deps() {
     local bin="$1" ; shift
 
     declare -a FILES
@@ -96,7 +96,7 @@ EOF
     echo "${FILES[@]}"
 }
 
-function inst() {
+inst() {
     if [ "$#" != "2" -a "$#" != "3" ];then
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] modules: lvm: fix activationskip check
Date: Thu, 25 Jun 2015 14:56:54 +0200
Message-ID: <87zj3ot089.fsf@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=eh7pN6ARpuw7NXvjtHxkpXIFQdoDdNjuAg2XBTwNKSw=;
        b=S2Sc8t+y2mEiqsUFqq9ku7xf1LbVAeuQNPmEFu9scoH0gIk/qzGZQUSaUshUVF6hj3
         CVZS/zmpvWEOXJTqr7/Ln2gSOD0H3CK/SCC1M1gF7Az7DAZWAqJLdOOr9xAdc1hbrW1D
         Sc/Cj+B6yEk25ly/13pDFUftpF3FYlZIGAgqHMpGI7zPmOeCePsp97H4+cVuMUrQSeeZ
         kyOhaMoPqrN/4NyY3YV3H33Bt5XDC8rFjeJD3Pt5nkcAdxp/Jys0EezZA3FojhVgJ0tQ
         D41J/eQXxpzoNENNG8paXwiTTqeCclr4tXEtp38cmMn6ThMGI+m9rkOBWZRy0i+BNgFz
         +qnQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Fix boot breakage due to the activationskip check introduced in
cfa365a32d47 ("lvm: Don't activate LVs with activationskip set").

In 'man 8 lvs', it is stated that LVs with activationskip set, will have
a "k" flag in their lvs attribute listing.

The current implementation excludes LVs which do not have the "k"
flag set. This leads to the activation of LVs with the activationskip
set and the exclusion of LVs with no activationskip set: the check's
logic is inverted.

Fix this issue by skipping those LVs that have the "k" flag in their
attributes.

Signed-off-by: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90lvm/lvm_scan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90lvm/lvm_scan.sh b/modules.d/90lvm/lvm_scan.sh
index ce46e14..ba7d738 100755
--- a/modules.d/90lvm/lvm_scan.sh
+++ b/modules.d/90lvm/lvm_scan.sh
@@ -106,7 +106,7 @@ if [ -n "$LVS" ] ; then
     info "Scanning devices $lvmdevs for LVM logical volumes $LVS"
     lvm lvscan --ignorelockingfailure 2>&1 | vinfo
     for LV in $LVS; do
-        if [ "x$(lvm lvs --noheadings --select "lv_attr =~ k" $LV | wc -l)" = "x0" ]; then
+        if [ "x$(lvm lvs --noheadings --select "lv_attr =~ k" $LV | wc -l)" != "x0" ]; then
             info "Skipping activation of '$LV' because activationskip is set."
             continue
         fi
-- 
2.4.4

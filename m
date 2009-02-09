From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:34:46 -0800 (PST)
Message-ID: <9eeb778e566a22401b45810116d76aec1040152d.1234137267.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=yee8e+ad98u43FKpYXlMK34rmXX4N1/5E7CLpyJQK/E=;
        b=aTAN7BAfhqZCII40HdjviyEzzC7jhy+Qvo/pfOTyOYWpQYYoX7XTYAUtqt/fCXXlhW
         aoBqN4QGGlAURuB7lMGJtyVYvbWFG/BFQ3wkOAACiGgtLPEUKHhzpUnoDMCSO+rODY9n
         oksSDGoqv2P97XKk3g4gZ3KUJKhJ5LRNW+GCw=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add a simple getarg function.

If we ever need to get more than one kernel command line argument, this
function will pay for itself.  It relies on a feature of the way bash
handles string comparisons in [[ ]] statements -- the RHS is matched
according to globbing rules, and is not a straight string match.
---
 init |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/init b/init
index eb8998d..b5b0b1b 100755
--- a/init
+++ b/init
@@ -14,6 +14,12 @@ emergency_shell()
     bash < /dev/console
 }
 
+getarg() {
+    for o in $(< /proc/cmdline); do
+	[[ $o == $1 ]] && { echo $o; break; }
+    done
+}
+
 echo "Starting initrd..."
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

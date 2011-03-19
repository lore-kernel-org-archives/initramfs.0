From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] Update PKGBUILD to force backups of /etc/dracut.conf on install.
Date: Sat, 19 Mar 2011 10:48:19 -0500 (CDT)
Message-ID: <f35e7408086fe4e04447878011205cad5c2de0c2.1300549698.git.victor.lowther@gmail.com>
References: <71417f80994fec215a884b94d86b8579e5a1b63d.1300549698.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:in-reply-to:references:from:subject
         :to:x-mailer:date;
        bh=R0lrldjMzNu2+xN0/GCf4pF5ZFrRk/EPZNQQlMRhqJ4=;
        b=sSkkujDcGZuPPHcVwrH6oCrwgTivUDYDtvczY+YZW7om6FNXawJ7sXnASsChY4wL7z
         JooDn0jEnbCDn0WPnd16OwKPv3DenCWGbIrsv3QXz0H0drysEWYEQPKvVL+bt66SYOvk
         gk61MNVcGJi9+lZ+Y5RJl9Vh1CZ+5g/+vgvMw=
In-Reply-To: <71417f80994fec215a884b94d86b8579e5a1b63d.1300549698.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 PKGBUILD |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/PKGBUILD b/PKGBUILD
index 5776c09..991daa6 100644
--- a/PKGBUILD
+++ b/PKGBUILD
@@ -10,6 +10,7 @@ provides=('dracut=9999' 'mkinitcpio=9999')
 depends=('bash')
 optdepends=('cryptsetup' 'lvm2')
 makedepends=('libxslt')
+backup=(etc/dracut.conf)
 source=()
 md5sums=()
 
-- 
1.7.4.1

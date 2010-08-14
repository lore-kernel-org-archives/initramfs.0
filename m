From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 16/16] Add a PKGBUILD file to make building on Arch Linux from a git checkout easy.
Date: Sat, 14 Aug 2010 14:23:26 -0500 (CDT)
Message-ID: <acf10b502c78c6478320e7860da7fc5982efcd67.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=4hkHBdq9/XaGuLYKLgGCdLaC7J7hD9FzpOr+eCszNUQ=;
        b=v/C0MrjpJzGvx6lguY1fWW4sc0/KY98tOwFEJhSDHpxKUlzK09Q2/SYSFmP7oOZAUN
         nOh0GRe9vsQ02gNfZLI0J567/7Xz1MwmVI16bWnsGZUy2d0AtfjXiUEr43dBrDutwr8U
         7TDAJVUhwvRcQvi1cytdwAa8m8GvlR2stFZds=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This might come in handy for anyone else trying out dracut on Arch.

---
 PKGBUILD |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/PKGBUILD b/PKGBUILD
new file mode 100644
index 0000000..5776c09
--- /dev/null
+++ b/PKGBUILD
@@ -0,0 +1,20 @@
+pkgname=dracut-git
+pkgver=$(date +%s)
+pkgrel=$(git log --pretty=format:%h |head -n 1)
+pkgdesc="Initramfs generation utility"
+arch=('i686' 'x86_64')
+url="http://sourceforge.net/apps/trac/dracut/"
+license=('GPL')
+conflicts=('dracut' 'mkinitcpio')
+provides=('dracut=9999' 'mkinitcpio=9999')
+depends=('bash')
+optdepends=('cryptsetup' 'lvm2')
+makedepends=('libxslt')
+source=()
+md5sums=()
+
+build() {
+  cd ..
+  make sysconfdir=/etc || return 1
+  make DESTDIR="${pkgdir}" sysconfdir=/etc install || return 1
+}
\ No newline at end of file
-- 
1.7.2.1

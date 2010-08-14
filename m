From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/16] Get rid of unneeded dirname calls.
Date: Sat, 14 Aug 2010 14:23:24 -0500 (CDT)
Message-ID: <0e55145f49bde182dc7efec5fa8965f31dc5234e.1281812505.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=DgJ31R2pqZpooefgDAUNVfStKHgCg4SdJuKUyj56RxI=;
        b=MxlpCRJi/whQUkhyNzvMA95Pxb4Bzeq+wYAP98O3gtxpT3KV1rD7amksi8OYILCs79
         Jckm7WzSZwU31Dj2Y0mJ1tRadYeAjtja0kzXq3EE4qhN+THXVdq/vFi5hFbTrzIn7VQQ
         W+27KoN/6dcAl4l11bvf5BZVRFA3t9M8BrqAU=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Use parameter expansion instead.

---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index a50e14a..541bfc0 100755
--- a/dracut
+++ b/dracut
@@ -127,7 +127,7 @@ export PATH
 
 [[ $dracutbasedir ]] || dracutbasedir=/usr/share/dracut
 
-[[ $allowlocal && -f "$(readlink -f $(dirname $0))/dracut-functions" ]] && dracutbasedir="$(dirname $0)" 
+[[ $allowlocal && -f "$(readlink -f ${0%/*})/dracut-functions" ]] && dracutbasedir="${0%/*}" 
 
 # if we were not passed a config file, try the default one
 if [[ ! -f $conffile ]]; then
-- 
1.7.2.1

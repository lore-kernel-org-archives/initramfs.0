From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix find_binary always succeeding
Date: Fri, 27 Feb 2009 11:03:56 -0600
Message-ID: <1235754236.6445.2.camel@sentry-no.fnordovax.org>
References: <49A7EA88.6090602@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ofQ/BwDFvZ4+ygBhQbBwn92VjQLcbUz6rN0MFAM935s=;
        b=B1PtDkRTRGf6OMI243cj5fv4fxeReCMUGk8gnp1F2q1mk4OzX3/94HQFVjxYGtjIZH
         /cDNdd5N94bPc6MT+MoR5yKIG9qSZ/s05PJ83DiPMp24P+9F2fYBQrwFycm4oqrNTdiE
         OKXzljLPRe0WcsnNkiQ3epG848Jzvrd7R0pZI=
In-Reply-To: <49A7EA88.6090602-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-02-27 at 14:28 +0100, Seewer Philippe wrote:
> find_binary inside dracut-functions always succeeds. Independent of 
> whether the file actually exists or not.
> 
> This patch fixes this.
> 
> And since we're using the function not only to find binaries at little 
> enhancement there shouldn't be that bad either.
> 
[snip patch]

Hmmm... a bit wordy.  Why not

diff --git a/dracut-functions b/dracut-functions
index 852ce36..f11d372 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -53,9 +53,9 @@ inst_library() {
     fi
 }
 	
-find_binary() {
+find_file() {
     local binpath="/bin /sbin /usr/bin /usr/sbin" p
-    [[ ${1##*/} = $1 ]] || { echo $1; return 0; }
+    [[ ${1##*/} != $1 && -e $1 ]] && { echo $1; return 0; }
     for p in $binpath; do
 	[[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
     done
@@ -134,7 +134,7 @@ inst() {
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
-    local src=$(find_binary "$1") || {
+    local src=$(find_file "$1") || {
 	echo "Cannot find requested file $1. Exiting."
 	exit 1
     }


> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

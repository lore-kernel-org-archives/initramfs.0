From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: [PATCH] Ensure UNICODE keyboard layout is functional in
	emergency shell
Date: Sat, 9 Jan 2010 09:50:09 +0100
Message-ID: <20100109085009.GA29904@maude.comedia.it>
References: <201001081054.55497.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=comedia.it; h=
	user-agent:in-reply-to:content-disposition:content-type
	:mime-version:references:message-id:subject:from:date:received:
	x-virus-scanned; s=200808; t=1263027009; bh=giwiJBvatibpz0blodCa
	/Y8jI95jehnH/whZHXdWJLQ=; b=N+MJonwknqnTONWmeIK2Veqz4e7OPU0qa2qb
	FU9lgzZfgaPL1haRvSDZrxDxHzD2eXXFwO4bz8Xs4JWI8hc5meY/6VAb5hph6G6T
	nkkihJheI8mefQxjAj2BOp9ZNK7vvOvj1YTLkgo6AMO9v+68O2/GfLnIsbypeETg
	J5lE7XU=
Content-Disposition: inline
In-Reply-To: <201001081054.55497.arvidjaar-JGs/UdohzUI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline

this one is rebased against the kbd patch i sent earlier.

regards,
L.
On Fri, Jan 08, 2010 at 10:54:55AM +0300, Andrey Borzenkov wrote:
>The attached patch ensures that keyboard in emergency shell more closely 
>corresponds to live system. I am not sure about UNIKEYTABLE which 
>console_init checks as well - if it is not artifact, it can be easily 
>added as well.
>
>-andrey


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-Ensure-UNICODE-keyboard-layout-is-functional-in-emer.patch"

From 7b3ff7a66e79534bbf21314a1880a0ec06379bb3 Mon Sep 17 00:00:00 2001
From: Luca Berra <bluca-1WC7Or56Oao@public.gmane.org>
Date: Sat, 9 Jan 2010 09:39:22 +0100
Subject: [PATCH] Ensure UNICODE keyboard layout is functional in emergency shell

/lib/udev/cosole_init will load either non-unicode or unicode versions
of keyboard layout for the same value of KEYMAP depending on language
setting. The simplest solution is to install both versions in initrd;
it does not take much space.

While on it, copy some additional maps to ensure emergency shell
has the same keyboard layout as full system.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Signed-off-by: Luca Berra <bluca-1WC7Or56Oao@public.gmane.org>
---
 modules.d/10redhat-i18n/install |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/modules.d/10redhat-i18n/install b/modules.d/10redhat-i18n/install
index 92939a6..e7323a4 100755
--- a/modules.d/10redhat-i18n/install
+++ b/modules.d/10redhat-i18n/install
@@ -27,12 +27,20 @@ install_local()
             KEYMAP=/etc/sysconfig/console/default.kmap
 	else
             . /etc/sysconfig/keyboard
-            [[ $KEYTABLE && -d ${kbddir}/keymaps ]] && KEYMAP="$KEYTABLE.map"
+	    if [[ $KEYTABLE && -d ${kbddir}/keymaps ]]; then
+		[[ $KEYTABLE =~ *.uni ]] && UNIKEYMAP="$KEYTABLE.map" \
+		    || UNIKEYMAP="$KEYTABLE.uni.map"
+		KEYMAP="$KEYTABLE.map"
+	    fi
 	fi
 	if [[ $KEYMAP ]]; then
             [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
             inst loadkeys
             findkeymap $KEYMAP
+            [[ $UNIKEYMAP ]] && findkeymap $UNIKEYMAP
+	    [[ $GRP_TOGGLE ]] && findkeymap $GRP_TOGGLE.map
+	    findkeymap delete.map
+	    findkeymap backspace.map
 
             for FN in $KEYMAPS; do
 		if [ -L $FN ]; then
-- 
1.6.4.4


--x+6KMIRAuhnl3hBn--

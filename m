From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 12:19:39 +0100
Message-ID: <AANLkTi=N9QZZ0tKzBab78kuZ=X7nOThC5DKpss40XBze@mail.gmail.com>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
	<4CD9102B.7030702@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=6ovIzmIN516aoLiGZralDBCUPbcWQbumBYnux7XbpoQ=;
        b=SrshQqedh0E4vFUc/xhouzopTODIrkWFBMM4AnXGlxiLNOYvNaaD9k+4xfqARW6UAw
         2fg7mWvkBbrtdyIp1c+FJuqj7YMlAJbbtIPc8tvlXCMIyms+Mfjh7LkXY4S210vSSCvJ
         HyqXgwWntJqQUh+Yi9hyEAfeSoYxlLe4njyB4=
In-Reply-To: <4CD9102B.7030702-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>
>> I imagine that these should be version specific patches :
>>
>
> This is a debian/ubuntu specific fix and should not go in just like that. We
> need a version check to decide if -[46] can be passed or not, since newer
> version of dhclient should be supplied with it.

Sorry, I meant that Ubuntus packages should have this patches applied,
because otherwise are broken. I was not refering to pulling them into
the master, I'm sorry.


 - Ubuntu 10.10 ships dhclient 3, which doesn't support the "-4" flag.

diff -urN dracut/modules.d/40network/ifup dracut-007/modules.d/40network/ifup
--- dracut/modules.d/40network/ifup	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/modules.d/40network/ifup	2010-10-21 02:49:45.714564995 +0200
@@ -132,7 +132,7 @@
     if [ "$netroot" = "dhcp6" ]; then
 	do_dhcp -6
     else
-	do_dhcp -4
+	do_dhcp
     fi
 fi

@@ -151,7 +151,7 @@

     case $autoconf in
 	dhcp|on|any)
-	    do_dhcp -4 ;;
+	    do_dhcp ;;
 	dhcp6)
 	    do_dhcp -6 ;;
 	auto6)


- Ubuntu Maverick's arping seems to be broken (a least for me).

diff -urN dracut/modules.d/40network/netroot
dracut-007/modules.d/40network/netroot
--- dracut/modules.d/40network/netroot	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/modules.d/40network/netroot	2010-10-21 02:49:45.714564995 +0200
@@ -96,9 +96,9 @@
        [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*) dest=$dummy;;
     esac
 fi
-if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
-    die "Resolving $dest via ARP on $netif failed"
-fi
+#if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
+#    die "Resolving $dest via ARP on $netif failed"
+#fi

 # Source netroot hooks before we start the handler
 source_all netroot


> We need iputils-arping and not the standard arping. Mind checking if you are
> using the correct package?

$ dpkg -S `which arping `
iputils-arping: /usr/bin/arping

$ arping -V
arping utility, iputils-sss20100418


> Thanks && Regards,
> Philippe

Regards,

Jon Ander.

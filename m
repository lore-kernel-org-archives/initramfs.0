From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian multiarch support
Date: Mon, 16 Apr 2012 11:34:38 +0200
Message-ID: <CAGEveXqScm9T-cto8jRYh2_dM6Md+grqppXs0nWTjB_Vo69zMA@mail.gmail.com>
References: <CAGEveXprJz33cnna8PDQE7eyNUw1S-RDYtyZY405STOH7FfswA@mail.gmail.com>
	<CAGEveXr7G+5_rcuHUWBrg-rAQ1y6wU2ozVy2yBbQuo3PYdx3Mw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=abqEqfFjo9KrfKA4NIjD/fn2ckN6NhLNtY5KSgOMbhc=;
        b=avONhg3PTTNx2UJ5nqMtskVgC3hWuIIJyIGlgt2g3+g2ZGnuFk4SqCFZyXRFiH969C
         O8ku/Quu8AZEHpnDqa+hcgtGzkxx1Qrx3AdnoDsmgMz4TAXT7GNz8NlXcTTSuAVWaIv2
         Yx4N7YatGb8RzG0+sotBmDZk07AGndM4eMYIY675TjlsVIvXxpdRW/BxOiv88ElFaE9N
         fIlbtsYBlroPMC4qfsIW5OlCWpqaQLPIgFg/oHVm8HnlRC/P+0MVpW+CYJ02thJFHJUL
         ATHfNgP8bPbsAI8SJoO7LuLkb5y2CtgOTTbJ+jyUOGX1KNb0hknvQA5J7FopjTbMiXWt
         T6mQ==
In-Reply-To: <CAGEveXr7G+5_rcuHUWBrg-rAQ1y6wU2ozVy2yBbQuo3PYdx3Mw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

Before considering my patch I should note that it has a bug, it should be:

 # Detect lib paths
 [[ $libdir ]] || for libdir in /lib64 /lib; do
-    [[ -d $libdir ]] && break
+    [[ -d $libdir ]] && libdirs+=" $libdir" && break
 done || {
    dfatal 'No lib directory?!!!'
    exit 1
 }

 [[ $usrlibdir ]] || for usrlibdir in /usr/lib64 /usr/lib; do
-    [[ -d $usrlibdir ]] && break
+    [[ -d $usrlibdir ]] && libdirs+=" $usrlibdir" && break
 done || dwarn 'No usr/lib directory!'

Now there is a space before $libdir and $usrlibdir, which avoids
suffixing the libdirs value defined on a *.conf file with $libdir. I'm
sorry.

Regards,

JonAn.

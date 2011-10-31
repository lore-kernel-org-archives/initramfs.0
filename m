From: yajosev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] exit 255 documentation.
Date: Mon, 31 Oct 2011 12:45:33 -0600
Message-ID: <1320086733-3949-1-git-send-email-yajosev@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=oBUeoQcpXKwuhmZxlpItHl++tv0KiwGBnABAp76zppM=;
        b=fb4Xjwr38CzYnhlpjQjhuKnOByOx7nSNFbiaYkrwJ/V2hua5AKwNQKvmLM64QAI2Zu
         YMQhN+6NiWrwDXdtG2gzTHFOuHSacrE+H6KxREnpi6vRnS2AQdQFLvJAKHxFw+wXH1vs
         b8lM6dg5A4XgbyLSDu+6vliafRg4p9M28lkp8=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="macroman"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, yajosev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

=46rom: Yader Vel=C3=A1squez <yajosev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add documentation about the exit 255 in check script that
indicates that the modules should only be included when
explicitly requested by the configuration.
---
 README.modules |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/README.modules b/README.modules
index 21461de..932db29 100644
--- a/README.modules
+++ b/README.modules
@@ -43,8 +43,9 @@ check():
=20
        When called without options, check should check to make sure th=
at
        any files it needs to install into the initrd from the host sys=
tem
-       are present.  It should exit with a 0 if they are, and a 1 if t=
hey are
-       not.
+       are present. It should exit with a 0 if they are, a 1 if they a=
re
+       not, and a 255 if the module should only be included when expli=
citly
+       requested by the configuration or command line options.
=20
        When called with $hostonly set, it should perform the same chec=
k
        that it would without it set, and it should also check to see i=
f the
--=20
1.7.6.4

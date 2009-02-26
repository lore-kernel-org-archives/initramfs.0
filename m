From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] Save any dhcp options we did not handle to net.$interface.dhcpopts
Date: Wed, 25 Feb 2009 18:42:09 -0800 (PST)
Message-ID: <4db8e4b16862ff81949349fc956f713b4fb16f28.1235615754.git.victor.lowther@gmail.com>
References: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=IKCUxCPYHW3nEA4Lt/3w5jNZPZodHjusrW9gF42+NtU=;
        b=QtPCfQYO5b/T2JwKN03B2Vp6TTDzpRdqWSGx0Ls7F590oBMJKNEm/7R5dVX8FGTTPG
         DQbxzrnbxzmXcVkkA/56+vP0wBNtsyihkigIit7B5xJ5mk4JT/r9LHWQDtt8RcK/matE
         9OxKPHCfN6XqIhHA5wRv3dGlrlfCcIFPoNSDs=
In-Reply-To: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dhclient-script |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dhclient-script b/dhclient-script
index dce9878..5a2c66b 100755
--- a/dhclient-script
+++ b/dhclient-script
@@ -19,6 +19,7 @@ case $reason in
 	for s in $new_domain_name_servers; do
 	    echo "nameserver $s" >> /etc/resolv.conf
 	done
+	set |grep -e '^new_[a-z_]=' >/net.$interface.dhcpopts
 	>/net.$interface.up ;;
     *) ;;
 esac
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

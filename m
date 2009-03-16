From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Improved test harness
Date: Mon, 16 Mar 2009 18:11:20 -0500
Message-ID: <1237245080.5070.15.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=sbgVEWY0l6xRDcZumqEHIAJAyhqK5h8P1GbxlgBNVNg=;
        b=mQVrCvnBNR2cc/FcYP3T+xBjsfR5cDD1+JX3MCxDhAKlKEf9JWj4/2F0yzr/wmlQDa
         OVGydAcJ8C5Aje6yt0c6rsJy6icE7fRI9AGAGM0kd9wdt29u+pPpcNj99lzjhhu8xqvo
         ZKDlFRT8pbKsvveY7tIFjd3goXShhXUWT6ZCY=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I have created an improved test harness for testing changes to dracut.
This test harness creates a LVM root on an encrypted block device, and
then creates an initramfs that attempts to mount the root partition that
it just created.  It currently relies on qemu-kvm to do all the heavy
lifting, but should be easily modified to use other virtual machines.

You can invoke it with "make test". 

The code is available as the enhanced-test-framework branch at
git://fnordovax.org/dracut
( http://git.fnordovax.org/dracut/log/?h=enhanced-test-framework ).


It is mostly self-contained, but does include some minimal changes to
the init script and some fixups to make cryptoroot work properly.  It
does not contain the latest code from Harald's merge tree -- there are
some conflicts in getting dynamically created udev rules to work with
it.

Other test cases welcome -- an nfs test case and an iscsi test case
would exercise most of the functionality we are looking at targeting.

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

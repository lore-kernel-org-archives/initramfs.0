From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: inst_rules() searches for rules in current dir
Date: Thu, 3 Oct 2013 18:51:09 +0400
Message-ID: <20131003185109.4f88e313@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:Message-ID:Subject:To:From:Date; bh=76quY7hQwGmq68lByvGPpUlHsoQByhs2kh1eOPq5wv4=;
	b=iNOLY7dr6lplv8bqCY6mkTY1a0L95MFOtc/aVGuTI3Dcw/NFEZDFdpGT9Nyp8rOraZzwgFSca8JqHBo0vH1eRbvDqfQJy2oNzfvJs4mJsCKvqjIsC/CNPhM+1XnyXMo/l7B2OrmETH3hUbcSA+xIqKoYvib3o8a5FXInJtwzjy8=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

Is this intentional, or a bug?

# touch 11-dm-lvm.rules 
# ls -ln 11-dm-lvm.rules 
-rw-r--r-- 1 1000 1000 0 Oct  3 18:32 11-dm-lvm.rules
# dracut -f
 ...
*** Including module: lvm ***
dracut-install: ERROR: installing '11-dm-lvm.rules' to '/etc/udev/rules.d/11-dm-lvm.rules'
/usr/libexec/dracut-install -D /var/tmp/initramfs.EZ7ISH 11-dm-lvm.rules /etc/udev/rules.d/11-dm-lvm.rules
 ...
# lsinitrd /boot/initramfs-3.11.3-hardened.img | grep 11-dm-lvm.rules
-rw-r--r--   1 root     root            0 Oct  3 18:32 etc/udev/rules.d/11-dm-lvm.rules
-r--r--r--   1 root     root         1303 Sep 30 20:11 lib64/udev/rules.d/11-dm-lvm.rules


Related line from dracut-functions.sh:

 899         for r in '' ./ $dracutbasedir/rules.d/; do

Are '' and ./ really needed here?

-- 
Alexander Tsoy

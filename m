From: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut 005 question
Date: Mon, 14 Mar 2011 10:53:59 +0000
Message-ID: <AANLkTikhgLdM_x_UHgCDQYqD=ekVE2G+aY+YNyuwXD75@mail.gmail.com>
References: <AANLkTimG_vvX-qDQ7+hUA7LjrWBmJU6uA1OY0ZHMA+VG@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=WxxFao8hdQ+3cxrPVGfCMBsOuIWfP9Ktn1RyoBiR1qs=;
        b=i7l0ZxHLg61rBxm/c00lJNOo1t45VsqIPg5yUsvqUWlMsG1E/M8l5eUlLn2jPDMGkN
         Dp9M9I5fqO0R6zZ3YLMfVUMoadtwzWTQ/m5I3lqTc/cgUYgJKe8Qw57du81CwxBg6wqd
         vKUjL3ZGOo4rnv1S9HdqwAMt4Zp3NlFs2l9mM=
In-Reply-To: <AANLkTimG_vvX-qDQ7+hUA7LjrWBmJU6uA1OY0ZHMA+VG-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello guys,

I use Fedora 13, dracut 005, I have encrypted root and I tried to have
crypto key on my USB stick working.
After some modifications to dracut, I'm almost done, however I have
one last issue:

My root partition and other partitions on the same lvm group mount
fine, but my second volume group (vg3) is not OK:
My root partition is configured like that:
md raid -> luks1 -> LVM vg2 -> filesystem

My second volume group:
LVM vg3 -> luks2 -> filesystem

I use the same key for both partitions and=A0 I use rd_LUKS_KEYDEV_UUID
kernel parameter for all my luks partitions and I know all are mounted
successfully by dracut - all partitions are present in the /dev/mapper
in dracut - I tested that.
(I also tested that cryptsetup luksOpen returns zero in dracut for all
partitions - this is OK as well)
The issue is that when init process starts, for some reason luks2
partition on vg3 is not present in the /dev/mapper (however vg2 on
luks1 is OK).

I also tried to specify all partitions into rd_LVM_LV arguments, but
it did not help either.

Do you please have any hint how can I force dracut to pass all
partitions from the /dev/mapper to the init process or where do you
think the issue can be?
I also know I can create a workaround and change init script to mount
addtional partition on vg3, but I would prefer it is done by dracut,
so USB stick with the key does not have to be inserted during the
whole boot process (which takse quite some time on my slow machine).

Thank you very much,

Jaiv

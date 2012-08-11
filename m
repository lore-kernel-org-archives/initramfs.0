From: Shlomi Fish <pickledibex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Getting "Cannot resume from device" (or something along these) lines
 with dracut and add_device+="LABEL=sf_unix_swap"
Date: Sat, 11 Aug 2012 12:06:38 +0300
Message-ID: <CAAsq1beH8qcf5CpyvBeG+1EFEyBKY9WKq79wjSsJT9MHkrD_4Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KsBBF+BGdCKtNFP7KbaX+1djwjY5AGVTQfthlN1RbAw=;
        b=zbHyXXx68rAaLWQPpP2iI4EQfnubol/+4c5hlJJCKCHGhjkbOCu1BGPa0+c52NwQXU
         k9nE4jlMT4FwY+2tSPKCoDgPx8yP5/k/OFrZXqw5C8XALnqky3mtxWAsdQ7GlOKWjzIr
         VteTfBmohXCXxBTDEfSRKzb9jqfXFv/xaILymZr3iefPJ6babAUDrECu7x/T4Ptg7NZ9
         6dz1ghi+2gaOb8dgRvJ8P/rKIDddAC6DeWocP9svonJTDUgyYY7L0x604l1UZvKZxnth
         o1VcuCwvkY0XcG27S9LbOyQaopQ9+iKUx7qYOPCWaecdyPF3R2kFPBj/nA3S0ettCM9m
         cWHA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

I'm using Mageia Linux 3/Cauldron and have this in my dracut configuration:

<<<
[root@telaviv1 ~]# cat /etc/dracut.conf.d/51-mageia-resume.conf
add_device+="LABEL=sf_unix_swap"
[root@telaviv1 ~]#
>>>

Now, at startup, I am getting (after waiting for several seconds) a
message such as "Cannot resume from device" or
"resume device not found" and then it boots normally.  My questions are:

1. The label is valid. Can I use a label for the resume device?

2. If not, can I use a UUID instead?

3. If I cannot use a label, then the man page of dracut should be
fixed because -add-device does not mention anything  about not being
able to use a LABEL (which is possible in e.g: /etc/fstab ).

Thanks in advance for any help.

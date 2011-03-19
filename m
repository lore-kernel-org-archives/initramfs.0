From: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut 008 luks key in external device - still broken
Date: Sat, 19 Mar 2011 14:02:09 +0000
Message-ID: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=FOpNJjwYrnh9VISBf8mhKlinwvNy15BA3AqhgZSSuyI=;
        b=b/fwxl4ja/XAriiOhMYtCAETFsaCV+VEp35+vp5+yn6Pd9xlWhEEhfleQCntL3g5wA
         zp1kQsfkmG05mz4/RUo+59c1jZ4XFjlitHhWqh5VInGBrSIMNO3JEHya3xhkjay3ikar
         v9r51ufTA/XjG9uJxEqj2cDZaLx3YoYIGdHIg=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello guys,

I installed F14 into virtualbox and I replicated the HDD layot I have
on my server. Root partition is encrypted together with other
partitions. I created this setup in Anaconda installer, so it should
be considered as "standard" install.
System boots fine (with dracut 006) - it asks for password once during the boot.

Then I installed dracut-008-7.fc15 from
http://koji.fedoraproject.org/koji/packageinfo?packageID=8714, I
updated the grub.conf (created by anaconda) for the new syntax and I
run plymouth-update-initrd so new dracut 008 is active.
Boot was OK without the key on external device.

However when I added rd.luks.key=/mykey:abcd-1234 into the grub
(Instead of abcd-1234 I use real UUID of my key) the boot fails and I
end up in the dracut shell.

Here is how my updated kernel parameters look like:

kernel /vmlinuz-2.6.35.11-83.fc14.i686 ro root=/dev/mapper/vg2-lv_root
rd.luks.uuid=luks-6508ce25-91d1-469a-9423-7b10ef00754e
rd.luks.uuid=luks-73608094-4b4d-48bf-99a6-0493aeb7498d
rd.luks.uuid=luks-9d1124c6-22fe-4572-984b-175c0e307a1f
rd.luks.uuid=luks-eac11ed2-4136-4f73-bda7-1af1c09fe644
rd.md.uuid=eb005502:33822bc2:b956ad0a:be45f8e0
rd.md.uuid=9ce2b0c0:ed400210:451f5dab:694b56f7
rd.md.uuid=5e644250:1dda1a02:9365481e:4e0aee0a
rd.md.uuid=2e0eedaf:41d79b6b:0bed1099:5adc22ef rd.lvm.lv=vg2/lv_root
rd.lvm.lv=vg2/lv_swap rd.dm=0 rd.luks.key=/mykey:abcd-1234
LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us

The change in dracut seem to be quite turbulent and I hope it will
settle a bit. It make take me a while to create patch for dracut 008
and then I can realize you are elsewhere with dracut 009...

dracut.kernel man page confuses me as well:
"           If luksdev is given, the specified key will only be
applied for that LUKS device. Possible values are the same
           as for keydev. Unless you have several LUKS devices, you
don't have to specify this parameter."

I have several luks devices, but one key only. Does it mean I have to
list them all manually for the key again?

So I have to ask you - what logic is used to mount luks partitions
with the key on external device in dracut 008?
(When I modified dracut 005 I had to add delay before USB was checked,
in dracut 008 USB is checked in the loop but if it fails, it does not
ask for password, but ends in shell.)

I have this idea how it can be done (when external key is specified)
I suggest to replace once instance of cryptsetup luksOpen command
which waits for password and blocks boot proccess
with two parallel instances which will try to unlock the same luks device:
- first instance will ask user for password - in the same way it is
done now - cryptsetup luksOpen,
- second intance will:
a) monitor keydev in the loop with sleep. Once keydev is mounted and
the key is found, it will try to unlock luks partition with that key
and when this is successful,
b) Then it will kill the crytpsetup process waiting in the first
instance, first instance will then recheck luks device was
successfully mounted and boot will continue.

In my view this can be implemented without any changes in the
cryptsetup tools. Another option to consider is to try to mount luks
device based on event comming from udev (once key is attached) - and
then perform point b) - what do you think?

In this way once user is asked for password he/she can either enter it
manually or insert the key.

What to you think about my ideas? And can I get any help in
trouble-shooting my problem with dracut 008?

Thank you,

Jaiv

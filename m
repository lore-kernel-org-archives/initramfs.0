From: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sun, 20 Mar 2011 02:14:30 +0000
Message-ID: <AANLkTinL5H7rdTeW=gRrtvpuToP368uQw=m5xNONbr26@mail.gmail.com>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
	<1300544966-sup-1505@ittemni>
	<AANLkTikifPgn4N1mF67o4Cm3TPBGDfS-TF7RgTXb7NfZ@mail.gmail.com>
	<1300577445-sup-6446@ittemni>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YGkfhnvbmL/fgHfyZ7bpRj6TdOy/zZbstJ7FdZF9wJo=;
        b=eRGWE9VZF1zp5wwt2lWHurOZUTsBNY3oBhikqyUD6f+WKzNmUla/oocZag/gBDft9F
         3bOVbH3TTiS2aQlzSvgME+LKtJceSkZN1xQfTMGxoaM8to68D/UkQRYZeNJe5jfykmwY
         WlDwgDiC4NQ/huQkwihovchk8Uwlk2yEMbTLw=
In-Reply-To: <1300577445-sup-6446@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2011/3/20 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> First of all I haven't taken into consideration fact, that one can wa=
nt
> to use dracut for mounting something more than root. That's why there=
's
> only key or only password. But it probably would be possible to
> optionally ask for password, too. I will have to think of cases with
> multiple devices to be decrypted and improve the module.

Anaconda by added swap as well, and other things can be added manually
as a kernel parameter...

> What happens? Doesn't decrypt anything? Or just one of devices?
Apparently anything.

> Please specify:
> 1) How did you build initramfs (which options) and please provide out=
put
> it has printed. (Append -v to options to get more verbose output.)
I used:
/usr/libexec/plymouth/plymouth-update-initrd
It takes a while to finish and it does not display anything - with or
without -v...

> 2) How did you specify kernel cmd line options.
It is in my first e-mail and you can see it in dmesg on the line 79 as =
well.
Link to dmesg is in point 4 below.

> 3) What is expected to happend and what happens.
Expected: I expect my machine boots in the same way as if
rd.luks.keydev is not specified.
What happens: it says it cannot mount md devices and I end up in dracut=
 shell.

> 4) dmesg
http://pastebin.com/nA4qVFcZ

> 5) Content of /tmp/ from initramfs time would be useful, too. (Conten=
t
> of every file there.)
It has 3 files:

#console_init.tty0 - it is empty (size 0)

#luks.keys:
*:/dev/sdc1:/mykey

#root.info:
root=3D'block:/dev/mapper/vg2-lv_root'
rflags=3D'ro'
fstype=3D'auto'
netroot=3D''
NEWROOT=3D'/sysroot'

I added four more points:
6) To prove my key is OK, I tried below from dracut shell: (I'm sure
key for other partitions is fine as well)
#mkdir /mnt
#mkdir /mnt/USB
#mount /dev/sdc1 /mnt/USB
(successful)

#cryptsetup -d "/mnt/USB/mykey" luksOpen /dev/md1
luks-6508ce25-91d1-469a-9423-7b10ef00754e
(successful)

#ls /dev/mapper
control
luks-6508ce25-91d1-469a-9423-7b10ef00754e

7) Is there any option how to enable history and arrow keys in
dracut's shell? (Apart from adding bash into intramfs?)

8) My /etc/dracut.conf contains: (everything else is commented out:)
# list of kernel filesystem modules to be included in the generic initr=
amfs
filesystems+=3D"vfat fat"

# install local /etc/mdadm.conf
mdadmconf=3D"yes"

# install local /etc/lvm/lvm.conf
lvmconf=3D"yes"

9) Also please note that my system boots fine if I remove rd.luks.key
from the kernel options - it asks for pw and all is OK.
Here is dmesg log from successful boot (when rd.luks.key
option is not used):
http://pastebin.com/61yMGff5

Thank you very much for your help.

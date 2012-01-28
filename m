From: Kaya Saman <kayasaman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Using dracut to build a new initramfs in order to boot from USB HD
Date: Sat, 28 Jan 2012 18:40:51 +0000
Message-ID: <4F244133.6030208@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Z4eERhU1wQdnQ1rCFWwsq0kk+/+uo4UKE0jdgHbYGig=;
        b=H7u1bPwV0abDupxdD51DuA8ysqGEvNknWpSmqQN+fTZ4OXE7UBndzg7AjHkZhS+mgh
         lk8JoqNsm0Fc2RZsETfnE2WaLLnCbAvS90nmWb02pWl4T6oxpPjk+Mb5Z26Jz/DStnW7
         0NktIxfQycgioLjgpgECyTJcGOdicPPtIaD2w=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I'm hoping some can help me...

I am trying to get the hard disk that was in my old laptop working as an 
external drive on my new one. The old machine doesn't work any more and 
the new machine uses a slim version of the 2.5" disk so the old disk 
doesn't fit.

The old system is Fedora 15 x64.

Since I have never done this before I spent a few days trying and 
failing already to get this working.

I am not sure even how to check that I have all the necessary modules 
even though I did run:

yum install kernel-headers kernel-devel previously


So far I ran:


dracut -d "jdb ext4 scsi_mod sd_mod usb-storage usb-uhci usbcore 
ehci-hcd uhci-hcd ohci-hcd" initramfs-2.6.41.10-3.fc15.x86_64.img 
2.6.41.10-3

in order to create the new initramfs then backed the original one up and 
simply moved this one into the originals place.

However I'm still getting the error of:

hd1 cannot get C/H/S values

???

The disk works perfectly as am able to mount it through the USB 
enclosure and it's running USB 3.0 so speed shouldn't be an issue either.


Can anyone offer any assistance?


Many thanks,


Kaya

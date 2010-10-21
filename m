From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Thu, 21 Oct 2010 14:54:54 +0100
Message-ID: <4CC0462E.20507@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah> <20101021132916.GC22186@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cJAh/Jbx4IdNX8OBEBWgpBE0rpJbakeY5Z+MbjvzC2I=;
        b=D6x6JcoamSRvAj8SzwXrLk7r1tjR1WGumcY4iWOctUC8xlwV4HJKu2hjd/s1j4DJjW
         cYm38cCXh4IXH8LMVsIqCTVif+zPEahzi8UWgUKTCVC40U5BN/R4Mxirf90+uOELKGLk
         oGm6Rz4zUjyQKwdiJtPd+xuwWoOt1UKS+UZFs=
In-Reply-To: <20101021132916.GC22186-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>>   rd.luks.key=<key_path>:<key_dev>:<key_dev_fs>:<luks_dev>
>>     
>
>  The LABEL and UUID are always stored in filesystem specific
>  superblock (or root directory) on the device. It means that your
>  system has to be able to detect FS type before it's able to read
>  LABEL/UUID from the device.  The <key_dev_fs> is unnecessary.
>   
If I have HFS drive (Mac) or even HPFS (OS/2) and have the keys there 
how would I be able to retrieve them then if I do not use labels/UUID - 
by using /dev/sdXX?

I think specifying the target file system is important because by just 
executing 'mount' without indicating the target file system when I have, 
for example, HFS or HPFS mount just won't happen. I am also not certain 
that by just executing 'mount' it would automatically map NTFS either, 
without specifying that the target system is NTFS (the command in 
question for mounting NTFS partitions is ntfs-3g isn't it?). Same goes 
for ReiserFS (I think) as well as cidr/smb partitions/drives (although I 
admit the latter case is a bit special as it needs network access and a 
bit more options to be configured in order to make it work).

The 'guessing' of the file systems by mount also comes with a health 
warning, which has to be respected: "Warning: the probing uses a 
heuristic (the presence of appropriate 'magic'), and could recognize the 
wrong filesystem type, possibly with catastrophic consequences. If your 
data is valuable, don't ask mount to guess."

From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Thu, 21 Oct 2010 17:18:02 +0200
Message-ID: <20101021151802.GD22186@nb.net.home>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah> <20101021132916.GC22186@nb.net.home> <4CC0462E.20507@googlemail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CC0462E.20507-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Oct 21, 2010 at 02:54:54PM +0100, Mr Dash Four wrote:
>
>>>   rd.luks.key=<key_path>:<key_dev>:<key_dev_fs>:<luks_dev>
>>>     
>>
>>  The LABEL and UUID are always stored in filesystem specific
>>  superblock (or root directory) on the device. It means that your
>>  system has to be able to detect FS type before it's able to read
>>  LABEL/UUID from the device.  The <key_dev_fs> is unnecessary.

Well, rephrasing: The <key_dev_fs> is unnecessary if you want to use
UUID or LABEL.

> If I have HFS drive (Mac) or even HPFS (OS/2) and have the keys there  
> how would I be able to retrieve them then if I do not use labels/UUID -  
> by using /dev/sdXX?

HFS, HPFS and NTFS support labels and uuids

> I think specifying the target file system is important because by just  
> executing 'mount' without indicating the target file system when I have,  
> for example, HFS or HPFS mount just won't happen.

Why? My mount(8) is able to detect HFS or HPFS.

# losetup --show -f /home/images/filesystems/hfs.img
/dev/loop0

# mount /dev/loop0 /mnt/test

# grep loop0 /proc/mounts 
/dev/loop0 /mnt/test hfs rw,relatime,uid=0,gid=0 0 0


> I am also not certain  
> that by just executing 'mount' it would automatically map NTFS either,  
> without specifying that the target system is NTFS (the command in  
> question for mounting NTFS partitions is ntfs-3g isn't it?).

 $ ll /sbin/mount.ntfs
 lrwxrwxrwx 1 root root 13 Oct  8 10:32 /sbin/mount.ntfs -> mount.ntfs-3g

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com

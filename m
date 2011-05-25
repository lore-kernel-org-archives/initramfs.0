From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Wed, 25 May 2011 16:33:11 +0200
Message-ID: <20110525143311.GA14298@nb.net.home>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info> <20110523230507.GC2659@nb.net.home> <4DDC1A05.9030400@ziu.info> <20110524223936.GG2659@nb.net.home> <4DDD0E48.3060607@rasengan.ppgk.com.pl>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4DDD0E48.3060607-dAhJnYnFfKxY6LDf3zcCrARSaAK4NQh3@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rasengan rootish <root-FKoNWt1xKxkgbZ1banK5DA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, May 25, 2011 at 04:12:24PM +0200, rasengan rootish wrote:
> W dniu 25.05.2011 00:39, Karel Zak pisze:
>>
>>    From my point of view it would be ideal to avoid fstab parsing in the
>>   script at all.
>>
>>   export FSTAB_FILE=/etc/fstab.sys
>>
>>   for $dev in $(findmnt --fstab -o SOURCE -e -n -O no_netdev); do
>>
>>      fsck -T $dev
>>      mount $dev --target-prefix $NEWROOT
>>
>>   done
>>
>>   Unfortunately mount(8) does not allow to read info about mountpoints
>>   from alternative fstab file and it does not support --target-prefix
>>   now.  I'll add this to my TODO list.
>>
>>      Karel
>>
>
> Ok, thanks for info (btw, findmnt seems to only handle octal escapes).

 That's correct. 
 
 The hex (e.g. \x40) escapes are used by udev for /dev/disk/by-*
 symlinks only. 

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com

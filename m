From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Wed, 25 May 2011 16:32:43 +0200
Message-ID: <4DDD130B.90602@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info> <20110523230507.GC2659@nb.net.home> <4DDC1A05.9030400@ziu.info> <20110524223936.GG2659@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110524223936.GG2659-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

W dniu 25.05.2011 00:39, Karel Zak pisze:
>
>   from mount(8) code:
>
>     need_escaping[] = { ' ', '\t', '\n', '\\' };
>
>   It's used for all strings in fstab (so not for mountpoints only).
>
>> Also, some standard handling uuid/label and watching for other stuff as
>> well would be good too. Plain 'test -e' is not too proper either.
>
>    From my point of view it would be ideal to avoid fstab parsing in the
>   script at all.
>
>   export FSTAB_FILE=/etc/fstab.sys
>
>   for $dev in $(findmnt --fstab -o SOURCE -e -n -O no_netdev); do
>
>      fsck -T $dev
>      mount $dev --target-prefix $NEWROOT
>
>   done
>
>   Unfortunately mount(8) does not allow to read info about mountpoints
>   from alternative fstab file and it does not support --target-prefix
>   now.  I'll add this to my TODO list.
>
>      Karel
>

Ok, thanks for info (btw, findmnt seems to only handle octal escapes).

I'll update fstab-sys & co. and send new set of patches.

From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Wed, 25 May 2011 00:39:37 +0200
Message-ID: <20110524223936.GG2659@nb.net.home>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info> <20110523230507.GC2659@nb.net.home> <4DDC1A05.9030400@ziu.info>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4DDC1A05.9030400-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, May 24, 2011 at 10:50:13PM +0200, Michal Soltys wrote:
> On 11-05-24 01:05, Karel Zak wrote:
>> On Fri, May 20, 2011 at 05:09:25PM +0200, Michal Soltys wrote:
>>>  +fstab_mount() {
>>>  +    local _dev _mp _fs _opts _dump _pass _rest
>>>       test -e "$1" || return 1
>>>       info "Mounting from $1"
>>>  -    while read dev mp type opts rest; do
>>>  -	[ -z "${dev%%#*}" ]&&  continue # Skip comment lines
>>>  -	mount -v -t $type -o $opts $dev $NEWROOT/$mp
>>>  -    done<  $1 | vinfo
>>>  +    while read _dev _mp _fs _opts _dump _pass _rest; do
>>
>>   How does this code handle encoding in fstab? (e.g. /path/foo\x40bar)
>>
>
> Ah, I knew something went too easy. Though you mean - \040 as escape for  
> space character in mountpoint, not any arbitrary \xNN or \0NN ?

 from mount(8) code:

   need_escaping[] = { ' ', '\t', '\n', '\\' };

 It's used for all strings in fstab (so not for mountpoints only).

> Also, some standard handling uuid/label and watching for other stuff as  
> well would be good too. Plain 'test -e' is not too proper either.

 From my point of view it would be ideal to avoid fstab parsing in the
 script at all. 

 export FSTAB_FILE=/etc/fstab.sys

 for $dev in $(findmnt --fstab -o SOURCE -e -n -O no_netdev); do

    fsck -T $dev
    mount $dev --target-prefix $NEWROOT

 done

 Unfortunately mount(8) does not allow to read info about mountpoints
 from alternative fstab file and it does not support --target-prefix
 now.  I'll add this to my TODO list.

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com

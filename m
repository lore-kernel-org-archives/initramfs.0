From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Tue, 24 May 2011 22:50:13 +0200
Message-ID: <4DDC1A05.9030400@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info> <20110523230507.GC2659@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110523230507.GC2659-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11-05-24 01:05, Karel Zak wrote:
> On Fri, May 20, 2011 at 05:09:25PM +0200, Michal Soltys wrote:
>>  +fstab_mount() {
>>  +    local _dev _mp _fs _opts _dump _pass _rest
>>       test -e "$1" || return 1
>>       info "Mounting from $1"
>>  -    while read dev mp type opts rest; do
>>  -	[ -z "${dev%%#*}" ]&&  continue # Skip comment lines
>>  -	mount -v -t $type -o $opts $dev $NEWROOT/$mp
>>  -    done<  $1 | vinfo
>>  +    while read _dev _mp _fs _opts _dump _pass _rest; do
>
>   How does this code handle encoding in fstab? (e.g. /path/foo\x40bar)
>

Ah, I knew something went too easy. Though you mean - \040 as escape for 
space character in mountpoint, not any arbitrary \xNN or \0NN ?

Also, some standard handling uuid/label and watching for other stuff as 
well would be good too. Plain 'test -e' is not too proper either.

I'll get it done.

>>  +        [ -z "${_dev%%#*}" ]&&  continue # Skip comment lines
>>  +        if [ ! -e "$_dev" ]; then
>>  +            warn "Device $_dev doesn't exist, skipping mount."
>>  +            continue
>>  +        fi
>>  +        if [ "$_pass" -gt 0 ]&&  ! strstr "$_opts" _netdev; then
>>  +            wrap_fsck "$_dev"
>>  +        fi
>>  +        _fs=$(det_fs "$_dev" "$_fs" /etc/fstab.sys)
>>  +        info "Mounting $_dev"
>>  +        mount -v -t $_fs -o $_opts $_dev $NEWROOT/$_mp 2>&1 | vinfo
>>  +    done<  $1
>
>   It means that fsck is not running in parallel if you have more
>   devices in /ect/fstab.sys. Is it expected?
>

Actually, when you mentioned it - I didn't really think about actually 
parallelizing those fscks. I assumed fstab-sys use is more of an 
exception for special cases (as, "must have that mount at all cost 
before pivot"), than something "standard". Shouldn't be a problem to 
expand it in such direction though.

One point though - next step I wanted to do was to call proper 
fs-specific checker (if applicable, or fallback to generic one) - e.g. 
xfs wants xfs_check (xfs_db) or xfs_repair to be used (preferably 
including user intervention). So that would have to be done outside 
parallel run either way.

Also I wonder, if fsck stuff and det_fs wouldn't be better in its own 
module, on which fstab-sys and rootfs-block would depend (instead of 
sourcing fscks themselves, while relying on dracut-lib.sh, etc.).

>   It would be better to call one fsck instance for all devices
>
>      fsck -T /dev/sda1 /dev/sda2 /dev/sdb1
>
>   or use the "-l" option for more instances.
>
>      Karel
>

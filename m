From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] teach dmsquash-live-root to use rootflags
Date: Fri, 09 Apr 2010 16:40:22 +0200
Message-ID: <4BBF3C56.4010803@redhat.com>
References: <1269612076-18504-1-git-send-email-jboggs@redhat.com> <4BBF355B.80600@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BBF355B.80600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 04/09/2010 04:10 PM, Joey Boggs wrote:
> On 03/26/2010 10:01 AM, Joey Boggs wrote:
>> ---
>> modules.d/90dmsquash-live/dmsquash-live-root | 7 ++++++-
>> 1 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root
>> b/modules.d/90dmsquash-live/dmsquash-live-root
>> index b1754dc..c98cdef 100755
>> --- a/modules.d/90dmsquash-live/dmsquash-live-root
>> +++ b/modules.d/90dmsquash-live/dmsquash-live-root
>> @@ -172,7 +172,12 @@ if [ -b "$OSMIN_LOOPDEV" ]; then
>> echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot $BASE_LOOPDEV
>> $OSMIN_LOOPDEV p 8" | dmsetup create --readonly live-osimg-min
>> fi
>>
>> +ROOTFLAGS="$(getarg rootflags)"
>> +if [ -n "$ROOTFLAGS" ]; then
>> + ROOTFLAGS="-o $ROOTFLAGS"
>> +fi
>> +
>> ln -s /dev/mapper/live-rw /dev/root
>> -printf '/bin/mount /dev/mapper/live-rw %s\n' "$NEWROOT">
>> /mount/01-$$-live.sh
>> +printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS"
>> "$NEWROOT"> /mount/01-$$-live.sh
>>
>> exit 0
> any comments on this one?
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

looks good :) will merge

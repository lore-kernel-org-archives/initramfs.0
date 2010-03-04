From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add readonly overlay support for dmsquash
Date: Thu, 4 Mar 2010 15:16:33 +0100
Message-ID: <20100304141633.GA18077@nb.net.home>
References: <1267195469-32522-1-git-send-email-jboggs@redhat.com> <20100226202326.GG8702@nb.net.home> <4B8FB0A5.2090309@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B8FB0A5.2090309-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 04, 2010 at 02:07:49PM +0100, Harald Hoyer wrote:
> On 02/26/2010 09:23 PM, Karel Zak wrote:
>> On Fri, Feb 26, 2010 at 09:44:29AM -0500, Joey Boggs wrote:
>>>       # set up the snapshot
>>> -    echo 0 `blockdev --getsize $BASE_LOOPDEV` snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create live-rw
>>> +    echo 0 `blockdev --getsize $BASE_LOOPDEV` snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create $readonly_overlay live-rw
>>                 ^^^^^^^^^^^^^^^^^
>>
>>   Don't use --getsize, this option is deprecated and it's based
>>   on BLKGETSIZE ioctl that returns *32-bit* sector count (= 2TiB only).
>>
>>   Please, use --getsz. For more details see blockdev(8) man page.
   ^^^^^^^^^^^^^^^^^^^^^
>>
>>      Karel
>>
>
> patched to use --getsize64

 That's wrong solution. The --getsize64 option returns size in bytes,
 but you need size in 512-byte sectors. Use --getsz, read "man
 blockdev" ;-)

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

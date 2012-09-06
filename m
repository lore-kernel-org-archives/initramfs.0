From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Don't truncate the overlay file on a reset.
Date: Thu, 06 Sep 2012 10:51:59 +0200
Message-ID: <5048642F.9090406@redhat.com>
References: <CAEcBt+XLgwWV7GDtrR18aZ6MR1GtZihcWub-CNxL0mr7NS_YpQ@mail.gmail.com> <CAEcBt+XQLRA-PZ4m7SjhTw3qASkg3s57PYHKOG56g0f5xtdz7w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEcBt+XQLRA-PZ4m7SjhTw3qASkg3s57PYHKOG56g0f5xtdz7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, livecd-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org

Am 31.08.2012 02:19, schrieb Frederick Grose:
> On Wed, Aug 29, 2012 at 9:15 PM, Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> commit d0d4f29cdd0a0e6dd1170965decb282ef5511746
>> Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
>> Date:   Wed Aug 29 21:02:07 2012 -0400
>>
>>     Don't truncate the overlay file on a reset.
>>
>> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> index f8bfca6..62340a5 100755
>> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> @@ -98,7 +98,7 @@ do_live_overlay() {
>>          if [ -f /run/initramfs/overlayfs$pathspec -a -w
>> /run/initramfs/overlayfs$pathspec ]; then
>>              losetup $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
>>              if [ -n "$reset_overlay" ]; then
>> -                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 2>/dev/null
>> +                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1
>> conv=notrunc 2>/dev/null
>>              fi
>>              setup="yes"
>>          fi
> 
> Void the above patch.
> 
> I don't know why the overlay is NOT truncated without the notrunc
> conversion argument to dd.
> 
> However, my testing shows that this bug is fixed by using the fsync
> conversion argument,
> https://bugzilla.redhat.com/show_bug.cgi?id=832884
> 
> A revised patch file is attached to the bug ticket.
> 
>         --Fred

bugzilla attachment applied, thanks!

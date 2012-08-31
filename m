From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Don't truncate the overlay file on a reset.
Date: Thu, 30 Aug 2012 20:19:08 -0400
Message-ID: <CAEcBt+XQLRA-PZ4m7SjhTw3qASkg3s57PYHKOG56g0f5xtdz7w@mail.gmail.com>
References: <CAEcBt+XLgwWV7GDtrR18aZ6MR1GtZihcWub-CNxL0mr7NS_YpQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Sl6wSeJQ3ABJjWTWHxpCo5ywj3zeVAYRTGR4acS1m+8=;
        b=azONDinDXALQtdJAkQSp+1IS2huqD/ov40rZTxDFhRUvhVDA+gfTl7X57zzaV2FEmT
         X+kwdK0WumGSLLeXfEg6TUc9uR9wRz0ukrCjo/9XPQxhza9JPJCRLSw8TN/ZAzXVhoZN
         /jHG6z8X7qXtQeUloTm8HHeBsOqHUoXTVpP67JxnwOqyxMtlgoIKDU+HLwrSyjLLsmgY
         ajrCt0Wld3B+IF35GQBR72YZ4IyAJecOlWQ7mfKmD/+/ogPC88xXviTCPInN4FN+Da/W
         XbcK9nYgak8xvxb/sReyr48qIILscaEeJG5eADW9yj694PqhJyUUln22HMxn54zs5GCa
         9mVg==
In-Reply-To: <CAEcBt+XLgwWV7GDtrR18aZ6MR1GtZihcWub-CNxL0mr7NS_YpQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: livecd-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org

On Wed, Aug 29, 2012 at 9:15 PM, Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> commit d0d4f29cdd0a0e6dd1170965decb282ef5511746
> Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
> Date:   Wed Aug 29 21:02:07 2012 -0400
>
>     Don't truncate the overlay file on a reset.
>
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> index f8bfca6..62340a5 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> @@ -98,7 +98,7 @@ do_live_overlay() {
>          if [ -f /run/initramfs/overlayfs$pathspec -a -w
> /run/initramfs/overlayfs$pathspec ]; then
>              losetup $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
>              if [ -n "$reset_overlay" ]; then
> -                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 2>/dev/null
> +                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1
> conv=notrunc 2>/dev/null
>              fi
>              setup="yes"
>          fi

Void the above patch.

I don't know why the overlay is NOT truncated without the notrunc
conversion argument to dd.

However, my testing shows that this bug is fixed by using the fsync
conversion argument,
https://bugzilla.redhat.com/show_bug.cgi?id=832884

A revised patch file is attached to the bug ticket.

        --Fred

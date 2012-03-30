From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: NFS mount problem since 017
Date: Fri, 30 Mar 2012 11:01:03 +0200
Message-ID: <4F75764F.8040407@redhat.com>
References: <CAKzfqkd3hGyqhVvfdSFg7=R595cEjy0gNpnwmBcHQnUXOxbkOA@mail.gmail.com> <CAKzfqkcWuySSQRSOdk=Z-UbVieHUEb4aHVs9qro3uw7Q6s-7jg@mail.gmail.com> <4F743BF8.9000608@redhat.com> <CAKzfqkeDMpAKarVENVFHddERc0ySn1acnQR=K1wKCDC=N5dGTg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfqkeDMpAKarVENVFHddERc0ySn1acnQR=K1wKCDC=N5dGTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 29.03.2012 20:53, schrieb Wim Muskee:
> On Thu, Mar 29, 2012 at 12:39 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Am 27.03.2012 20:13, schrieb Wim Muskee:
>>
>> Ah, we now kill rpc.idmapd. So before you do any action, you have to restart
>> rpc.idmapd in the real root.
> 
> Any reason the rpc.idmapd is killed now?
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

ok, just investigated: we kill rcp.idmapd since dracut 0.3.

must be another problem

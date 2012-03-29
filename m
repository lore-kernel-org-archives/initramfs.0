From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: NFS mount problem since 017
Date: Thu, 29 Mar 2012 12:39:52 +0200
Message-ID: <4F743BF8.9000608@redhat.com>
References: <CAKzfqkd3hGyqhVvfdSFg7=R595cEjy0gNpnwmBcHQnUXOxbkOA@mail.gmail.com> <CAKzfqkcWuySSQRSOdk=Z-UbVieHUEb4aHVs9qro3uw7Q6s-7jg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfqkcWuySSQRSOdk=Z-UbVieHUEb4aHVs9qro3uw7Q6s-7jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 27.03.2012 20:13, schrieb Wim Muskee:
> Harald also asked me on irc to check if rpc.idmapd was running.
> 
> I added a ps fax | grep idmap at the end of 95nfs/nfsroot-cleanup.sh
> and saw no rpc.idmapd process.
> 
> Is that the correct way to check? I figured at the end of the cleanup,
> it should be there.
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ah, we now kill rpc.idmapd. So before you do any action, you have to restart
rpc.idmapd in the real root.

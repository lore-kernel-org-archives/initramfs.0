From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: NFS mount problem since 017
Date: Tue, 27 Mar 2012 20:13:00 +0200
Message-ID: <CAKzfqkcWuySSQRSOdk=Z-UbVieHUEb4aHVs9qro3uw7Q6s-7jg@mail.gmail.com>
References: <CAKzfqkd3hGyqhVvfdSFg7=R595cEjy0gNpnwmBcHQnUXOxbkOA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=0RXjJWN/ZgafgvygeTgHaGanHfGZUAiRQHBWB8QdA3w=;
        b=oNBwjmbJy9kJiqJtEnsHwdf/NE20G261ZdfcuWFDffjxDb9YnKq+qTtoEViHc4+Xnk
         fcy4wYjdy9qZ0QxjTrJdXHl1YqbeL0t935jCrS0iDAhY9Y0TPa9owJOW/tH4YU2ShCKn
         6mTsDwj/HArRKX8AgqNvHpmC+dzc4WswbSAuk4pqzqM5bAs8JiEhwjBxgSoU36xC3y8u
         jgXrO/Vmu3PYN4MbeBR2RWj+IdEMyv6jU6w4uUACIM77JiFFIZK6AePskfCaT+KSqKkE
         nxJKjudSiceUDW1dNShm3GkIFUNY2VosfVt7Ltyn8CBTOjatVtk8etTeLLrbn80unClw
         nb9Q==
In-Reply-To: <CAKzfqkd3hGyqhVvfdSFg7=R595cEjy0gNpnwmBcHQnUXOxbkOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald also asked me on irc to check if rpc.idmapd was running.

I added a ps fax | grep idmap at the end of 95nfs/nfsroot-cleanup.sh
and saw no rpc.idmapd process.

Is that the correct way to check? I figured at the end of the cleanup,
it should be there.

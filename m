From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: NFS mount problem since 017
Date: Thu, 29 Mar 2012 20:53:22 +0200
Message-ID: <CAKzfqkeDMpAKarVENVFHddERc0ySn1acnQR=K1wKCDC=N5dGTg@mail.gmail.com>
References: <CAKzfqkd3hGyqhVvfdSFg7=R595cEjy0gNpnwmBcHQnUXOxbkOA@mail.gmail.com>
	<CAKzfqkcWuySSQRSOdk=Z-UbVieHUEb4aHVs9qro3uw7Q6s-7jg@mail.gmail.com>
	<4F743BF8.9000608@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ymWilPR99tdteVdumjqx2xQK8PzfZRME5GAkKkpcm1k=;
        b=X8rOmlndvAcNgw7bb1Xzc5wlO5oJP9i1IZlxmv+roDbY17q1MzLgH4GhidoJIsWNI0
         j90JJewyImejn6VRxbdCtpIKZlT7Uj4BV42YV+U0ttYn8dY6W7DBEQO5KyIPIAkjyJEi
         UywHH8MfSrfoaHPzyWx0EvAu5hhNMruAUz/vlWstSn8u+x5Hkngn7j2cqvQ6fVSs/x69
         IRT3nbmCJtFDYwBDKNIHbQMA1R+95gOpznjJY6fjON/7DjTnAKzZqN7JEm3ezcJiHoFV
         OXEeztLvooHkyOQuKBpQNnry30ucc20Sg01SXO/BquP1maeSiHWz6jc42OQPqHhHqtn+
         0Dmg==
In-Reply-To: <4F743BF8.9000608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 29, 2012 at 12:39 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Am 27.03.2012 20:13, schrieb Wim Muskee:
>
> Ah, we now kill rpc.idmapd. So before you do any action, you have to restart
> rpc.idmapd in the real root.

Any reason the rpc.idmapd is killed now?

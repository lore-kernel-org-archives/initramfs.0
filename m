From: Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut does not load pata_atiixp module
Date: Sat, 30 Jun 2012 15:31:29 +0300
Message-ID: <4FEEF1A1.6030206@gmail.com>
References: <4FEEEE37.4070105@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=one8w9By33gB3+MTH6qlNt0VcODHOp4nxaEk5bQP3iM=;
        b=Hj0LpCq4OeC/zFsve8QumbSswTXQZIfrEuxTMgbjaQVq4I49pLolUcL2zjsfXUcxg8
         52JNZ/+eF/hOiqX+NTK+yT4DjDg0NMmi9WoL7KmySLQ1h2t9Cvn2Tn9D3AnDDez/eD3d
         6HFa5eUTyJXXICSy1bqSZQa1wyxB+EnX1lIAm9OgWaKLqA4/+BvqF4z09QGg6+QCn4Ur
         dIgFNAzwiXdGPnqH4kjbifhUmfAU0CcgTMmVb5UdPDWPLhr1wOgt81U5DTp+XMaCG4Vf
         G8gPOP9LCNZgH9r/riJAOpuJ+Ms7owBcoEO06hiUD+4wGWIexgBoggZwlXPVo1AKFbPJ
         Kc4Q==
In-Reply-To: <4FEEEE37.4070105-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/30/2012 03:16 PM, Paulius Zaleckas wrote:
> I have upgraded F16->F17 with preupgrade and booting
> with F17 kernel fails. The reason is that dracut fails
> to find my root HDD (sdb). Module pata_atiixp has to be
> loaded for it to appear. This module exists in initramfs,
> but dracut does not load it... F16 initramfs loads it

Acctually F17 dracut on my system does not load any module
at all (but I can load them manually).
F16 dracut loads not only pata_atiixp, but some other
modules also.

> and boots OK. I am really willing to help nail this bug.
>
> Dracut version is: 018-40.git20120522.fc17
> failing kernel: 3.4.3-1.fc17.x86_64


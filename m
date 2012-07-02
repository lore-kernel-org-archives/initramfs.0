From: Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut does not load pata_atiixp module
Date: Mon, 02 Jul 2012 20:42:23 +0300
Message-ID: <4FF1DD7F.5020907@gmail.com>
References: <4FEEEE37.4070105@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=O+k1vf5oq4UCkJSUaHWiTJfpBzWSxKJ9KD1zWJSzNDo=;
        b=j73Q2T96xXn2fALb9WvQXaiP8w4455W5k7qUhumROILHvOw4xoOfVfLLjMNWPvLfdq
         maGGm7tQApsYyfHYT2psbXdaXVt9PHp1JguM2vw9liXNI4hfe5nRegPubaoKi3/ao6uD
         TLeggcD3NrQRWICbWsJDFfW1mHtbxIpvmHkvi3ym5bBqowMtCboUwFU7SvzK61TBAUQl
         +8FnfNdfMZHviEES7vPRnQhvLNewP6ym91xQo8E9tEdYt99df9A1ZktpvBcXTj70UN/Q
         T6sSa/OOVtlB3uF6m5OxkRQ8MRjYJRu7bGxf9Yyy9Ft/jFC2qXk+eKBGP4t1jjo8lph+
         RJEw==
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
> and boots OK. I am really willing to help nail this bug.
>
> Dracut version is: 018-40.git20120522.fc17
> failing kernel: 3.4.3-1.fc17.x86_64

It seems that initramfs regeneration fixed the problem.


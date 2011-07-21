From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch] busybox module: parse busybox defined functions dynamically
Date: Thu, 21 Jul 2011 10:01:01 +0200
Message-ID: <4E27DCBD.4010407@gmail.com>
References: <CAM_iQpWn9SMU8NXKd-XzdXX7WZv3ba6swRcf2yYTwEJvGHN35w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=T9wfp8MyR92kKyU1432Efw8yAzxSALOdVpJ+GgaR33I=;
        b=dDR7q5tc4bJj5LcPBpKCKACrB4+80V0zIveYaldBodlgKooKRxOFHGOZ4c+HcujkCd
         MrxvbflbH+CMJ6tSbatTCx9EyTy8ie5QK5ukw8TiROHlQYALpVSBS5oDP1MTTlCIXQ0W
         CGBxpx196W7Bl7RwraxuNxjyNeIA9xIEv3qok=
In-Reply-To: <CAM_iQpWn9SMU8NXKd-XzdXX7WZv3ba6swRcf2yYTwEJvGHN35w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 21.07.2011 09:33, Am=C3=A9rico Wang wrote:
> Currently in dracut busybox module, we hard-code the list of binaries
> available in busybox. Actually we can get this list by running busybo=
x
> without any arguments.
>=20
> Also, if find_binary() finds nothing, we would symlink $initdir/
> which is not we expect.
>=20
> Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

pushed

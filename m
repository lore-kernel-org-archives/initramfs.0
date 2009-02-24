From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its 
	own series of hooks.
Date: Tue, 24 Feb 2009 12:50:00 -0300
Message-ID: <82ecf08e0902240750v5a742714n1873d36321c1312c@mail.gmail.com>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com> <49A3A924.9000003@bfh.ch>
	 <1235474964.28090.53.camel@sentry-no.fnordovax.org>
	 <82ecf08e0902240435v5ebbb37clea8c8148ce19fa95@mail.gmail.com>
	 <49A41618.2020807@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zGUweYatLykGGypB8BN9MdZ9ChmFPeRAX/YvgCLVNpc=;
        b=HKI7W+vWcYKCbRV2u9ntNx+7dEtBlKtoqc0MNROO0aKP8JpAO6CsRjxvtQR067fsz+
         G5kIgCW1113S4JLh35PNtdB7tW2MaVB8ABAPx1CKaljCiy2KnXZMfkBr6QD27ZVrxALl
         E1Ba2nLYbz5Xmak1YoRf94UuP/1sxBU3g9llE=
In-Reply-To: <49A41618.2020807-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>> I think it is important to keep backwards compatibility in this
>> specific case, and handle "root=3D/dev/nfs" kind of stuff. Really, t=
hink
>> about keeping 2, 3 different cmdlines depending if the system is new=
er
>> or older. It may look like a small hassle, but getting this right
>> sometimes takes some time
>
>
> Who's tools handled "root=3D/dev/nfs"? =A0/dev/nfs cannot be a valid =
dev node?

Take a look at /Documentation/filesystems/nfsroot.txt

--=20
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

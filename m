From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] 90crypt: probe for keydev asynchronously; changed
 kernel arg
Date: Sat, 13 Nov 2010 11:50:54 +0300
Message-ID: <AANLkTimg81mVgKeJ93y_J52Kud_NaUSB6RLT3wFst7fN@mail.gmail.com>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name>
	<1289553710-7568-2-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=riAWfgYHuzdH/rZXXO88av8ceDoB/QRcfaGn7CWKtDg=;
        b=tThPhScpub+6IWVSNypyO1ftsdVSGUhcB38lOlWMuUmLLrhvx44fepx8ZOKF54H7zX
         42YiQgvwjyECtfY1YKkdXyv3E/H1Mn6bSB/TizTciSLjONioS9WfplSDkM6f+bJNq5kX
         mlosMfQEXeX68m+Ha4jUOVGd5BPl0odkznZTc=
In-Reply-To: <1289553710-7568-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/11/12 Amadeusz =AFo=B3nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
[...]
> diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/c=
ryptroot-ask.sh
[...]
> =A0inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask

As you are currently working on it, could you look into making
cryptroot coexist with plymouth? Currently they fight for
/sbin/cryptroot-ask; I thought about adding minimal plugin support
(i.e. something like /cryptroot-ask.d where modules can drop their
implementation; they will be tried is sequence until some succeeds).
Then /sbin/cryptroot-ask could be moved to base and be simple wrapper
around this directory.

Unfortunately I do not currently have ready-to-use infrastructure to
test this implementation.

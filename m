Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955238F80
	for <initramfs@vger.kernel.org>; Tue, 19 Dec 2023 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iffzN9PY"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd4d2018f8so307722276.1
        for <initramfs@vger.kernel.org>; Tue, 19 Dec 2023 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703013809; x=1703618609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81mt3uxxMIhL0SQSJ0+t3yAxcx7pFGIEDren6C8DC0g=;
        b=iffzN9PY3gqrABkk9CqKsd/czK9NSr+OADT5I98Hz1ntn4vw03SYssg/u7VGNPAexy
         2qNl0TeFkt9/wuesqwj4oog6RRHZrdGiUzpaTxUyg4zu9X2tY5/G/mnVAEf+3bmS6cdT
         rXyaYoNOjTrCDA2vrH1sojHxDX7uiOGForuB9OfD7TLXiE1lPLrlfb21t+zEtFQMHUSi
         aBX0Jm9a7CJBJplkiS99qwT0ujhD2uC7qg26G+vrotLnZsadTMObqHBtl9RYvckzI2pm
         mjWsC6ZefzAZS2Hc/OYrQNEDprBrL3Ob1HV74H0ZM7k4THc2B5rrO+fHwuPDxp06+Wtd
         GtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013809; x=1703618609;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81mt3uxxMIhL0SQSJ0+t3yAxcx7pFGIEDren6C8DC0g=;
        b=sXBk4weHjx8ezxMMMWj5eiHC5JcZ02d7dTUgy/nHU+MoAcskuRa4vu/QyJzzbap+W3
         OkPaDfZPsg+wgmtBAsMiliijKWJ0O2TxO8uPvzI8hKqi4EdXuxQ8RS9LfZuYwuy8cRNj
         BrzD/oXnyWPSJz1s12Wan6CsTdWfpBXIjiSpvEDycylphYYviMPk277Ptb9rZ0Wh1oJx
         aAi6+e7GyBKDIMHwMrK3o9B0R4fHsLGV7g//I2qqdz3X2iOiwaxSvGMXesxwYvC1HbmM
         Ep/4uKFTbuCBLy1JwLAT+Eb+Kau0v8Kc610mALzUrw1utm9T7OnXMcPRUqvORUUSwqGr
         WgOQ==
X-Gm-Message-State: AOJu0YxQGKo0lnu+IMu4S0OzTh5uc4qDbxNoX+bCLOJPAKHzEWDKcrZa
	Htb5+WHo5IOyKc289tEbwkZxXtiNgmHhuJGCaE1bFVWTqcA=
X-Google-Smtp-Source: AGHT+IGH2u0EkJNL6kchuykHMZpLkjto6jG7UoqP1Y79xTU/R7hkOIDkE7uL1GOIAwcrS9GIBhUakBHtubik+Slggmk=
X-Received: by 2002:a25:c281:0:b0:dbd:2443:31c8 with SMTP id
 s123-20020a25c281000000b00dbd244331c8mr4016804ybf.0.1703013808796; Tue, 19
 Dec 2023 11:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 19 Dec 2023 22:22:43 +0300
Message-ID: <CAPnZJGAqrj4f+63-cwOpTk+bL2mzpmThSthmGGmfQTTbxT+Taw@mail.gmail.com>
Subject: Re: [PATCH v2] initramfs: Support unpacking directly to tmpfs
To: emily@redcoat.dev
Cc: initramfs@vger.kernel.org, rob@landley.net
Content-Type: text/plain; charset="UTF-8"

Hi, Emily.

I propose this solution: in very beginning of your initramfs's init do
equivalent of this:

mkdir root
mount --bind / root
cd root
mount --move . /
chroot .

And then everything else.

This will create second mount of initramfs. Everything will look same,
but pivot_root will work.

Also, you can do this: create file named, say, "preinit" and put it to
initramfs. Write to this file code above and put to the end of the
file "exec /init". Of course, "preinit" could be written in shell or C
or any other language. Add "rdinit=/preinit" to kernel command line.
This will execute preinit at first, preinit will duplicate initramfs
mount and then execute actual initramfs's init.

I didn't test this, but I'm nearly sure it will work. If you want, I
can test this.

Also you can put "rdinit=/preinit" to CONFIG_CMDLINE. As well as I
understand, CONFIG_CMDLINE will be merged with command line provided
by bootloader, but I'm not sure. Also you can link small initramfs
with /preinit to kernel image. Again, as well as I understand it will
be merged with initramfs provided by bootloader. Thus, kernel with
CONFIG_CMDLINE and with linked in initramfs with /preinit will behave
very similarly to kernel with your patch. Of course, initial mount
will not be empty, but I think this is a minor point.

Of course, instead of that "mount --bind" trick you can do the same
with "cp + rm" solution.

Also, I remember I saw patch similar to yours in Linux mailing lists.
It was rejected, too. If you want I can try to find it.

I suggest solution described above. But let me also provide some
alternative solutions. You can implement patch similar to yours, but
which will work unconditionally, always. This will solve the problem
once and for all. Ideally initial mount will be nullfs as suggested by
Rob. I. e. file system, which has no state at all. To make sure
containers cannot exchange data. I think such filesystem is easy to
create. All operations will be no-ops. Look at "fs" directory in
kernel tree and write something similar.

Another way is to make pivot_root work with initial mount. I think
this will be hard.

Note that Rob Landley is absent from MAINTAINERS file (
https://elixir.bootlin.com/linux/latest/source/MAINTAINERS ), so he
doesn't decide whether a patch will be accepted. (I doesn't decide,
too. I'm not a kernel developer, I just occasionally found this thread
and decided to answer.)

If you ever want to start new discussion or sent new patch, then,
please, sent it to LKML, not to initramfs@vger.kernel.org . As you can
see here: https://lore.kernel.org/initramfs/ , new discussions are
started nearly once a month at initramfs@vger.kernel.org , so I think
very few people will see your message.

Ask me any questions.

-- 
Askar Safin

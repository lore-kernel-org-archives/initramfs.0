From: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut 005 question
Date: Tue, 15 Mar 2011 09:25:06 +0000
Message-ID: <AANLkTik9Q+ga+nvjawVOc4gYdHohwwEN7FYC02Kdmi4H@mail.gmail.com>
References: <AANLkTimG_vvX-qDQ7+hUA7LjrWBmJU6uA1OY0ZHMA+VG@mail.gmail.com>
	<AANLkTikhgLdM_x_UHgCDQYqD=ekVE2G+aY+YNyuwXD75@mail.gmail.com>
	<1300101485-sup-8139@ittemni>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=fIMAKNjvuGQf7lAYTTA/UCWOum2WcMeSKIGG8nVwwGk=;
        b=JhxXN13MpGZ1D0LNkJ1dwf64Jzi9qjI4BUC1Mg9FFeYro9kYddLU3ktqjP2K7Fjva2
         TGjkbDUN+7bf93Rsh33H4f0RHmQOITBeULI5mzaMBxilMqcKzdOqXfGXw4A2KSPJ+qhb
         J3EQF7NVFURU87E3RQ9edsLeEB+TfuC2/Lx18=
In-Reply-To: <1300101485-sup-8139@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi guys,

Let me tell you what I want to achieve here - I have a host with
several luks partitions using the same key and I want them to be
unlocked by plugging USB stick with the key during the boot and not
typing the key via the keyboard at any stage.

I managed to install F14 with dracut-006-6.fc14 and I configured
second key and I assumed it will work. But it didn't. To my surpsire I
do not see rd_LUKS_KEYDEV_UUID anywhere in the 90crypt/* folder. I
searched whole modules.d and I did not find it either. So it looks to
me this version of dracut actually dropped support of key on external
device entirely?

What I would like to do now is to install dracut 008 (or the latest
version) in my F14 and try my USB key with it. I checked dracut 006
has dependency on plymouth-scripts, can you please advise me if it is
the same for dracut 008? Do I have to install latests plymouth-scripts
or is it optional?
And can you please give me any hint what is the best way of upgrade
from 006 to the latest one?

Thank you very much,

Jaiv

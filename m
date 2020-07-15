From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Default initramfs location
Date: Wed, 15 Jul 2020 07:52:57 +0300
Message-ID: <85069822-cd21-f11a-58ba-04526f5b48f8@gmail.com>
References: <rektsp$17oq$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qCCN3xAOcF0bbgAOTv+jOoRN4ZXiaYfGrFMHU0i8zOQ=;
        b=ZQkBB1B/S6R2YQwPH3HS7Uss5/TtSrJDzMOLAeHx0uceLGtBjgE1WuP/fL9DEeAoEm
         wRszT9SIvIt4rHmpT4xo43NMBl9cAT55Ktx7h3vEZ4iVHh7cabePxDtHBDxpxgdK9OZY
         QuzBSvqE1HgKRcjuFNmJY7qhKayqMFYPDTnWAfsFdL9FNWbRMH8LPECMQ9pkxLZqfdrS
         w/yr+aPnUO8q+XeRgTGfShNExuaIGVZjsp/IPDFeZ3l/pKLec03/EW9XIq4VlP1e0whV
         bS7dSo+y/CowNrfOs7BdujgmVWppW9oTRLD0zgNJ6rKAPDMC9Eyo16z4ch5lk7U9vOEd
         AOyA==
In-Reply-To: <rektsp$17oq$1@ciao.gmane.io>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Pilcher <arequipeno-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

14.07.2020 21:35, Ian Pilcher пишет:
> I've recently migrated one of my systems from GRUB to systemd-boot.  As
> a result my initramfs is no longer at /boot/initramfs-$(uname -r).img.
> 
> Instead, it is at /efi/$(cat /etc/machine-id)/$(uname -r)/initrd.
> 
> dracut is still using the old location by default.  (For example, if I
> rebuild the initramfs with 'dracut -f', dracut writes the new file at
> it's "traditional" location under /boot.)
> 
> Is there a configuration option that I can set to make dracut use the
> systemd-boot location (or some other way to do it)?
> 
> Thanks!
> 

If you use --uefi parameter dracut defaults to
\EFI\Linux\linix-$kernel-$MACHINE_ID-$BUILD_ID.efi (where BUILD_ID is
from /etc/os-release if present).

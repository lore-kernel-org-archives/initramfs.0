Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52037D127
	for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887898; cv=pass; b=dliThOwVpY2i1VoIWjPfXloowS7bXe1erMugLsIhVHGz4ElnPWVPN647QEjaCd82+HT2egKE9Y/ZDvRsB1FxXMBRuHFlKhhba+WNMBoqtxuTzdiTcQgXT+44vKtE7ltnN069wnWN3+RwMmqo6MAYGG+TT2nXaRVl8Hu7fFavhy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887898; c=relaxed/simple;
	bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+lv2esN5vGk1HfruGuzrnkiqPMHCTbjkdZ6XScqHl99AYm6GhDPs6HEu3VanQNdPL1zAtV+6AOXnIV4UliFKvOgfs7n+KV9kiXooutdSa4OamLJqio0ODyqiREJKTtE0vVh8NTKEYGI33Y+gZVJ2yA0v0DCCAZOsd01bfItGcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrAAB+3k; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrAAB+3k"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7947cf097c1so44869477b3.2
        for <initramfs@vger.kernel.org>; Mon, 23 Feb 2026 15:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771887896; cv=none;
        d=google.com; s=arc-20240605;
        b=Wnic9dbYeiJEx/lC3EhbSBEiapad4vjL0XiSRNvomE4RgceeeF6cyEkpN5FlS0w9ww
         zJSN9UagJBfcKrMHKC46jE5c3qqQWUwGNYGDFM37+Hta2WIIIE4c5qHp0/bQj8wew6UG
         +WJJPvSib5hdte5qTsXuMQzRUh8NBevuj8VyKnMEEnEK61SN4oDe+2OGonoheOulrMAS
         +ZqPVBSVkIObs+1g7UE+kzH88lj6g6TfrQxMYHQU6gogpzhfR6kKhQyza8hqW7ypZsI0
         PSlgPROQAaNI3ORnVmAwsGCgU68UvGKg+2w3nmrJnW7xvlrtYekPfL2d84zWWBWGNP5x
         sGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
        fh=JRcagYCfNAvArzTVqrNaKasQ8mdwoGwc2PoYVVx4mpM=;
        b=BSECR1VcL83PJjRa0edSwaFMTjJRMNbN51ByDGwGJv+GdEK3kXJdTp/zljkEOEkaWj
         IhgMt3TeFIh86x6323F5T2n9P+LApnjDr3xX9/6mcjXPPAFC7u3BzippBs2vK2QrtWCP
         q75eyetGWABgvJF3/atHNky43upp0UZj2m1myKP2KJ2qoz6CrN9J8pCZD24kgC1kpi1A
         PS2ryFiMr5awcqug4/XNiT4ttiibeyI/zoa4QcoS6s6U6GT1d9qw4Owbxbc/UZWmOdZe
         dmcXZDi5D/ntJ09kQ0bMJjQpk2Gxkm3t9GZF9Ccwtrt0kyyluGTjZO3t11uJuatoXK1g
         0U1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771887896; x=1772492696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
        b=DrAAB+3krUOPSUGm37lQQJkEE9HoTlGF/HbNs4GdWUTZ4X3lXfQHENhFxfKUwTqVJL
         4qeJbAIIy9RrdZgTqqPlnRE5+VUa+kwk97S8W3i5mryiRtrHkoyr1WORYyrUv5za3fcP
         HSYlTgpFgrOrezAPiqjcfLlRqrwFOtQs82Dd/gT/gqDPupCekCkXs6vq6jiYIZ+SUf17
         4PmtxsVvStJGhcGZh/PwkwWNH1erbD2wZRLF86q/Q3A7tOaieEfIlrVloBDA2jKBbQ+4
         w0Fvmnd1XbjXStYEF4cDYW6VHqq55y1hnVpIYnQk8DXjaVET632P7JBM1bwSEbb9YNC8
         TxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887896; x=1772492696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
        b=Mg+yQEU9BHp3075HjQq/PEMLOV5nL2xLKIJxFVXBINMCnQr7LozUU9SZlHyfeBM4/Z
         /pGXYyr7vh8vnGF7pnqRdPsEEm0w66CuWc8hUw5UQ3F9+XiO3dMBlMW2znW3CojXeTll
         /zOxIvq3B/+wzgS2Gs11kz6A5tl54tbg4rhb3bpRwkqM40koSXI4rXEhYBl9+3Lb595Q
         HjLVyznXJj1hl5j99+u3c82i5CU/2TS9R7DomZ4iLvVmCu2j/czctZSwxOMJkk8uxk8W
         G8BuAFHcV7nRBUFwupH6H12tyybpSzQ3YYFyJ467CuoayXXb+OztSZWUe4nAfuq3z97S
         TSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU4IleubQ6MRBgrRBSuuZWbPCm8MOYj9203+wail8CSfUTyqK7/G5aFaq13ysY4kUFxLeDTRjkfDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhrj3ot4fxNeLoS0OAj4pstATGZWJT7AzNK/wj2ceJaWgKAHU
	f5ExNGutHYLa7JCI9X/GlCVN6pZpvZLh8pk9dfHo7JD+HqyNmwVVd46BMqsNcKbPMGP6Cxoh6F+
	sDgkRpODOYAOknAlExGQj6PsmZfFOuEU=
X-Gm-Gg: ATEYQzxHO4N4/bWen4du/E4Vi+P44wIu8/Y5VvdnEfuZ2CWsmQRU0w4TOV9ffCk5yjz
	4nT8hET1AcvFblnYKRESwvWvvIOcXZsbF1QM/FRPx3dD0OykkG0vIYhOvqZfSC/XsM+jeC1rKXC
	IZz2mOmtX7DlknqriRlLFWpNnh4UkTag1KEZigURlQkc9jSxJHPA7dZ12Md2r+TNsGznsi63WCp
	PkB4InuI/BhZDEpNODDoOf5klHWLo1aAJ+tbPd/tEc0BZ/bTB2DiqjFHZYcBdUlduuVWggx961T
	CNAF3WA=
X-Received: by 2002:a05:690c:f09:b0:798:5333:ce36 with SMTP id
 00721157ae682-7985333d4f3mr19166357b3.7.1771887895866; Mon, 23 Feb 2026
 15:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-2-safinaskar@gmail.com> <20260220105913.4b62e124.ddiss@suse.de>
 <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
In-Reply-To: <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 24 Feb 2026 02:04:19 +0300
X-Gm-Features: AaiRm51ShYWisRZxqEP2jfYkn9npSVqKeCstRJL8gtXtjrs-RidKNfYk8lXIBQs
Message-ID: <CAPnZJGDDonspVK1WxDac2omkLJVX=_1Tybn4ne+sf3KyaAuofA@mail.gmail.com>
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: Rob Landley <rob@landley.net>
Cc: David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rob, I THINK I KNOW HOW TO SOLVE YOUR PROBLEM! (See below.)

On Mon, Feb 23, 2026 at 4:27=E2=80=AFAM Rob Landley <rob@landley.net> wrote=
:
>
> On 2/19/26 17:59, David Disseldorp wrote:
> >> This problem can be solved by using gen_init_cpio.

I said this, not David.

> It used to work, then they broke it. (See below.)

So you have a directory with rootfs, and you want to add /dev/console
to it? Do I understand your problem correctly?

This is how you can solve it.

Option 1 (recommended).

Let's assume you have your rootfs in a directory /tmp/rootfs . Then
create /tmp/cplist with:

dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1

And add this to your config:

CONFIG_INITRAMFS_SOURCE=3D"/tmp/rootfs /tmp/cplist"

This will create builtin initramfs with contents of /tmp/rootfs AND
nodes from /tmp/cplist
(i. e. /dev/console).

This will work, I just checked it.
No need to build the kernel twice.
Does this solve your problem?

Option 2.
Alternatively (assuming you already built gen_init_cpio) you can
create cpio with /dev/console using gen_init_cpio and then
concatenate it with cpio archive with your rootfs.

Unfortunately, this may require building the kernel twice, as I
explained in my previous letter in this thread. But this option
is still doable.

Option 3.
Yet another way: run

usr/gen_initramfs.sh /tmp/rootfs /tmp/cplist > some-output.cpio

(again, here /tmp/rootfs is a directory with your rootfs and
/tmp/cplist is a list of nodes.)

Unfortunately, this requires gen_init_cpio to be present, so, again,
similarly to option 2, this may require building the kernel twice.
But, again, this is doable.

In fact, gen_initramfs.sh accepts same options as CONFIG_INITRAMFS_SOURCE,
this is explained in
https://elixir.bootlin.com/linux/v6.19/source/Documentation/driver-api/earl=
y-userspace/early_userspace_support.rst#L70
.

Conclusion.
As I said, option 1 is the best in my opinion. It does not require
building the kernel twice,
and, as well as I understand, fully solves your problem.

If I miss something, please, tell me this.

I really want to help you, Rob.
I sent this patch, because I want to help you.

--=20
Askar Safin

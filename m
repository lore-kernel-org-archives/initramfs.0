Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05B2FF16B
	for <initramfs@vger.kernel.org>; Mon, 13 Oct 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351387; cv=none; b=CHT9JuJ8jahLlO6X26XIy44ikMpGO5vfbxmJHCXVNG0VUbvKDS+QKXjj53xn66Q9z941WUAKagoKAK2sVUsqUIhf/wEbB4+rgcR6dblYuHkJIUW0gFm5s30MF9daoKBxZfZSbZ7V8OSPbVHGdvPUq1NdPuveDHp2s9pUP9m1Kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351387; c=relaxed/simple;
	bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pfo3tZqkyF/aUv1v53ociPMA8+KLqSzaI9jJtTIFRXgsxnypfNg/V52l5J73RiRn53xiSuHuRZ9VubtaQsW2oNaTpC7K7guP05r9A3krRBj5yenzjCmo8Fm5DOrfcc5dI6x0FVNz8neRQx0kyaqM59+PqZCaY+H3JivMLVBMzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIQhb/oU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIQhb/oU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d6014810fso39067107b3.0
        for <initramfs@vger.kernel.org>; Mon, 13 Oct 2025 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760351384; x=1760956184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=ZIQhb/oUlO3F9MEPUxurf/mgWI7Y1g8uHfT6SNbxuv/4xY5+m/YraZW/5KqmjRIwzX
         rdTRUXUR5ZYcRqHAcjEXbyqp9QPzrQjcU/+tE2lLY7zsYf9eKvPgMh7Yb+eG+DeMYl1A
         NNkv7u+ELQLfd91UVqU5n/EDVbx6VQywzqTdWGNVo8cwyfdUj0VZFPUXp9En5uePFJsJ
         B8tJ7rKH5YlpW+Pq8nGhj+PB2fjPaXocpEbEosY0ETAXl+QzWKYisCRZclqHs3mpy0wb
         S17h9fT1i/DEuznIcB2PXT67kVi/TGa5zjTd/jM4v9YckG+ajQAB0eFRwEULsu95liHd
         eM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351384; x=1760956184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=OSwgkqVR+aEjQrEPH2NVmiZldujcR97XhGBPyHccDlyafRd9DmqOCicca9IY3O7a4G
         fyeeY5E83HLK16hWy1QqA/zY1dLVlJ8edFKKTOiNxZW2K/ZvV4/5eHpB2SSkD5ESgP0g
         vyCsXRXWGq1YRN9z8ltnxu1aOwKglPGrkwOjhEH2pNVXKkoFoiSmoypFR/NUvGPtAzfm
         sQSIKqP2b6GGSSurU3os8W1fTOQTVbkrXPd9S2cpv95oZfob7hsFmnvoGCaYglXGTd9K
         yIuLUbCptL+pPHFRuMf3bXP19/29hHMz1EIVniaBKD19sJI0oghgD/VPpSjPiCo2ezbH
         gANg==
X-Forwarded-Encrypted: i=1; AJvYcCX3E0wmiuBDK/h+svPL4hn0bvbny6wV2jDvg6iFYD6ZPKb8Uxrc4aiHm/iIPJ7Fwmdp03i2RfG336c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0JbHSOyuziMO0sizEavaj2PIpC7hcu7c7c7uvUcf20OICz3e
	IH6qzOtVC8+DZDoz/0z0Nx6jtPLFvRYYOHAIyzVu+P/mZ0XgxNX6pcVfdjH0eSrLOHFGfGvIzXI
	kwqc445Y7AD0gdVY+GGXjp1P73+LE72M=
X-Gm-Gg: ASbGncus321KZk7ixk4dv7RH335jv7Cl9LpjsrKzkR6MANJiXm6R6lhI//YNc1OHTxK
	96mDpM+18U0+oWbwoII8DATaA3bxShkkxWNI/2Q+M1VhP3oUZdYPLtD30XtWYB9CyI+PlhxJcOE
	1/wDgl0Qw5xbI4YHbfgrItO41K3ERz82/xNKA03SCdfib7DUyi/+h27aDm3ejQByBt55oVPyV7f
	Ah6DZYtxn+B6aNmFzpkw3IIQbW+xWKx9AHZ
X-Google-Smtp-Source: AGHT+IF7gB/uIYJ4y7t+OLiZ00mCO9lllMt+QoIyqpZ385m2NgZqSy+lqlMIQpqL29tGtjodZ9h+RUr8WRjGSui6l/0=
X-Received: by 2002:a05:690e:4186:b0:63c:f5a6:f2f0 with SMTP id
 956f58d0204a3-63cf5a7080fmr6997775d50.66.1760351383745; Mon, 13 Oct 2025
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com> <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
In-Reply-To: <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 13:29:07 +0300
X-Gm-Features: AS18NWAYGkNu7BjeCT0jHGno_eA5ARoSWF2j7yYdLIuVOnrJP74yF3CsWnjM_B4
Message-ID: <CAPnZJGDe+sDCsCngHyF6+=3=A9pYwQ1+N87jpq-ZdsSvVbQuNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> There are more places in Documentation/ that refer to "linuxrc".
> Should those also be removed or fixed?
>
> accounting/delay-accounting.rst
> admin-guide/initrd.rst
> driver-api/early-userspace/early_userspace_support.rst
> power/swsusp-dmcrypt.rst
> translations/zh_CN/accounting/delay-accounting.rst

Yes, they should be removed.
I made this patchset minimal to be sure it is easy to revert.
I will remove these linuxrc mentions in cleanup patchset.

--=20
Askar Safin

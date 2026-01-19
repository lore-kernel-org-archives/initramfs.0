Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245953904C0
	for <initramfs@vger.kernel.org>; Mon, 19 Jan 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849536; cv=pass; b=g1dTK2BcIQlxH3NYq77c1YzoOMhZLYEceXGYiTweXB4N5v9PltQcBGYXA2y9B37uk2losMbzPrzjpISGEK0cKMyZqMhglRK3/lAyZ5s9HPNyjsHQ2/bwdYcTSmgrLQKmlg3obgAyD8iO0QdV1pAjsnIodF3Sl87tkwJmeoMH5Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849536; c=relaxed/simple;
	bh=/ce3dudxc2POARZLcfse5sBstVqNXvQFSe7cYp3NGco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/UZ/PFig4bxE1oNQ5szyUHzcJUUCqtHPDd9nMLmMaBFN8+J3dCYpM8t+T+ehrbB/qGDYt2wgJeJhh9EGeiMyMLhbxEgImJq2mld+NzBE3ma+yeFSJT88fpWfuK44FNGLPUncOg9FfLnSguuqbBqXI/nNeFoil3WPmfawgp8vyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=ZLCChveB; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="ZLCChveB"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-382fb2bb83dso24167261fa.1
        for <initramfs@vger.kernel.org>; Mon, 19 Jan 2026 11:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768849526; cv=none;
        d=google.com; s=arc-20240605;
        b=j/w9Cz+wIR1jGxs6IlfdhUdXwFSas7NCjNMzW0v/VtcioEuz7xgd+zTzX7HAeAKe8o
         E0pYem5jKTqbMuUAqLNtHI5aAIg9BzNcCG6Lt+o25T0XLdSciNIhmJ/Yk0CAkz23MduY
         DEslref5KW/dZyaps0jdBkm9/18XKcKfDgOmcy8FMeoCbo1rz6EAKl4rwhmMTRDguXpS
         snPL1Luu9wQQthfl3pAg3/PAbejYedtbfU1kxslowyCVPFckt3uUYJmkbqe4dQ6Eq2kd
         /WcSCj4KPdHzBp0E+kEyFkdnjgQ0XGwxh/LbiDof9A8pAtKYGIW+T1A6cEELjlBx0lLP
         OnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        fh=82S1bbnBwHUtuP7S6uU58ug/pvRlfjwAIxjDwWt8zbM=;
        b=bmyTuDYbjOJFD0pb6hgc49JoMoQZGxB7z7gABNy+jUESQgJYXOeaJMBmtCRLXqxjWq
         R+PAIlxl04VjKIqo15WFRl1MJ5x4GezekSsnSl6OyOiLCNHULDvHwqFn1wGlv1qln7b0
         tUMiKYUldgUONTJw80BtiOxiPbHxoAeg3ShlxsVL/iprkJKyDF9IpeXxCAuvgxHJk0lA
         ta97AgvAzncNfzqLqm2xn9chNIo+LVOeDp2DuT57c1qSDEt6I9IF5CosJOmkDJjTr+AY
         LrossbfeH4iYRfvq6xQphetzuY6g/275U1/ldH40nC/ZygU63qlA66aztrz6xD6bfCye
         ppzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1768849526; x=1769454326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        b=ZLCChveBpdWvmIIICTa6S/fc053UxqrmmgURpdZW4LIFa5kVxRtc9VCz7L9Hft9W42
         /XusbZMRQfSJ/+Zk3bm2qmindiU2KL9Vu5aPbKqode4lTBaRrDFuAlRnhroW+TlWqM1A
         w0/KsiQaEic9f+uvYLWwMN5rvaUDBEobMpjIQW6qfZGoxDEoDwJ76XMH5t4z2OLugh+p
         SMRz4F+sLSz51Mzt3h7BXK9cogEQyp9VwwFBdyUg9DnL1o7/Z5SUs+zwlghLOEv/Mhkb
         BqP7H7D4lAyKvP1aCfgWXICvg+iUaCT1iswB08UEggCCUa0XLsvLiMMjs5T/RH6SL7hC
         jsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849526; x=1769454326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        b=WLvJdPzJQ3YDBuIInrLgBjLi/NAtVzU/0aqL1dkZ+Cgwn6LrQKATiXqSFgKasUlb6y
         jQpJ8r2XakCsvfOPw0Pi5EJdC1cJY36uMBBPqxr7v5p3NFpCKcTfZGqtVnrLBj6Wr3HK
         2GOKieSHAm5GhfPgBV1T4p1lv15FOUYXux6Ib1/8ZtnIuENfjV+lqOfNk0SefP2f9H8h
         O4/L7YJlOFgbY+ufQ1yzdyWKYjLhttuRmd/h29dDow1OJ3UXFJfGjBQqqMudGa+QpQ8m
         v0wKUdEtVL8yZLXgMDrZuehS8/Jy1TKiZy+dlRg3OXiFqMem1OUYmtD9rAHa4/X9+7bc
         +SBw==
X-Forwarded-Encrypted: i=1; AJvYcCV6sZffNaL9VeuObHF1hcSV4zkFRGhfaCOpdYxQ60Y+NlBbyLSmv9DQxGE4ZdIi6kXXslMlOde0Hng=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/Czlxpnm8MUU/MdZhX3ssu5rhKYW8+zjgWWPwvZTNPMSOfWs
	zXxkD+G2KYywEd5jACCivvhpu9g+z65xKFBZS8I7PMPV/gOqEUHP3pY7Arvsh+icBDWCuDMAJeN
	QsgO2nt7PWq+48/0QCujf7u1UXG/d3wrgyC2EuhZd
X-Gm-Gg: AY/fxX589QEsyUgw/4cm1wOOhMRmw4UsX/cevlklXtuS4oX0OlBXcWIGHKWC90hhdxE
	Eq9n3/zOoIQY8iOKIT/ohU6+qyfcddc/EVJc+/X6/Drshh+FnQLtdlmueAa8jFOxbpythu6qtcj
	O3m2fyRtvhGbQFT7E2UakApDebEoCkWStPEqTMWAj8wkhUR8p2sxTTUrGcGt+yQZR9IhsA8rER8
	1vTk7FRavYRu8C8PJm4WaXRtpHiZeKa0LES263rmHhd5yd3lZOIkTxCvalrc0XegPUr
X-Received: by 2002:a05:6512:3c95:b0:599:289c:67b with SMTP id
 2adb3069b0e04-59baeeadbc3mr4115534e87.21.1768849526113; Mon, 19 Jan 2026
 11:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org> <20260119171101.3215697-1-safinaskar@gmail.com>
In-Reply-To: <20260119171101.3215697-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 19 Jan 2026 11:05:14 -0800
X-Gm-Features: AZwV_Qi9RyaiB91QL-WyEcAJf4X_KdMWwLXZLw6yqaw5pxCOP4suRdhto2Jp-kE
Message-ID: <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, amir73il@gmail.com, cyphar@cyphar.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Lennart Poettering <mzxreary@0pointer.de>, 
	David Howells <dhowells@redhat.com>, Zhang Yunkai <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, emily@redcoat.dev, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:56=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Christian Brauner <brauner@kernel.org>:
> > Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> > OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> > returning a file descriptor referring to that mount tree
> > OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> > to a new mount namespace. In that new mount namespace the copied mount
> > tree has been mounted on top of a copy of the real rootfs.
>
> I want to point at security benefits of this.
>
> [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
> I like them, and I think they should get wider exposure. ]]
>
> If this patchset ([1]) and [2] both land (they are both in "next" now and
> likely will be submitted to mainline soon) and "nullfs_rootfs" is passed =
on
> command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPA=
CE) will
> usually contain exactly 2 mounts: nullfs and whatever was passed to
> open_tree(OPEN_TREE_NAMESPACE).
>
> This means that even if attacker somehow is able to unmount its root and
> get access to underlying mounts, then the only underlying thing they will
> get is nullfs.
>
> Also this means that other mounts are not only hidden in new namespace, t=
hey
> are fully absent. This prevents attacks discussed here: [3], [4].
>
> Also this means that (assuming we have both [1] and [2] and "nullfs_rootf=
s"
> is passed), there is no anymore hidden writable mount shared by all conta=
iners,
> potentially available to attackers. This is concern raised in [5]:
>
> > You want rootfs to be a NULLFS instead of ramfs. You don't seem to want=
 it to
> > actually _be_ a filesystem. Even with your "fix", containers could comm=
unicate
> > with each _other_ through it if it becomes accessible. If a container c=
an get
> > access to an empty initramfs and write into it, it can ask/answer the q=
uestion
> > "Are there any other containers on this machine running stux24" and the=
n coordinate.

I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
path that gives it sensible behavior should be conditional like this.
Either make it *always* mount on top of nullfs (regardless of boot
options) or find some way to have it actually be the root.  I assume
the latter is challenging for some reason.

--Andy

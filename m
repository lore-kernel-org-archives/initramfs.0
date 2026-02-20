Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F62ECEA5
	for <initramfs@vger.kernel.org>; Fri, 20 Feb 2026 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614720; cv=none; b=TxUX7AUgfMyWRwNhrevZoOQk95IkaSiffU6/E+YzMor2NiNeWEobFa+Py+TorcLbeKInQ3hPH6JbFhYw8Vo3cJmIwGt1vltS+xufb386zxgx9NKqM8iosKFhrFakBlA4R2PsBlfMfgomkAV1zQ6Zc7q3CRKqfHIdjw+vWjOyNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614720; c=relaxed/simple;
	bh=M8P+BbQ1YqZa4ng6H3k/8o1frpPX12XdeZj5ECuK2xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EonPwaibYzCA5pzfvFc4xPmDDvF4F86UJ7VU+Yyt5Y6YtKRUgNKL9+UATaJZ9v6IqS+g+jSL8QPeAnL05ht+uWlkwqZYtbACz6qlwvsUm5QjfsguMQwQvU0IyDizjmFG4o6OlHc3IBzhLYEqK+jlvJ90xWmTIErumJI68ZGRIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeURJjEP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeURJjEP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso26970955e9.0
        for <initramfs@vger.kernel.org>; Fri, 20 Feb 2026 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771614718; x=1772219518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp4Hmr4tnrGJtnxnP1S6eBYh/Nilm6oZrfuoKYFMN2U=;
        b=XeURJjEPAhhsPz8gwaYzwl8B171cOhVK1QrAju+c45qH0I/E7RF3hSgmwVhCgw/g7R
         umW/c8CcInLV7DGnspPCOzaZh8IlctKLK3xx/VR+79sYJnswdy6HNXQUdbreUWw9kYzA
         YsgRq/9UvZWYPx7n2DodWrNIDXDUUVrjU9Q7xnNPy6vzdjiiQP5jIEl00rO+sLebmlum
         FmYrYuWL6Ia/4QWgk2+woZvH2hLL62go09TzukFizZbP/46i1WigYjU+7KI0zSriFcwx
         wGwy0CTwl8bYLKZYNWzNOdm76rNcL2IHp9IAYOwMh8lc+NqpgU/BllAuYibUnsTebnwx
         wwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771614718; x=1772219518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zp4Hmr4tnrGJtnxnP1S6eBYh/Nilm6oZrfuoKYFMN2U=;
        b=Lsaop2f2BVwSwQt/j//onxO09a3FSmDphjRFAyXfgkAo+ASLcoFGMLpPCHpmLP1LWD
         qAGDF0H3T89PTAy8WCw6uUBeXdpb4V/9OAxI/taDsCj9QL/4ttxxBwxobDn/O9KjmEH9
         gM8G2RW2DUItLzIOgkUo0EOJsT27mwqzb8Os472X9K1q91fb5Vk1m6civ3F6QPQ+jZ/Z
         bBxde266LtlHgCPa1bpcllfX2SEOkqid70Nz+0lUvdAkSGloNHko8PlaivPS7F6s1fe6
         f3+EvLigZ0ApYXs2Mf6sEhWNDsjxfGGhJtHXFDmlpw47+4xe95pgtVxoolq4kOe6MNnn
         ba6w==
X-Forwarded-Encrypted: i=1; AJvYcCXjY0n9TkcLOnGj1Et59nnby+aTrcasCZaMNfznc6dPph1Jrx03E5kiqN3pIwiHMNySnkO+XLIfRfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KazXAVJCBOu2CFikziAGP8Zy0hHVW0oYlN/1s3a75uBGNi7M
	ku6zvhtHBxQ+QZ2ZY3Ji2cYLH5kVA3J83m/DGdQiGbgJwRpsWvIf4cLn
X-Gm-Gg: AZuq6aJ3KdNvOzzGYtDc/cy4WBucrWyrnLPxzIb4zry8jszgk+9ELrSuyiwfWSDmVKl
	nbnD69JVsK+aiI+CTUJKrUV6cDEzLB0JBYcCf2hAu9VG5rgqIY1IsieBnsoNUVKMMDnSM3t/TIp
	oa2j5QwwKZ839RXygMReGZfd73809gKX/15JSgcQHFvkk63K36BMBUEJz0aNdPGThsHWw9mZ+Xp
	F7F5wkqbKNOQi877OF9qz+l9dz7LvTnCURpi5GANeff+lk1LSF4wli3YdyOKJQ9lugbaPxLBbT8
	wdhycB2Ydp4xbbH8g5qHoHduz8YboJWXOxx0LZn+Q1uUCzQHni+1EuHve7Mvb/f4qsygxi1RviM
	touvKXmxN9L9jz9j/lrlLDs4BwX3aaw442rtc5+YOVY7PMKp6qW9xtcSGVc8jBjfO3YZ5KuK/kF
	KOHAhgycrH6H1/N0ypoEUiqMcOt7cBog==
X-Received: by 2002:a05:600c:3516:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-483a9637590mr8799125e9.26.1771614717583;
        Fri, 20 Feb 2026 11:11:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a9b21ceasm3704985e9.0.2026.02.20.11.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 11:11:56 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: ddiss@suse.de
Cc: brauner@kernel.org,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	rob@landley.net,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always available in initramfs
Date: Fri, 20 Feb 2026 22:11:50 +0300
Message-ID: <20260220191150.244006-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220105913.4b62e124.ddiss@suse.de>
References: <20260220105913.4b62e124.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

David Disseldorp <ddiss@suse.de>:
> I'd prefer not to go down this path:
> - I think it's reasonable to expect that users who override the default
>   internal initramfs know what they're doing WRT /dev/console creation.
> - initramfs can be made up of concatenated cpio archives, so tools which
>   insist on using GNU cpio and run into mknod EPERM issues could append
>   the nodes via gen_init_cpio, while continuing to use GNU cpio for
>   everything else.

This cannot be done in proper way.

Let's assume we want to build *builtin* initramfs using GNU cpio and
then concatenate to it an archive made by gen_init_cpio.

Then we want CONFIG_INITRAMFS_SOURCE to accept already existing cpio
archive AND file in gen_init_cpio format. But, according to
CONFIG_INITRAMFS_SOURCE docs in usr/Kconfig, this is not possible
(I didn't check whether this is true, I just have read the docs.)

This means that we should do this:

1. Generate an archive by invoking gen_init_cpio and concatenate it to
our preexisting archive
2. Create kernel config, while specifying resulting archive in
CONFIG_INITRAMFS_SOURCE
3. Build the kernel

Unfortunately, this will not work, because to invoke gen_init_cpio you
should build it first. And you cannot build it if there is no config
(I checked this).

So, we should do this:

1. Create kernel config, while specifying an archive in
CONFIG_INITRAMFS_SOURCE, which *DOES NOT EXISTS YET*
2. Build gen_init_cpio by invoking "make usr/gen_init_cpio"
3. Create an archive by invoking gen_init_cpio and concatenate it to
our preexisting archive. Put resulting archive to the path specified in
CONFIG_INITRAMFS_SOURCE
4. Build the kernel

Unfortunately, this will not work, either, because command
"make usr/gen_init_cpio" doesn't work in clean kernel tree even if
config exists (I checked this).

This means that the only remaining way is this:

1. Create *fake* kernel config
2. Build whole kernel (!!!)
3. Create an archive by invoking gen_init_cpio and concatenate it to
our preexisting archive
4. Create config, this time for real. Specify archive created in previous
step as CONFIG_INITRAMFS_SOURCE
5. Build the kernel, this time for real

I hope you agree that this is totally insane.

So, there is no proper way to create builtin initramfs by concatenating
archives created by GNU cpio and gen_init_cpio.

I think this is a bug in kbuild, and it probably needs to be fixed.

But I think that my patchset is a better approach. My patchset simply
ensures that /dev/console and /dev/null are always available, no matter
what. And thus my patchset side steps the whole issue.

Here are additional arguments in favor of my patchset.

* The kernel itself relies on presence of /dev/console in console_on_rootfs.
There is even comment there that currently says that opening of /dev/console
should never fail. (The comment is wrong, and this patchset fixes it.) So, if you
happen to supply builtin initramfs without /dev/console, then you will
build kernel, which violates its own assumptions. This will not be
detected until we actually try to boot the kernel. And even then it will
be hard to understand what exactly went wrong.

Why should we allow this failure mode? Let's instead ensure that this will
never happen. I. e. let's make sure that the kernel's asssumptions are always
true!

* My patchset makes the kernel not more complex, but more simple!
(28 insertions(+), 33 deletions(-).) Moreover, my patchset makes it
simpler not only in LoC sense, but in conceptual sense, too!
Currently codes in usr/default_cpio_list and init/noinitramfs.c are
very similar. It is possible that they will be out of sync in
some point of future.

By the way, noticing that they are out of sync is *very* hard. Consider
this scenario: usr/default_cpio_list contains this line:

nod /dev/null 0666 0 0 c 1 3

and init/noinitramfs.c contains this line:

init_mknod("/dev/null", S_IFCHR | 0666,
                        new_encode_dev(MKDEV(1, 3)));

Are these lines equivalent? You may think they are, but they are not.

init_mknod function above in fact creates node with different rights
due to umask of kernel thread. (And thus unprivileged users will be unable
to write to /dev/null...)

My patchset merges both codes into a single helper, thus making sure they
will never be out of sync. And thus my patchset reduces complexity of
the kernel.

* Currently it is okay not to put /dev/console to external initramfs.
But it is not okay not to put it to builtin initramfs. Why creating
builtin initramfs is harder than creating external initramfs? Why we make
lifes of developers in one of these cases harder without any reason?

Consider this scenario: somebody built kernel and external initramfs.
Everything works. Now they make this initramfs to be builtin.
Of course, they expect that everything will continue to work as before.
But it doesn't work. PID 1 doesn't print anything to console,
and you cannot even debug this, because it doesn't print anything to
console and you cannot see your debug printfs!

This clearly violates principle of least surprise.

-- 
Askar Safin

Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAD38B7AF
	for <initramfs@vger.kernel.org>; Mon, 19 Jan 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848589; cv=none; b=eyCrHHWkdnixoUDyBpqi4OAlxaxIJ3qKTt6wiPUcs7TAiOVidaP4hAUJDH1obCFfgIdZgjMZSQ+cm+LRVU2uqQy7qT/R0D2VDiF/uwfzUUa3JZKwJ/EJmQYFpNXQIspeujylhrq81XDez1CT/7WGWNiMdafIbSnjOyL9gnoZOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848589; c=relaxed/simple;
	bh=bI5IPQFJ+by3IIQyhZwdLpvLyRBSEgqkFjkzhjf0OBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF0ZH+6JIli+qK0ViLg5iRCX2oK/jH995MSSJJeh6j74Kkn0ztGPLx3Tthgan8gH/8TLAgwvnHGLXXGtFrFJYCC93h+QCcYbL+spEmhNbiW7EmZ1TMlnHbQ4LxxNluRSIAKZz0FbgubJWzQ/jWck6cd8TvJ5fZkCv2jM7JyQlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FELg4Mpz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FELg4Mpz"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so7627149a12.3
        for <initramfs@vger.kernel.org>; Mon, 19 Jan 2026 10:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768848586; x=1769453386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihXpfk6s5RJismx/mSJFIyW5r33kfZuDg7he69hJB7c=;
        b=FELg4MpzKcLb2656LriDD0XjcPIBv10DvQZuv4LI2+PgOUXoMYeK60mihQFtZuWNig
         tkkZnWqhNVq04sEZIDqref1BN/EMapQ/Bhg1j/s3mxwraR1UsIijhdVBP9/GTdE+i/Zq
         jSHlc8HQlQhSpWdjrAYHlKE7eYK6+S7zIcOed8sf8aR6mq8SMVlxGplm/SEphVquam+S
         3gDpU9/644zRsBqVRJpyuB6RW+Pc1018SI2J9g8cVnfI0Yjor0g0xNMlF9x4vfpsTies
         zWYHlFJR/54u30PUBdHeBaKHq1lGKqzhZLg5IBGj1DS5H2AEL0o8B7MolNGNJUeQvRll
         9GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768848586; x=1769453386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihXpfk6s5RJismx/mSJFIyW5r33kfZuDg7he69hJB7c=;
        b=kIJEd2CYNTzoQkPXGMzM8X5UmQqSOH80skocvpEVpZ+RKQCFy5n/bh+nCzDlFXbghI
         HDLBfN5M3H3ZP2nr7Abb8pJPDjpl/JxRvd2wWVTDQyKCMiA5EUF1TEiOzRFNOkU5Mm8e
         QS57rQJNhc+pJ6Ejmj+JI6u08n2h5XHUmEwtETOVQUmWzCVoCDPCUtu3/lZ0ID6Ysd5C
         wKyYrciQV6K5Os4JRZ6caap5/MngquF7OHu9OdXWMoWuHeJDUd/WmyztKz1Bhde2Nk5S
         VdHf9vwRmZ9DknyWbP79xSR7QY8gCjy57tbF8VB+HdPJPuIqs/r6lUO44S3ZSSIWxNY3
         BvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVd2klPH6mNLSNenyljSSJ2J9p9WVP9nh0yJH5m9Ru8119t6BKBQZ/Iye0IuD6GJiWN1cW5eznRcKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZD4GoQpc7MZn1WM+T5NRiI/z9FPQTCsVUY0cnQ7A6RfewfedX
	E9jZkWSQN5lxMD0g4vCL6tXEIa/9h3utxrYblZ2dEzTJi1i/pbkdiXBM6ZxDKA==
X-Gm-Gg: AZuq6aLwbI28a7BrUg25tkyiARAd3M17dPQFlzrZRm+LsKzlyvH1edTt/3GWaLLI1Ja
	H0IFt5zSjW2o9x/epJNHurDLyVbLcfpuWZvzVUXC51mVhlKVHYj/2tgA6Ksr8SqVrBxdrPqsE9q
	yOMClKZ1ZQECHmo25d3RyBjD61xYimb3RxgKPpmQO7JDcNlgUrO0MWsLeCDLFLO7vhKumFuJTvQ
	eroxMOxGJpcQnLxg7fOWlNM0k9jYAq8PDz4f6IISCKyrybmPkGe4PrQIhQnrh7B3gQMS0/7jAV9
	FdcDnhSdxMTf+aYvL5uXzoWuEl1FX3AR0NVXM+JT345i+9VZfbWWi668O+UXiBaTuM0OHaPPIWU
	GehY1j0BtWvVxWm4hRfa64mYUJjoijrxhFLizgGBUzmIoevDt5HmSnFQ2ysBPQwVQ8fW7gpkjEj
	iz9qS+uQk=
X-Received: by 2002:a05:6000:613:b0:432:586f:2ab9 with SMTP id ffacd0b85a97d-435699787cdmr17106815f8f.5.1768842854026;
        Mon, 19 Jan 2026 09:14:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43569922032sm25380858f8f.8.2026.01.19.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:14:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	cyphar@cyphar.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Lennart Poettering <mzxreary@0pointer.de>,
	David Howells <dhowells@redhat.com>,
	Zhang Yunkai <zhang.yunkai@zte.com.cn>,
	cgel.zte@gmail.com,
	Menglong Dong <menglong8.dong@gmail.com>,
	linux-kernel@vger.kernel.org,
	initramfs@vger.kernel.org,
	containers@lists.linux.dev,
	linux-api@vger.kernel.org,
	news@phoronix.com,
	lwn@lwn.net,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Landley <rob@landley.net>,
	emily@redcoat.dev,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Mon, 19 Jan 2026 20:11:01 +0300
Message-ID: <20260119171101.3215697-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> returning a file descriptor referring to that mount tree
> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> to a new mount namespace. In that new mount namespace the copied mount
> tree has been mounted on top of a copy of the real rootfs.

I want to point at security benefits of this.

[[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
I like them, and I think they should get wider exposure. ]]

If this patchset ([1]) and [2] both land (they are both in "next" now and
likely will be submitted to mainline soon) and "nullfs_rootfs" is passed on
command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPACE) will
usually contain exactly 2 mounts: nullfs and whatever was passed to
open_tree(OPEN_TREE_NAMESPACE).

This means that even if attacker somehow is able to unmount its root and
get access to underlying mounts, then the only underlying thing they will
get is nullfs.

Also this means that other mounts are not only hidden in new namespace, they
are fully absent. This prevents attacks discussed here: [3], [4].

Also this means that (assuming we have both [1] and [2] and "nullfs_rootfs"
is passed), there is no anymore hidden writable mount shared by all containers,
potentially available to attackers. This is concern raised in [5]:

> You want rootfs to be a NULLFS instead of ramfs. You don't seem to want it to
> actually _be_ a filesystem. Even with your "fix", containers could communicate
> with each _other_ through it if it becomes accessible. If a container can get
> access to an empty initramfs and write into it, it can ask/answer the question
> "Are there any other containers on this machine running stux24" and then coordinate.

Note: as well as I understand all actual security bugs are already fixed in kernel,
runc and similar tools. But still [1] and [2] reduce chances of similar bugs
in the future, and this is very good thing.

Also: [1] and [2] are pretty big changes to how mount namespaces work, so
I added more people and lists to CC.

This mail is answer to [1].

[1] https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
[2] https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

[3] https://lore.kernel.org/all/rxh6knvencwjajhgvdgzmrkwmyxwotu3itqyreun3h2pmaujhr@snhuqoq44kkf/
[4] https://github.com/opencontainers/runc/pull/1962
[5] https://lore.kernel.org/all/cec90924-e7ec-377c-fb02-e0f25ab9db73@landley.net/

-- 
Askar Safin

Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031E329E64
	for <initramfs@vger.kernel.org>; Wed, 21 Jan 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018436; cv=pass; b=krG1j4Hrnj9ShcZnqpIyptqn+JpoixU6RVyctYeiCTeOgsNONIbSdyE7ZrE3Z0y2tjfro4aNRetJwnc16w0x9cK/0qXj4I/j0ToNc3PUzqdhSCM4AleOlaX4F12tCLy87Lfq/L8+XqLc0xTuZuz9V/dmBu3jP/+SNubGY0I/jcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018436; c=relaxed/simple;
	bh=9fUfO4M1OR0hA17huHEVgs6JgJd2UYGS587dIvnVGRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgqgSRMlwEVNuSTddKjc3QxDgZ4GFq4JIuEABsI++1mV4wMMpAgSApZ34oKGoV8J8hmKf/Xw3w9fXicB+a9auv+ub/BaBYFllmpNkNeRobSOxp2DuG3MJe8AplL1UiI2DN8IDj5Qqr0rzQMhzlSNkC+TjqHbbvPtguBYYOUqgwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=pXK65Fml; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="pXK65Fml"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso64578e87.0
        for <initramfs@vger.kernel.org>; Wed, 21 Jan 2026 10:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018432; cv=none;
        d=google.com; s=arc-20240605;
        b=jPj1lS8EjRcL9SBm9qdEt0rZi4C8KImfBVfuy9nc8C69Imv77ooido+Y4bcOH8w9K+
         +gXr+ewpJJA/RaRLWu6jbg+PiDT+D+pz3cSAhFaWdo0i29DWGYknQ1oRV9asOBa+EkqN
         xybbem70ujfC8XPZ0Za1jogtzPYamiIxSieYS5hGtbT9NQTrc5n8sG8TmYhh6RetfRnP
         zQ1NmYq6SGygu9bZ6UKHPYKrBe49w272gLBgH6FiaxMZJCLyEvA3f/OL+ZawHvyScvxV
         NUDHcl+ZDw5KZ8GNkG0XdD/l641FcdUszwOw6lTCzKEWP/roXAKO6IkenQMhSLUot6Y8
         DK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnUAur1XuHkI/gglF6Mz+7XnQMlmdnUuVjG0jwsSsno=;
        fh=DUJ0kpzqmDbqX1hFtSjIalzNuGFsIiWQA4lBQSSXYOY=;
        b=DQpa1lnGnjbmkbL6a1VOzcUtTBaKekOMB4L1DNZeaRz0cqzRjaMFa8qaeJZyIAEESb
         MzW+Qc/HYy3WQGaI9EKm9bea7RAoHq379HX6V7ELHNjnVeV78Cr+zKP6TtuybZe2lvV3
         PkQ/gH+jvMvn5CZHSfAx0vrdb6MiFa5YW6+dIp1wkWqbojEIFcBkUcEVQTCKYobKihBr
         XOMJA4O4jGlPZ9rqdkk4pMc+BvkNfKDFxkNGAVtD314kdhL4cJVhP3KNdqPiQLtz7CcB
         gghMdaE3qUyg4nToiGF/FS5vBzoKe4VqUKfWLEOhh3BaaOGPRuSVWs7KW2r7Ln9dEyi9
         Vz7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1769018432; x=1769623232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnUAur1XuHkI/gglF6Mz+7XnQMlmdnUuVjG0jwsSsno=;
        b=pXK65FmlR/ikv0hyYSDauFJl7evsrenS2c8I4guizWR+XmM16PmLT/Xg/o4ecieRaQ
         av1tbDpFyXbcM6Sn/sSp5i81VWi6pR4CJ1KB3tHm5+dZuUW8S0AwkKMQGDzapwdkMj3p
         WTpW30coyhhYujAakIxYEU85FKrOO213vGA0y3Kx9WfvkqSOMWodt6J4j37/leqFu1oK
         vTgDqdzl/4et0VknLshBHlNs6ruD7StL+KVTNdX0W+0gNzxeiw2EU78eMS/A86r7lzAi
         64d364HKh/BTOhAfwo1OXJsho4Mgg8KOEQMHY1g/iScSfV9VL9qc7qgqgHpWDio/F1Vt
         /yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018432; x=1769623232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnUAur1XuHkI/gglF6Mz+7XnQMlmdnUuVjG0jwsSsno=;
        b=sq4qZLqRUTbAFdeL1EBT+JJdIBNUIeXg0PoZdXGWP8MOQeof6RLJm5hWOZrg9lcDq2
         nY2UP8QIU/ZYKa9nOExR1O4xdij9UH++oDJL5lM8ghF2CgJSeJZ3qe0RfU91K0tfU8NP
         bLZCW3ykIvFIgn1w+Ob2ARlVfW0BW5+b7WSpM6jNw1YaHt+5Y23qTLb7lN/90opFlOuz
         RAlLVX+2fyfLRL0OR90LUje0JNKkjv3Oo6NUdiK4Ir9zGj/RrSwefScgzQI7gWqmWWrE
         zmBDs3BKMwVBTUYSXYpD2cm1NsLhcxbNujqZ7p+vhtIerdD2T8VFL6t8vq1jC5WfvEbE
         fEKg==
X-Forwarded-Encrypted: i=1; AJvYcCXyvtKMFqbc6SpihxsKt5giHfhZv+SQkMenFLEn15vWazulpkGNkHkHPitj+fVx+aoDqdXOeaLet6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7ESZIcozQ+L6HSnR1G7+WAPs6IbcYrmWSG1BJYhpbbQ74SMI
	dX6Ht9aLFZbTiv2GC6AnFDPXQEz+ZzZyoOPpdDlDQol7JFpcqWwIc+iZ9zhymjtH46kGEWwpJxG
	kL60yM+2RNCyVUY9GXr2k4eb9Azix40IUkNn6Xd8rTxCECVMtAPs=
X-Gm-Gg: AZuq6aLHjA9/0MBm2tJDdTDLRhbOgFzagrQ02Yv6N8TyKDJ6Yg44rnqCqwTYKE4NpzL
	eVuiXIyBovyp/KneoTdNfMtynJtWBBJXGTt8FUrjG2y3W8227/YTKiq0DbhP/6Y0hXdmaKIXYc2
	awusk/qDsOs1o0mBxCLpIKAdVSxHaqDGlhEm2738pxcRPHGGJ15TPFqSVILLaq3//m3IBVkV/km
	8nf8UorTHo3AwWqgPn2C8AimxEyJUAvgcVV5Qg1HVBO16VyaXtgtEXRXKPflfs7hWNZVxfjTlds
	vNs=
X-Received: by 2002:a05:6512:3f0d:b0:59b:6c03:74a5 with SMTP id
 2adb3069b0e04-59dc8f11cbamr2090430e87.8.1769018431803; Wed, 21 Jan 2026
 10:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com> <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
In-Reply-To: <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 21 Jan 2026 10:00:19 -0800
X-Gm-Features: AZwV_Qj4HThaSaYzNn-qIgAjYFvcri9rsxrh7J0CX4Os2pMzxyAuji1p2rkqKzY
Message-ID: <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Jeff Layton <jlayton@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, amir73il@gmail.com, 
	cyphar@cyphar.com, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Yunkai Zhang <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, emily@redcoat.dev, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Jan 19, 2026, at 2:21=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> wro=
te:
>
> =EF=BB=BFOn Mon, 2026-01-19 at 11:05 -0800, Andy Lutomirski wrote:
>>> On Mon, Jan 19, 2026 at 10:56=E2=80=AFAM Askar Safin <safinaskar@gmail.=
com> wrote:
>>>
>>> Christian Brauner <brauner@kernel.org>:
>>>> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
>>>> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
>>>> returning a file descriptor referring to that mount tree
>>>> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
>>>> to a new mount namespace. In that new mount namespace the copied mount
>>>> tree has been mounted on top of a copy of the real rootfs.
>>>
>>> I want to point at security benefits of this.
>>>
>>> [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work=
.
>>> I like them, and I think they should get wider exposure. ]]
>>>
>>> If this patchset ([1]) and [2] both land (they are both in "next" now a=
nd
>>> likely will be submitted to mainline soon) and "nullfs_rootfs" is passe=
d on
>>> command line, then mount namespace created by open_tree(OPEN_TREE_NAMES=
PACE) will
>>> usually contain exactly 2 mounts: nullfs and whatever was passed to
>>> open_tree(OPEN_TREE_NAMESPACE).
>>>
>>> This means that even if attacker somehow is able to unmount its root an=
d
>>> get access to underlying mounts, then the only underlying thing they wi=
ll
>>> get is nullfs.
>>>
>>> Also this means that other mounts are not only hidden in new namespace,=
 they
>>> are fully absent. This prevents attacks discussed here: [3], [4].
>>>
>>> Also this means that (assuming we have both [1] and [2] and "nullfs_roo=
tfs"
>>> is passed), there is no anymore hidden writable mount shared by all con=
tainers,
>>> potentially available to attackers. This is concern raised in [5]:
>>>
>>>> You want rootfs to be a NULLFS instead of ramfs. You don't seem to wan=
t it to
>>>> actually _be_ a filesystem. Even with your "fix", containers could com=
municate
>>>> with each _other_ through it if it becomes accessible. If a container =
can get
>>>> access to an empty initramfs and write into it, it can ask/answer the =
question
>>>> "Are there any other containers on this machine running stux24" and th=
en coordinate.
>>
>> I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
>> path that gives it sensible behavior should be conditional like this.
>> Either make it *always* mount on top of nullfs (regardless of boot
>> options) or find some way to have it actually be the root.  I assume
>> the latter is challenging for some reason.
>>
>
> I think that's the plan. I suggested the same to Christian last week,
> and he was amenable to removing the option and just always doing a
> nullfs_rootfs mount.
>
> We think that older runtimes should still "just work" with this scheme.
> Out of an abundance of caution, we _might_ want a command-line option
> to make it go back to old way, in case we find some userland stuff that
> doesn't like this for some reason, but hopefully we won't even need
> that.

What I mean is: even if for some reason the kernel is running in a
mode where the *initial* rootfs is a real fs, I think it would be nice
for OPEN_TREE_NAMESPACE to use nullfs.

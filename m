Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D284301487
	for <initramfs@vger.kernel.org>; Thu, 14 Aug 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167157; cv=none; b=PBfynLJFVOLI0xNngktRVAwE98QuGZHwDo1GXwDGR4Orx/2Q/n/GRW531WIFosI6Ma+eHWSCwlm5pwbGmfd4VB4UKEYLwVGE71QPTsGjF39bH8rzzaokup242XB1QgM+52jr+hVDfnnBbHQ1gEj26KWGXXPxbOi5pp42FADVFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167157; c=relaxed/simple;
	bh=67TWpFC9kFmlTZkHoTfDgzCSeOb00SIOcx47D6NFSkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmoFh1iqHUEtjcnXKg1JT4E4zm9/vxue66VSJGtrBGNxTxXKtLfWaz5kGSiBG+hiRhG8OrkvLOoQEB45dIhvZ63GvAmjrCICxoVHUzuIYBoEkM8u05RYlZe8xcgweWId2YXsLz/NMaD8tN6cQWlNzuo1+GXVkC1TQ4z7/Vpbtoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXvlAql+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXvlAql+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755167154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgn81Tr+8hcjcnOTiZziRVmr22vaTnfczgkfFVMrPuA=;
	b=aXvlAql+XahO9rBv+GLROyzF5ETVx8jvkt9xhsjsIn0j7rBYiiKo+z9INSxODUcRvlCcIT
	XQ5Z+oJHiHNLeXXw9IldtU6rbSptdCMNwdrO0OmKj1+zdQdbIdhmaUcaxcE5DBmj0msgv2
	u6bz0Es55iNWcS+XuI+/lpeRsa2gtgY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ZcaQJJ2eMQaXQ6b-ZcjkUA-1; Thu, 14 Aug 2025 06:25:53 -0400
X-MC-Unique: ZcaQJJ2eMQaXQ6b-ZcjkUA-1
X-Mimecast-MFC-AGG-ID: ZcaQJJ2eMQaXQ6b-ZcjkUA_1755167153
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88dd04faso28388296d6.0
        for <initramfs@vger.kernel.org>; Thu, 14 Aug 2025 03:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167153; x=1755771953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgn81Tr+8hcjcnOTiZziRVmr22vaTnfczgkfFVMrPuA=;
        b=Y2KnOTPj1EwaWhyo5h3Zgk/szlLrPtES+ECNnTAdvMLSxUKM0pBgIPpahjulIKSthr
         9Zt29EUlF/KUiy372Y2wwHaapsNc0a0j0x5L3leO23ihVuv432pG/B8PoaX9kNBqVMja
         bvQbUaMYZJhylnR4RXEHugV0y1T/Z2iAZu68bsH4bRUD+mcUJglz1R6y/FfxVwsH19ut
         LDtSuXmxC6GNNte/HO5uslybsyexpowp4ikJ2vLExXrgcem+jNgH5LOMV/odagJgEe+Q
         cBeuW/5Yi7TCre9dBgRGbmzKSFkKHEGwFgsfMfLGxpDqBQw8x0zOa/SI1TYzwE46fK2y
         n/dw==
X-Forwarded-Encrypted: i=1; AJvYcCV++Az+/UgNGLRw4TuBis3SF6TXUzcLowT1Pc/2sc/Ia85g3003VgeTWsN58fupX+Pksp0l34lH7uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpoVradMZfJ1fE8vjIyBAsAHdiYtAb5ytT3R0gcto4AKR+/Bl
	WhuGh2tz77OLHQqrYALGiubInfEPnYbVrN06XsBKB7tOXIYjMF2sOV9ypzdyqbkBFjykQyGwyXj
	EbVi03lmv2wDNzi06HNqyDoA5PciczjfNSxbmEc1o7PN5lLnMlQtrIWMh/SZKbf8RghS9q0X1+Z
	wY7JfoWN8hYigTecRuMsgGhEP/D/9ensHNdNeh
X-Gm-Gg: ASbGncsgBSQHEYkvDqz6xiyE875DENmOY9ifg/2TpMRMuDyD3jlr3uxAdOW0Y7oP5Ck
	9qEx8apmp+WgksFokCfgo3NrjOi4XbKqMrJioL2PUGNVpaLaxSuOvWT1xQYN3oLNaE7GYibeBc1
	xwRmtI0eCtWBN+WT3ZOkArRpItlPqch4S9zWQXS7pg2KhqaDeliv9c
X-Received: by 2002:ac8:7e81:0:b0:4b1:dd3:e3a0 with SMTP id d75a77b69052e-4b10dd3eecfmr23734341cf.63.1755167152783;
        Thu, 14 Aug 2025 03:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj6Fqf8ZwqtpABxCnBRRgWEUtTuRorTGk78D6BUIRWpQRL0vtIDMWjft+v/pu6kMmSX/QebZM7wdmGQ8Fxz5E=
X-Received: by 2002:ac8:7e81:0:b0:4b1:dd3:e3a0 with SMTP id
 d75a77b69052e-4b10dd3eecfmr23733991cf.63.1755167152330; Thu, 14 Aug 2025
 03:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <20250814081339.3007358-1-safinaskar@zohomail.com>
In-Reply-To: <20250814081339.3007358-1-safinaskar@zohomail.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Thu, 14 Aug 2025 18:25:41 +0800
X-Gm-Features: Ac12FXxDAq6OF9fc6qDx2bbELbCoeU3NGz_x-43ufP_dIt47GGsYNY84NXPWPG0
Message-ID: <CAPmSd0OpjE7-kKtW08LthJXsdMi4YNEfdrKiLjmHYtHuQ+CCkg@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Askar Safin <safinaskar@zohomail.com>
Cc: brauner@kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, rob@landley.net, viro@zeniv.linux.org.uk, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, initramfs@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:15=E2=80=AFPM Askar Safin <safinaskar@zohomail.co=
m> wrote:
>
> Lichen Liu <lichliu@redhat.com>:
> > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > By default, a tmpfs mount is limited to using 50% of the available RAM
> > for its content. This can be problematic in memory-constrained
> > environments, particularly during a kdump capture.
> >
> > In a kdump scenario, the capture kernel boots with a limited amount of
> > memory specified by the 'crashkernel' parameter. If the initramfs is
> > large, it may fail to unpack into the tmpfs rootfs due to insufficient
> > space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> > memory must be available for the mount. This leads to an OOM failure
> > during the early boot process, preventing a successful crash dump.
> >
> > This patch introduces a new kernel command-line parameter, rootfsflags,
> > which allows passing specific mount options directly to the rootfs when
> > it is first mounted. This gives users control over the rootfs behavior.
> >
> > For example, a user can now specify rootfsflags=3Dsize=3D75% to allow t=
he
> > tmpfs to use up to 75% of the available memory. This can significantly
> > reduce the memory pressure for kdump.
> >
> > Consider a practical example:
> >
> > To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> > the default 50% limit, this requires a memory pool of 96MB to be
> > available for the tmpfs mount. The total memory requirement is therefor=
e
> > approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacke=
d
> > kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
> >
> > By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48M=
B
> > tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> > requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> > smaller crashkernel size, such as 192MB.
> >
> > An alternative approach of reusing the existing rootflags parameter was
> > considered. However, a new, dedicated rootfsflags parameter was chosen
> > to avoid altering the current behavior of rootflags (which applies to
> > the final root filesystem) and to prevent any potential regressions.
> >
> > This approach is inspired by prior discussions and patches on the topic=
.
> > Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> > Ref: https://landley.net/notes-2015.html#01-01-2015
> > Ref: https://lkml.org/lkml/2021/6/29/783
> > Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-in=
itramfs.html#what-is-rootfs
> >
> > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > ---
> >  fs/namespace.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index ddfd4457d338..a450db31613e 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
> >  }
> >  __setup("mphash_entries=3D", set_mphash_entries);
> >
> > +static char * __initdata rootfs_flags;
> > +static int __init rootfs_flags_setup(char *str)
> > +{
> > +     rootfs_flags =3D str;
> > +     return 1;
> > +}
> > +
> > +__setup("rootfsflags=3D", rootfs_flags_setup);
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
> >       struct mnt_namespace *ns;
> >       struct path root;
> >
> > -     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
> >       if (IS_ERR(mnt))
> >               panic("Can't create rootfs");
> >
> > --
> > 2.50.1
>
> Thank you for this patch!
>
> I suggest periodically check linux-next to see whether the patch got ther=
e.
>
> If it was not applied in resonable time, then resend it.
> But this time, please, clearly specify tree, which should accept it.
> I think the most apropriate tree is VFS tree here.
> So, when resending please add linux-fsdevel@vger.kernel.org to CC and say=
 in first paragraph
> in your mail that the patch is for VFS tree.
Thank You!

I checked the linux-next and it was not applied now. I will resend
this patch and CC linux-fsdevel@vger.kernel.org.

>
> --
> Askar Safin
>


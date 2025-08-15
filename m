Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B75137E
	for <initramfs@vger.kernel.org>; Fri, 15 Aug 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259966; cv=none; b=geldaFGYIUlQubUy43OV9tu1GuwHE2eXYMtE+tXAIjYtfc3xp/on61VMlUwH1yiCZZqzFjsIDUg/1bMij/L/Vej1dm84sadx2VKXj0nK53q1P7kDPN9RKDKToXgkH1iSaiK+hYRuEqbaM5sscwcn4UUPdfscTgYtxvPw1ybcJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259966; c=relaxed/simple;
	bh=RupsilpKIyJKD6xVBtFhDOFiNYQdWmcA4JoYQiiXKxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5zrKIscoA6CQsKzjdr4hQFxUUjKlj1nQk9xr0b76ATVW2rjreW8Wd9F/t8knbTzJJkMYxyojQ5MB3CVrGIuuQIv6IeuyCrrksehfEhWJrMzpwQ39hFzkcNfLB5NnSlF4+bFO80AIEsHjRXvCIP2gVfp3qfueLWxohJXUfWAJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoxy82CV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoxy82CV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755259963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=;
	b=hoxy82CV9FAs5gKYh8QPnV7WGxhnxPZA4RWosfSpVscst11mrfSE9ODC34kHI1ov/bMGWu
	Hx397doHdiu2pQTyhYiLb4AbOBrM9wv4GhSBBrrl3LnQ9Q+Xw7hWz8/GXwRDvC36zCSrKe
	1RGbv2nSZ27khLzOBIb11hRqJJl0thQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-wCJXOD3BN7GfvyHkNIgoeQ-1; Fri, 15 Aug 2025 08:12:42 -0400
X-MC-Unique: wCJXOD3BN7GfvyHkNIgoeQ-1
X-Mimecast-MFC-AGG-ID: wCJXOD3BN7GfvyHkNIgoeQ_1755259961
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bb3e22so54332501cf.2
        for <initramfs@vger.kernel.org>; Fri, 15 Aug 2025 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755259961; x=1755864761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=;
        b=JXWGHJ62ybuF2JbJmZtGZjtDIPKP9uyeJe4bUjagj7bhRhli/oNU+0mbIK4JjczKve
         8fdiHTFaZm4ty34VVSFG7V0m26YFX0kpsspOGQUSpWCyoyECaq4/d+AayjRwp6C8YIIv
         m129kNksCw++fFUGLIKqvbYdFRk6rfu0VNd0SZrdJOr86A/OKqVtkIvlS1tz3oPtqDcp
         BpBbzSCX/7TkObuwNwo/aQY0tFVK6SP7vElJM/hoykO3rssW6hwIc+m+8A6Pqnl+ATob
         O82LXs8GufsEDdHvrEh746RGCSQ4xWn6VEoziajjLAwkgja2NgK4ELL67XnlV/JeZRUZ
         Ha/w==
X-Forwarded-Encrypted: i=1; AJvYcCWlA2nb8v+Fgd97ELmtbp3eikEXzwijo+ABf+T8GK+UsxAsX/nAfEu6+W37Kn63JzGVZRUnmtyCE34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yrL0kFKdDO+jcHdZ7ax+sHvg4c9DgidrwqJ+tKAuzOQWnWq3
	m4plZBfBrMshLgobOTj1XNbWWc1QoHH0HWqKQ8lO6wK5IaSuRTrDum454ErcAIRjufvevatt+/V
	zuXHzycFsP/Ahf/4aZ2EWEt+efyoFDT7HuIOXTWf0/iFRuqkIzE62PVIH2X7Ajl4pr47VPU7KeU
	ssa3qtOn6gDTSwFJTcEdgD+aVrxqA6K3Y20w/I
X-Gm-Gg: ASbGncuOXGpZS9StqNlZKybgWWNDeN7uSTgp4dPp4Dv7zThUR7JWIC/vwXUDa/SZkEW
	VwCiK8Vmb8aTwlERtr7075fgs6S4RPKr28vU9QxGpYfms2whwcl4QfXGCQTYrA0IYk0s2irsCRH
	nGD5LgOiJT0cdqxeyz5vcKz+P25kqNjfmBdPdrZXVXW3qFb6XCdfEi
X-Received: by 2002:ac8:58d6:0:b0:4b0:6d72:58da with SMTP id d75a77b69052e-4b11e27e336mr21593901cf.40.1755259961353;
        Fri, 15 Aug 2025 05:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnPnvMwLbNdtzAW+0roAeIZqivH1p27UtKqFsGOF6SNMkniTfnNu9dyNXw9EPSCCREzSVauEw0aVkW+ujZac=
X-Received: by 2002:ac8:58d6:0:b0:4b0:6d72:58da with SMTP id
 d75a77b69052e-4b11e27e336mr21593341cf.40.1755259960870; Fri, 15 Aug 2025
 05:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814103424.3287358-2-lichliu@redhat.com> <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
In-Reply-To: <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 15 Aug 2025 20:12:30 +0800
X-Gm-Features: Ac12FXz8u1gnW3sWaPY_5ktKOWU5Gtqqb7XQcSSDytiYY6c-gGJc-TBLcG6Iyzc
Message-ID: <CAPmSd0O=f24o0J6Q202qFv09YrvvAtVryLk68RbU9ncfMTS0Vw@mail.gmail.com>
Subject: Re: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
To: Randy Dunlap <rdunlap@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Randy,

I will send a v2 with documentation.

On Fri, Aug 15, 2025 at 12:27=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
> On 8/14/25 3:34 AM, Lichen Liu wrote:
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
> > Tested-by: Rob Landley <rob@landley.net>
> > ---
> > Hi VFS maintainers,
> >
> > Resending this patch as it did not get picked up.
> > This patch is intended for the VFS tree.
> >
> >  fs/namespace.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 8f1000f9f3df..e484c26d5e3f 100644
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
>
> Please document this option (alphabetically) in
> Documentation/admin-guide/kernel-parameters.txt.
>
> Thanks.
>
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
> >       struct mnt_namespace *ns;
> >       struct path root;
> >
> > -     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
> >       if (IS_ERR(mnt))
> >               panic("Can't create rootfs");
> >
>
> --
> ~Randy
>
>


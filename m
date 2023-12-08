Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXfRMHCd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C791729
	for <initramfs@vger.kernel.org>; Fri,  8 Dec 2023 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702058425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=z7/gKUMIQni2L/YjQRD2H+ogKzYsa+9ghxNOOnRe2+0=;
	b=PXfRMHCdnK+MmwDTkuIuMYnSduLtcCBHbcoES3RngFgsn6cGQOHQXDZ4APc8W3do8swFrd
	3Kf6j30cA/S5t/Nu/rBxUZX+us3fT9/Lq/O9uOtKRP7CA7+4fH7rilndS7Gy1GAKcQXMfX
	vpcCs4YSoFu91nkXR74aek+M+zXSik8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-wd1c10wsPJuitowWOirR5Q-1; Fri, 08 Dec 2023 13:00:23 -0500
X-MC-Unique: wd1c10wsPJuitowWOirR5Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c5d72fb5e6so1631325a12.1
        for <initramfs@vger.kernel.org>; Fri, 08 Dec 2023 10:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058423; x=1702663223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7/gKUMIQni2L/YjQRD2H+ogKzYsa+9ghxNOOnRe2+0=;
        b=fittIop2zkRtspX3cOdUeyP9xLqrg7X/sS4NLtweFBtCnxvQbXHy41ZtE7YEXTnaff
         FawObJlZ3VepOb2eoDObtbhgVySIAMPT0Eb4tyAT5terMNG4yqfX4WAAPoW1XfXTiPkw
         LluHxVjGcF4X4o+qzoK2/crAjhkWnptoINLmT/Zg5zCxilrEJ4YQmn3wkoyXIHF9NeW/
         jJP8H6x8tPlA5UkVd4py7oBeJEnT3tRlKtBiJiifw6TW//pvUN7HXc22NTsaS8RSMlWi
         K4A2bFO2a9H3XtZ77qEwmeGQ7KQ3JEQCgUv18N6uXEB3pvN2sml/VO7YhAfzN8C5XC6X
         AGcw==
X-Gm-Message-State: AOJu0YyuSsoI5WUgw8jAGyCzje1x2Yy28WyF0PmGGAJ3DwTk5z5kptPD
	s16CRf2/RF2tgDZ56851CmTlP+bAys/9RKc7I13WXeOc6o7CzPJ4PPAJVfuQCmg5ThQkqbZayIV
	4Yqm+gZdHMy/qQ4AMd8HYI6CVjo0uRt4E0zfW
X-Received: by 2002:a05:6a20:9711:b0:18f:97c:825b with SMTP id hr17-20020a056a20971100b0018f097c825bmr382639pzc.101.1702058422727;
        Fri, 08 Dec 2023 10:00:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPG1l3Yi7hZg7/PsRql4Ko851hPBYdbLbn/WH0DnFaFnQnxUdvR4ROSvPbnig+eeFmsSl9BUe9npXebRUwVOs=
X-Received: by 2002:a05:6a20:9711:b0:18f:97c:825b with SMTP id
 hr17-20020a056a20971100b0018f097c825bmr382629pzc.101.1702058422416; Fri, 08
 Dec 2023 10:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 8 Dec 2023 17:59:46 +0000
Message-ID: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
Subject: [RFC] initoverlayfs - a scalable initial filesystem
To: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org
Cc: Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Daniel Walsh <dwalsh@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

We have been working on a new initial filesystem called initoverlayfs.
It is a new filesystem that provides a more scalable approach to
initial filesystems as opposed to just using initrds. We are writing
this RFC to the systemd and dracut mailing lists (feel free to forward
to UAPI group also) because although this solution works without
changing the code in these projects, it operates in the same area as
systemd, udev, dracut, etc. and uses these tools.

Brief context:
--------------

initoverlayfs by default uses transient overlays rather than tmpfs to
create throwaway filesystems early in the boot sequence.

Why?

An initramfs has to be decompressed and copied to a tmpfs up front
before it can be used. This results in a situation where you end up
paying for every byte in an initrd in boot performance, even the ones
you don't use in a given boot.

This leads to a fear of using languages that result in larger binaries
sizes early boot, reusing libraries, etc. In some cases, reimplemented
minified versions of software components present in the rootfs are
used.

Alternatively, initoverlayfs uses erofs (with compression) and
overlayfs to achieve this, so you only pay for the bytes you actually
use.

There is also increased pressure from certain industries like
automotive, to start essential services in a boot sequence early.

Requirements:
-------------

An init system
An initramfs building tool
A device manager
overlayfs

Nothing that you wouldn't find in most Linux distributions today.

Design:
-------

Here is the boot sequence with initoverlayfs integrated, the
mini-initramfs contains just enough to get storage drivers loaded and
storage devices initialized. storage-init is a process that is not
designed to replace init, it does just enough to initialize storage
(performs a targeted udev trigger on storage), switches to
initoverlayfs as root and then executes init.

```
fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs

fw -> bootloader -> kernel -> storage-init   -> init ----------------->
```

Benefits:
---------

Scalability: You can put less emphasis on keeping this initial
filesystem small as you will only pay for the bytes you read. This is
probably the bigger picture than raw performance in the next point.

Performance: As this minifies the initramfs to contain only the most
basic storage initialization tasks, linux userspace starts earlier
than it would using just initramfs alone. Leaving all the other
software that require early throwaway filesystems to be executed in
the initoverlayfs. In the case of a Raspberry Pi 4 with sd card, it
leads to systemd starting ~300ms faster and in the case of a Raspberry
Pi 4 with NVMe SSD drive over USB it leads to systemd starting ~500ms
faster. There are some devices that by starting Linux userspace early,
you can expose a slowly initializing storage driver, leading to a
slower boot as with just an initramfs you mask this slow driver by
spending this time on decompression and copying. But a computer is
only as fast as it's slowest component, so if you care about super
fast boots, you need to optimize your storage drivers.

Flexibility: It is now easier to consider using fatter languages like
Rust, etc. Using libraries like graphics libraries, camera libraries,
libevent, glib, C++, etc. early boot can be considered. As you don't
have to decompress and copy this data upfront. This leads to easier to
maintain initrd software also, with more consolidation between rootfs
impelmentations and initial filesystem implementations of components.

Changes required in other projects:
-----------------------------------

There are no major changes required in other projects. Tools like
systemd-analyze might need to be updated to recognize this boot
sequence more accurately, because it has no awareness of
initoverlayfs.

Future plans:
-------------

We intend to propose this to Fedora, CentOS Stream, ostree and
non-ostree variants as we continue this project.

Feel free to try:
-----------------

It should work on most standard 3 partition non-ostree Fedora and
CentOS 9 installs (note: CentOS 9 kernel does not support erofs
compression, so Fedora is a better playground today). It's still in
alpha/beta state I guess. Although I successfully dogfood this on my
laptop and we hard tried this on a couple of different pieces of
hardware and VMs... Maybe run this on a non-critical piece of hardware
or a VM for the next few weeks if you want to try :)

git repo:

https://github.com/containers/initoverlayfs

Also checkout the README.md, there are some graphs and other information there:

https://github.com/containers/initoverlayfs/blob/main/README.md

rpm available in copr:

dnf copr enable @centos-automotive-sig/next
dnf install initoverlayfs
initoverlayfs-install

Is mise le meas/Regards,

Eric Curtin


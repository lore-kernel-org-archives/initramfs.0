Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redcoat-dev.20230601.gappssmtp.com header.i=@redcoat-dev.20230601.gappssmtp.com header.b="CW+b7gM+"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38E1AA
	for <initramfs@vger.kernel.org>; Mon, 27 Nov 2023 12:37:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso3428989a12.0
        for <initramfs@vger.kernel.org>; Mon, 27 Nov 2023 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redcoat-dev.20230601.gappssmtp.com; s=20230601; t=1701117473; x=1701722273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhG34AS0jJNpKhmY++lYG8pnUVlarlbnYelx0/7WyI0=;
        b=CW+b7gM+ohGrVRvBuLD9JLV+M4P6QdiEMZFXowuNcnlekxEWkTqf+GTz2dwZ+T+5H3
         6ZCOaCqLzKJAcblHOEVfi05F7osYYHGMnQ/a9mrSIYUozyM7q3zQPWcBNrSxIEY8BAp6
         t1FlvT+mKRaQG2B9/olcTnY0FC3yB/nMewSArxDJhg/7bdv72VMhhjOFXZrzUL3fcJfe
         BB8IwCqXVO0PIs1QhbUJcE2TzadK0nmpnMobXOL0dwN+zjh49FJCgB6WeWD28jFZQNxm
         AjAAfpYXObmpUc1PLk5IrtC48h+Hxa+FWA1vtuSCn1B3mj7b4swsRh8pX1UWaCUodNh3
         pyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701117473; x=1701722273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhG34AS0jJNpKhmY++lYG8pnUVlarlbnYelx0/7WyI0=;
        b=vI3ZISwQXxNziW7AxI96d45U506gVz3+oMRPJCeBitRbrfasMapm/wQQrQbAQpfqHl
         bcE9g8M+OaMR2aA1uFOCsboq09t5gmxbhRw45FVJd23uqxHF77sCCRNzkpVJYZqyQexB
         4PjUPg7Ou+LI+a3BSVGR3IlbwG109rQjMCZGB4yc1n0NzpMchx6Ycz7gfYwgaQJg57d6
         F93IE8omrNw6jIs1fVF1DINGtg3id/UZQXdFgJFovJl8605zUVvRjWp9qB85ceQgRFlE
         S3mn5kYFDEKlWOHbUfvS4JwhvPCKn9X0bQcd2x0VTUlMXjvtUXhsN+DPX1csegTTrDx5
         fshA==
X-Gm-Message-State: AOJu0YxGov9RhUPsnGjQ6yyt5GS20RPU6ic3YZU0KbtdnXltN/734Sql
	L2oNzA4TZifmNjoUqM28Ga1LW+MBALX4/jCyo+B4aFMz+Gg8/1L0cgo=
X-Google-Smtp-Source: AGHT+IHmwIW0urGxEqYY2QGfk8uk3iX7Kydo5fnYd8qtsvXzQGCKZjOA7qmQ9bmEYT9S8NfyFfROhHx9S1y9Oo/Ro2M=
X-Received: by 2002:a17:90b:4c50:b0:285:8407:6152 with SMTP id
 np16-20020a17090b4c5000b0028584076152mr13851588pjb.8.1701117472693; Mon, 27
 Nov 2023 12:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACHV8XpuC=RsvCqB3LMzxQFRnQB15-0fb4gr7b_EzUpOisrLsA@mail.gmail.com>
 <20231127112705.a77ea26ca0749fafe676b5f9@linux-foundation.org>
In-Reply-To: <20231127112705.a77ea26ca0749fafe676b5f9@linux-foundation.org>
From: Emily Shepherd <emily@redcoat.dev>
Date: Mon, 27 Nov 2023 20:37:41 +0000
Message-ID: <CACHV8XrL5McSWW4ULZbi4O5NM3j9i+JONNN2zYZB=qUGM6cVNQ@mail.gmail.com>
Subject: Re: [PATCH] initramfs: Support unpacking directly to tmpfs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 19:27, Andrew Morton <akpm@linux-foundation.org> wrote:

> Nice changelog.  Can you please find more people to cc?  Al Viro,
> people who have recently worked on this.  Also other interested
> parties, not necessarily from the kernel side of things - people who
> might use this feature.

Thanks for the feedback - yes, will do.

> Please use tabs to indent, like the surrounding code.

Apologies for that, I'll change email client for the next submission.

> If the return value is ignored, overmount_rootfs() should return void
> type.  Or should the return value be used in some fashion?

Good point. I wasn't sure about this - at the moment, a failure in
overmount_rootfs will result in the kernel continuing to unpack the
initramfs "normally" directly to rootfs. This feels nicer than giving up
and panicking, but could be unexpected. That said, I'm not sure under
what conditions init_mkdir and init_mount (of tmpfs) would fail.

I'll get a new patch out shortly, with corrected formatting, returning
void, and cc'd to more people.

Emily

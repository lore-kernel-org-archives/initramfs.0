Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F7760A7
	for <initramfs@vger.kernel.org>; Mon, 18 Dec 2023 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOMeG/TJ"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbcf0d341c6so508998276.0
        for <initramfs@vger.kernel.org>; Mon, 18 Dec 2023 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702942348; x=1703547148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qC5kqRWt+IM6HpOJ/FutfOxROjyUc6IQbph5jco/DGc=;
        b=mOMeG/TJGAcvS1GSdrD4FL0UUA4vzd97WIcLpsKaGFxIx5tf6QrXEl18sgJXkJbcqM
         S6oz7rICMGL7wZ5SqNgrmnt09tvql50QiMw/G8d/Rz6NVzwRVhzbeoDoURMtri1wOK7S
         sLqH7tTzDni3mTxdOmWszTUxa1lHWT+9OBgaxXquGvIqpLfi415eFvBKyisn2oW4yOCl
         Ph4rRz+Y8lIzS4ezcih0SWQiUPe/gCulPmPpf8DzrYdEZnolrF1bpXlJ1awIFWzDadXo
         JzYxgrr3BKOhWbi7eLk7UfHZlIVdkDoOTOJfO6S4iX46ovqM+1vF4n2Idf/FoHzw4L0g
         TXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702942348; x=1703547148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qC5kqRWt+IM6HpOJ/FutfOxROjyUc6IQbph5jco/DGc=;
        b=vZPqwwnJXzXcu+48rFvJI6GAACy7f05V+qmajUxZWeJt6AvKSckBRbAoW13GnId39v
         9Eik/+xHAGT26hiX5QBYZprWx7mdUORnvuEV6wGMctShFZuaIGC9sapki2t+98eKRJnX
         4RUFafES8eu7qrypnnCzYS1w8gIFpDAmKhSpM2NAjxNDBId1WNtTiV6/SdoNmZgzq4Jz
         2WyVq6IrpBK+DmPmQ0pTwZjECsAXQpgD0HUhUJDF4v27LylDk+SPYY9z6JLhog5X+VcS
         sAKEnuzkmTe3odkOJ2LjFrTZMqgOi7LVZ4a0y+6u26UlwtZJHlUHtHisVeoHiOFJqhbZ
         mL8w==
X-Gm-Message-State: AOJu0YydoJfjA27V7rZdhhTwi/B315ZwHLS8Wv9xIEa0ODv6uvNEEvQs
	eVqH0f0QSDQgRAbT2DMvF63iNcEg6okLVdbk4ak=
X-Google-Smtp-Source: AGHT+IGkFy5o838PajPl2Fh14ruA+DlL6HtP7B94PEKWwSiXNmKp+Qo+D9Pg9kKukPQbaGSUFpopfqB6v5kiWzDwhDA=
X-Received: by 2002:a25:b911:0:b0:db5:3d22:883f with SMTP id
 x17-20020a25b911000000b00db53d22883fmr15946726ybj.4.1702942348304; Mon, 18
 Dec 2023 15:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGCPd7Z4PYkNf8ES1t0ZBE=p2Lny6HKzhqNmyfq5UGw0+g@mail.gmail.com>
 <CAOgh=FyA94-7YqGpsAqVQjadegRusoAvRhD=t-ipzVWN0CiJRQ@mail.gmail.com>
In-Reply-To: <CAOgh=FyA94-7YqGpsAqVQjadegRusoAvRhD=t-ipzVWN0CiJRQ@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 19 Dec 2023 02:31:44 +0300
Message-ID: <CAPnZJGAALQKGR4ieqWd3eJ6MmuqwqweN=Xb5TqjPAGNFDknsug@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yes, your understanding is correct
Cool! Then I think your current solution is better than other
solutions proposed in the thread. I. e. it is better than to have the
bootloader to load erofs image into memory, because we don't want this
extra copy

--
Askar Safin

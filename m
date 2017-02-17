From: Andy Kittner <andy.kittner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Bind mounting /etc & co. from encrypted partition
Date: Fri, 17 Feb 2017 18:08:08 +0100
Message-ID: <b6edc1d7-ccc3-5178-9a16-90c08b99304a@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=j6zr+P9hjqKkhNKRnNFn7J3Nw68cRufJmBUWS3C44fg=;
        b=mvbzVDOI1qy476exxyesErLFr8n8t2Ci+v2KWHDgx2cWEqiNAd9XSnDnxUxwqOlRzy
         /b24otOSJEBRfYD59asPNbZkWgvFVrUuDl+6PBdSZ2t4hx1CXQpFeZlgc52f5WEmrU2u
         19cZtNKWuqFYM3qJnjBwgD4kdUnXPaLJ9T+Rdxz2VdPGT4i636RMSwKA7Qk+HvFFBvJO
         qFNRAIj7dSvNw0qAs9KSYxrcVVs7rFSRouYOVLxdBoBdUFOt8JjBU4SLbucxceTTSL/n
         1Ke/MtaiAwL2kxnlG/9BPDqbFMrePMPXT+hYvLMjcLn9P16bGkaiLTpJTVQThi+39m0W
         dn8A==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

I hope this is the right place to ask, if not kindly give me a kick in
the right direction.

I'm currently in the process of setting up my new notebook and (possibly
foolishly) decided to get a bit more fancy this time (currently
I just used FDE, which worked out of the box).

What I'd like to achieve is something like the following:

/dev/sda4 --> / (unencrypted)
/dev/sdb2 --> crypt_LUKS /mnt/data

And then bind-mount stuff thats worth encrypting (/etc, /home, /var, ...)
from /mnt/data.

I've been playing with the fstab.sys stuff to get the mounts set up
before the real system continues booting, but I can't seem to get it
quite right.

Before I waste any more time with this, or reinvent an existing wheel
by trying my hand at a dracut-module I thought I'd ask here for any
tips. Or possibly for someone telling me that this is a stupid idea to
begin with and I should just set up FDE again ;)


Thanks in advance,
Andy
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEETO5sBHZ40QsISAeRPjKZR38oUbAFAlinLfQACgkQPjKZR38o
UbDUIxAAhyXwNsuXh75OerYcFKS8+UHIqvWOuZaphQM1hwAjDsjvTTe95/yCOUzG
dHnDOkAntED/HDL8X7M5TBAN9OgF01DbMJEVplFMIJGqBHUNd0GB6VIE7IaZU0Xm
yAIoRLFks1Zm9o8W9cm7dbvZny4hzsvMzGTiyJtKFNSThnJJkbW+VTs5OMLFKs7d
zFDEjpoXp55C20mTKGz59HGWA86JcsxB5WMEBgoa/GW9SIdsJTlQzLGf84urIDp5
W0N7lm8XBZFrtTKrXQmOf1bGYNc/rq1uKPJHz/6U0aWiZrtF+9JiSZy5v0etBr79
42DmKZqTIfO/fx/9yF4sR43GBlXF5tGp0P1qTm1Sxhp0YAFcQibl37dbAPXXU89R
tNSton+LtvTw+cptlnIjxMuuOeEXAWS+C08xbkrzx8X3A7DtfCd/m/qlyU2Eh7X0
HY7DwyzV0GGGj/csIyx+126mpPyHVIEXOmwHPk3+rBuqe9T/6XY5xSK0vxDwXld7
Adjvxs6vPQ5fwyfsYKzN6VQiOrkN09Z32kx0Ye08SxeAI003dJWQlBZoX7tEsU75
o0re9jKDB64trtdjoOzXcalSsjM4BR3JOeKYcooD+Kvy/R83Jc5HnH1o+ZJMmXfT
zoOSBt8loAuDcR9WAkg0eeNN3pF+q5zlSb7OexMAwLuj/NWnxCY=
=+wCG
-----END PGP SIGNATURE-----

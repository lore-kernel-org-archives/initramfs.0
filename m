From: Freeman Zhang <freeman.zhang1992-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: "kdumpbase" dracut module
Date: Tue, 22 Mar 2016 08:41:21 +0800
Message-ID: <56F094B1.6070209@gmail.com>
References: <CACeEjSL0jrqF9WtX3mZrO0036pGc4O4aPg+=JPMOB7QH47DLWA@mail.gmail.com>
 <20160321062655.GA9896@dhcp-128-65.nay.redhat.com>
 <CAAm8cU6EaVwQPV5wwy5PXeEShtEfscTz-vAOOxmZWP56YDgNSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6dOVfa93sM5pEqnjMliEqQ7lraUd8VFUQ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=YHEygWP6z0MbJq9AkJ2itEIfSqmU4aHB03VOLnw6ISE=;
        b=ZE6zDgx0VNLvyn23InxfGYUIgLGLMmvNFt8zma16nPJo/RxCfLz5+oeCvwyf5qSraL
         Od/ZkPKSONryYSvPUvSDExGmpP6vDsruGgzgyjUZeMcHxzxvnVkv0f1gsfLMJMcExxLN
         +JaAomGY5wS2JkErNi6NbxQC5eTywM0z40i3FRFsC3RCpKPxB68B1eDRBli30Dzw1fax
         PDNPg03M2c5vCjG5yswxQo1dSwPQOQIOTP2l3e4JZ0jCYSbRS6Lurya8Iwrv0AP5eglY
         bSbig/Sx8DaMS8HtOJP9v/bvg2VXmrKfbsG/xKo4Co7lbJIIIL0yPJR5AxIIRsIUQ/KV
         KmfA==
In-Reply-To: <CAAm8cU6EaVwQPV5wwy5PXeEShtEfscTz-vAOOxmZWP56YDgNSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Ronit Halder <ronit.crj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ronit.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernelnewbies-7JyXY6prKcjpASu1u0TL5ti2O/JbrIOy@public.gmane.org, zhezhang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6dOVfa93sM5pEqnjMliEqQ7lraUd8VFUQ
Content-Type: multipart/mixed; boundary="7HXTNAAQ0AEP43IvBNRvqmQwcSf92bsQu"
From: Freeman Zhang <freeman.zhang1992-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ronit Halder <ronit.crj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ronit.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 kernelnewbies-7JyXY6prKcjpASu1u0TL5ti2O/JbrIOy@public.gmane.org, zhezhang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Message-ID: <56F094B1.6070209-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: "kdumpbase" dracut module
References: <CACeEjSL0jrqF9WtX3mZrO0036pGc4O4aPg+=JPMOB7QH47DLWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <20160321062655.GA9896-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
 <CAAm8cU6EaVwQPV5wwy5PXeEShtEfscTz-vAOOxmZWP56YDgNSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAAm8cU6EaVwQPV5wwy5PXeEShtEfscTz-vAOOxmZWP56YDgNSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--7HXTNAAQ0AEP43IvBNRvqmQwcSf92bsQu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 3/21/16 9:55 PM, Ronit Halder wrote:
> Thanks for helping
>=20
> So, this module is used to dump the crash kernel.
> Am I right?
> If not then can you explain how kdump kernel calls the makedumpfile?
>=20

You are absolutely right Ronit. By the time the second kernel is booted,
this module will start a service called kdump-capture, which will
execute kdump.sh, which will invoke makedumpfile after all, depending on
your kdump configuration.

All the best!
Freeman


--7HXTNAAQ0AEP43IvBNRvqmQwcSf92bsQu--

--6dOVfa93sM5pEqnjMliEqQ7lraUd8VFUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJW8JSxAAoJENZCakLuo2TNQqgQAJBH7iFXr7s0dlyEviayZn/g
rrZXG1UJyWU+uTAUlCjM1DnmroHf4dmGwwKeYlg+GDuEo+C+XsbLRmfUSeeln+Jp
U53NXUrEE4nnQZlreapPE9F6p1ULBmYWJ4qUr3CwcAR8Uk+sy68AG3x0bfmV2/Q+
z/f1WRda+ALvSzFkMqK2DK1iUYM5qWrL+1ynmGpmRyRdrQU7g4FqkkenAItbal2e
RdXbbzMQvuDMkiOlWa+IVj/+ZTPQTJZEEqa/EfiENL5N5s+DKn8K7/gD1NdypWrH
Ba/gDufOAfykY/Ecdapnm5yqt/N/KrmEVjDzUSLoYEG88HeD2mVQwL0eMdLtUIoF
qeV0I8IWvMczGnk2iSrw4Z2BWS1lTgo3ZWhOTusfvPvsrhljS0ItS1VGaR/VKZqW
lLIVx+tzFWyU3kKFJGtiwH2YSrD1RtW1pKm25BQ4Us2ooKvIv80t06AG8IzT5Vkt
2Zf4lxgYDEHMR0WYiVg8mFS9no3hzvO1pSBsGMBrTtzkoqbwmQkPCDQeh/5wpoSO
zAPagqriVSN9UoCJJr0vHkV7dd55fJzAp0LU1N7Ghgnpz0U2Gkz1j9d5s5RDotAw
ME/WHX5vWWhuIrGu3oOWsvLh1P+MWLN03H7yXsK/a0s337LW8Pe427GMsW9rb1+u
6+7YmHVzpDJ/S5lXJMtf
=Id4S
-----END PGP SIGNATURE-----

--6dOVfa93sM5pEqnjMliEqQ7lraUd8VFUQ--

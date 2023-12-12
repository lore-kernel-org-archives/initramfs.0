Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="1gVSnXlg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmSxXWzt"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF19F
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 11:05:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EC8A65C0207;
	Tue, 12 Dec 2023 14:05:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Dec 2023 14:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1702407931;
	 x=1702494331; bh=biUxq4soyIMPKRgYXQmG88kn4vdDYNuow5hDcbCwc4w=; b=
	1gVSnXlg/7Vm1ggGcZBfNj9pau5O8PUW1XwnRTrNnQwVJ0fsochirQ8B26r6gT1r
	4BhYuQnrGuIjyQErzdFCuTeucJE6weyBShSej+GxVQm0GiqJ5he24ILi2jOO4s7Q
	CTCPxFeTX/7dxNpaVz8f3zYYYY1AMm5SkdLfXySpHVdQfSdlm32717eXypO6D05v
	eJ7hMhZiuUKdnVNQl6h68QCr22/YDGBbqpgqn1WsYgAk/r4IbvXRym+CGEf3WJFu
	B4wLsepIdIiZQc2xWqWIDd49bOOTg5s/VpiX7u0zmrsM4DE3b4u1Fi/wmQdKbBzo
	fe/TKPt+GeqnCQYUD9Hq+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702407931; x=1702494331; bh=biUxq4soyIMPKRgYXQmG88kn4vdD
	YNuow5hDcbCwc4w=; b=mmSxXWztcDeDnivbKMA3wYlD7AGQKjiCgggP2kCgeWqc
	RF9UxTVmixryDWq8KxRpyCTUddHbg17yfLcEjQagKE3uf1Ogft6IXpGKS8GXf+vH
	wLhDj6+ZKyO17Ic8N8uZ4QffaCJigKx+7TzgQojVfVaBJmU+zXFU1hKsiUctCMLX
	Np361UWfArFhVu2rS7450l6U2YJGXzSqSMv30BvOs2C0cyq+iS4FzhRvtM12bRaC
	ywte/MDT/CBUJ64ZD7iz/HIWzA/kfSFvlXe0X94oNfs2LFUpp1d+WstM7esYeat1
	6WOGys3JYHomIkcL3pP/thshrXn67eVAd0bIdDFPJg==
X-ME-Sender: <xms:-654ZVQ2jE6_vcSwT_7I01UJHXyfr8momZ7PhAh7iOMr5Fk9VeYb0A>
    <xme:-654Zey16J-8H1XCwnlCbL2ATcFtIIgA7xVDKR0TRZiHBTkfmuPbHSknNVEnNFpaP
    hfQ0Op6EGMxlAg>
X-ME-Received: <xmr:-654Za3Vd37dvzdPy7S1juWC1Y4n3u2_0JN_wN9uvpFQTym0O8GgSmHZyyopRFsouSIL3sF_mMQdfqNUwTdkOlmuQRkpWcBul_ZNrbaI72byRhEO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:-654ZdDUXsmYZrRiU3yjHdOAfyMfwaRlUDvEISaahDGSnCYRq0rtpw>
    <xmx:-654ZehAl7wTPWnTIkrTrECVSE2_ykiQYB7NTpxIYDUzAr80X144WQ>
    <xmx:-654ZRqvfbee-X2PQx0tHetnlmmtHqAkJ6kDLr27rlUtkpzHbqnllg>
    <xmx:-654ZWflZgD5LxnQUdKzpdt68PX0TOT2KEZohr_XkmGUrk7KEoL5Ig>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 14:05:31 -0500 (EST)
Date: Tue, 12 Dec 2023 14:05:27 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Lennart Poettering <lennart@poettering.net>,
	Eric Curtin <ecurtin@redhat.com>
Cc: Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXiu-s65w8KYmeIi@itl-email>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
 <ZXb3xhSswgjQAwlL@gardel-login>
 <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>
 <ZXibEHuAkEsKPeci@gardel-login>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EtGVXVjwVp7uTx9g"
Content-Disposition: inline
In-Reply-To: <ZXibEHuAkEsKPeci@gardel-login>


--EtGVXVjwVp7uTx9g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Dec 2023 14:05:27 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Lennart Poettering <lennart@poettering.net>,
	Eric Curtin <ecurtin@redhat.com>
Cc: Yariv Rachmani <yrachman@redhat.com>, initramfs@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem

On Tue, Dec 12, 2023 at 06:40:32PM +0100, Lennart Poettering wrote:
> On Mo, 11.12.23 12:48, Eric Curtin (ecurtin@redhat.com) wrote:
>=20
> > Although the nice thing about a storage-init like approach is there's
> > basically zero copies up front. What storage-init is trying to be, is
> > a tool to just call systemd storage things, without also inheriting
> > all the systemd stack.
>=20
> Just to make this clear: using things like systemd-cryptsetup outside
> of the systemd stack is not going to work once you leave trivial
> setups. i.e. the TPM hookup involves multiple services these days, and
> it's not going to get any simpler. i.e. systemd-tpm2-setup,
> systemd-pcrextend, systemd-pcrlock and so on. I am sorry, but doing
> reasonable disk encryption with TPM involved means you either buy into
> the whole systemd offer (i.e. with the service manager) or you have to
> rewrite your own systemd.
>=20
> But maybe I am misunderstanding what you are saying here.

I think a key factor here is that the initial suggestion was for
automotive use cases.  One can have a vastly simpler system if one is
willing to deliver hardware-specific images, rather than trying to have
a single image that supports many different hardware models.  Automotive
and other embedded systemd understandably do not want to pay for
complexity that they do not need, and which is present to support
features (such as supporting arbitrary hardware) they will never use.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--EtGVXVjwVp7uTx9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmV4rvkACgkQsoi1X/+c
IsHu+xAAz5JEvAuO7euOnbliWXrYhG+wbLlGDUE4pB5lPwt4vhjAZ0EGSVz2MKgx
G3P3PY+AtviY6gCf8/a+R4b1Y87YB5WK8yHKrwMgWGdtoaZWoYuSRAChiJ4L8zJl
/ZEOtDMowOqoI8RwLx7Dgznf0DptY1px5qqfFxMFcEW7bQkJTDSYJD62bte1ijYZ
R4r3gJUa63eQR0HD8GTdjkcpzrqkS6fXR4CNd5HoVE3xW6kw411wHRmays1RHfyX
Kl4M0esKRLYQ8S0zHhFfTlm/eUr54/ORGS2LvLjV93b84ErWvR0FK8DKZw2wUSZS
fX+63zqFQ9DdTSuGlWm09caZ9GPkFuZg+kVd/4F+hYYaxMaVijo/A1HM2zidV+I4
OWJI4HJEpo7x0D4ORGVjNFuACwAvtEVjrECMV23LRd2C5JICPsDd/QzhN3vLQwuS
JqlNoQlEAiMZCLaNLa7uY2fEWgeNT9vhuPS4y5x9uAf/WXVuyNv07myA6vbrh2mp
mdtOkYz7pkDvsdp6L+7vCRW3QHlqfqmAZOIt5SCGWHulqhaMFQfmiF/keV/qg2YL
rrZOrMa2qk8NmjRWUGCqVTicVHkKszAFAQqOWdzksQwdWcr2ZxsO59l92wMWlaju
tzqsKNsZnrjW4kXavPc76nn+V7RTnK5iMKlGEIbXiKlwHDxB4I8=
=5+rD
-----END PGP SIGNATURE-----

--EtGVXVjwVp7uTx9g--

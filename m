From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] dracut-functions: find_rule a bit smarter
Date: Mon, 05 Jul 2010 09:53:57 -0500
Message-ID: <1278341637.4056.17.camel@localhost.localdomain>
References: <20100705090647.30b3c2bc@etiriah>
	 <20100705090847.4a2bcc7e@etiriah> <20100705091220.670f00f7@etiriah>
	 <20100705112407.26026f40@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:content-transfer-encoding:date
         :message-id:mime-version:x-mailer;
        bh=mnDyls4tGOetwClqlzlJJCofZEBOKprIOu2G008Zqgo=;
        b=AhuUUYonS+ttxaNPhTFvvKY5HO5KNfooQntVVsSFfN9vlrdfSzMHMK/paXfbIYfHnQ
         aUN/Xs1kSXTwRAJgd+VyBYXSjTcyCpuvQrv5GfhDrUjnlniIVKq7Y5iO0ws3ploK5ZqZ
         4fEGqswxZpDIywojrNnFb+C2u2RCIl2MAu3II=
In-Reply-To: <20100705112407.26026f40@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Amadeusz =?UTF-8?Q?=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2010-07-05 at 11:24 +0200, Amadeusz =C5=BBo=C5=82nowski wrote:
> Matches rules filename if it's specified without prefix number.
> ---
>  dracut-functions |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/dracut-functions b/dracut-functions
> index be6b2e9..1f2528e 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -319,11 +319,32 @@ inst_symlink() {
>      inst "$realsrc" && ln -s "$realsrc" "$target"
>  }
> =20
> -# find a udev rule in the usual places.
> +# find a udev rule in the usual places and try to be smart (just a b=
it).
> +# See example:
> +#   find_rule default.rules
> +#   find_rule 50-default.rules
> +# All of them will return: /lib/udev/rules.d/50-udev-default.rules
> +# If there are few matching files, error message is printed.
>  find_rule() {
> +    local rule t
> +
>      [[ -f $1 ]] && { echo "$1"; return 0; }
>      for r in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/ru=
les.d; do
# Parsing the output of ls can lead to strange and subtle bugs.
# Use globbing and parameter expansion instead, and go with the first
# matching file.
	local f
	for f in "$r/$1" "$r/${1%%-*}-udev-%{1##*-}" "$r/"*"$1"; do
		[[ -f $f ]] || continue
		echo "$f"
		return 0
>      done
>      return 1
>  }

--=20
Victor Lowther
LPIC2 UCP RHCE=20

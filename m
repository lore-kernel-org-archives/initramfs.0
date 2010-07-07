From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 3/3] dracut-functions: find_rule a bit smarter
Date: Wed, 7 Jul 2010 11:19:46 +0200
Message-ID: <20100707111946.568b4775@etiriah>
References: <20100705090647.30b3c2bc@etiriah>
	<20100705090847.4a2bcc7e@etiriah>
	<20100705091220.670f00f7@etiriah>
	<20100705112407.26026f40@etiriah>
	<1278341637.4056.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/K/KB21E8Z5aqlSkPKOHGclF"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278341637.4056.17.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/K/KB21E8Z5aqlSkPKOHGclF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> # Parsing the output of ls can lead to strange and subtle bugs.
> # Use globbing and parameter expansion instead, and go with the first
> # matching file.
> 	local f
> 	for f in "$r/$1" "$r/${1%%-*}-udev-%{1##*-}" "$r/"*"$1"; do
> 		[[ -f $f ]] || continue
> 		echo "$f"
> 		return 0


Thank you for advice!  I've modified function to the following form:

# Final efect the same as previous, but in addition detects ambiguousness
# among multiple directories.  If it's not desired uncomment the line with
# "break" statement.
find_rule() {
    local rd f files=3D()

    [[ -f $1 ]] && { echo "$1"; return 0; }

    for rd in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/rules.d;=
 do
        for f in "$rd/$1" "$rd"/*-"$1"
        do
            [[ -f $f ]] || continue
            [[ ${f##*/} =3D~ [0-9][0-9]-.*\.rules ]] || continue
            files+=3D($f)
        done
        # (( ${#files[@]} >=3D 1 )) && break
    done

    (( ${#files[@]} < 1 )) && return 1
    (( ${#files[@]} > 1 )) && {
        derror "Ambigous rules filename.  Matches: ${files[@]}"
        return 1
    }

    echo "$files"
}


--=20
PGP key: 1024D/C284750D

--Sig_/K/KB21E8Z5aqlSkPKOHGclF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkw0RrIACgkQ+hU8EsKEdQ0FBgCgprK1JNIakCzW/zEzc4tG3l7+
zZUAoKNWWRcZRIMqp8aXVuEJNfwVUsCt
=e5bH
-----END PGP SIGNATURE-----

--Sig_/K/KB21E8Z5aqlSkPKOHGclF--

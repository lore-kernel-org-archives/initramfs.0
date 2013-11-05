From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH] dracut-functions.sh: Avoid loading unnecessary 32-bit
 libraries for 64-bit initrds
Date: Tue, 05 Nov 2013 11:19:40 +0000
Message-ID: <5278D44C.1060709@colin.guthr.ie>
References: <1383391590-437-1-git-send-email-colin@mageia.org> <20131105015309.1a6aa99b@home.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131105015309.1a6aa99b-gl4+DzqHFJLpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Alexander Tsoy at 04/11/13 21:53 did gyre and gimble=
:
> =D0=92 Sat,  2 Nov 2013 11:26:30 +0000
> Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> Due to the 'inst_libdir_file "libnss_files*"' in the udev-rules modu=
le
>> this caues the /usr/lib/libnss_files-2.18.so* to be included. This i=
s
>> a 32-bit library and pulls in a 32-bit version of glibc also even on=
 a
>> 64-bit system.
>>
>> This is due to the fact that ldconfig -pN will print [/usr]/lib path=
s
>> from the cache as well as [/usr]/lib64. As we handle these paths
>> specifically we should ignore these results from the cache.
>>
>> Also there was a missing space when appending the ldconfig paths
>> onto our list meaning the last builtin and first ldconfig path
>> were unusable.
>> ---
>>  dracut-functions.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/dracut-functions.sh b/dracut-functions.sh
>> index 2e6e845..1355aca 100755
>> --- a/dracut-functions.sh
>> +++ b/dracut-functions.sh
>> @@ -65,6 +65,7 @@ ldconfig_paths()
>>              printf "%s\n" ${d%/*};
>>          done
>>      ); do
>> +        [[ "$i" =3D "/lib" || "$i" =3D "/usr/lib" || "$i" =3D "/lib=
64" ||
>> "$i" =3D "/usr/lib64" ]] && continue a["$i"]=3D1;
>=20
> "/lib32" and "/usr/lib32" should be also excluded. In Gentoo by defau=
lt
> we have 32-bit binaries in lib32 and lib is a symlink to lib64.

Looking through the dracut code it doesn't seem to specially handled
[/usr]/lib32 at all (unlike the special handling for [/usr]/lib64).

So my logic here was that the folders are already "handled" via specifi=
c
code and thus should be ignored from the cached results.

As lib32 is not already "handled", it shouldn't be ignored. However,
that basically doesn't work in practice!

I guess it would make make sense to add a second line after the above
one to do the [/usr]/lib32 ignoring - I think keeping them separate
makes sense (and with a separate commit message) as they are dealing
with slightly different cases.

Harald, are you OK to do something like that after pulling this one?

Col



--=20

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/

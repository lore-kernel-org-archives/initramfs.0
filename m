From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Use modinfo to gather module dependencies
Date: Mon, 27 Feb 2012 11:25:04 +0100
Message-ID: <4F4B5A00.2060400@redhat.com>
References: <2369135.eJzU9GBXlg@ernie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2369135.eJzU9GBXlg@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 25.02.2012 22:09, schrieb Dennis Schridde:
> Hello!
> 
> I just switched from module-init-tools to kmod and found dracut broken, 
> because it uses modprobe --show-depends to find out about module locations
> and dependencies, which apparently is not implemented in kmod.
> 
> Hence I wrote attached patch, switching from modprobe to modinfo, which
> also seem to be the tool intended for the job. This method appears to work
> reliable in kmod-5, but I have not tested with module-init-tools.
> 
> Kind regards, Dennis

You need this patch for kmod:

http://git.profusion.mobi/cgit.cgi/kmod.git/commit/?id=269de2e0bf5011072da2f40f4f2d4023fad696b9
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPS1nvAAoJEANOs3ABTfJwhbgP/iasuIv8UUjNT6GO6oGU5nPN
CBulsqlfSyYHedi2mg6owI4sDb/UU6Ii5gs1fYI4pzlRGJwUTD0/eR2yAZ0Cpyht
eEliTS9zb/UqZcXRvDQi245IvKD4cM1xKAQhwSzGwAEBEbuD10RXLkNm8x5LmwpW
ZhjlMl58s1FjYC54Ezrqd2H3dD6d0oWEkDW6pU0wn34QQOemaZEgNcXXXn62qR1X
j4Br8ambBaByTqhOBX8xZGXPa7K6Uz6BM5vvd5CTRpZ/uODJ1r6ngUz/hWS+zzwl
iBjrM2DHBEJdg7HJjwn7Dt8FH5ifxWdIN42Pkp//NyozwBbbfSyeGczYn4tHQPs8
W2EyiIkTwzp09UT5JmLCbULyrg12YgSI7jreW3Mb37Hyvzll1846rBSrUWP5Ujx2
bqzajMiPXgZx9hJR6N3YxFlGw96ORbSfpnrbIlTrfN8qdCEeOx6IZRteM/Pkyzza
1m+T08WwCzQE2MLkIStLX//zmHDRVZErBsUHp0rSu9ya68/N0lFlJvPrOc1HsNaF
kcnnmOy9Anak21UCO4+QMIzhNG1C0wujZUiWu0W37eQLpCGBBUAZTXQSrJhmsNj+
V2gx10+/W3mnKHbhdjGbcr0ds87oJFMIfT3XKdn1aJ88PtVtdfwd97ZA8gQ5omv5
SVet9vwoaupvgfsaETqq
=Oc+u
-----END PGP SIGNATURE-----

From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PROBLEM: Errors in instmods_1 are ignored
Date: Tue, 28 May 2013 14:01:18 +0200
Message-ID: <51A49C8E.2040201@redhat.com>
References: <6426657.ZbTK3INMtd@ernie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6426657.ZbTK3INMtd@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/09/2013 01:18 PM, Dennis Schridde wrote:
> Hello!
> 
> I found a problem with add_drivers / module installation.
> 
> Current behaviour: When instmods_1 cannot find a module (for example), it
> returns an error (1). It's caller, instmods, aborts the installation of any
> further modules and also returns an error (1). dracut then ignores that
> error and does not even output a warning.
> 
> Expected behaviour: Variant 1: instmods outputs a warning when instmods_1
> returns an error, but continues to install the other modules. Variant 2:
> dracut outputs an error message, including the module that failed, and
> aborts the whole operation.
> 
> See also: https://github.com/haraldh/dracut/issues/8
> 
> Best regards, Dennis
> 

instmods can take two options:

- -c : abort on error
- -s : silently abort on error


instmods -c a b c || exit 1

will give you:

F: Failed to install a

and dracut will exit.


instmods ignores the errors.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRpJyOAAoJEANOs3ABTfJwGtYP+wQIuA2ovQdDoR6wmm5xxoTY
Zy9DLRWQ3mouw7pVp//U0rF98q+9ZGABmMSrhbxwdKgIF0BuCTbRzjW26rrLisuZ
gprv0XxkBEb7EKlwjKFcb706/MSQAI+rg+uDU1clgviBjjVcCcOJUXLCohu1Zh2F
bRKQq89nUo0YUndK/l2hXN21qxrlPOJc8WWFuUDxn6mBH1yekBo6keewyXzXR6Sr
wvHDNni6hbWX3PJMj6JBpFaheF9Vl2NMd3eMXCj1X1dbYRD0MFngg7K/fIgUOkJY
33UKWQ1Ijfw7uFMKYKP1ne/kxcNu6e5AbTpd1XXn6SRsC/f/fkVwxJW9DIDCrm+Z
ihA3rBCNvlvc/6m9/OU2ZwGpUXkwwwPMbHxBusG/o9Gu8qiT1UVpDVsAoPrsp4y+
ZVmbD/3gN7AK9XbBqjajJL3R6ObKMofwJkEK7Ia3GWPXii8qKQ8/xKbehex2K48e
sWhxMAbkSL7D2PGXd4dj4RUxlBcs+DxmxXLItG4ncJ90XpZ62wLZIBT1HsUfasT/
S9th5iXoC1ZfdIIlfpu8ISQygD4z7D1SB4zYPnHS/R43FL2DC0LljqyVp01Qpjpg
+Q/DXIQAWA4usRU6UcULeZFhFWA/SSa8d4ted/POGXynKiOkFIubM38mnCPe6yJz
3b+z9nLqHdhF4FtY1G6B
=jgLC
-----END PGP SIGNATURE-----

From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Wed, 20 Oct 2010 15:44:31 +0100
Message-ID: <4CBF004F.9070201@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=yxG3cuicHiNmN68HpODflc+NmMZb+JIBLjcu0910/LQ=;
        b=VZWhh8tVcwvtJU1IT6dPX/EnGmXgKwP93khUIK/hybJ3PJU4x4adzcw8aR/DW2z3YI
         9RRTDVAwNDvS1fCdl4ldWWMhxXdCydP365ormVTW77usGVmEwSXuJfvTO7QN/6kUIK7n
         qRgvKqRJfWSrM5upBDmY9wehInsvBoK4oItI4=
In-Reply-To: <1287580805-sup-6517@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> '-I' option are for user to include single files.  If you'd like to
> merge files into initramfs with its dependencies, you use '*inst*'
> family functions.  See 'dracut-functions' file.
>  =20
Thanks, I'll have a good look.


> First of all rd_LUKS_KEYDEV_UUID will be changed to 'rd.luks.keydev' =
and
> allow to specify devices by filename in /dev, LABEL or UUID.
>
> It's done a bit more flexible.  You can specify 'rd_LUKS_KEYDEV_UUID'
> (later 'rd.luks.keydev') and 'rd_LUKS_KEYPATH' (later 'rd.luks.keypat=
h')
> several times.  For every 'rd.luks.keydev' ALL 'rd.luks'keypaths' are
> checked.  I know that such approach have some flaws.  I'll consider y=
our
> proposition (quoted below) for specifying that.
>
> [...]
>   rd.luks.key=3D<key_path>:<key_dev>:<luks_dev>
>
> Why this order?  <key_path> is always required (obvious).  <key_dev>
> doesn't have to be required, because it's easy to perform search for
> device (and it's done know, it works pretty well, at least with my
> latest not yet accepted patch which needs more improvement :-)).  The
> last is optional too.  Forcing user to write down all UUID-s is not
> ethical. ;-)  It should be automated as far as it makes sense.
>  =20
Bugger, I forgot about drive labels :-\

In which case using separate rd.luks=3D<luks_dev> (for password=20
identification), rd.luks.key for external dev/key authentication and=20
rd.luks.token for token authentication makes sense. I would reverse the=
=20
order though.

The way I see it if you reverse the order to be=20
<luks_dev>:<key_dev>:<fs>:<key_path> (don't forget the file system,=20
otherwise how would you know how to mount it to read the key - you may=20
'assume' that it is either ext2/3, but it might be something else - HFS=
,=20
ReifeiserFS etc.) it makes it more consistent with the Fedora's own=20
Kickstart options (see http://fedoraproject.org/wiki/Anaconda/Kickstart=
=20
- scroll further until you find 'ks=3D').


> Examples:
>   rd.luks.key=3D/some/file.key:LABEL=3Dcool_keys:UUID=3D00aabc
>   rd.luks.key=3D/some/file.key::UUID=3D00aabc
>   rd.luks.key=3D/some/file.key:LABEL=3Dcool_keys
>   rd.luks.key=3D/some/file.key
>
> And probably I'll introduce this scheme in patches I'm improving
> recently.  Does it satisfy you? :-)  And for token it would be:
>
>   rd.luks.token=3D=E2=80=A6
>
> Might be?
>  =20
I'll be happy if you reverse the order and add a file system type as=20
well - it makes it more consistent with the Fedora Kickstart format,=20
otherwise is a bit confusing.



>> I've looked through the dependencies and the package scripts though
>> there are, among other things, udev rules and config files, which
>> could complicate matters. Following this I have another query: Does
>> dracut have (at least read) access to the /boot partition where the
>> initramfs image is?
>>    =20
>
> No, no.  You don't need access to /boot.  You put everything in
> initramfs using installation functions provided by 'dracut-functions'=
=2E
> See 'install' and 'check' scripts in some module's directory.
>  =20

That could spell trouble as for just running pkcs11-tool that requires =
2=20
configuration files which reflect the specific token type and various=20
parameters. Although 90% of all cases fall into the 'default' mode=20
scenario there are the rest 10% which do not and have to be properly=20
catered for.

The parameters and attributes in these files are complex and cannot be=20
specified in the kernel command line in grub.conf. If these 2=20
configuration files are embedded into initrd they cannot be changed,=20
which means that initrd has to be custom-built for each client=20
configuration which makes this whole exercise largely impractical.

The other possible scenario, as I already mentioned, is to use=20
configuration files which are outside initrd (separate device or locate=
d=20
in /boot are two possible alternatives)

One other query related to this: if I want to use crypttab for my root=20
(/) partition how is that handled by dracut?

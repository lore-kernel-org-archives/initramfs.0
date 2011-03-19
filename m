From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sat, 19 Mar 2011 18:12:56 +0300
Message-ID: <AANLkTimnjQrheKijCZ5uoJWapf9Pdt1Se22LFoK9Dp4J@mail.gmail.com>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zp0k21tsGNvCOho1WfenK06CTVGTYfz0IdldGCwycfk=;
        b=XYHqHK4jacc6HJEntMSB2oe/ywEjGnVxlSEifqghi7d32Ax13kXOCQEqafyuhK8sOM
         m1fIORs+sisD2AexMthg9HzDGNziERoFCu2oNOg1Cog8/BcTxZoeG93y4KVLaRiPxbpu
         VS8mUxfFwCotVQg73bHN0rmJ77DnHq+POPM04=
In-Reply-To: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sat, Mar 19, 2011 at 5:02 PM, jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> However when I added rd.luks.key=3D/mykey:abcd-1234 into the grub
> (Instead of abcd-1234 I use real UUID of my key) the boot fails and I
> end up in the dracut shell.
>

If you cannot capture console log, at this point mount some filesystem
rw and dump dmesg ouput there. dracut logs into kmsg so it may provide
some insight into the problem.

> Here is how my updated kernel parameters look like:
>
> kernel /vmlinuz-2.6.35.11-83.fc14.i686 ro root=3D/dev/mapper/vg2-lv_r=
oot
> rd.luks.uuid=3Dluks-6508ce25-91d1-469a-9423-7b10ef00754e
> rd.luks.uuid=3Dluks-73608094-4b4d-48bf-99a6-0493aeb7498d
> rd.luks.uuid=3Dluks-9d1124c6-22fe-4572-984b-175c0e307a1f
> rd.luks.uuid=3Dluks-eac11ed2-4136-4f73-bda7-1af1c09fe644
> rd.md.uuid=3Deb005502:33822bc2:b956ad0a:be45f8e0
> rd.md.uuid=3D9ce2b0c0:ed400210:451f5dab:694b56f7
> rd.md.uuid=3D5e644250:1dda1a02:9365481e:4e0aee0a
> rd.md.uuid=3D2e0eedaf:41d79b6b:0bed1099:5adc22ef rd.lvm.lv=3Dvg2/lv_r=
oot
> rd.lvm.lv=3Dvg2/lv_swap rd.dm=3D0 rd.luks.key=3D/mykey:abcd-1234
> LANG=3Den_US.UTF-8 SYSFONT=3Dlatarcyrheb-sun16 KEYBOARDTYPE=3Dpc KEYT=
ABLE=3Dus
>
> The change in dracut seem to be quite turbulent and I hope it will
> settle a bit. It make take me a while to create patch for dracut 008
> and then I can realize you are elsewhere with dracut 009...
>
> dracut.kernel man page confuses me as well:
> " =A0 =A0 =A0 =A0 =A0 If luksdev is given, the specified key will onl=
y be
> applied for that LUKS device. Possible values are the same
> =A0 =A0 =A0 =A0 =A0 as for keydev. Unless you have several LUKS devic=
es, you
> don't have to specify this parameter."
>
> I have several luks devices, but one key only. Does it mean I have to
> list them all manually for the key again?
>

no

> So I have to ask you - what logic is used to mount luks partitions
> with the key on external device in dracut 008?

Dracut tries to mount all devices that match <keydev> spefication and
checks whether <keypath> exists inside of this filesystem. If yes, it
remembers this device as suitable for specified <luksdev>. Later in
cryptroot-ask it will call

cryptsetup -d "$mntp/$keypath" luksOpen "$device" "$luksname"

where device is real device.

The first thing to try is to use just /keydev; this will try to apply
this key to every LUKS device and will probe all available disks.

> (When I modified dracut 005 I had to add delay before USB was checked=
,
> in dracut 008 USB is checked in the loop but if it fails, it does not
> ask for password, but ends in shell.)

It re queues cryptroot-ask for after udev queue is settled if key is
not available initially. If device is still not available at this
point, I am not sure what can be done sensibly.

>
> I have this idea how it can be done (when external key is specified)
[...]
>
> In my view this can be implemented without any changes in the
> cryptsetup tools. Another option to consider is to try to mount luks
> device based on event comming from udev (once key is attached) - and
> then perform point b) - what do you think?
>

Tested patches are welcome :)

> And can I get any help in
> trouble-shooting my problem with dracut 008?
>

Please provide dmesg output after failed boot.

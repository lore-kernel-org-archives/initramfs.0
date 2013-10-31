From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH] build: lookup for the "mount" binary
Date: Thu, 31 Oct 2013 12:17:01 -0300
Message-ID: <5272746D.4080303@opensuse.org>
References: <1383156754-30935-1-git-send-email-crrodriguez@opensuse.org> <CAG-2HqUcQy8DK_W5w974+cWAKFc8p0fe7rimy0FEqDMZwW0sXg@mail.gmail.com> <52714F7A.7070600@opensuse.org> <52715138.7030001@gmail.com> <52716B30.6080204@opensuse.org> <5272346A.9040300@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UiZsJAmhHXdbnXCw74WUKm+KZlsYPJUn0G9U4XoUXG8=;
        b=IUEOWLSK+HO/uLm5v9ZCK14b4VD+nXuCbWmwAJYoOKaIf0wosDXviBF5vkLdLE55vK
         Oyfm1Av7f+GhImfqgPqIMFwmHsTPlPLnIY65ksiQa+Jo2wwZhSDK+WKHDumvpPW2JuAX
         i8kvyJwdMANWGqKOwEtATWYBXM2DELK0DSrwM=
In-Reply-To: <5272346A.9040300-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

El jue 31 oct 2013 07:43:54 CLST, Harald Hoyer escribi=C3=B3:
> On 10/30/2013 09:25 PM, Cristian Rodr=C3=ADguez wrote:
>> El 30/10/13 15:34, Harald Hoyer escribi=C3=B3:
>>> On 10/30/2013 07:27 PM, Cristian Rodr=C3=ADguez wrote:
>>>> El mi=C3=A9 30 oct 2013 15:18:48 CLST, Tom Gundersen escribi=C3=B3=
:
>>>>> On Wed, Oct 30, 2013 at 7:12 PM, Cristian Rodr=C3=ADguez
>>>>> <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org> wrote:
>>>>>> Real executable might be in /usr and not in /bin
>>>>>
>>>>> I'm not against the patch, but the justification seems lacking...=
 Does
>>>>> anyone actually do this? I.e., have a mount that is not symlinked=
 to
>>>>> by /bin/mount?
>>>>
>>>> I am not aware of anyone not having a symlink to /bin/mount.. howe=
ver,
>>>> when creating an initrd with dracut the symlink is not included (o=
nly
>>>> the real binary is at /usr/bin/mount) and mounting stuff breaks.
>>>>
>>>> It is either this patch or I should send a patch to dracut instead=
 :-)
>>>>
>>>> In any case, from my perspective this is the right thing to do any=
way.
>>>>
>>>
>>> Can you provide me the output of "dracut --debug -f test.img", so I=
 can see what
>>> goes wrong?
>>>
>>> Normally dracut also installs the symlink.
>>>
>>
>> Here is the debug log attached, this is dracut git HEAD.
>>
>> The resulting initrd drops you into the emergency shell because syst=
emd is
>> unable to find /bin/mount to mount /sysroot.
>>
>> Workaround to continue boot is to create the symlink and exit or a a=
dding
>> band-aid hack to
>> http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/modules.d/99f=
s-lib/module-setup.sh
>> just before inst_multiple -o $_helpers fsck to force installation of=
 mount as
>> /bin/mount , clearly not the right thing to do ;-)
>>
>
> dracut-install: Handle 'mount'
> dracut-install: PATH=3D/usr/sbin:/sbin:/usr/bin:/bin
> dracut-install: stat(/usr/sbin/mount) !=3D 0
> dracut-install: stat(/sbin/mount) !=3D 0
> dracut-install: find_binary(mount) =3D=3D /usr/bin/mount
> dracut-install: dracut_install '/usr/bin/mount'
> dracut-install: dracut_install('/usr/bin/mount', '/usr/bin/mount')
> dracut-install: dracut_install ret =3D 0
> dracut-install: cp '/usr/bin/mount' '/var/tmp/initramfs.pRJ2ZL/usr/bi=
n/mount'
> dracut-install: dracut_install ret =3D 0
> dracut-install: dracut_install '/usr/bin/mount' OK
>
>
> So, the PATH dracut uses is PATH=3D/usr/sbin:/sbin:/usr/bin:/bin.
> dracut-install finds a real mount at /usr/bin/mount.
>
> So, you are saying, that you have a symbolic link pointing:
>
> /bin/mount -> /usr/bin/mount
>
> ??

Yes /bin/mount -> /usr/bin/mount .


> What we might can do, is search _all_ components of PATH for the bina=
ries and
> install everyone of them.

That will be cool. because there is the same problem with the following=
=20
binaries

setfont, loadkeys, blkid and mount.



--
"Judging by their response, the meanest thing you can do to people on=20
the Internet is to give them really good software for free". - Anil Das=
h

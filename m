From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH] build: lookup for the "mount" binary
Date: Thu, 31 Oct 2013 17:08:56 +0000
Message-ID: <l4u2qu$geh$1@ger.gmane.org>
References: <1383156754-30935-1-git-send-email-crrodriguez@opensuse.org> <CAG-2HqUcQy8DK_W5w974+cWAKFc8p0fe7rimy0FEqDMZwW0sXg@mail.gmail.com> <52714F7A.7070600@opensuse.org> <52715138.7030001@gmail.com> <52716B30.6080204@opensuse.org> <5272346A.9040300@redhat.com> <5272746D.4080303@opensuse.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5272746D.4080303-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

'Twas brillig, and Cristian Rodr=C3=ADguez at 31/10/13 15:17 did gyre a=
nd gimble:
> El jue 31 oct 2013 07:43:54 CLST, Harald Hoyer escribi=C3=B3:
>> On 10/30/2013 09:25 PM, Cristian Rodr=C3=ADguez wrote:
>>> El 30/10/13 15:34, Harald Hoyer escribi=C3=B3:
>>>> On 10/30/2013 07:27 PM, Cristian Rodr=C3=ADguez wrote:
>>>>> El mi=C3=A9 30 oct 2013 15:18:48 CLST, Tom Gundersen escribi=C3=B3=
:
>>>>>> On Wed, Oct 30, 2013 at 7:12 PM, Cristian Rodr=C3=ADguez
>>>>>> <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org> wrote:
>>>>>>> Real executable might be in /usr and not in /bin
>>>>>>
>>>>>> I'm not against the patch, but the justification seems lacking..=
=2E
>>>>>> Does
>>>>>> anyone actually do this? I.e., have a mount that is not symlinke=
d to
>>>>>> by /bin/mount?
>>>>>
>>>>> I am not aware of anyone not having a symlink to /bin/mount.. how=
ever,
>>>>> when creating an initrd with dracut the symlink is not included (=
only
>>>>> the real binary is at /usr/bin/mount) and mounting stuff breaks.
>>>>>
>>>>> It is either this patch or I should send a patch to dracut instea=
d :-)
>>>>>
>>>>> In any case, from my perspective this is the right thing to do an=
yway.
>>>>>
>>>>
>>>> Can you provide me the output of "dracut --debug -f test.img", so =
I
>>>> can see what
>>>> goes wrong?
>>>>
>>>> Normally dracut also installs the symlink.
>>>>
>>>
>>> Here is the debug log attached, this is dracut git HEAD.
>>>
>>> The resulting initrd drops you into the emergency shell because
>>> systemd is
>>> unable to find /bin/mount to mount /sysroot.
>>>
>>> Workaround to continue boot is to create the symlink and exit or a
>>> adding
>>> band-aid hack to
>>> http://git.kernel.org/cgit/boot/dracut/dracut.git/tree/modules.d/99=
fs-lib/module-setup.sh
>>>
>>> just before inst_multiple -o $_helpers fsck to force installation o=
f
>>> mount as
>>> /bin/mount , clearly not the right thing to do ;-)
>>>
>>
>> dracut-install: Handle 'mount'
>> dracut-install: PATH=3D/usr/sbin:/sbin:/usr/bin:/bin
>> dracut-install: stat(/usr/sbin/mount) !=3D 0
>> dracut-install: stat(/sbin/mount) !=3D 0
>> dracut-install: find_binary(mount) =3D=3D /usr/bin/mount
>> dracut-install: dracut_install '/usr/bin/mount'
>> dracut-install: dracut_install('/usr/bin/mount', '/usr/bin/mount')
>> dracut-install: dracut_install ret =3D 0
>> dracut-install: cp '/usr/bin/mount'
>> '/var/tmp/initramfs.pRJ2ZL/usr/bin/mount'
>> dracut-install: dracut_install ret =3D 0
>> dracut-install: dracut_install '/usr/bin/mount' OK
>>
>>
>> So, the PATH dracut uses is PATH=3D/usr/sbin:/sbin:/usr/bin:/bin.
>> dracut-install finds a real mount at /usr/bin/mount.
>>
>> So, you are saying, that you have a symbolic link pointing:
>>
>> /bin/mount -> /usr/bin/mount
>>
>> ??
>=20
> Yes /bin/mount -> /usr/bin/mount .
>=20
>=20
>> What we might can do, is search _all_ components of PATH for the
>> binaries and
>> install everyone of them.
>=20
> That will be cool. because there is the same problem with the followi=
ng
> binaries
>=20
> setfont, loadkeys, blkid and mount.

As a semi-hack, can you not just run the convertfs.sh script included i=
n
dracut before doing the final compress?

Wouldn't this "fix" the problem too?

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

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: check_finished() syntax weirdness
Date: Tue, 20 May 2014 11:18:48 +0200
Message-ID: <537B1DF8.9010207@suse.de>
References: <5371E992.1080802@suse.de> <5371EA56.3000203@redhat.com> <5371EC2E.4020209@suse.de> <5371F250.9040708@redhat.com> <5371F448.5030208@suse.de> <5371F645.3080309@redhat.com> <5371F729.2000100@suse.de> <53720BCF.5080806@redhat.com> <53722A84.7080205@suse.de> <53722CFC.6060500@redhat.com> <537B1677.9050402@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <537B1677.9050402-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/20/2014 10:46 AM, Hannes Reinecke wrote:
> On 05/13/2014 04:32 PM, Harald Hoyer wrote:
>> On 13.05.2014 16:21, Hannes Reinecke wrote:
>>> On 05/13/2014 02:10 PM, Harald Hoyer wrote:
>>>> On 13.05.2014 12:42, Hannes Reinecke wrote:
>>>>> On 05/13/2014 12:39 PM, Harald Hoyer wrote:
>>>>>>
>>>>>> for systemd:
>>>>>>      modules.d/98systemd/rootfs-generator.sh:
>>>>>> [ "${root%%:*}" =3D "block" ] && generator_wait_for_dev
>>>>>> "${root#block:}"
>>>>>>
>>>>>> for non-systemd:
>>>>>>     modules.d/95rootfs-block/parse-block.sh:
>>>>>> [ "${root%%:*}" =3D "block" ] && wait_for_dev "${root#block:}"
>>>>>>
>>>>>>
>>>>>> What is your kernel command line?
>>>>>>
>>>>> BOOT_IMAGE=3D/boot/vmlinuz-3.12.18-4-default \
>>>>> root=3DUUID=3D7b90aa11-62ba-4260-81c6-bcf43914e97e \
>>>>> console=3Dtty0 console=3DttyS1,57600 sysrq_always_enabled \
>>>>> panic=3D100 ignore_loglevel unknown_nmi_panic \
>>>>> resume=3D/dev/disk/by-uuid/7be10c24-f0fe-4ecd-b04f-c307b0370c48 \
>>>>> splash=3Dsilent quiet showopts crashkernel=3D166M-:83M \
>>>>> rd.break=3Dpre-mount
>>>>>
>>>>> (The pre-mount thingie is inserted by me so that I have a
>>>>> chance to debug & fix
>>>>> things)
>>>>>
>>>>> Cheers,
>>>>>
>>>>> Hannes
>>>>
>>>> do a rd.break=3Dinitqueue and look in the
>>>> /lib/dracut/hooks/initqueue/finished
>>>> directory.
>>>>
>>>> If you use systemd in the initramfs, you should have:
>>>>
>>>> /usr/lib/systemd/system-generators/dracut-rootfs-generator
>>>>
>>>> in the initramfs, which transforms root=3DUUID=3D... into the
>>>> finished hook.
>>>>
>>>> You should be able to test it in the dracut shell with:
>>>>
>>>> # bash -x
>>>> /usr/lib/systemd/system-generators/dracut-rootfs-generator
>>>
>>> Which seems to be the problem; the generator is present, but
>>> apparently not
>>> called.
>>> Once I execute the above line the 'finished' entry for the root
>>> fs is there.
>>>  From which I surmise that the generator hasn't been called.
>>>
>>> Hmm.
>>>
>>
>> Does it have the executable bits set?
>
> Argl. Totally stupid.
>
> Look at modules.d/99base/module_setup.sh:
>
>      ## save host_devs which we need bring up
>      if [[ $hostonly_cmdline =3D=3D "yes" ]]; then
>          if [[ -f "$initdir/lib/dracut/need-initqueue" ]] || !
> dracut_module_included "systemd"; then
>              (
>                  if dracut_module_included "systemd"; then
>                      DRACUT_SYSTEMD=3D1
>                  fi
>                  PREFIX=3D"$initdir"
>
>                  . "$moddir/dracut-lib.sh"
>
>                  for _dev in ${host_devs[@]}; do
>                      [[ "$_dev" =3D=3D "$root_dev" ]] && continue
>                      _pdev=3D$(get_persistent_dev $_dev)
>
>                      case "$_pdev" in
>                          /dev/?*) wait_for_dev $_pdev;;
>                          *) ;;
>                      esac
>                  done
>              )
>          fi
>      fi
>
> So if /etc/fstab contains just the root device (or if the swap
> device resides on a different device which is initialized earlier)
> the initqueue will _never_ run, and the worker scripts will never
> be executed.
> Once I remove the '[[ "$_dev" =3D=3D "$root_dev" ]] && continue'
> line the system boots.
>
Which is actually wrong.

However, the _real_ issue is even more stupid.
At one point systemd switched over to /usr/lib instead of /lib,
and all scripts got moved to the new location.

Well, nearly all:

diff --git a/modules.d/98systemd/module-setup.sh=20
b/modules.d/98systemd/module-setup.sh
index e14ce39..4516b9a 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -192,7 +192,7 @@ install() {
      inst_script "$moddir/dracut-mount.sh" /bin/dracut-mount
      inst_script "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot

-    inst_script "$moddir/rootfs-generator.sh"=20
/lib/systemd/system-generators/dracut-rootfs-generator
+    inst_script "$moddir/rootfs-generator.sh"=20
$systemdutildir/system-generators/dracut-rootfs-generator

      inst_binary true
      ln_r $(type -P true) "/usr/bin/loginctl"

and surprisingly the system boots.
I'll be sending a proper patch.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)

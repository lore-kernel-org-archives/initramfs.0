From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: iBFT oddities
Date: Wed, 04 Jun 2014 14:10:21 +0200
Message-ID: <538F0CAD.5050407@suse.de>
References: <538ED042.8000904@suse.de> <538F0800.80008@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <538F0800.80008-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/04/2014 01:50 PM, Harald Hoyer wrote:
> On 04.06.2014 09:52, Hannes Reinecke wrote:
>> Hi all,
>>
>> I'm trying to setup a machine with root on iSCSI via iBFT
>> (on SR-IOV, yay!).
>>
>> But anyhow, I'll be setting 'ip=3Dibft' on the commandline as per do=
cumentation
>> and the iBFT settings are applied and everything is nice and dandy.
>>
>> It's only that dracut complains during boot:
>>
>> Jun 03 16:28:11 localhost dracut-cmdline[80]: ibft
>> Jun 03 16:28:11 localhost dracut-cmdline[80]: Warning: Please supply=
 bootdev
>> argument for multiple ip=3D lines
>> Jun 03 16:28:11 localhost dracut-cmdline[80]: Warning: Setting bootd=
ev to 'ibft0'
>>
>> Looking closer, setting 'ip=3Dibft' triggers 'ibft_to_cmdline()',
>> which will add _another_ ip=3D argument to the dracut commandline.
>> And consequently parse_ip_opts() complains here.
>>
>> While it's quite easy to fix (just ignore ip=3Dibft when checking fo=
r duplicate
>> ip arguments), I do wonder whether this is the correct way.
>>
>> Thing is, 'ip=3Dibft' is not really an ip setting, but rather a mark=
er that iBFT
>> should be evaluated.
>> As such, wouldn't 'rd.iscsi.firmware=3Dibft' be a more appropriate s=
etting?
>> Seeing that the ip argument is added to the commandline anyway, havi=
ng a
>> duplicate 'ip=3Dibft' setting does look a bit odd.
>> And confuses the logic ...
>>
>> Cheers,
>>
>> Hannes
>
> Good catch! The bad thing is, that "ip=3Dibft" is already documented =
and used, so
> we might want "rd.iscsi.ibft=3D1" and also ignore "ip=3Dibft" in the =
check.
>
> "rd.iscsi.firmware=3D1" is already taken for also starting iscsistart=
 (which also
> starts the network interfaces, AFAIK)
>
Hmm. You are of course aware that rd.iscsi.firmware doesn't=20
necessarily requires you to start network interfaces, right?
be2iscsi and qla4xxx have a separate PCI function, operating=20
independently on the network interface. So no need to do anything there=
=2E

> "rd.iscsi.ibft=3D1" would probably fit, if you only want to ifup the =
network
> interfaces.
>
>
As said above, rd.iscsi.firmware should just cause 'iscsistart' to=20
run, and we need another setting to setup network interfaces=20
specified by iBFT. So for that I really would like to use
rd.iscsi.ibft=3D1, which will allow us to deprecate the 'ip=3Dibft'=20
commandline in the long run.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)

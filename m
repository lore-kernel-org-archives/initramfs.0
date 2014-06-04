From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: iBFT oddities
Date: Wed, 04 Jun 2014 14:16:53 +0200
Message-ID: <538F0E35.4070301@redhat.com>
References: <538ED042.8000904@suse.de> <538F0800.80008@redhat.com> <538F0CAD.5050407@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <538F0CAD.5050407-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 04.06.2014 14:10, Hannes Reinecke wrote:
> On 06/04/2014 01:50 PM, Harald Hoyer wrote:
>> On 04.06.2014 09:52, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> I'm trying to setup a machine with root on iSCSI via iBFT
>>> (on SR-IOV, yay!).
>>>
>>> But anyhow, I'll be setting 'ip=ibft' on the commandline as per documentation
>>> and the iBFT settings are applied and everything is nice and dandy.
>>>
>>> It's only that dracut complains during boot:
>>>
>>> Jun 03 16:28:11 localhost dracut-cmdline[80]: ibft
>>> Jun 03 16:28:11 localhost dracut-cmdline[80]: Warning: Please supply bootdev
>>> argument for multiple ip= lines
>>> Jun 03 16:28:11 localhost dracut-cmdline[80]: Warning: Setting bootdev to
>>> 'ibft0'
>>>
>>> Looking closer, setting 'ip=ibft' triggers 'ibft_to_cmdline()',
>>> which will add _another_ ip= argument to the dracut commandline.
>>> And consequently parse_ip_opts() complains here.
>>>
>>> While it's quite easy to fix (just ignore ip=ibft when checking for duplicate
>>> ip arguments), I do wonder whether this is the correct way.
>>>
>>> Thing is, 'ip=ibft' is not really an ip setting, but rather a marker that iBFT
>>> should be evaluated.
>>> As such, wouldn't 'rd.iscsi.firmware=ibft' be a more appropriate setting?
>>> Seeing that the ip argument is added to the commandline anyway, having a
>>> duplicate 'ip=ibft' setting does look a bit odd.
>>> And confuses the logic ...
>>>
>>> Cheers,
>>>
>>> Hannes
>>
>> Good catch! The bad thing is, that "ip=ibft" is already documented and used, so
>> we might want "rd.iscsi.ibft=1" and also ignore "ip=ibft" in the check.
>>
>> "rd.iscsi.firmware=1" is already taken for also starting iscsistart (which also
>> starts the network interfaces, AFAIK)
>>
> Hmm. You are of course aware that rd.iscsi.firmware doesn't necessarily
> requires you to start network interfaces, right?
> be2iscsi and qla4xxx have a separate PCI function, operating independently on
> the network interface. So no need to do anything there.
> 
>> "rd.iscsi.ibft=1" would probably fit, if you only want to ifup the network
>> interfaces.
>>
>>
> As said above, rd.iscsi.firmware should just cause 'iscsistart' to run, and we
> need another setting to setup network interfaces specified by iBFT. So for that
> I really would like to use
> rd.iscsi.ibft=1, which will allow us to deprecate the 'ip=ibft' commandline in
> the long run.

Let's do that :)

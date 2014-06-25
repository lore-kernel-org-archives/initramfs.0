From: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] write-ifcfg.sh: Don't overwrite network config in root
 filesystem
Date: Wed, 25 Jun 2014 13:07:26 +0200
Message-ID: <53AAAD6E.9010207@wiesinger.com>
References: <alpine.LFD.2.02.1406211239250.1876@bbs.intern> <53AA9B8E.7020801@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53AA9B8E.7020801-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 25.06.2014 11:51, Harald Hoyer wrote:
> On 21.06.2014 12:40, Gerhard Wiesinger wrote:
>> This patch adds the possibility to keep the original
>> network configuration specified in the root filesystem.
>> This is necessary in situations with dual stack IPv4 and
>> IPv6 configurations or different kind on nameservers
>> (e.g. public ones at boot time, running a dns server
>> on localhost later on).
>>
>> Keeping original configuration can be activated by:
>> networkstatic=yes
>> on the kernel boot command line.
>>
>>
>> I don't understand this. It only copies to /run/initramfs. If you want to keep
>> your original network configuration, just don't copy over the files from
>> /run/initramfs to your root filesystem.

Hello Harald,

The topic is: /etc/sysconfig/network-scripts/ifcfg-eth0 is overwritten 
by dracut when network config is specified on boot command line (e.g. 
grub config). As normal config is different and more complex (e.g. IPv6 
setup) boot config is different.

I found, that this patch doesn't overwrite the network config in 
/etc/sysconfig/network-scripts/ifcfg-eth0 when you specify network 
config on the boot command line.

I didn't debug into details and I'm not familiar with dracut in detail 
so I can't say why it works but it works. I think that some other code 
parts copy the initramfs afterwards to /etc/sysconfig/....

But maybe you can clarify it.

Ciao,
Gerhard

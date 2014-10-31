From: Orion Poplawski <orion-CVdf0l11yl+B+jHODAdFcQ@public.gmane.org>
Subject: Re: Question about netmask format
Date: Fri, 31 Oct 2014 10:55:01 -0600
Message-ID: <5453BEE5.3030908@cora.nwra.com>
References: <loom.20141014T001540-462@post.gmane.org> <5449FB04.9030803@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cora.nwra.com;
	s=default; t=1414774502;
	bh=H/PFismxq+yBkAv25KyJOiFF6KYo/LiiSATUZg1RtRU=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=VGJg01BudObzwi63lv9WZMx181/aDKUXIg/l0N/HlWSJn/fnbh/dWoPr/CcSPmVXU
	 MnTy6GUkacmWdAFKBGsxEnSM/1MoIATttSYCJikpIZgK4ZRGLik2MsEwvZF4UqGW2L
	 XKphQBbrZ1/WuiGrX4yCuopKKUQOi6Bc3JxJMl2I=
In-Reply-To: <5449FB04.9030803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/24/2014 01:08 AM, Harald Hoyer wrote:
> On 14.10.2014 00:23, Orion Poplawski wrote:
>> The dracut.cmdline man page lists:
>>
>> ip=<client-IP>:[<peer>]:<gateway-IP>:<netmask>:<client_hostname>:<interface>:
>>    {none|off|dhcp|on|any|dhcp6|auto6|ibft}[:[<dns1>][:<dns2>]]
>>
>> for explicit (static) network configuration.  To my old mind, "netmask"
>> refers to something of the form 255.X.X.X.  However if I use that form with
>> EL7 or Fedora 20, it fails with a message like:
>>
>> Bringing up interface eth0:  Error: an inet prefix is expected rather than
>> "10.8.0.0/255.255.255.0".
>>
>> It works if I give it a CIDR suffix.  It appears that the netmask for used
>> to work.
>>
>> - Orion
> 
> Hmm, in my case
> 
> 	"ip=192.168.50.101::192.168.50.1:255.255.255.0:iscsi-1:ens3:off"
> 
> results in:
> 
> ip addr flush dev ens3
> ip addr add 192.168.50.101/255.255.255.0 brd + dev ens3
> ip route replace default via 192.168.50.1 dev ens3
> echo iscsi-1 > /proc/sys/kernel/hostname
> 
> Which works on my machine.

My full (obsufscated) args are:

method=http://centos/7.0.1406/os/x86_64 ksdevice=eth0 lang= text net.ifnames=0
ks=http://cobbler/ks
ip=4.X.X.X::4.X.X.X:255.255.225.224:test.domain.com:eth0:none:10.10.10.1:10.10.10.2
kssendmac

No idea how to determine what commands were run as a result of this.

This is an anaconda install, so not sure what interaction there might be with
that.

Same result with F21, rawhide is uninstallable today so can try that.

-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion-CfuHcwXVrUc@public.gmane.org
Boulder, CO 80301                   http://www.nwra.com

From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Question about netmask format
Date: Fri, 24 Oct 2014 09:08:52 +0200
Message-ID: <5449FB04.9030803@redhat.com>
References: <loom.20141014T001540-462@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20141014T001540-462-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Orion Poplawski <orion-CVdf0l11yl+B+jHODAdFcQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 14.10.2014 00:23, Orion Poplawski wrote:
> The dracut.cmdline man page lists:
> 
> ip=<client-IP>:[<peer>]:<gateway-IP>:<netmask>:<client_hostname>:<interface>:
>    {none|off|dhcp|on|any|dhcp6|auto6|ibft}[:[<dns1>][:<dns2>]]
> 
> for explicit (static) network configuration.  To my old mind, "netmask"
> refers to something of the form 255.X.X.X.  However if I use that form with
> EL7 or Fedora 20, it fails with a message like:
> 
> Bringing up interface eth0:  Error: an inet prefix is expected rather than
> "10.8.0.0/255.255.255.0".
> 
> It works if I give it a CIDR suffix.  It appears that the netmask for used
> to work.
> 
> - Orion

Hmm, in my case

	"ip=192.168.50.101::192.168.50.1:255.255.255.0:iscsi-1:ens3:off"

results in:

ip addr flush dev ens3
ip addr add 192.168.50.101/255.255.255.0 brd + dev ens3
ip route replace default via 192.168.50.1 dev ens3
echo iscsi-1 > /proc/sys/kernel/hostname

Which works on my machine.

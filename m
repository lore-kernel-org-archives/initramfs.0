From: Orion Poplawski <orion-CVdf0l11yl+B+jHODAdFcQ@public.gmane.org>
Subject: Question about netmask format
Date: Mon, 13 Oct 2014 22:23:45 +0000 (UTC)
Message-ID: <loom.20141014T001540-462@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The dracut.cmdline man page lists:

ip=<client-IP>:[<peer>]:<gateway-IP>:<netmask>:<client_hostname>:<interface>:
   {none|off|dhcp|on|any|dhcp6|auto6|ibft}[:[<dns1>][:<dns2>]]

for explicit (static) network configuration.  To my old mind, "netmask"
refers to something of the form 255.X.X.X.  However if I use that form with
EL7 or Fedora 20, it fails with a message like:

Bringing up interface eth0:  Error: an inet prefix is expected rather than
"10.8.0.0/255.255.255.0".

It works if I give it a CIDR suffix.  It appears that the netmask for used
to work.

- Orion

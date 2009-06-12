From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH 0/5] Multiple interfaces support and lots of cmdline parsing
Date: Fri, 12 Jun 2009 17:11:44 +0200
Message-ID: <4A327030.1000803@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Basically dracut has a problem with netroot when booting with multiple 
nics. If we have multiple interfaces online at the same time, we don't 
really know which interface to use for default-route or dhcp root-path 
source.

This series of patches adresses this problem by delegating the real 
interface configuration to netroot and introducing a new cmdline 
argument. I'll try to explain to solution with two use cases:


Case 1: Multiple interfaces with ip=dhcp or ip=client-ip... but no <dev>

The problem here is that we can't up just every eth that pops up. 
Default-route or whatever will get confused.

The solution here is that ifup and/or dhclient script just write the 
necessary ip statements into /tmp/net.$dev.* and netroot (which is 
synchronized by a lock) just uses one interface at a time, deconfiguring 
it if mounting fails.


Case 2: Multiple interfaces with multiple ip= lines

This is a case where the user expects all interfaces to be up before 
mounting. Think bonding, iscsi multipathing, etc.

The solution here is that the ip cmdline parsers enforces the presence 
of <dev> for multiple ip= lines and further demands that the new 
argument bootdev contains the name of the primary interface to be used 
for routing etc. Configuration is of course again delegated to netroot 
but in this case netroot takes additional care to "wait" for all 
required interfaces to be up.


In order to ensure correct ip= lines I've added a lot of cmdline 
parseing and some mostly minor rewrites of actual netroot handlers.


Thanks for reviewing (or accepting) the stuff,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

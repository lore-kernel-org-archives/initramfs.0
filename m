From: Kevin Yung <kevin.yung-QSbsa4wbOXo@public.gmane.org>
Subject: Patch for ip setting on bridge interface and vlan
Date: Wed, 23 Jan 2013 22:12:38 +0000 (UTC)
Message-ID: <loom.20130123T230308-855@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

I have an environment that needs to boot on bridged interface or 
interface using vlan. 

I found curent dracut release will by pass ip settings on these interfaces. 

So I wrote the a patch to set up provided ip options on the interfaces 
that using bridge or vlan. 

Please let me know if I need to tidy it up a bit more or 
add additional code to handle ip settings on bridge 

and vlan.

Cheers
Kevin

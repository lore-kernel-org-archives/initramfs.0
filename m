From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/2] support multiple bonding interfaces
Date: Mon,  8 Apr 2013 17:47:48 +0800
Message-ID: <cover.1365413867.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Harald,

I tested your patch - "network: support multiple bonding interfaces",
and it works very well on f19 on my local PC. 

The 2/2 patch is used to add a script file to wait the logical interface
up during initqueue, like bond, bridge and vlan. I just tested bond case,
it works.

Please help review it when convenient.

Baoquan He (2):
  network: support multiple bonding interfaces
  Wait for logical interface to be up

 modules.d/40network/ifup.sh         |   15 ++++++++++-----
 modules.d/40network/net-genrules.sh |   20 ++++++++++++++++----
 modules.d/40network/parse-bond.sh   |    6 +++---
 modules.d/40network/parse-bridge.sh |    6 ------
 modules.d/45ifcfg/write-ifcfg.sh    |    9 +++++----
 5 files changed, 34 insertions(+), 22 deletions(-)

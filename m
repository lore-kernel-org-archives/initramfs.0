From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dracut and multiple iscsi/network disks
Date: Wed, 09 Jun 2010 17:47:05 +0200
Message-ID: <4C0FB779.30005@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=169f16715145fd087d61ef7fdfd7e9a3cbb68fc9

adds support for multiple iscsi disks with the syntax:

root=<normal block path or UUID or LABEL>  \
netroot=iscsi:...  netroot=iscsi:... netroot=iscsi:...

which is suboptimal, because you can't specify it in the dhcp protocol.

A better syntax would be a single netroot (also for FCoE disk) something like:

netroot=netdisks:iscsi:...[separator]iscsi:...[separator]fcoe:...

What do you think? Any better ideas?

From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] iscsi unit files and helper script
Date: Tue, 11 Dec 2012 14:43:16 -0800
Message-ID: <20121211224316.GB5307@straylight.hirudinean.org>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
 <1355177316-25803-4-git-send-email-cleech@redhat.com>
 <50C7A9D7.8080900@cs.wisc.edu>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50C7A9D7.8080900-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Christie <michaelc-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>
Cc: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Tue, Dec 11, 2012 at 03:47:03PM -0600, Mike Christie wrote:
> Thanks for working on this. Just one question. Is this patch for some
> other package? How does it relate to the unit files in Tomasz's
> patchset? He unit files with the same name.

I just diffed against an empty directory to show what I was testing
with, it might have made more sense for this to not be a patch but I was
on a roll.

There's a difference between running as forking or simple here, but
that's not a big deal.  And I've been making changes to my iscsi.service
for automatic starting and stoping of sessions today, getting the
ordering right to not run into problems with automatic mount points.

I haven't run into any problems with the patches I posted, but I'm not
happy with the unit files just yet.

- Chris

> On 12/10/2012 04:08 PM, Chris Leech wrote:
> > iSCSI service and socket files, and the iscsi_mark_root_nodes helper script to
> > preserve sessions started in the initramfs.
> > 
> > diff -Naur a/iscsid.service b/iscsid.service
> > --- a/iscsid.service	1969-12-31 16:00:00.000000000 -0800
> > +++ b/iscsid.service	2012-12-10 13:38:38.643307001 -0800
> > @@ -0,0 +1,9 @@
> > +[Unit]
> > +Description=Open-iSCSI
> > +Documentation=man:iscsid(8) man:iscsiadm(8)
> > +After=network.target NetworkManager-wait-online.service iscsiuio.service tgtd.service targetcli.service
> > +
> > +[Service]
> > +Type=simple
> > +ExecStart=/usr/sbin/iscsid -f -n
> > +ExecStop=/sbin/iscsiadm -k 0 2
> > diff -Naur a/iscsid.socket b/iscsid.socket
> > --- a/iscsid.socket	1969-12-31 16:00:00.000000000 -0800
> > +++ b/iscsid.socket	2012-12-10 13:38:38.643307001 -0800
> > @@ -0,0 +1,9 @@
> > +[Unit]
> > +Description=Open-iSCSI iscsid Socket
> > +Documentation=man:iscsid(8) man:iscsiadm(8)
> > +
> > +[Socket]
> > +ListenStream=@ISCSIADM_ABSTRACT_NAMESPACE
> > +
> > +[Install]
> > +WantedBy=sockets.target
> > diff -Naur a/iscsi.service b/iscsi.service
> > --- a/iscsi.service	1969-12-31 16:00:00.000000000 -0800
> > +++ b/iscsi.service	2012-12-10 13:38:38.643307001 -0800
> > @@ -0,0 +1,18 @@
> > +[Unit]
> > +Description=Login and scanning of iSCSI devices
> > +Documentation=man:iscsiadm(8) man:iscsid(8)
> > +#Requires=iscsid.service
> > +#BindTo=iscsid.service
> > +After=network.target NetworkManager-wait-online.service iscsid.service
> > +ConditionPathExists=/etc/iscsi/initiatorname.iscsi
> > +
> > +[Service]
> > +Type=oneshot
> > +ExecStart=/usr/libexec/iscsi_mark_root_nodes
> > +ExecStart=/sbin/iscsiadm -m node --loginall=automatic
> > +ExecStop=/bin/sync
> > +ExecStop=/sbin/iscsiadm -m node --logoutall=automatic
> > +RemainAfterExit=true
> > +
> > +[Install]
> > +WantedBy=remote-fs.target
> > diff -Naur a/iscsiuio.service b/iscsiuio.service
> > --- a/iscsiuio.service	1969-12-31 16:00:00.000000000 -0800
> > +++ b/iscsiuio.service	2012-12-10 13:38:38.643307001 -0800
> > @@ -0,0 +1,11 @@
> > +[Unit]
> > +Description=iSCSI UserSpace I/O driver
> > +Documentation=man:iscsiuio(8)
> > +Requires=iscsid.service
> > +BindTo=iscsid.service
> > +Before=iscsid.service
> > +After=network.target NetworkManager-wait-online.service
> > +
> > +[Service]
> > +Type=simple
> > +ExecStart=/usr/sbin/iscsiuio -f
> > diff -Naur a/iscsiuio.socket b/iscsiuio.socket
> > --- a/iscsiuio.socket	1969-12-31 16:00:00.000000000 -0800
> > +++ b/iscsiuio.socket	2012-12-10 13:38:38.643307001 -0800
> > @@ -0,0 +1,9 @@
> > +[Unit]
> > +Description=Open-iSCSI iscsiuio
> > +Documentation=man:iscsiuio(8)
> > +
> > +[Socket]
> > +ListenStream=@ISCSID_UIP_ABSTRACT_NAMESPACE
> > +
> > +[Install]
> > +WantedBy=sockets.target
> > diff -Naur a/usr/libexec/iscsi_mark_root_nodes b/usr/libexec/iscsi_mark_root_nodes
> > --- a/usr/libexec/iscsi_mark_root_nodes	1969-12-31 16:00:00.000000000 -0800
> > +++ b/usr/libexec/iscsi_mark_root_nodes	2012-12-10 13:38:47.322082141 -0800
> > @@ -0,0 +1,14 @@
> > +#!/bin/bash
> > +
> > +ISCSIADM=/sbin/iscsiadm
> > +SESSION_FILE=/run/initramfs/iscsi.sessions
> > +
> > +if [ ! -f $SESSION_FILE ] ; then
> > +  exit 0
> > +fi
> > +
> > +while read t num i target; do
> > +  ip=${i%:*}
> > +  $ISCSIADM -m node -p $ip -T $target -o update -n node.startup -v onboot
> > +done < $SESSION_FILE
> > +
> > 
> 

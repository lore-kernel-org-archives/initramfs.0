From: Mike Christie <michaelc-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>
Subject: Re: [RFC] iscsi unit files and helper script
Date: Tue, 11 Dec 2012 15:47:03 -0600
Message-ID: <50C7A9D7.8080900@cs.wisc.edu>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com> <1355177316-25803-4-git-send-email-cleech@redhat.com>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Return-path: <open-iscsi+bncBCZ4TFNN2YMRBXWTT2DAKGQEJNFRKMI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=z9DLma6f4QHeyPxM8iX+xGH2TjSP778PePONPUuVXPU=;
        b=J2QKFBP4hyyH2uePHXMbYoGOOJo2ToR11h9GMT5C+/TkElxv0s1xj91VpdFMk2QV2v
         TsuKTpD0EtAXQYckqz4bOM9c2B4WDnwYVHWVgEO7YT1dqud59KDi5keLxv7hz0adbEXW
         UtjH8I0NOsqETMYFCWVmyDFrQ/OzwpradN+CEqLaY6UsJBVn1hU8fP/KwPdtihseEMC4
         oHDRvkNdo1+l1cjgCNmQbBVM+XGXUNT+uHR+/yBdTD6FToCqSS3sOxL/M8JkSeWQ8N1S
         0L/sajlC6/t+8gLewN8PgpTpRA/CFKGC34LnUfs2HvFJx3UBkIFxM9dN1N+xklxCFX2o
       
In-Reply-To: <1355177316-25803-4-git-send-email-cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
List-Post: <http://groups.google.com/group/open-iscsi/post?hl=en_US>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/open-iscsi?hl=en_US>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Thanks for working on this. Just one question. Is this patch for some
other package? How does it relate to the unit files in Tomasz's
patchset? He unit files with the same name.


On 12/10/2012 04:08 PM, Chris Leech wrote:
> iSCSI service and socket files, and the iscsi_mark_root_nodes helper script to
> preserve sessions started in the initramfs.
> 
> diff -Naur a/iscsid.service b/iscsid.service
> --- a/iscsid.service	1969-12-31 16:00:00.000000000 -0800
> +++ b/iscsid.service	2012-12-10 13:38:38.643307001 -0800
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=Open-iSCSI
> +Documentation=man:iscsid(8) man:iscsiadm(8)
> +After=network.target NetworkManager-wait-online.service iscsiuio.service tgtd.service targetcli.service
> +
> +[Service]
> +Type=simple
> +ExecStart=/usr/sbin/iscsid -f -n
> +ExecStop=/sbin/iscsiadm -k 0 2
> diff -Naur a/iscsid.socket b/iscsid.socket
> --- a/iscsid.socket	1969-12-31 16:00:00.000000000 -0800
> +++ b/iscsid.socket	2012-12-10 13:38:38.643307001 -0800
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=Open-iSCSI iscsid Socket
> +Documentation=man:iscsid(8) man:iscsiadm(8)
> +
> +[Socket]
> +ListenStream=@ISCSIADM_ABSTRACT_NAMESPACE
> +
> +[Install]
> +WantedBy=sockets.target
> diff -Naur a/iscsi.service b/iscsi.service
> --- a/iscsi.service	1969-12-31 16:00:00.000000000 -0800
> +++ b/iscsi.service	2012-12-10 13:38:38.643307001 -0800
> @@ -0,0 +1,18 @@
> +[Unit]
> +Description=Login and scanning of iSCSI devices
> +Documentation=man:iscsiadm(8) man:iscsid(8)
> +#Requires=iscsid.service
> +#BindTo=iscsid.service
> +After=network.target NetworkManager-wait-online.service iscsid.service
> +ConditionPathExists=/etc/iscsi/initiatorname.iscsi
> +
> +[Service]
> +Type=oneshot
> +ExecStart=/usr/libexec/iscsi_mark_root_nodes
> +ExecStart=/sbin/iscsiadm -m node --loginall=automatic
> +ExecStop=/bin/sync
> +ExecStop=/sbin/iscsiadm -m node --logoutall=automatic
> +RemainAfterExit=true
> +
> +[Install]
> +WantedBy=remote-fs.target
> diff -Naur a/iscsiuio.service b/iscsiuio.service
> --- a/iscsiuio.service	1969-12-31 16:00:00.000000000 -0800
> +++ b/iscsiuio.service	2012-12-10 13:38:38.643307001 -0800
> @@ -0,0 +1,11 @@
> +[Unit]
> +Description=iSCSI UserSpace I/O driver
> +Documentation=man:iscsiuio(8)
> +Requires=iscsid.service
> +BindTo=iscsid.service
> +Before=iscsid.service
> +After=network.target NetworkManager-wait-online.service
> +
> +[Service]
> +Type=simple
> +ExecStart=/usr/sbin/iscsiuio -f
> diff -Naur a/iscsiuio.socket b/iscsiuio.socket
> --- a/iscsiuio.socket	1969-12-31 16:00:00.000000000 -0800
> +++ b/iscsiuio.socket	2012-12-10 13:38:38.643307001 -0800
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=Open-iSCSI iscsiuio
> +Documentation=man:iscsiuio(8)
> +
> +[Socket]
> +ListenStream=@ISCSID_UIP_ABSTRACT_NAMESPACE
> +
> +[Install]
> +WantedBy=sockets.target
> diff -Naur a/usr/libexec/iscsi_mark_root_nodes b/usr/libexec/iscsi_mark_root_nodes
> --- a/usr/libexec/iscsi_mark_root_nodes	1969-12-31 16:00:00.000000000 -0800
> +++ b/usr/libexec/iscsi_mark_root_nodes	2012-12-10 13:38:47.322082141 -0800
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +
> +ISCSIADM=/sbin/iscsiadm
> +SESSION_FILE=/run/initramfs/iscsi.sessions
> +
> +if [ ! -f $SESSION_FILE ] ; then
> +  exit 0
> +fi
> +
> +while read t num i target; do
> +  ip=${i%:*}
> +  $ISCSIADM -m node -p $ip -T $target -o update -n node.startup -v onboot
> +done < $SESSION_FILE
> +
> 

-- 
You received this message because you are subscribed to the Google Groups "open-iscsi" group.
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/open-iscsi?hl=en.


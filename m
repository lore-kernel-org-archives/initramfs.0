From: =?ISO-8859-1?Q?=22J=F3hann_B=2E_Gu=F0mundsson=22?=
 <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration effort
Date: Wed, 12 Dec 2012 00:46:06 +0000
Message-ID: <50C7D3CE.20902@gmail.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com> <50C67697.7020208@gmail.com> <20121211232646.GC5307@straylight.hirudinean.org>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <open-iscsi+bncBDNNVMX2WEFRBD5JT6DAKGQEZ2SYAQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Lxr8Yka8Gd+3I83uBy48T9ts9+e4twu0lvYzjwuAgl0=;
        b=D4A9BFB4OeBr4Fy+ncZu64xPKAmeYP6p7uNeb9YfSzW0XHL6Ah8IOlz547Rq6yZAmz
         CV6HB9A4XoI1I1TgOXreYh60mK9OrlD6VpR9574e6n0c6EU1EO2XeMq3rhN8ojpzrZ7q
         Czqn85G/YRofCvJNyKVLD0kqUn+ckBwR7wrhu0/Z7MmLquiRcPsEd3jVaDD6xWU3iHJF
         ZSRNz0LFtzEYlq6jaUQDhWV1Z6Go7M/xvrHwqry5b0i8wDsfMNVfcCICNHwRfyI2pOHT
         P+U9h2KyN6M5xVoUZh9zu7OgXGPq1heqNkO0+4xn7C 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Lxr8Yka8Gd+3I83uBy48T9ts9+e4twu0lvYzjwuAgl0=;
        b=vZ0eLsDa/8eOy78/OPwxasy93xSfh2yXdmsCyWZuNX794l5LMw+TcWYdxakAxIZgcg
         IdrV3cJPo+j0SRZ0wtxBtHI0BbEGIJ/SOwZg113B1iLvGiUpplKJYdsuMphicp8rL0xU
         Q2QpbuGYTvoGGqGNPf5UGbrTpWetkr9YYtRFM/Aju/06JbPx/wxbn0kN47re+C1vco//
         HJM2iCcVU2aLnSXvJd2Gh0Twr/RAobP0LlHV+StGwLPlSQ4FCenFLhzjuwfwLqtBL1OG
         exkSt1jFxIFui41HOxQYJQCH8WKTOrR7SZZxtgdHGE2dxuyWn 
In-Reply-To: <20121211232646.GC5307-r8IHplWLGbA5tHQWs+pTeqPFFGjUI2lm2LY78lusg7I@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
List-Post: <http://groups.google.com/group/open-iscsi/post?hl=en_US>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/open-iscsi?hl=en_US>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 12/11/2012 11:26 PM, Chris Leech wrote:
> On Mon, Dec 10, 2012 at 11:56:07PM +0000, "J=C3=B3hann B. Gu=C5=A1mundsso=
n" wrote:
>> On 12/10/2012 10:08 PM, Chris Leech wrote:
>>> 2) Proper ordering of the iscsi.service for non-root filesystems.
>>>
>>> Any and all feedback and/or help welcome.
>>>
>> Looking the unit file for iscsid I do believe I missed this (
>> basically the same as multipath unit ) since you know it's early
>> boot special, root and all that ;)
>>
>> [Unit]
>>
>> # Before or After lvm2-activation-early.service
>> DefaultDependencies=3Dno
>> Conflicts=3Dshutdown.target
>>
>> [Install]
>> WantedBy=3Dsysinit.target
> Thanks, this got me going in the right direction.  These unit files
> seems to be working much better for me, with the startup and shutdown
> ordering between iscsi, iscsid, and remote-fs mounts sorted out.  I'm
> not sure about the tgtd/targetcli stuff, not sure what the original need
> there was.

You should remove if it's not necessary for iscsi to function and the=20
ordering for iscsi be put in those units instead

>
> My non-root test install with /home on iSCSI also has a swap partition
> on it, and that's still causing me all sorts of trouble if I don't
> comment it out in fstab.

Hmm even if you add noauto after the relevant swap entry in /etc/fstab=20
actually it might be necessary for you to create a .swap unit for it.
( man systemd.swap for details )

>    Trying to order all this before swap.target
> blew up in my face pretty good.

You should not order it after the swap.target however you can order=20
.swap unit before the swap.target

>
> - Chris
>
> --- iscsi.service ---
>
> [Unit]
> Description=3DLogin and scanning of iSCSI devices
> Documentation=3Dman:iscsiadm(8) man:iscsid(8)
> DefaultDependencies=3Dno
> Conflicts=3Dshutdown.target
> After=3Dsystemd-remount-fs.service network.target iscsid.service iscsiuio=
.service
> Before=3Dremote-fs.target
> ConditionPathExists=3D/etc/iscsi/initiatorname.iscsi
>
> [Service]
> Type=3Doneshot
> ExecStart=3D/usr/libexec/iscsi_mark_root_nodes
> ExecStart=3D/sbin/iscsiadm -m node --loginall=3Dautomatic
> ExecStop=3D/bin/sync
> ExecStop=3D/sbin/iscsiadm -m node --logoutall=3Dautomatic
> RemainAfterExit=3Dtrue
>
> [Install]
> WantedBy=3Dsysinit.target
>
> --- iscsid.service ---
>
> [Unit]
> Description=3DOpen-iSCSI
> Documentation=3Dman:iscsid(8) man:iscsiadm(8)
> DefaultDependencies=3Dno
> Conflicts=3Dshutdown.target
> After=3Dnetwork.target tgtd.service targetcli.service
> Before=3Dremote-fs-pre.target
>
> [Service]
> Type=3Dsimple
> ExecStart=3D/usr/sbin/iscsid -f -n
> ExecStop=3D/sbin/iscsiadm -k 0 2
>
> --- iscsid.socket ---
>
> [Unit]
> Description=3DOpen-iSCSI iscsid Socket
> Documentation=3Dman:iscsid(8) man:iscsiadm(8)
>
> [Socket]
> ListenStream=3D@ISCSIADM_ABSTRACT_NAMESPACE
>
> [Install]
> WantedBy=3Dsockets.target
>
>

So it seems to be in ready enough to be pushed to rawhide and the next=20
step is to boot with "systemd.log_level=3Ddebug systemd.log_target=3Dkmsg=
=20
log_buf_len=3D1M enforcing=3D0" in the kernel command line to actually see=
=20
why that's blowing up in your face.

One question the iscsid is calling fork() right so why are you so=20
incline to use type simple for it?

There is an ordering gotcha when using type simple units which boils to=20
systemd has no way of knowing if what it just fired up is finished=20
running/setup etc. ( unless notified ) so you might find yourself in a=20
race condition.

JBG

--=20
You received this message because you are subscribed to the Google Groups "=
open-iscsi" group.
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to open-iscsi+unsubscribe@google=
groups.com.
For more options, visit this group at http://groups.google.com/group/open-i=
scsi?hl=3Den.


From: =?UTF-8?B?IkrDs2hhbm4gQi4gR3XDsG11bmRzc29uIg==?=
 <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration effort
Date: Mon, 10 Dec 2012 23:56:07 +0000
Message-ID: <50C67697.7020208@gmail.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <open-iscsi+bncBDNNVMX2WEFRBVPOTGDAKGQEV5P5O3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=/kTtqKVJ7zO6/Ut4qXCqRxJcX9TvnqXJJDWXQhu6N9Y=;
        b=n/TXDCKSEYezt4OlTGDYGCNH4zip6sFlas5Mi2caWzfDxFF4mIOmZOEXr/6pJvpuuq
         f5ad5raOS1KXVWSDnkF8pu8DzdGY58NR69UFwZ3YmLR10L4YiHa2/i7DLctERQ/1Efy5
         VKqcgMmKGPCrZvJpOsqi+/jj29mJSTp1k3PPflE+WIu91IFec+vlqlk3BANQCCAehwLb
         Py3uh+pM4w6+h3Nszn6Zomiue1MyxX55sZjnQJtZ9UsPnqw3n2iI7Xo1Icb26sDpyIfk
         nibic+UtYxFT9VFFumr4WjtPSNe6ykebkjhCi75 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=/kTtqKVJ7zO6/Ut4qXCqRxJcX9TvnqXJJDWXQhu6N9Y=;
        b=n8E9FymIMd9MpkkLQshSWAAN3G7zA6kf9tnqwJHLSLWK9KijClO4+oVfF3VERSnJCc
         1+StW7NKirk21QOZAlDQD9zrjOGhXqwf4Y9+SyDhfcJUFvBaTbA4mjSzpyFFumRzWvVC
         ckOvwGfB0ISVSU7j4jABWn+ekHIz9m2qfXCppCp8R0SMr5cwVrnF9lAYi/4ds89c5Yp7
         qN7PX7Ndwge2TT1FAbdEIaBQ6xPx5lKoG+PBYZfPN879VcD0t/zF23qWyTBwhBgMDrH7
         iAn4ZGkic8J1Qn+9bVRlEyMipCpkMqpW8aSiTUXnqrrsl5 
In-Reply-To: <1355177316-25803-1-git-send-email-cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
List-Post: <http://groups.google.com/group/open-iscsi/post?hl=en_US>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/open-iscsi?hl=en_US>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 12/10/2012 10:08 PM, Chris Leech wrote:
> Sorry about the cross-posting, but I think that in order to get this righ=
t I'm
> going to need as much feedback as I can get.
>
> I think I've got this working pretty well now (at least for my iBFT confi=
gured
> iSCSI root test case), although the dracut module still needs work.  This=
 is
> based on the iscsid socket activation patch from Tomasz Torcz and the uni=
t
> files from Tomasz and J=F3hann B. Gu=F0mundsson.
>
> Attempting to start iscsid using systemd unit files (socket activated or =
not)
> was impacting my iscsi-root test setup.  Rather than try to preserve the =
old
> logic that used the _netdev mount flag to determine when iscsid could be =
safely
> shutdown, I've been working on following the guidelines for root storage
> daemons http://www.freedesktop.org/wiki/Software/systemd/RootStorageDaemo=
ns.
>
> 1) I patched iscsid to set argv[0][0] =3D '@' if a new --initrd flag is p=
assed on
>     the command line.  It's simple, it works, we don't kill iscsid before=
 the
>     root filesystem is unmounted.
>
> 2) When starting iscsid from the initrd, I then ran into issues of iscsid=
 not
>     functioning properly after the switch_root.  It's not mentioned in th=
e
>     RootStorageDaemons documentation, but if a process left running from =
the
>     initrd needs further filesystem access at runtime it will need to be =
able to
>     chroot itself before the switch_root.  I patched iscsid and iscsiadm =
with a
>     newroot command (using plymouth as an example), and used a dracut cle=
naup
>     hook to call "iscsiadm --newroot /sysroot".
>
> 3) Related to #2, launching iscsid as a Type=3Dsimple service from the in=
itrd
>     (I'm testing this with Fedora 18 beta, where dracut uses systemd in t=
he
>     initrd) results in STDOUT/STDERR access after the switch_root failing=
 with
>     EPIPE.  It seems that the connection to the journal process is dead o=
nce the
>     initrd instantiated systemd-journald is replaced with the runtime pro=
cess.
>
>     I can at least keep iscsid functioning if I run it as Type=3Dforking,=
 but I'm
>     not sure if I'm losing runtime logging or not.  I may be able to do
>     something with the StandardOutput and StandardError options in the se=
rvice
>     file.

You should be using Type=3Dforking here

>
> 4) None of this helps if the sessions are shutdown when we still need the=
m.
>     Rather than the all-or-nothing _netdev mount option checks that have =
been
>     used in the past, I'm attempting to use the fact that iscsiadm will s=
kip
>     over session that match a node with startup=3Donboot set when doing a
>     logoutall.  The iscsi_mark_root_nodes script is borrowed from the SUS=
E init
>     scripts in the open-iscsi repos written by Hannes Reinecke.  I've mad=
e minor
>     changes to export the list of sessions activated in the initramfs, an=
d then
>     mark those as onboot when starting iscsi.service.
>
> Things that still need looking into.
>
> 1) Command line configured iSCSI parameters.  If iscsistart is to be full=
y
>     removed something needs to setup the node from the command line.  Or
>     iscsistart needs to be able to run alongside iscsid.
>
> 2) Proper ordering of the iscsi.service for non-root filesystems.
>
> Any and all feedback and/or help welcome.
>

Looking the unit file for iscsid I do believe I missed this ( basically=20
the same as multipath unit ) since you know it's early boot special,=20
root and all that ;)

[Unit]

# Before or After lvm2-activation-early.service
DefaultDependencies=3Dno
Conflicts=3Dshutdown.target

[Install]
WantedBy=3Dsysinit.target

JBG

--=20
You received this message because you are subscribed to the Google Groups "=
open-iscsi" group.
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to open-iscsi+unsubscribe@google=
groups.com.
For more options, visit this group at http://groups.google.com/group/open-i=
scsi?hl=3Den.


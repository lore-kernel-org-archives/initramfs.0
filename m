From: The Lee-Man <leeman.duncan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration
 effort
Date: Mon, 23 Sep 2013 10:33:36 -0700 (PDT)
Message-ID: <b993ef26-ea4e-4dbe-8d9a-d86ad50c9fbc@googlegroups.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
 <50C67697.7020208@gmail.com>
 <20121211232646.GC5307@straylight.hirudinean.org>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_217_5041631.1379957616345"
Return-path: <open-iscsi+bncBC755V5RXMKBB4PWQGJAKGQEJJHNLMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:reply-to:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=0khZuS4wPdSUmweZcLO/kZ2FLlTpjzUHEUt5Z9UqcMI=;
        b=DGJ+AIu+LdyEroEUDgfTalMDtnrmBHwwyxozqrSmjR8S4V3RnMTcZVTRIku+iZHrLZ
         7xiEzJMzRaiYGpBE1Rte4mAUnLwehAyIx/LR6uuOHZJf34nm25H2eueLgKasdAWnQiXU
         w0fQOJz2xhK3VGdPLPYi/ndg3Q6rSV3Mazaf6VYd9uBd20iLQogMYa2Ybco9zWy9ZwRm
         hSKah+JwQG0Gte+zfN6Pri3rNplpDd2a/N89E4ec2nwpluC/DuakjCh7DIzeXw4rkxQH
         udd6AwJuNh2hXcnNDC4RKSlDRLtFiVTOpAA34Fj+wVf8rTVDMDbBeHPyAD3D/1eoiZgk
         lKVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:reply-to:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=0khZuS4wPdSUmweZcLO/kZ2FLlTpjzUHEUt5Z9UqcMI=;
        b=RG/rSs6Wq2FblUiQ0VEGflpdlagdC+wOmPp4tVKzsKA44R/4UL7u1saOi9xOrHMPnP
         pWXtMHkcclYl7k4p/uJO+MAHgPpUYggbGdxR+ine6PogWPomGP/ZT/EdWeQm6iZf+GhC
         JvocAw2fNXF7XzoKVpvIOPBkPtbGN4uVMB+IHNnuPJWZLJJsmoZZQiGM9OLsYaLL+9UX
         RuasUl36W1tXDjzOZCUb+TKcMcBC/Bx0o++Khw3R/DiLMTmr9AD+zcV/QSXy+im0PaGa
         9k6EvaR+IsoRYtflNDAoergu9xLDeKA2V7W69A4TMOCKI2/S5M0xp30q/ojRvh1Fvy4c
         CXpQ==
In-Reply-To: <20121211232646.GC5307-r8IHplWLGbA5tHQWs+pTeqPFFGjUI2lm2LY78lusg7I@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
List-Post: <http://groups.google.com/group/open-iscsi/post>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/open-iscsi>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/open-iscsi/subscribe>, <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/open-iscsi/subscribe>, <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: =?UTF-8?Q?J=C3=B3hann_B=2E_Gu=C3=B0mundsson?= <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

------=_Part_217_5041631.1379957616345
Content-Type: text/plain; charset=ISO-8859-1


On Tuesday, December 11, 2012 3:26:46 PM UTC-8, Chris Leech wrote:
>
> ...
>
> Thanks, this got me going in the right direction.  These unit files 
> seems to be working much better for me, with the startup and shutdown 
> ordering between iscsi, iscsid, and remote-fs mounts sorted out.  I'm 
> not sure about the tgtd/targetcli stuff, not sure what the original need 
> there was. 
>
>
>
I just wanted to post a thank you for all of this work, as I was attempting 
to do some of it myself and making slow progress.

I am trying to get open-iscsi version 2.0-873-suse working on openSUSE.

In my case open-iscsi-based boot is not working and has not been working 
for a while. In addition, we have an initrd-based boot, and it looks like 
that will have to change before iscsid-based booting can work correctly. 
Because of that, I did not try to get iscsi-root volumes working. My goal 
was to get normal non-root open-iscsi working with systemd as well as it 
had with SysV-based init (or better).

Toward that end, I have 3 unit files that are working on openSUSE 12.3 that 
I thought I would share. I am not submitting these as patches, since the 
whole systemd-integration effort is still in flux.

Using the systemd configuration below, iscsid is not started until needed. 
NOTE: I think we need a new mode in iscsid that goes away when it's work is 
done, since it can now be socket-activated (i.e. it doesn't have to sit 
there and wait for work).


Submitted for your comments:


iscsid.socket:
==========
Unit]
Description=Open-iSCSI iscsid Socket
Documentation=man:iscsid(8) man:iscsiadm(8)

[Socket]
ListenStream=@ISCSIADM_ABSTRACT_NAMESPACE

[Install]
WantedBy=sockets.target



iscsid.service:
===========
[Unit]
Description=Open-iSCSI
Documentation=man:iscsid(8) man:iscsiadm(8)
After=network.target NetworkManager-wait-online.service tgtd.service 
targetcli.service

[Service]
Type=forking
PIDFile=/var/run/iscsid.pid
ExecStart=/sbin/iscsid

[Install]
WantedBy=multi-user.target



iscsi.service:
==========
[Unit]
Description=Login and scanning of iSCSI devices
Documentation=man:iscsiadm(8) man:iscsid(8)
After=network.target NetworkManager-wait-online.service iscsid.service
ConditionPathExists=/etc/iscsi/initiatorname.iscsi

[Service]
Type=oneshot
ExecStart=/sbin/iscsiadm -m node --loginall=automatic
ExecStop=/bin/sync
ExecStop=/sbin/iscsiadm -m session --logout
SuccessExitStatus=21
RemainAfterExit=true

[Install]
WantedBy=remote-fs.target

-- 
You received this message because you are subscribed to the Google Groups "open-iscsi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
Visit this group at http://groups.google.com/group/open-iscsi.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_217_5041631.1379957616345
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Tuesday, December 11, 2012 3:26:46 PM UTC-8, Chris =
Leech wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-lef=
t: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">...<br>
<br>Thanks, this got me going in the right direction. &nbsp;These unit file=
s
<br>seems to be working much better for me, with the startup and shutdown
<br>ordering between iscsi, iscsid, and remote-fs mounts sorted out. &nbsp;=
I'm
<br>not sure about the tgtd/targetcli stuff, not sure what the original nee=
d
<br>there was.
<br>
<br><br></blockquote><div><br>I just wanted to post a thank you for all of =
this work, as I was attempting to do some of it myself and making slow prog=
ress.<br><br>I am trying to get open-iscsi version 2.0-873-suse working on =
openSUSE.<br><br>In my case open-iscsi-based boot is not working and has no=
t been working for a while. In addition, we have an initrd-based boot, and =
it looks like that will have to change before iscsid-based booting can work=
 correctly. Because of that, I did not try to get iscsi-root volumes workin=
g. My goal was to get normal non-root open-iscsi working with systemd as we=
ll as it had with SysV-based init (or better).<br><br>Toward that end, I ha=
ve 3 unit files that are working on openSUSE 12.3 that I thought I would sh=
are. I am not submitting these as patches, since the whole systemd-integrat=
ion effort is still in flux.<br><br>Using the systemd configuration below, =
iscsid is not started until needed. NOTE: I think we need a new mode in isc=
sid that goes away when it's work is done, since it can now be socket-activ=
ated (i.e. it doesn't have to sit there and wait for work).<br><br><br>Subm=
itted for your comments:<br><br><br>iscsid.socket:<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>Unit]<br>Description=3DOpen-iSCSI iscsid Socket<br>Documentati=
on=3Dman:iscsid(8) man:iscsiadm(8)<br><br>[Socket]<br>ListenStream=3D@ISCSI=
ADM_ABSTRACT_NAMESPACE<br><br>[Install]<br>WantedBy=3Dsockets.target<br><br=
><br><br>iscsid.service:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>[Unit]<br>=
Description=3DOpen-iSCSI<br>Documentation=3Dman:iscsid(8) man:iscsiadm(8)<b=
r>After=3Dnetwork.target NetworkManager-wait-online.service tgtd.service ta=
rgetcli.service<br><br>[Service]<br>Type=3Dforking<br>PIDFile=3D/var/run/is=
csid.pid<br>ExecStart=3D/sbin/iscsid<br><br>[Install]<br>WantedBy=3Dmulti-u=
ser.target<br><br><br><br>iscsi.service:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>[Unit]<br>Description=3DLogin and scanning of iSCSI devices<br>Documenta=
tion=3Dman:iscsiadm(8) man:iscsid(8)<br>After=3Dnetwork.target NetworkManag=
er-wait-online.service iscsid.service<br>ConditionPathExists=3D/etc/iscsi/i=
nitiatorname.iscsi<br><br>[Service]<br>Type=3Doneshot<br>ExecStart=3D/sbin/=
iscsiadm -m node --loginall=3Dautomatic<br>ExecStop=3D/bin/sync<br>ExecStop=
=3D/sbin/iscsiadm -m session --logout<br>SuccessExitStatus=3D21<br>RemainAf=
terExit=3Dtrue<br><br>[Install]<br>WantedBy=3Dremote-fs.target<br></div></d=
iv>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;open-iscsi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
Visit this group at <a href=3D"http://groups.google.com/group/open-iscsi">h=
ttp://groups.google.com/group/open-iscsi</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_217_5041631.1379957616345--

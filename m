From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] 98integrity: Use /etc/ima as dir for
 IMA policy and config file
Date: Wed, 30 Nov 2016 12:54:42 -0500
Message-ID: <155467b7-2361-337c-2b52-b68753f86f1e@linux.vnet.ibm.com>
References: <1480522734-975-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <OFAB3B0DDA.C5BDF803-ON0025807B.00603714-8525807B.0060434C@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1428271074=="
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
In-Reply-To: <OFAB3B0DDA.C5BDF803-ON0025807B.00603714-8525807B.0060434C@notes.na.collabserv.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
To: Stefan Berger <stefanb@us.ibm.com>
Cc: linux-ima-user@lists.sourceforge.net, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, harald@redhat.com

This is a multi-part message in MIME format.
--===============1428271074==
Content-Type: multipart/alternative;
 boundary="------------B20F340D9E82082C0C516E4A"

This is a multi-part message in MIME format.
--------------B20F340D9E82082C0C516E4A
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Harald,

   please do not apply this patch.

     Stefan
>
> >
> > From: Stefan Berger <stefanb@us.ibm.com>
> >
> > To sync with systemd, use the filepath /etc/ima/ima-policy as
> > the default file location for the IMA policy. At the same time we
> > move the ima config file location to /etc/ima/ima. Adapt the
> > documentation to the new path. Maintain backwards compatibility
> > by still reading the old files in case the new ones do not exist.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > ---
> >  modules.d/98integrity/README   |  8 ++++----
> >  modules.d/98integrity/ima-keys-load.sh   |  7 ++++++-
> >  modules.d/98integrity/ima-policy-load.sh | 20 +++++++++++++++++---
> >  3 files changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/modules.d/98integrity/README b/modules.d/98integrity/README
> > index 64de0ae..c8ccee5 100644
> > --- a/modules.d/98integrity/README
> > +++ b/modules.d/98integrity/README
> > @@ -33,10 +33,10 @@ line.
> >
> >  # Save the policy in a file.
> >
> > -# Create the configuration file '/etc/sysconfig/ima' to override
> > the path name of
> > +# Create the configuration file '/etc/ima/ima' to override the path 
> name of
> >  # the IMA custom policy.
> > -------------- '/etc/sysconfig/ima' (with the default value) 
> -------------
> > -IMAPOLICY="/etc/sysconfig/ima-policy"
> > +------------- '/etc/ima/ima' (with the default value) -------------
> > +IMAPOLICY="/etc/ima/ima-policy"
> > 
>  -------------------------------------------------------------------------
> >
> >
> > @@ -64,5 +64,5 @@ IMAPOLICY="/etc/sysconfig/ima-policy"
> >
> >  # 98integrity/ima-keys-load.sh script loads the signed certificates 
> stored
> >  # in the $IMAKEYSDIR onto the trusted IMA keyring.  The default 
> $IMAKEYSDIR
> > -# directory is /etc/keys/ima, but can be specified in the 
> /etc/sysconfig/ima
> > +# directory is /etc/keys/ima, but can be specified in the /etc/ima/ima
> >  # policy.
> > diff --git a/modules.d/98integrity/ima-keys-load.sh b/modules.d/
> > 98integrity/ima-keys-load.sh
> > index 659b722..922af1e 100755
> > --- a/modules.d/98integrity/ima-keys-load.sh
> > +++ b/modules.d/98integrity/ima-keys-load.sh
> > @@ -2,7 +2,10 @@
> >
> >  SECURITYFSDIR="/sys/kernel/security"
> >  IMASECDIR="${SECURITYFSDIR}/ima"
> > -IMACONFIG="${NEWROOT}/etc/sysconfig/ima"
> > +IMACONFIG="${NEWROOT}/etc/ima/ima"
> > +
> > +# for backwards compatibility
> > +IMACONFIG_OLD="${NEWROOT}/etc/sysconfig/ima"
> >
> >  load_x509_keys()
> >  {
> > @@ -11,6 +14,8 @@ load_x509_keys()
> >      # override the default configuration
> >      if [ -f "${IMACONFIG}" ]; then
> >          . ${IMACONFIG}
> > +    elif [ -f "${IMACONFIG_OLD}" ]; then
> > +        . ${IMACONFIG_OLD}
> >      fi
> >
> >      if [ -z "${IMAKEYDIR}" ]; then
> > diff --git a/modules.d/98integrity/ima-policy-load.sh b/modules.d/
> > 98integrity/ima-policy-load.sh
> > index 85cd3b9..a92b1bb 100755
> > --- a/modules.d/98integrity/ima-policy-load.sh
> > +++ b/modules.d/98integrity/ima-policy-load.sh
> > @@ -5,10 +5,19 @@
> >  # Copyright (C) 2011 Politecnico di Torino, Italy
> >  #  TORSEC group -- http://security.polito.it 
> <http://security.polito.it/>
> >  # Roberto Sassu <roberto.sassu@polito.it>
> > +#
> > +# Copyright (C) 2016 IBM Corporation
> > +#
> > +# Stefan Berger <stefanb@linux.vnet.ibm.com>
> > +#
> >
> >  IMASECDIR="${SECURITYFSDIR}/ima"
> > -IMACONFIG="${NEWROOT}/etc/sysconfig/ima"
> > -IMAPOLICY="/etc/sysconfig/ima-policy"
> > +IMACONFIG="${NEWROOT}/etc/ima/ima"
> > +IMAPOLICY="/etc/ima/ima-policy"
> > +
> > +# for backwards compatibility
> > +IMACONFIG_OLD="${NEWROOT}/etc/sysconfig/ima"
> > +IMAPOLICY_OLD="/etc/sysconfig/ima-policy"
> >
> >  load_ima_policy()
> >  {
> > @@ -21,11 +30,16 @@ load_ima_policy()
> >      fi
> >
> >      # override the default configuration
> > -    [ -f "${IMACONFIG}" ] && \
> > +    if [ -f "${IMACONFIG}" ]; then
> >          . ${IMACONFIG}
> > +    elif [ -f "${IMACONFIG_OLD}" ]; then
> > +        . ${IMACONFIG_OLD}
> > +    fi
> >
> >      # set the IMA policy path name
> >      IMAPOLICYPATH="${NEWROOT}${IMAPOLICY}"
> > +    [ ! -f "${IMAPOLICYPATH}" ] && \
> > +        IMAPOLICYPATH="${NEWROOT}${IMAPOLICY_OLD}"
> >
> >      # check the existence of the IMA policy file
> >      [ -f "${IMAPOLICYPATH}" ] && {
> > --
> > 2.8.3
> >
>


--------------B20F340D9E82082C0C516E4A
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <tt><font size=3D"2">Harald,<br>
        <br>
        =A0 please do not apply this patch.<br>
        <br>
        =A0=A0=A0 Stefan<br>
      </font></tt>
    <blockquote
cite=3D"mid:OFAB3B0DDA.C5BDF803-ON0025807B.00603714-8525807B.0060434C@notes=
.na.collabserv.com"
      type=3D"cite"><tt><font size=3D"2"><br>
          &gt; <br>
          &gt; From: Stefan Berger <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:stefanb@us.ibm.com">&lt;stefanb@us.ibm.com&gt;</a><br>
          &gt; <br>
          &gt; To sync with systemd, use the filepath
          /etc/ima/ima-policy as<br>
          &gt; the default file location for the IMA policy. At the same
          time we<br>
          &gt; move the ima config file location to /etc/ima/ima. Adapt
          the<br>
          &gt; documentation to the new path. Maintain backwards
          compatibility<br>
          &gt; by still reading the old files in case the new ones do
          not exist.<br>
          &gt; <br>
          &gt; Signed-off-by: Stefan Berger
          <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:stefanb@linux.v=
net.ibm.com">&lt;stefanb@linux.vnet.ibm.com&gt;</a><br>
          &gt; ---<br>
          &gt; =A0modules.d/98integrity/README =A0 =A0 =A0 =A0 =A0
          =A0 | =A08 ++++----<br>
          &gt; =A0modules.d/98integrity/ima-keys-load.sh =A0 | =A07 ++++++-=
<br>
          &gt; =A0modules.d/98integrity/ima-policy-load.sh | 20
          +++++++++++++++++---<br>
          &gt; =A03 files changed, 27 insertions(+), 8 deletions(-)<br>
          &gt; <br>
          &gt; diff --git a/modules.d/98integrity/README
          b/modules.d/98integrity/README<br>
          &gt; index 64de0ae..c8ccee5 100644<br>
          &gt; --- a/modules.d/98integrity/README<br>
          &gt; +++ b/modules.d/98integrity/README<br>
          &gt; @@ -33,10 +33,10 @@ line.<br>
          &gt; =A0<br>
          &gt; =A0# Save the policy in a file.<br>
          &gt; =A0<br>
          &gt; -# Create the configuration file '/etc/sysconfig/ima' to
          override
          <br>
          &gt; the path name of<br>
          &gt; +# Create the configuration file '/etc/ima/ima' to
          override the path
          name of<br>
          &gt; =A0# the IMA custom policy.<br>
          &gt; -------------- '/etc/sysconfig/ima' (with the default
          value) -------------<br>
          &gt; -IMAPOLICY=3D"/etc/sysconfig/ima-policy"<br>
          &gt; +------------- '/etc/ima/ima' (with the default value)
          -------------<br>
          &gt; +IMAPOLICY=3D"/etc/ima/ima-policy"<br>
          &gt;
=A0------------------------------------------------------------------------=
-<br>
          &gt; =A0<br>
          &gt; =A0<br>
          &gt; @@ -64,5 +64,5 @@ IMAPOLICY=3D"/etc/sysconfig/ima-policy"<br>
          &gt; =A0<br>
          &gt; =A0# 98integrity/ima-keys-load.sh script loads the signed
          certificates
          stored <br>
          &gt; =A0# in the $IMAKEYSDIR onto the trusted IMA keyring. =A0The
          default $IMAKEYSDIR<br>
          &gt; -# directory is /etc/keys/ima, but can be specified in
          the /etc/sysconfig/ima<br>
          &gt; +# directory is /etc/keys/ima, but can be specified in
          the /etc/ima/ima<br>
          &gt; =A0# policy.<br>
          &gt; diff --git a/modules.d/98integrity/ima-keys-load.sh
          b/modules.d/<br>
          &gt; 98integrity/ima-keys-load.sh<br>
          &gt; index 659b722..922af1e 100755<br>
          &gt; --- a/modules.d/98integrity/ima-keys-load.sh<br>
          &gt; +++ b/modules.d/98integrity/ima-keys-load.sh<br>
          &gt; @@ -2,7 +2,10 @@<br>
          &gt; =A0<br>
          &gt; =A0SECURITYFSDIR=3D"/sys/kernel/security"<br>
          &gt; =A0IMASECDIR=3D"${SECURITYFSDIR}/ima"<br>
          &gt; -IMACONFIG=3D"${NEWROOT}/etc/sysconfig/ima"<br>
          &gt; +IMACONFIG=3D"${NEWROOT}/etc/ima/ima"<br>
          &gt; +<br>
          &gt; +# for backwards compatibility<br>
          &gt; +IMACONFIG_OLD=3D"${NEWROOT}/etc/sysconfig/ima"<br>
          &gt; =A0<br>
          &gt; =A0load_x509_keys()<br>
          &gt; =A0{<br>
          &gt; @@ -11,6 +14,8 @@ load_x509_keys()<br>
          &gt; =A0 =A0 =A0# override the default configuration<br>
          &gt; =A0 =A0 =A0if [ -f "${IMACONFIG}" ]; then<br>
          &gt; =A0 =A0 =A0 =A0 =A0. ${IMACONFIG}<br>
          &gt; + =A0 =A0elif [ -f "${IMACONFIG_OLD}" ]; then<br>
          &gt; + =A0 =A0 =A0 =A0. ${IMACONFIG_OLD}<br>
          &gt; =A0 =A0 =A0fi<br>
          &gt; =A0<br>
          &gt; =A0 =A0 =A0if [ -z "${IMAKEYDIR}" ]; then<br>
          &gt; diff --git a/modules.d/98integrity/ima-policy-load.sh
          b/modules.d/<br>
          &gt; 98integrity/ima-policy-load.sh<br>
          &gt; index 85cd3b9..a92b1bb 100755<br>
          &gt; --- a/modules.d/98integrity/ima-policy-load.sh<br>
          &gt; +++ b/modules.d/98integrity/ima-policy-load.sh<br>
          &gt; @@ -5,10 +5,19 @@<br>
          &gt; =A0# Copyright (C) 2011 Politecnico di Torino, Italy<br>
          &gt; =A0# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
          =A0TORSEC group -- </font></tt><a moz-do-not-send=3D"true"
        href=3D"http://security.polito.it/"><tt><font size=3D"2">http://sec=
urity.polito.it</font></tt></a><tt><font
          size=3D"2"><br>
          &gt; =A0# Roberto Sassu <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:roberto.sassu@polito.it">&lt;roberto.sassu@polito.it&gt;</a><br>
          &gt; +#<br>
          &gt; +# Copyright (C) 2016 IBM Corporation<br>
          &gt; +#<br>
          &gt; +# Stefan Berger <a class=3D"moz-txt-link-rfc2396E" href=3D"=
mailto:stefanb@linux.vnet.ibm.com">&lt;stefanb@linux.vnet.ibm.com&gt;</a><b=
r>
          &gt; +#<br>
          &gt; =A0<br>
          &gt; =A0IMASECDIR=3D"${SECURITYFSDIR}/ima"<br>
          &gt; -IMACONFIG=3D"${NEWROOT}/etc/sysconfig/ima"<br>
          &gt; -IMAPOLICY=3D"/etc/sysconfig/ima-policy"<br>
          &gt; +IMACONFIG=3D"${NEWROOT}/etc/ima/ima"<br>
          &gt; +IMAPOLICY=3D"/etc/ima/ima-policy"<br>
          &gt; +<br>
          &gt; +# for backwards compatibility<br>
          &gt; +IMACONFIG_OLD=3D"${NEWROOT}/etc/sysconfig/ima"<br>
          &gt; +IMAPOLICY_OLD=3D"/etc/sysconfig/ima-policy"<br>
          &gt; =A0<br>
          &gt; =A0load_ima_policy()<br>
          &gt; =A0{<br>
          &gt; @@ -21,11 +30,16 @@ load_ima_policy()<br>
          &gt; =A0 =A0 =A0fi<br>
          &gt; =A0<br>
          &gt; =A0 =A0 =A0# override the default configuration<br>
          &gt; - =A0 =A0[ -f "${IMACONFIG}" ] &amp;&amp; \<br>
          &gt; + =A0 =A0if [ -f "${IMACONFIG}" ]; then<br>
          &gt; =A0 =A0 =A0 =A0 =A0. ${IMACONFIG}<br>
          &gt; + =A0 =A0elif [ -f "${IMACONFIG_OLD}" ]; then<br>
          &gt; + =A0 =A0 =A0 =A0. ${IMACONFIG_OLD}<br>
          &gt; + =A0 =A0fi<br>
          &gt; =A0<br>
          &gt; =A0 =A0 =A0# set the IMA policy path name<br>
          &gt; =A0 =A0 =A0IMAPOLICYPATH=3D"${NEWROOT}${IMAPOLICY}"<br>
          &gt; + =A0 =A0[ ! -f "${IMAPOLICYPATH}" ] &amp;&amp; \<br>
          &gt; + =A0 =A0 =A0 =A0IMAPOLICYPATH=3D"${NEWROOT}${IMAPOLICY_OLD}=
"<br>
          &gt; =A0<br>
          &gt; =A0 =A0 =A0# check the existence of the IMA policy file<br>
          &gt; =A0 =A0 =A0[ -f "${IMAPOLICYPATH}" ] &amp;&amp;
          {<br>
          &gt; -- <br>
          &gt; 2.8.3<br>
          &gt; <br>
        </font></tt><br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------B20F340D9E82082C0C516E4A--


--===============1428271074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kc3lzdGVtZC1k
ZXZlbCBtYWlsaW5nIGxpc3QKc3lzdGVtZC1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9zeXN0ZW1kLWRldmVs
Cg==

--===============1428271074==--


From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [Linux-ima-user] [PATCH 2/2] main: added
 support for loading IMA custom policies
Date: Mon, 20 Feb 2012 18:24:18 +0100
Message-ID: <20120220172418.GG26356@tango.0pointer.de>
References: <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
	<CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
	<4F3BDCAA.7040001@polito.it>
	<CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
	<4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>
	<4F3D06D1.7000404@polito.it>
	<CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
	<4F3D144D.3060102@polito.it>
	<CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
To: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, Michael Cassaniti <m.cassaniti@gmail.com>, linux-security-module@vger.kernel.org, Roberto Sassu <roberto.sassu@polito.it>, harald@redhat.com, ramunno@polito.it

On Thu, 16.02.12 19:50, Gustavo Sverzut Barbieri (barbieri@profusion.mobi) =
wrote:

> >> Then I wonder: why not make an ima-init binary that:
> >> =A0 - does ima_setup()
> >> =A0 - exec systemd || upstart || ...
> >>
> >> this way you only have to audit this very small file and not systemd
> >> itself, it's very early and so on.
> >>
> >
> > This does not work because SELinux is initialized inside Systemd and IMA
> > requires it for parsing LSM rules in the policy.
> =

> initramfs may do it as well, no? then systemd will inherit it.

We moved SELinux loading out of the initrd into systemd, in order to
support fully featured initrd-less boots. I don't think we should reopen
this problem set by having IMA in the initrd. I believe IMA should be
treated pretty much exactly like SELinux here: the policy should be
loaded from PID1 and it needs to be a compile time option, and it needs
a kernel cmdline option to disable it (i.e. like selinux=3D0).

Lennart

-- =

Lennart Poettering - Red Hat, Inc.

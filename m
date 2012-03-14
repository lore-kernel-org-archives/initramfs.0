From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH-v3 1/2] systemd: mount the securityfs
 filesystem at early stage
Date: Wed, 14 Mar 2012 17:54:14 +0100
Message-ID: <20120314165414.GA853@tango.0pointer.de>
References: <1331655340-11595-1-git-send-email-roberto.sassu@polito.it>
	<20120313173911.GY838@rampage> <4F5F9409.6060706@polito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <4F5F9409.6060706@polito.it>
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
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On Tue, 13.03.12 19:38, Roberto Sassu (roberto.sassu@polito.it) wrote:

> >>  static const MountPoint mount_table[] = {
> >>          { "proc",     "/proc",                  "proc",     NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
> >>          { "sysfs",    "/sys",                   "sysfs",    NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
> >>          { "devtmpfs", "/dev",                   "devtmpfs", "mode=755",          MS_NOSUID,                    true },
> >>+        { "securityfs", "/sys/kernel/security", "securityfs", NULL,              MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
> >
> >Failure to mount securtiyfs might be fatal for _your_ purposes, but I'd
> >wager that not only are some people not interested in this, but some
> >people (myself included) might not even have securityfs in their kernel.
> >
> 
> Hi Dave
> 
> i think i can change this to false without breaking
> the other code, because at the beginning of the new
> file 'src/ima-setup.c' i check for the IMA support in
> the kernel by checking the existence of the
> '/sys/kernel/security/ima' directory. If the mount
> fails, this will be handled as the same as when the
> IMA support is disabled in the kernel.
> This could be acceptable because IMA requires the
> security filesystem as dependency.
> 
> I'll wait for other comments before reposting the patches.

Yes, please change this. It is important to us that systemd works well
on kernels without any special security features enabled.

Also, may I ask you to turn this feature on in configure, by default? I
presume that machines with this feature built into systemd but with no
policy file around will boot just fine, right? Hence enabling this by
default shouldn't hurt.

(The reason that I want this enabled by default is that I -- or other
devs -- build this locally the code as comprehensively as possible so
that things don't start to bitrot that easily)

Lennart

-- 
Lennart Poettering - Red Hat, Inc.

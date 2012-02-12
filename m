From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: dracut: ordering of modules
Date: Sat, 11 Feb 2012 19:17:25 -0500
Message-ID: <1329005846.4201.39.camel@falcor>
References: <1328886121.2472.19.camel@falcor> <4F353840.8050505@polito.it>
	<20120210181413.GA13111@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20120210181413.GA13111@tango.0pointer.de>
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
To: Lennart Poettering <mzerqung@0pointer.de>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, selinux@lists.fedoraproject.org, linux-kernel@vger.kernel.org, Harald@freedesktop.org, Roberto Sassu <roberto.sassu@polito.it>, Hoyer <harald@redhat.com>

On Fri, 2012-02-10 at 19:14 +0100, Lennart Poettering wrote:
> On Fri, 10.02.12 16:31, Roberto Sassu (roberto.sassu@polito.it) wrote:
> 
> > 
> > Hi Mimi
> > 
> > i'm CCing the systemd and Fedora SELinux mailing lists.
> > 
> > Unfortunately, the SELinux policy initialization (at least
> > in Fedora 16) has been moved to systemd, so, now, loading an
> > IMA policy cannot be done in the initial ramdisk.
> > 
> > Further, the SELinux policy loading code is not in a unit file
> > but embedded in the main binary, which means that the new code for
> > loading IMA policies must be added just after that point.
> > 
> > I already wrote a patch for this. I need some time to test it
> > and will post in the systemd mailing list at the beginning of
> > the next week.

Thanks Roberto!
 
> Hmm, what is this about? You need a place to load additional security
> policies into the kernel at early boot? For SELinux that indeed takes
> place from within PID 1 now in systemd. I'd expect that other security
> technologies like AppArmor should work the same.

The IMA measurement/appraisal policy, which is described in
Documentation/ABI/testing/ima_policy, can be based on a number
of criteria.  One of these criteria are LSM subj/obj labels. The IMA
measurement/appraisal policy should be loaded as early as possible, but
only after the LSM policy has been loaded.

Mimi

> If you want to hack on this basing your work on selinux-setup.c in the
> systemd tree should be fairly easy.
> 
> Lennart

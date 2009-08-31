From: Jon Masters <jcm@redhat.com>
Subject: Re: Issues with dracut and network device naming
Date: Mon, 31 Aug 2009 11:16:10 -0400
Message-ID: <1251731770.6053.4.camel@perihelion.bos.jonmasters.org>
References: <4A97CA1A.5080606@redhat.com>
	<1251470171.1305.144.camel@perihelion.bos.jonmasters.org>
	<4A9BB155.8020106@redhat.com>
Reply-To: Discussion of Development and Customization of the Red Hat Linux
	Installer <anaconda-devel-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <anaconda-devel-list-bounces@redhat.com>
In-Reply-To: <4A9BB155.8020106@redhat.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/anaconda-devel-list>, 
	<mailto:anaconda-devel-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/anaconda-devel-list>
List-Post: <mailto:anaconda-devel-list@redhat.com>
List-Help: <mailto:anaconda-devel-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/anaconda-devel-list>, 
	<mailto:anaconda-devel-list-request@redhat.com?subject=subscribe>
Sender: anaconda-devel-list-bounces@redhat.com
Errors-To: anaconda-devel-list-bounces@redhat.com
Content-Type: text/plain; charset="us-ascii"
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list@redhat.com>
Cc: initramfs <initramfs@vger.kernel.org>

On Mon, 2009-08-31 at 13:17 +0200, Hans de Goede wrote:

> But in the future it could also be something like for example:
> ifname=eth0:/sys/devices/bus/pci/00:00:00:01.5

Right. Prarit and others are looking at how to expose the DMI-provided
slot information in e.g. sysfs - so then you'll have an entry that's a
symlink pointing to the device, setup according to the hardware vendor.

Jon.

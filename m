From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Issues with dracut and network device naming
Date: Mon, 31 Aug 2009 13:17:41 +0200
Message-ID: <4A9BB155.8020106@redhat.com>
References: <4A97CA1A.5080606@redhat.com>
	<1251470171.1305.144.camel@perihelion.bos.jonmasters.org>
Reply-To: Discussion of Development and Customization of the Red Hat Linux
	Installer <anaconda-devel-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <anaconda-devel-list-bounces@redhat.com>
In-Reply-To: <1251470171.1305.144.camel@perihelion.bos.jonmasters.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list@redhat.com>
Cc: initramfs <initramfs@vger.kernel.org>

Hi all,

On 08/28/2009 04:36 PM, Jon Masters wrote:
> On Fri, 2009-08-28 at 14:14 +0200, Hans de Goede wrote:
>
>> When using iscsi for example, an interface name (usually eth#) is
>> specified on the dracut cmdline, but if a machine has multiple nics
>> the probe order done by dracut may very well differ as the one
>> which was used during install when the dracut cmdline gets generated.
>
> It's worth talking to Prarit about this stuff because he's looking into
> persistent network device naming issues in general. I'm sure you know,
> but there's a generic DMI extension that allows you to determine from
> the system what the PCI slot->device name mapping should be so that e.g.
> moving the disk from one system to another doesn't affect the naming.
>
> Of course this only works on systems with the requisite SMBUS/DMI
> extension *but* it will (eventually) be a nice solution to the naming
> issues and worth working with him on if you're not already.
>

Hmm, well I really want to have something in place soon, and currently
all Fedora persistent network device naming is done based on MAC.

But I would like to keep possibilities like this open for the future, so
I'll go ahead and implement Seewer's suggeston to use a separate cmdline
arg for this called ifname, for now we will then have / use:
ifname=eth0:aa:bb:cc:dd:ee:ff

But in the future it could also be something like for example:
ifname=eth0:/sys/devices/bus/pci/00:00:00:01.5

Regards,

Hans

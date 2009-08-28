From: Harald Hoyer <harald@redhat.com>
Subject: Re: Issues with dracut and network device naming
Date: Fri, 28 Aug 2009 14:43:37 +0200
Message-ID: <4A97D0F9.9020302@redhat.com>
References: <4A97CA1A.5080606@redhat.com>
Reply-To: Discussion of Development and Customization of the Red Hat Linux
	Installer <anaconda-devel-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <anaconda-devel-list-bounces@redhat.com>
In-Reply-To: <4A97CA1A.5080606@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>
Cc: initramfs <initramfs@vger.kernel.org>, Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list@redhat.com>

On 08/28/2009 02:14 PM, Hans de Goede wrote:
> Hi all,
>
> When using iscsi for example, an interface name (usually eth#) is
> specified on the dracut cmdline, but if a machine has multiple nics
> the probe order done by dracut may very well differ as the one
> which was used during install when the dracut cmdline gets generated.
>
> For the fcoe support I've allowed specifying a mac address instead,
> however this has issues too. As now the udev run from rc.sysinit
> complains it cannot rename the interface to what the running system
> expects as the interface is busy (oops).
>
> So it looks like we need to somehow tell dracut to use the same
> mac <-> interface name mapping as during the running system.
>
> One way of doing this would be to have a configuration initrd with
> the persistent net rules. But I see multiple issues with this:
>
> 1) I'm not sure all bootloaders support loading multiple initrd's
> and I'm not sure dracut supports having files over multiple
> initrd's at the moment either
>
> 2) Merging the generic initrd and the config initrd, although it
> should be safe may turn out fragile
>
> 3) To me the biggest problem. Currently what dracut does is very
> transparent, if we know the cmdline and the hardware configuration /
> disk layouts, we should be able to predict what it is going to do
> Once we start hiding configration inside an image file, it becames
> less transparent
>
> 4) I don't know how well the persistent network device rules and our
> current generated during boot network device rules play together.
> The current generated rules do not seem to be ready for handling
> device name changes
>
> So I would like to propose another solution for this, allow specifying
> both an interface-name and a mac with ip=, and then have the dracut
> generated rules do the rename and init. This way problems 3) and 4)
> above are solved, and we can easily also write the mac address to
> grub.conf from anaconda when generating the ip= cmdline.

yes, sane solution .. +1

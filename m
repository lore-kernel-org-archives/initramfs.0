From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Issues with dracut and network device naming
Date: Fri, 28 Aug 2009 16:16:42 +0200
Message-ID: <4A97E6CA.2020200@redhat.com>
References: <4A97CA1A.5080606@redhat.com> <4A97D0F9.9020302@redhat.com>
	<4A97D17F.10405@bfh.ch>
Reply-To: Discussion of Development and Customization of the Red Hat Linux
	Installer <anaconda-devel-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <anaconda-devel-list-bounces@redhat.com>
In-Reply-To: <4A97D17F.10405@bfh.ch>
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
To: Seewer Philippe <philippe.seewer@bfh.ch>
Cc: initramfs <initramfs@vger.kernel.org>, Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list@redhat.com>, Harald Hoyer <harald@redhat.com>

Hi,

On 08/28/2009 02:45 PM, Seewer Philippe wrote:
>
>
> Harald Hoyer wrote:
> [snip]
>>> So I would like to propose another solution for this, allow specifying
>>> both an interface-name and a mac with ip=, and then have the dracut
>>> generated rules do the rename and init. This way problems 3) and 4)
>>> above are solved, and we can easily also write the mac address to
>>> grub.conf from anaconda when generating the ip= cmdline.
>>
>> yes, sane solution .. +1
> Yes, +1 as well. I'd vote for not doing this inside the ip= parameter,
> but use something like ifname=iface:mac.
>

Hmm, I'm not so sure about that, it sure would be easier for the genrules
script to have all the info in one place, instead of having to piece
bits together.

Regards,

Hans

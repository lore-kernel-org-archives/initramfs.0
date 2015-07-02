From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: IP configuration with dhcp
Date: Thu, 2 Jul 2015 15:26:58 +0200
Message-ID: <55953C22.8020403@redhat.com>
References: <a82892e788a77d505b9b4bedd690e480.squirrel@postweb.cs.tu-dortmund.de>
 <55953BDF.9090503@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55953BDF.9090503-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Pleger <Christoph.Pleger-ogaGWlaKng3jEoi5djuKH7NAH6kLmebB@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02.07.2015 15:25, Harald Hoyer wrote:
> On 02.07.2015 11:08, Christoph Pleger wrote:
>> Hello,
>>
>> I want to create a Debian Live DVD, with dracut as initrd tool. That is, I
>> already had the Live system running successfully, but IP configuration had
>> to be entered manually after boot from DVD. The grub menuitem for that
>> contains the following line to define the kernel and its parameters:
>>
>> linux   /vmlinuz root=/dev/cdrom ro aufs
>>
>> Then, I had the idea to add an option for automatic IP configuration by
>> DHCP. I expected it to work by adding a new grub menuitem with the
>> following line for the kernel:
>>
>> linux   /vmlinuz root=/dev/cdrom ip=dhcp ro aufs
>>
>> But that does not work, no configuration is set for eth0. But if the
>> chroot-Directory I created the DVD from is taken as NFSROOT and the
>> computer is booted by PXE, with the following in pxelinux.cfg/default
>>
>> DEFAULT vmlinuz initrd=initrd.img root=dhcp ip=dhcp ro aufs
>>
>> then eth0 gets its configuration from DHCP.
>>
>> So, does dracut only support automatic IP configuration by DHCP if
>> "root=dhcp" is set, or is there something I can change in the kernel
>> parameters to make automatic IP configuration work when booting from DVD?
>>
>> Regards
>>   Christoph
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> try "ip=dhcp rd.neednet=1"


or better, if you know the interface in advance "ip=eth0:dhcp rd.neednet=1"
otherwise dracut tries dhcp on every interface.

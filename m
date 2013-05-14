From: "Joseph D. Wagner" <joe-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Mon, 13 May 2013 20:53:29 -0700
Message-ID: <5191B539.9000705@josephdwagner.info>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info> <alpine.LFD.2.03.1305141317480.30473@beren.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.03.1305141317480.30473-N07bVqg5a7VBDLzU/O5InQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


On 05/13/2013 08:22 PM, Michael Chapman wrote:
> On Mon, 13 May 2013, Joseph D. Wagner wrote:
>> I'm pretty sure this is needed for resume-from-suspend.  My money is 
>> on a configuration problem. I'd be happy to take a look.
>
> Wonderful! First, I should point out I've also got LVM:
>
>   LV   VG      Attr      LSize   Pool Origin Data%  Move Log Copy%  
> Convert
>   home ogopogo -wi-ao--- 31.46g
>   root ogopogo -wi-ao--- 31.46g
>   swap ogopogo -wi-ao---  8.39g
>
> So /etc/crypttab references these LVs:
>
>   luks-home /dev/ogopogo/home none
>   luks-swap /dev/ogopogo/swap /dev/urandom swap
>
> And /etc/fstab references the swap volume by device mapper name (can't 
> use UUID, of course, since that changes on each mkswap):
>
>   UUID=c73aa277-ff32-42d0-a6f1-681694ba7b36 /         ext4 
> defaults                            1 1
>   UUID=009ef157-66a8-42cb-869e-436244f39ca2 /boot     ext4 
> defaults                            1 2
>   UUID=1400-EDC0                            /boot/efi vfat 
> defaults,umask=0077,shortname=winnt 0 0
>   UUID=50c2abf5-84b0-4752-b527-e94b82b208f8 /home     ext4 
> defaults                            1 2
>   /dev/mapper/luks-swap                     swap      swap 
> defaults                            0 0
>
> /proc/partitions:
>
>   major minor  #blocks  name
>
>      8        0  175825944 sda
>      8        1     204800 sda1
>      8        2     512000 sda2
>      8        3   74768384 sda3
>     11        0    1048575 sr0
>    253        0   32985088 dm-0
>    253        1   32985088 dm-1
>    253        2    8794112 dm-2
>    253        3    8794112 dm-3
>    253        4   32983040 dm-4
>
> /proc/cmdline:
>
>   BOOT_IMAGE=/vmlinuz-3.9.1-301.fc19.x86_64 
> root=/dev/mapper/ogopogo-root ro rhgb quiet

/dev/ogopogo might not be available at that point in the boot process.  
I must admit that I don't fully understand the rules that go into udev.

I would try changing the second entry in your crypttab file to the UUID 
of the underlying device.  For example, my crypttab looks like this:

swap UUID=bfd3a748-bfcd-49dd-992e-d061847ef33d none
userdata1 UUID=c2119916-20e6-45f2-87d7-26012cefba59 none
userdata2 UUID=2e8d7701-7b52-4ebc-b62f-8bd2774457bf none

In my case, the UUID is the luks UUID, but I *believe* it can be the 
UUID of the underlying device.  See here for examples:
http://ubuntuforums.org/showthread.php?t=1080760

Be sure to regenerate your initramfs after changing your crypttab file.

If this doesn't fix it for you, then I'm out of ideas.  Sorry, but I'm 
not the most knowledgeable person on this list.

Joseph D. Wagner


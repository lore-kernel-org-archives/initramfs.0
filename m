From: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Tue, 14 May 2013 13:22:28 +1000 (EST)
Message-ID: <alpine.LFD.2.03.1305141317480.30473@beren.home>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5191AA29.3010107-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Joseph D. Wagner" <joe-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 13 May 2013, Joseph D. Wagner wrote:
> I'm pretty sure this is needed for resume-from-suspend.  My money is on a 
> configuration problem.  I'd be happy to take a look.

Wonderful! First, I should point out I've also got LVM:

   LV   VG      Attr      LSize   Pool Origin Data%  Move Log Copy%  Convert
   home ogopogo -wi-ao--- 31.46g
   root ogopogo -wi-ao--- 31.46g
   swap ogopogo -wi-ao---  8.39g

So /etc/crypttab references these LVs:

   luks-home /dev/ogopogo/home none
   luks-swap /dev/ogopogo/swap /dev/urandom swap

And /etc/fstab references the swap volume by device mapper name (can't use 
UUID, of course, since that changes on each mkswap):

   UUID=c73aa277-ff32-42d0-a6f1-681694ba7b36 /         ext4 defaults                            1 1
   UUID=009ef157-66a8-42cb-869e-436244f39ca2 /boot     ext4 defaults                            1 2
   UUID=1400-EDC0                            /boot/efi vfat defaults,umask=0077,shortname=winnt 0 0
   UUID=50c2abf5-84b0-4752-b527-e94b82b208f8 /home     ext4 defaults                            1 2
   /dev/mapper/luks-swap                     swap      swap defaults                            0 0

/proc/partitions:

   major minor  #blocks  name

      8        0  175825944 sda
      8        1     204800 sda1
      8        2     512000 sda2
      8        3   74768384 sda3
     11        0    1048575 sr0
    253        0   32985088 dm-0
    253        1   32985088 dm-1
    253        2    8794112 dm-2
    253        3    8794112 dm-3
    253        4   32983040 dm-4

/proc/cmdline:

   BOOT_IMAGE=/vmlinuz-3.9.1-301.fc19.x86_64 root=/dev/mapper/ogopogo-root ro rhgb quiet

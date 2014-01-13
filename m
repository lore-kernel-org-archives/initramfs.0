From: Tim Mohlmann <muhlemmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Advanced dracut use help or tips needed.
Date: Mon, 13 Jan 2014 11:02:55 +0100
Message-ID: <CAHOCc1_kvKEoXBxaZXGehGp0yEQ+=a3nZLqiLk3x609ktPrGpA@mail.gmail.com>
References: <1729487458.368641100.1389443150192.JavaMail.root@spooler6-g27.priv.proxad.net>
	<1726532839.368644133.1389443257576.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=m6LzEb2vlSTpXK/HizOPTjjKOF5rfMEqjcoNDO8cEYA=;
        b=t5dZZPF3Fo/XnFJUTOJbnUWvLDoit7Jb+xjNC/DHwAz9yTzdpy05Js7yhXEdCxoMsM
         htaFpTuarYUR+Mbp7lBTd4kp0TEFz01TEDh9s0YNShyaWh87a1HNbB9xQBh3Q3o506lt
         ftZhTg3FaDBYv6sZpACGzg+lPbgOC0OxEZf7tgHTxEr6XX0SCI/1kTQd//FK9XxfqGvQ
         Ge4q/ZNaAXA51WQ4Lq7otifdBuKPlHapLOgOh1K35f3mZO/QSP46m88e8eMXk6CEkw3U
         fq4+eJSoLplLNxIbwU0mHP5fPncraYNufrYgaaLWe5x4jLyxy1OH18KZUHrhDGjL7GvY
         yH7w==
In-Reply-To: <1726532839.368644133.1389443257576.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: olivier.lahaye1-GANU6spQydw@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm not sure if dracut is the correct weapon of choice for automatic
linux install deployment. Dracut is a event driven initramfs. Means it
waits for events to do all operations necessary to mount your root
partition.

Dracut uses udev to monitor for events to happen. Udev is either
supplied separately or together in the systemd package of your distro.
Also, dracut includes kernel modules present for the version you are
generating for. Means you need the kernel modules present on the same
system as where you are generating the dracut image.

It is possible to hook in your own scripts. Maybe binaries. But then
you need static ones, or include all the libs they depend on
(including glibc) making your initramfs a beast.

I would recommend to either use dracut to mount a nfs as root. On the
nfs host you just need to install a basic linux system with all the
tools necessary to partition and install your system.

Another way is to use busybox in a manual created initramfs. Busybox
at least provide you with some standard binaries: wget, httpd, gunzip,
mk2fs and a shell whit quite some functionality. But I guess this is a
bit of topic for this list, but I used to use it before I found
dracut. If you need a quickstart guide, send me a message directly.

Br, Tim

2014/1/11  <olivier.lahaye1-GANU6spQydw@public.gmane.org>:
>
> Hi,
>
> Please forgive me if this is the wrong list to post, but I didn't find any other places to ask what I'm looking for regarding advanced usage of dracut.
>
> I'm part of systemimager developpers, a tool to build and deploy linux images on computers (often used in clusters to deploy nodes).
>
> This perl software is building it's own initramfs from scratch (build kernel and all content), unfortunately, this is problematic as it needs a recent kernel to support latest hardware.(detect disk or net adapters)
> Unfortunateley, trying to build everything on an rhel6 distro for example will result in bad binaries. Indeed, if we build kernel 3.10 on a 2.6 kernel (it works), but then building lvm tools (bad binaries) as the tools will be built with kernel 2.6 system includes and run on a 3.10 kernel resulting at best in crashes and at worse in data loss.
> More over, it is based on udev only (no systemd or network manager). thus, now it's even more difficult to build it (difficult to build udev without systemd, ...)
>
> My aim would be to drop this old way of doing stuff and use dracut to build a bootable image using system installed binaries. Indeed, this image is only used to boot the node, create disk partition table, format partitions, init network download some post install scripts, start a custom deployment monitoring daemon and copy the image from server using preconfigured method (either rsync, nfs, bittorrent, ...) (and reboot)
> As linux vendors are backporting support for latest hardware, having the latest binaries is not needed anymore. using booted system materials will be sufficient.
>
> For example, here is the actual content of the initrd_template we are using: http://olivier.lahaye1.free.fr/OSCAR/initrd_template.txt
> It has no second stage and it is far from being optimized but it does more or less what we need.
>
> Despite my googleing, I've been unable to find examples other than creating a basic initial ramdisk for booting an installed OS. I was even unable to find how the fedora or redhat pxe boot image were created (and how they are built).
>
> what I'm looking for would be some sort of comand that would do:
>
> dracut --include-all-network-drivers --include-all-disk-drivers --include-nfsandother_drivers --put_what_is_needed_for_an_advanced_initramfs(udev+systemd+networkmanager+...) --put_buzybox --add_binaries_from_running_system <list_of_binaries.txt> --add_binaries_required_libs_from_system --add_other_files --start_inital_system_tasks_like_systemd_then_jump_to_our_rcS_script
>
> I'd greatly apreciate any help, tip on how to proceed or even pointer to pages describing how the distro installation initial pxe disks are build (for example how the code calling the second stage is put into the image and from when it is taken from).
>
> Best regards.
>
> --
>   Olivier LAHAYE
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

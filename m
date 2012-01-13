From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut and root filesystem UUIDs
Date: Fri, 13 Jan 2012 15:06:25 +0100
Message-ID: <4F103A61.1070907@redhat.com>
References: <4F101BA1.5000903@ed.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F101BA1.5000903-5WhEfG1TI8k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alastair Scobie <ascobie-5WhEfG1TI8k@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 13.01.2012 12:55, Alastair Scobie wrote:
> Apologies if this is the incorrect mailing list to discuss this issue..
> 
> Does anyone know if there is a way to configure dracut such that
> it will not attempt to mount USB mass-storage devices at boot time,
> but will still allow mounting of such devices once a system (in our
> case ScientifcLinux6) is fully booted?
> 
> Why do we want to do this? We run several large teaching labs running
> SL6 desktops. We mount filesystems by UUID. We are concerned that our
> students could install a USB memory stick, at boot time, with a
> filesystem with the same UUID as the "official" root filesystem so
> fooling dracut into mounting a trojan filesystem.
> 
> Thanks, in advance, for any ideas..
> 
> Alastair Scobie
> 
> 

specifying "root=UUID=<uuid> rd.shell=0" will do exactly what you want. Then you
also want to secure grub (or any other bootloader) with a password.

From: Alastair Scobie <ascobie-5WhEfG1TI8k@public.gmane.org>
Subject: Dracut and root filesystem UUIDs
Date: Fri, 13 Jan 2012 11:55:13 +0000
Message-ID: <4F101BA1.5000903@ed.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alastair Scobie <ascobie-5WhEfG1TI8k@public.gmane.org>

Apologies if this is the incorrect mailing list to discuss this issue..

Does anyone know if there is a way to configure dracut such that
it will not attempt to mount USB mass-storage devices at boot time,
but will still allow mounting of such devices once a system (in our
case ScientifcLinux6) is fully booted?

Why do we want to do this? We run several large teaching labs running
SL6 desktops. We mount filesystems by UUID. We are concerned that our
students could install a USB memory stick, at boot time, with a
filesystem with the same UUID as the "official" root filesystem so
fooling dracut into mounting a trojan filesystem.

Thanks, in advance, for any ideas..

Alastair Scobie


-- 
Alastair Scobie
Head of Computing, School of Informatics, University of Edinburgh

10 Crichton Street, Edinburgh, Scotland, EH8 9AB
Mail: ascobie-5WhEfG1TI8k@public.gmane.org   Voice: 0131 650 5178


The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.

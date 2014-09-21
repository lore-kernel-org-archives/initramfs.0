From: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Hardlinks in initrd
Date: Sun, 21 Sep 2014 17:00:22 +0400
Message-ID: <lvmi56$3m0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I am looking into init/initramfs.c code where cpio being unpacked onto
tmpfs (or ramfs) root filesystem.

The question is how are the hardlinks handled here?

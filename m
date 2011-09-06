From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: build initramfs: explain modprobe?
Date: Tue, 06 Sep 2011 08:34:32 -0700
Message-ID: <4E663D88.7060603@bitwagon.com>
References: <4E5D68A0.8020006@bitwagon.com> <4E5E25DA.4060802@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5E25DA.4060802-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>> What properties of modprobe are essential for building initramfs?
>> [snip]

> And yes, "modprobe" is only used to easily get the requirements.

Explicitly:
  0) Expand short names: "pcmcia" ==> "kernel/drivers/pcmcia/pcmcia.ko".
  1) Compute transitive closure of Requires from modules.dep.
  2) Ignore modules listed in modules.builtin.
  3) Handle aliasing of underscore and minus:
     "usb_storage" ==> "usb-storage".

-- 

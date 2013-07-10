From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v1] dracut.sh: Support early microcode loading.
Date: Wed, 10 Jul 2013 09:37:11 +0200
Message-ID: <51DD0F27.70202@redhat.com>
References: <1373397849-11397-1-git-send-email-konrad.wilk@oracle.com> <3E5A0FA7E9CA944F9D5414FEC6C712205A528195@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C712205A528195-P5GAC/sN6hlZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/10/2013 02:29 AM, Yu, Fenghua wrote:
>> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org]
>> Sent: Tuesday, July 09, 2013 12:24 PM
>> Implement it per Linux kernel Documentation/x86/early-microcode.txt
>> (from v3.11-rc0):
[...]
> This patch works fine with one microcode blob in binary format. There are situations that the microcode is not delivered in one blob in binary format:
> 
> First, each microcode patch is one file instead all microcode patches are in one big blob. Secondly, old delivered microcode file is in ascii format.
> 
> To handle those formats, additional code needs to convert the formats into one big binary microcode blob. I'm not sure if we should consider the code and if we should put the code in dracut.
> 
> Thanks.
> 
> -Fenghua
> 


$ ls /lib/firmware/amd-ucode
microcode_amd.bin  microcode_amd_fam15h.bin  microcode_amd_solaris.bin
$ ls /lib/firmware/intel-ucode
06-03-02  06-06-00  06-07-02  06-08-0a  06-0b-04  06-0f-06  06-16-01  06-1c-02
06-25-02  06-2d-07  0f-01-02  0f-02-09  0f-04-03  0f-04-0a
06-05-00  06-06-05  06-07-03  06-09-05  06-0d-06  06-0f-07  06-17-06  06-1c-0a
06-25-05  06-2f-02  0f-02-04  0f-03-02  0f-04-04  0f-06-02
06-05-01  06-06-0a  06-08-01  06-0a-00  06-0e-08  06-0f-0a  06-17-07  06-1d-01
06-26-01  06-3a-09  0f-02-05  0f-03-03  0f-04-07  0f-06-04
06-05-02  06-06-0d  06-08-03  06-0a-01  06-0e-0c  06-0f-0b  06-17-0a  06-1e-04
06-2a-07  0f-00-07  0f-02-06  0f-03-04  0f-04-08  0f-06-05
06-05-03  06-07-01  06-08-06  06-0b-01  06-0f-02  06-0f-0d  06-1a-04  06-1e-05
06-2d-06  0f-00-0a  0f-02-07  0f-04-01  0f-04-09  0f-06-08

Also, for [[ $hostonly ]], we only want to add the current running CPU microcode.

Also, why does it have to be a separate cpio? Doesn't it work, if the files are
in the normal, single initramfs?

From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC v1] dracut.sh: Support early microcode loading.
Date: Wed, 10 Jul 2013 07:13:45 -0400
Message-ID: <8983176f-ddd7-43c3-9b41-0a912e640ff1@email.android.com>
References: <1373397849-11397-1-git-send-email-konrad.wilk@oracle.com> <3E5A0FA7E9CA944F9D5414FEC6C712205A528195@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C712205A528195-P5GAC/sN6hlZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

"Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org]
>> Sent: Tuesday, July 09, 2013 12:24 PM
>> Implement it per Linux kernel Documentation/x86/early-microcode.txt
>> (from v3.11-rc0):
>> 
>> <start>

>
>This patch works fine with one microcode blob in binary format. There
>are situations that the microcode is not delivered in one blob in
>binary format:
>
>First, each microcode patch is one file instead all microcode patches
>are in one big blob. Secondly, old delivered microcode file is in ascii
>format.
>
>To handle those formats, additional code needs to convert the formats
>into one big binary microcode blob. I'm not sure if we should consider
>the code and if we should put the code in dracut.
>
>Thanks.
>
>-Fenghua
>--
>To unsubscribe from this list: send the line "unsubscribe initramfs" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

The code already puts all of the microcode files in one big file per vendor. 

Ther are no Ascii files in /lib/firmware/intel_ucode directory.  That has been the situation for many years -  otherwise the existing microcode loading mechanism under Linux would complain that the microcode firmware is bogus. 
-- 
Sent from my Android phone. Please excuse my brevity.

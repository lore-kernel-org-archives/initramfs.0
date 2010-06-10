From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut and multiple iscsi/network disks
Date: Thu, 10 Jun 2010 10:19:48 +0200
Message-ID: <4C10A024.80802@redhat.com>
References: <4C0FB779.30005@redhat.com> <20100610070647.GA23726@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100610070647.GA23726-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/10/2010 09:06 AM, Luca Berra wrote:
> On Wed, Jun 09, 2010 at 05:47:05PM +0200, Harald Hoyer wrote:
>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=169f16715145fd087d61ef7fdfd7e9a3cbb68fc9
>>
>>
>> adds support for multiple iscsi disks with the syntax:
>>
>> root=<normal block path or UUID or LABEL> \
>> netroot=iscsi:... netroot=iscsi:... netroot=iscsi:...
>>
>> which is suboptimal, because you can't specify it in the dhcp protocol.
>>
>> A better syntax would be a single netroot (also for FCoE disk)
>> something like:
>>
>> netroot=netdisks:iscsi:...[separator]iscsi:...[separator]fcoe:...
>>
> be warned that DHCP option format is generally
> code: 1 byte
> lenght: 1 byte
> data: lenght bytes
>
> which would limit the lenght of the netroot string to 255 charachters
> anyway.
>
> L.
>

255 chars can be sufficient for up to 4 disks

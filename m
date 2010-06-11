From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut and multiple iscsi/network disks
Date: Fri, 11 Jun 2010 12:40:18 +0200
Message-ID: <4C121292.5030805@redhat.com>
References: <4C0FB779.30005@redhat.com> <4C11D27C.3020807@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C11D27C.3020807-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/11/2010 08:06 AM, Hans de Goede wrote:
> Hi,
>
> On 06/09/2010 05:47 PM, Harald Hoyer wrote:
>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=169f16715145fd087d61ef7fdfd7e9a3cbb68fc9
>>
>>
>>
>> adds support for multiple iscsi disks with the syntax:
>>
>> root=<normal block path or UUID or LABEL> \
>> netroot=iscsi:... netroot=iscsi:... netroot=iscsi:...
>>
>> which is suboptimal, because you can't specify it in the dhcp protocol.
>>
>> A better syntax would be a single netroot (also for FCoE disk) something
>> like:
>>
>> netroot=netdisks:iscsi:...[separator]iscsi:...[separator]fcoe:...
>>
>> What do you think? Any better ideas?
>>
>
> I think that will be a pain for the cmdline generating code in anaconda,
> one argument per disk please. Note having this as netroot syntax and
> a separate iscsi_disk= for the one argument per disk case would be fine.
>
> Regards,
>
> Hans

We could support both.. iscsi_disk= and the combined netroot=

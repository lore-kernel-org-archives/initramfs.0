From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: automatically add "unix" kernel module
Date: Fri, 12 Aug 2011 08:47:43 +0200
Message-ID: <4E44CC8F.9090202@redhat.com>
References: <1824774.VrzXCv2fyA@ernie> <4E44C1B0.7050605@redhat.com> <j22hvk$i9s$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j22hvk$i9s$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.08.2011 08:41, WANG Cong wrote:
> On Fri, 12 Aug 2011 08:01:20 +0200, Harald Hoyer wrote:
> 
>> On 12.08.2011 01:01, Dennis Schridde wrote:
>>> Hello!
>>>
>>> Dracut currently does not seem to automatically include the "unix"
>>> kernel module in the initramfs, which causes udev to be unable to start
>>> ("address family not supported by protocol").
>>>
>>> It should be adjusted to include it if possible.
>>>
>>> I am using dracut-011 and had to set add_drivers+="unix" in dracut.conf
>>> to be able to boot my system.
>>>
>>> Kind regards,
>>> Dennis
>>
>> Just add a file /etc/modprobe.d/myaliases.conf to your system,
>> containing: alias net-pf-1 unix
> 
> The kernel already does the same thing:
> 
> MODULE_ALIAS_NETPROTO(PF_UNIX);
> 
> don't know why udev can't load it automatically...

Not udev... it should be kernel itsself via:

$ cat /proc/sys/kernel/modprobe
/sbin/modprobe

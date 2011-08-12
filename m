From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: automatically add "unix" kernel module
Date: Fri, 12 Aug 2011 10:09:54 +0200
Message-ID: <4E44DFD2.8070601@redhat.com>
References: <1824774.VrzXCv2fyA@ernie> <4E44C1B0.7050605@redhat.com> <2596808.kGfioqbkmA@ernie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2596808.kGfioqbkmA@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.08.2011 09:58, Dennis Schridde wrote:
> Hello!
> 
> Please CC me, since I am not on the list.
> 
> Am Freitag, 12. August 2011, 06:41:56 schrieb WANG Cong:
>> On Fri, 12 Aug 2011 08:01:20 +0200, Harald Hoyer wrote:
>>> On 12.08.2011 01:01, Dennis Schridde wrote:
>>>> Dracut currently does not seem to automatically include the "unix"
>>>> kernel module in the initramfs, which causes udev to be unable to start
>>>> ("address family not supported by protocol").
>>>
>>> Just add a file /etc/modprobe.d/myaliases.conf to your system,
>>> containing: alias net-pf-1 unix
>>
>> The kernel already does the same thing:
>>
>> MODULE_ALIAS_NETPROTO(PF_UNIX);
>>
>> don't know why udev can't load it automatically...
> 
> The problem is that dracut does not automatically include the "unix" module in 
> the initramfs it generates. If I include the module manually (via 
> "add_drivers" in dracut.conf) it will be successfully loaded.

ah, ok.. didn't think about that one. So, I guess, we need:

http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=016c3cfed27952f328d481b231a51129341746d9

(might need some time to show up on kernel.org)

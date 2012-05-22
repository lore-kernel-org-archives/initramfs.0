From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Tue, 22 May 2012 11:32:45 +0200
Message-ID: <4FBB5D3D.2080101@redhat.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <1337591686-31875-3-git-send-email-amwang@redhat.com> <4FBA09F7.4030003@redhat.com> <4FBA0B8D.1070708@gmail.com> <4FBA0E7E.1070004@redhat.com> <4FBA1698.3090006@gmail.com> <4FBA26A1.6010109@redhat.com> <4FBAEF49.60108@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FBAEF49.60108-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 22.05.2012 03:43, schrieb Cong Wang:
> On 05/21/2012 07:27 PM, Harald Hoyer wrote:!
>>
>> it would skip eth0.2, because its DEVPATH contains "virtual" and the rule is
>> never matched
> 
> When eth0.2 comes up, yes.
> 
> When eth0 comes up, no, both lines will be applied to eth0 and the final result
> is that eth0 will be renamed to eth0.2.
> 
> And eth0 comes up before eth0.2, so...

well, but you wouldn't specify "ifname=" on the kernel command line for eth0.2,
would you?

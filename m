From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Tue, 22 May 2012 21:43:03 +0800
Message-ID: <4FBB97E7.6060804@gmail.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <1337591686-31875-3-git-send-email-amwang@redhat.com> <4FBA09F7.4030003@redhat.com> <4FBA0B8D.1070708@gmail.com> <4FBA0E7E.1070004@redhat.com> <4FBA1698.3090006@gmail.com> <4FBA26A1.6010109@redhat.com> <4FBAEF49.60108@gmail.com> <4FBB5D3D.2080101@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CHBT1raKkXAcgO1B5zjXR6Q0dZNak642LxZ5bCu1UJs=;
        b=EVBJ8pJZiWzG2oLqEL6vQM8w1KWQhFGRQrTYT5yHb3Ul5gtHDlLcDJ8vCFo/tNBae0
         reBR3IYY7E0aFLk1bE/oR81HmCGKhbgoKYWrW7LolelmGD8uK9Ab1mjGaS3ZRZKQf8nY
         d9JTOf6fSeaLTLsMJiVKfNJwh6ZlxRAUIqwkjyhzX+rqjoCvWTIv6M5lwikhLhraz2fl
         K3wGTUhduDOBcMZa/aOhvL5C394XBwSMHrsgD12RlsFqy8n+KyxuY1kI+dDdiPWZHC0R
         6ovsg3RKfox0pE9dnhiilPd5//4BPlI6DLafbyQHieta+yVeHj5IDgcbNAj3dKP5mcL/
         nisQ==
In-Reply-To: <4FBB5D3D.2080101-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 05/22/2012 05:32 PM, Harald Hoyer wrote:
> Am 22.05.2012 03:43, schrieb Cong Wang:
>> On 05/21/2012 07:27 PM, Harald Hoyer wrote:!
>>>
>>> it would skip eth0.2, because its DEVPATH contains "virtual" and the rule is
>>> never matched
>>
>> When eth0.2 comes up, yes.
>>
>> When eth0 comes up, no, both lines will be applied to eth0 and the final result
>> is that eth0 will be renamed to eth0.2.
>>
>> And eth0 comes up before eth0.2, so...
>
> well, but you wouldn't specify "ifname=" on the kernel command line for eth0.2,
> would you?

We use ip=eth0.2:dhcp to get IP for eth0.2 via DHCP, so 
ifname=eth0.2:XXX is requried by ip=, no?

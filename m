From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Mon, 21 May 2012 11:44:30 +0200
Message-ID: <4FBA0E7E.1070004@redhat.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <1337591686-31875-3-git-send-email-amwang@redhat.com> <4FBA09F7.4030003@redhat.com> <4FBA0B8D.1070708@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FBA0B8D.1070708-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 21.05.2012 11:31, schrieb Cong Wang:
> On 05/21/2012 05:25 PM, Harald Hoyer wrote:
>>> -        printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*",
>>> ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
>>> +        #Hack: vlan device has the same mac address with its physical device
>>> +        [ -e /tmp/vlan.info ]&&  source /tmp/vlan.info
>>> +        if [ "$ifname_if" != "$vlanname" ]; then
>>> +            printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*",
>>> ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
>>> +        fi
>>>       done
>>>
>>>       # Rename non named interfaces out of the way for named ones.
>>
>> Maybe one of the /sys attributes indicate, that it is a vlan interface?
> 
> Hmm... I tried DRIVERS!="8021q", then I got:
> 
> SUBSYSTEM=="net", ACTION=="add", DRIVERS!="8021q", ATTR{address}=="%s",
> ATTR{type}=="1" NAME="eth0"
> 
> SUBSYSTEM=="net", ACTION=="add", DRIVERS!="8021q", ATTR{address}=="%s",
> ATTR{type}=="1" NAME="eth0.2"
> 
> So, eth0 will be still renamed to eth0.2. :(


DEVPATH!="*/virtual/*" should help

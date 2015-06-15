From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Require all interfaces to be up before using iscsistart
 -b
Date: Mon, 15 Jun 2015 11:53:26 +0200
Message-ID: <557EA096.4070802@redhat.com>
References: <1431592211-5652-1-git-send-email-ross.lagerwall@citrix.com> <557E9C1F.4060102@citrix.com> <557EA026.7090509@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557EA026.7090509-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ross Lagerwall <ross.lagerwall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 15.06.2015 11:51, Harald Hoyer wrote:
> On 15.06.2015 11:34, Ross Lagerwall wrote:
>> ping!
>>
>> On 05/14/2015 09:30 AM, Ross Lagerwall wrote:
>>> If multiple targets are specified in the ibft, iscsistart will log into
>>> all of them, possibly using multiple interfaces. Since iscsistart is run
>>> indirectly from ifup, require that all interfaces are up before actually
>>> logging into the targets.
>>> ---
>>>   modules.d/95iscsi/iscsiroot.sh |    5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/modules.d/95iscsi/iscsiroot.sh b/modules.d/95iscsi/iscsiroot.sh
>>> index 1de6fb7..b9e99cb 100755
>>> --- a/modules.d/95iscsi/iscsiroot.sh
>>> +++ b/modules.d/95iscsi/iscsiroot.sh
>>> @@ -45,6 +45,11 @@ fi
>>>
>>>   handle_firmware()
>>>   {
>>> +    # iscsistart -b may use multiple interfaces so only run when
>>> +    # all are ready.
>>> +    type all_ifaces_up >/dev/null 2>&1 || . /lib/net-lib.sh
>>> +    all_ifaces_up || return 1
>>> +
>>>       if ! [ -e /tmp/iscsistarted-firmware ]; then
>>>           if ! iscsistart -f; then
>>>               warn "iscistart: Could not get list of targets from firmware."
>>>
> 
> 
> I would love to do that, but users want to have "iscsistart -b" executed
> regardless of faulty network configuration of interfaces, which are not part of
> the critical path for root mounting.
> 
> So, if you add a "iscsistart -b" in the timeout hook (which is removed, if once
> succeeded in the normal path), then I guess it will be fine for all.
> 

Oh, and ideally I want to see systemd units for iscsistart, or move to iscsid
completely.

And iscsid/iscistart would just handle all netlink events.

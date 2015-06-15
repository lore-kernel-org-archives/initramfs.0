From: Ross Lagerwall <ross.lagerwall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Require all interfaces to be up before using iscsistart
 -b
Date: Mon, 15 Jun 2015 15:25:57 +0100
Message-ID: <557EE075.7080908@citrix.com>
References: <1431592211-5652-1-git-send-email-ross.lagerwall@citrix.com>
 <557E9C1F.4060102@citrix.com> <557EA026.7090509@redhat.com>
 <557EA096.4070802@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557EA096.4070802-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/15/2015 10:53 AM, Harald Hoyer wrote:
> On 15.06.2015 11:51, Harald Hoyer wrote:
>> On 15.06.2015 11:34, Ross Lagerwall wrote:
>>> ping!
>>>
>>> On 05/14/2015 09:30 AM, Ross Lagerwall wrote:
>>>> If multiple targets are specified in the ibft, iscsistart will log into
>>>> all of them, possibly using multiple interfaces. Since iscsistart is run
>>>> indirectly from ifup, require that all interfaces are up before actually
>>>> logging into the targets.
>>>> ---
>>>>    modules.d/95iscsi/iscsiroot.sh |    5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/modules.d/95iscsi/iscsiroot.sh b/modules.d/95iscsi/iscsiroot.sh
>>>> index 1de6fb7..b9e99cb 100755
>>>> --- a/modules.d/95iscsi/iscsiroot.sh
>>>> +++ b/modules.d/95iscsi/iscsiroot.sh
>>>> @@ -45,6 +45,11 @@ fi
>>>>
>>>>    handle_firmware()
>>>>    {
>>>> +    # iscsistart -b may use multiple interfaces so only run when
>>>> +    # all are ready.
>>>> +    type all_ifaces_up >/dev/null 2>&1 || . /lib/net-lib.sh
>>>> +    all_ifaces_up || return 1
>>>> +
>>>>        if ! [ -e /tmp/iscsistarted-firmware ]; then
>>>>            if ! iscsistart -f; then
>>>>                warn "iscistart: Could not get list of targets from firmware."
>>>>
>>
>>
>> I would love to do that, but users want to have "iscsistart -b" executed
>> regardless of faulty network configuration of interfaces, which are not part of
>> the critical path for root mounting.
>>
>> So, if you add a "iscsistart -b" in the timeout hook (which is removed, if once
>> succeeded in the normal path), then I guess it will be fine for all.

That already effectively happens in the existing dracut code due to this 
line:
initqueue --onetime --timeout "/sbin/iscsiroot dummy '$netroot' '$NEWROOT'"

But the problem is that when multiple NICs are specified in the ibft, 
"iscsistart -b" hangs for something like 15 minutes trying to use an 
interface that isn't up so so letting it fallback to the timeout hook 
doesn't really work for me.

What about adding the following oneliner to the above patch (untested)?

8<-------------------------

diff --git a/modules.d/95iscsi/parse-iscsiroot.sh 
b/modules.d/95iscsi/parse-iscsiroot.sh
index 52f7a97..f1bd25f 100755
--- a/modules.d/95iscsi/parse-iscsiroot.sh
+++ b/modules.d/95iscsi/parse-iscsiroot.sh
@@ -62,7 +62,7 @@ if [ -n "$iscsi_firmware" ] ; then
      [ -z "$netroot" ] && netroot=iscsi:
      modprobe -b -q iscsi_boot_sysfs 2>/dev/null
      modprobe -b -q iscsi_ibft
-    initqueue --onetime --timeout /sbin/iscsiroot dummy "$netroot" 
"$NEWROOT"
+    initqueue --onetime --finished /sbin/iscsiroot dummy "$netroot" 
"$NEWROOT"
  fi

  # If it's not iscsi we don't continue

8<-------------------------

So if you have a faulty NIC configuration, you still end up running 
iscsistart -b eventually.
And if you've already run iscsistart -b (e.g. in the usual case), then 
the "/tmp/iscsistarted-firmware" flag will prevent you from running it 
again.

>>
>
> Oh, and ideally I want to see systemd units for iscsistart, or move to iscsid
> completely.
>
> And iscsid/iscistart would just handle all netlink events.
>

Of course :-)

-- 
Ross Lagerwall

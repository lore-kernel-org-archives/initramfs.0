From: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC dracut 1/1] unexpected boot failure due to races between
 iscsistart for multiple interfaces
Date: Thu, 21 Dec 2017 10:54:58 -0800
Message-ID: <29030bdf-e65a-dc01-ee1e-48498dafdc8f@oracle.com>
References: <1512418484-3948-1-git-send-email-cathy.zhou@oracle.com>
 <9326cbf7-b533-4cf2-baac-6699ee5dc4d6@googlegroups.com>
 <a759d3d3-5c21-4a28-a205-1390561abc2a@googlegroups.com>
 <213a0c37-587e-7375-341b-680faa752cde@oracle.com>
 <B00ADBFE-F00B-4BCD-A7FE-0FEFE2A64F9D@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=gc4zGKmocsVPtdDfIsGHwuOdFdzs7+oFsLK/1XD4BSc=;
 b=f1B6eBePz+fY3gAsYoVqOoap0SENQTHZ3V9Av/NeDGepPp351XX9CA5tfVpwjb/DI4Zr
 i3VkGYV1KXxiGMXxuTvNIiHa1DIGUXvNkxvLdGhiooCT6GG6wSFyu/OkJzyhoS4P7D5E
 IJzrKQZiLyinboJjG74Sxw0CYIfoMfMJQyy0rSGE06ydAepOAuEHaYKSOrW3A9/q9hS+
 d773q5mIGxF7wXNENHs5B5gllA/2jhUQ1qyMgawjhrD5aPJeWoOflaUwahjsQS5FzZHR
 JY2IjXz8SZlwcKiiFB62YUiomGNQV+MrU39VDN6RXIgXEfaR07ucdACqAqAHpEYJx7wf EA== 
In-Reply-To: <B00ADBFE-F00B-4BCD-A7FE-0FEFE2A64F9D-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Lee Duncan <leeman.duncan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: open-iscsi <open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Si-Wei <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>


On 12/20/2017 5:39 PM, Lee Duncan wrote:
> Hi Cathy:
>
> My comments are (well) below ...
Lee,

Thanks. See more inline:
>
>> On Dec 20, 2017, at 3:04 PM, Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org 
>> <mailto:cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>> wrote:
>>
>> Lee-man,
>>
>> Thanks for your comments. See inline:
>>
>> On 12/20/2017 1:47 PM, The Lee-Man wrote:
>>>
>>>
>>> On Friday, December 8, 2017 at 4:30:36 PM UTC-8, The Lee-Man wrote:
>>>
>>>    On Thursday, December 7, 2017 at 11:49:53 AM UTC-8,
>>> cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org <mailto:cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> 
>>> <mailto:cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>>>
>>>        From: Cathy Zhou <Cathy.Zhou-veTT2BtV2gBXrIkS9f7CXA@public.gmane.org 
>>> <mailto:Cathy.Zhou-veTT2BtV2gBXrIkS9f7CXA@public.gmane.org>>
>>>
>>>        Co-existence of iscsid and iscsistart can lead to unexpected
>>>        iSCSI boot
>>>        behavior:
>>>
>>>        We ran into iSCSI netboot failure when multiple interfaces are
>>>        configured
>>>        with dhcp. The problem is that iscsistart is not designed to
>>>        be working
>>>        together with iscsid. When an interface gets the dhcp offer
>>>        successfully,
>>>        the iscsiroot script is run which starts the iscsistart
>>>        service to
>>>        establish the iSCSI session. With the existence of iscsid, the
>>>        iscsistart
>>>        service's attempt to setup its own mgmt ipc fails. Instead,
>>>        the request
>>>        to login to the iscsi target is handled by the mgmt ipc of
>>>        iscsid. After
>>>        iscsistart finishes its login attempt, it eventually sends a
>>>        stop_event_loop request to stop the mgmt process. As the
>>>        result, it
>>>        terminates iscsid.
>>>
>>>        I don't think this behavior is expected. Further, we believe
>>>        the restart
>>>        of the iscsid service in iscsiroot.sh for multiple interfaces
>>>        could also
>>>        interfere with each other and race. That could also cause
>>>        unexpected
>>>        behavior.
>>>
>>>        Specifically, in our multiple interface iSCSI boot case, below
>>>        is what
>>>        happened:
>>>
>>>        a. eth0 successfully got the dhcp offer, the iscsiroot script
>>>        was run and
>>>        eventually ran "system-run" to start the "oneshot" iscsistart
>>>        service.
>>>
>>>        b. Before step a succeeded, the iscsiroot script was also run
>>>        for eth1.
>>>        It checks the status of the first iscsistart service instance,
>>>        which was
>>>        still "activating". So the iscsistart service was restarted
>>>        and that
>>>        killed the first instance. Note that in this case, the
>>>        stop_event_loop
>>>        request has not been sent, and iscsid was not terminated. As
>>>        the result,
>>>        the second iscsistart instance also failed because of the
>>>        "existing
>>>        session" error, as the half-baked session already existed in
>>>        iscsid.
>>>
>>>        Based on iscsistart(8), iscsistart's primary use is to start
>>>        session
>>>        used for iSCSI root boot, and is meant to work indpependently
>>>        from iscsid.
>>>        Making the two work together would need coordination between each
>>>        other, which would be complicate and unnecessary.
>>>
>>>
>>>    No, I believe iscsistart was mean to run *instead* of iscsid, not
>>>    independently.
>>>
>> That was what I meant: iscsistart is not to run together with iscsid.
>>>
>>>
>>>        Therefore, to fix the issue, we'd either choose to remove the
>>>        use of
>>>        iscsid and solely use iscsistart or to remove iscsistart and
>>>        use iscsid
>>>        and iscsiadm to manage the iSCSI sessions.
>>>
>>>        Our fix chooses the former. We tested the change in our setup.
>>>
>>>        Signed-off-by: Cathy Zhou <Cathy.Zhou-veTT2BtV2gBXrIkS9f7CXA@public.gmane.org 
>>> <mailto:Cathy.Zhou-veTT2BtV2gBXrIkS9f7CXA@public.gmane.org>>
>>>        ---
>>>         modules.d/95iscsi/cleanup-iscsi.sh   |  2 +-
>>>         modules.d/95iscsi/iscsiroot.sh       | 25
>>>        +------------------------
>>>         modules.d/95iscsi/module-setup.sh    | 30
>>>        ------------------------------
>>>         modules.d/95iscsi/parse-iscsiroot.sh | 10 ----------
>>>         4 files changed, 2 insertions(+), 65 deletions(-)
>>>
>>>        diff --git a/modules.d/95iscsi/cleanup-iscsi.sh
>>>        b/modules.d/95iscsi/cleanup-iscsi.sh
>>>        index bfc8aefc..e97d65ac 100755
>>>        --- a/modules.d/95iscsi/cleanup-iscsi.sh
>>>        +++ b/modules.d/95iscsi/cleanup-iscsi.sh
>>>        @@ -1,4 +1,4 @@
>>>         #!/bin/sh
>>>
>>>        -[ -z "${DRACUT_SYSTEMD}" ] && [ -e /sys/module/bnx2i ] &&
>>>        killproc iscsiuio
>>>        +[ -e /sys/module/bnx2i ] && killproc iscsiuio
>>>
>>>
>>>    Why are you removing the DRACUT_SYSTEMD checks?
>>>
>> Because before my change, iscsiuio is started in the form of service 
>> as a dependency of the iscsid service. My change removed the iscsid 
>> service, so iscsiuio needs to be started explicitly for iSCSI offload 
>> for bnx2i driver.
>>>
>>>
>>>        diff --git a/modules.d/95iscsi/iscsiroot.sh
>>>        b/modules.d/95iscsi/iscsiroot.sh
>>>        index aefd263d..c7f1c474 100755
>>>        --- a/modules.d/95iscsi/iscsiroot.sh
>>>        +++ b/modules.d/95iscsi/iscsiroot.sh
>>>        @@ -36,7 +36,7 @@ iroot=${iroot#:}
>>>         # figured out a way how to check whether this is built-in or not
>>>         modprobe crc32c 2>/dev/null
>>>
>>>        -if [ -z "${DRACUT_SYSTEMD}" ] && [ -e /sys/module/bnx2i ] &&
>>>        ! [ -e /tmp/iscsiuio-started ]; then
>>>        +[ -e /sys/module/bnx2i ] && ! [ -e /tmp/iscsiuio-started ]; then
>>>                 iscsiuio
>>>                 > /tmp/iscsiuio-started
>>>         fi
>>>        @@ -117,11 +117,6 @@ handle_netroot()
>>>                    mkdir -p /etc/iscsi
>>>                    ln -fs /run/initiatorname.iscsi
>>>        /etc/iscsi/initiatorname.iscsi
>>>                    > /tmp/iscsi_set_initiator
>>>        -           if [ -n "$DRACUT_SYSTEMD" ]; then
>>>        -               systemctl try-restart iscsid
>>>        -               # FIXME: iscsid is not yet ready, when the
>>>        service is :-/
>>>        -               sleep 1
>>>        -           fi
>>>             fi
>>>
>>>             if [ -z "$iscsi_initiator" ]; then
>>>        @@ -138,11 +133,6 @@ handle_netroot()
>>>                 mkdir -p /etc/iscsi
>>>                 ln -fs /run/initiatorname.iscsi
>>>        /etc/iscsi/initiatorname.iscsi
>>>                 > /tmp/iscsi_set_initiator
>>>        -        if [ -n "$DRACUT_SYSTEMD" ]; then
>>>        -            systemctl try-restart iscsid
>>>        -            # FIXME: iscsid is not yet ready, when the
>>>        service is :-/
>>>        -            sleep 1
>>>        -        fi
>>>             fi
>>>
>>>
>>>        @@ -163,11 +153,6 @@ handle_netroot()
>>>             if ! [ -e /etc/iscsi/initiatorname.iscsi ]; then
>>>                 mkdir -p /etc/iscsi
>>>                 ln -fs /run/initiatorname.iscsi
>>>        /etc/iscsi/initiatorname.iscsi
>>>        -        if [ -n "$DRACUT_SYSTEMD" ]; then
>>>        -            systemctl try-restart iscsid
>>>        -            # FIXME: iscsid is not yet ready, when the
>>>        service is :-/
>>>        -            sleep 1
>>>        -        fi
>>>             fi
>>>         # FIXME $iscsi_protocol??
>>>
>>>        @@ -234,14 +219,6 @@ if [ "$netif" != "timeout" ] &&
>>>        getargbool 1 rd.iscsi.waitnet; then
>>>             all_ifaces_setup || exit 0
>>>         fi
>>>
>>>        -if [ "$netif" = "timeout" ] && all_ifaces_setup; then
>>>        -    # s.th <http://s.th> <http://s.th>. went wrong and the 
>>> timeout script hits
>>>        -    # restart
>>>        -    systemctl restart iscsid
>>>        -    # damn iscsid is not ready after unit says it's ready
>>>        -    sleep 2
>>>        -fi
>>>        -
>>>         if getargbool 0 rd.iscsi.firmware -d -y iscsi_firmware ; then
>>>             if [ "$netif" = "timeout" ] || [ "$netif" = "online" ]; then
>>>                 handle_firmware
>>>        diff --git a/modules.d/95iscsi/module-setup.sh
>>>        b/modules.d/95iscsi/module-setup.sh
>>>        index 04937b5b..1d185a84 100755
>>>        --- a/modules.d/95iscsi/module-setup.sh
>>>        +++ b/modules.d/95iscsi/module-setup.sh
>>>        @@ -199,36 +199,6 @@ install() {
>>>             inst "$moddir/iscsiroot.sh" "/sbin/iscsiroot"
>>>             if ! dracut_module_included "systemd"; then
>>>                 inst "$moddir/mount-lun.sh" "/bin/mount-lun.sh"
>>>        -    else
>>>        -        inst_multiple -o \
>>>        -  $systemdsystemunitdir/iscsi.service \
>>>        -  $systemdsystemunitdir/iscsid.service \
>>>        -  $systemdsystemunitdir/iscsid.socket \
>>>        -  $systemdsystemunitdir/iscsiuio.service \
>>>        -  $systemdsystemunitdir/iscsiuio.socket \
>>>        -                      iscsiadm iscsid
>>>        -
>>>        -        mkdir -p
>>>        "${initdir}/$systemdsystemunitdir/sockets.target.wants"
>>>        -        for i in \
>>>        -                iscsiuio.socket \
>>>        -            ; do
>>>        -            ln_r "$systemdsystemunitdir/${i}"
>>>        "$systemdsystemunitdir/sockets.target.wants/${i}"
>>>        -        done
>>>        -
>>>        -        mkdir -p
>>>        "${initdir}/$systemdsystemunitdir/basic.target.wants"
>>>        -        for i in \
>>>        -                iscsid.service \
>>>        -            ; do
>>>        -            ln_r "$systemdsystemunitdir/${i}"
>>>        "$systemdsystemunitdir/basic.target.wants/${i}"
>>>        -        done
>>>        -
>>>        -        # Make sure iscsid is started after dracut-cmdline
>>>        and ready for the initqueue
>>>        -        mkdir -p
>>>        "${initdir}/$systemdsystemunitdir/iscsid.service.d"
>>>        -        (
>>>        -            echo "[Unit]"
>>>        -            echo "After=dracut-cmdline.service"
>>>        -            echo "Before=dracut-initqueue.service"
>>>        -        ) >
>>>        "${initdir}/$systemdsystemunitdir/iscsid.service.d/dracut.conf"
>>>
>>>
>>>    I'm not sure why you've removed all of this.
>>>
>> Because the above is added for the iscsid service, which is no longer 
>> needed.
>>>
>>>
>>>             fi
>>>             inst_dir /var/lib/iscsi
>>>             dracut_need_initqueue
>>>        diff --git a/modules.d/95iscsi/parse-iscsiroot.sh
>>>        b/modules.d/95iscsi/parse-iscsiroot.sh
>>>        index 43b2e088..c8c66ccf 100755
>>>        --- a/modules.d/95iscsi/parse-iscsiroot.sh
>>>        +++ b/modules.d/95iscsi/parse-iscsiroot.sh
>>>        @@ -116,11 +116,6 @@ if arg=$(getarg rd.iscsi.initiator -d
>>>        iscsi_initiator=) && [ -n "$arg" ] && ! [
>>>             if ! [ -e /etc/iscsi/initiatorname.iscsi ]; then
>>>                 mkdir -p /etc/iscsi
>>>                 ln -fs /run/initiatorname.iscsi
>>>        /etc/iscsi/initiatorname.iscsi
>>>        -        if [ -n "$DRACUT_SYSTEMD" ]; then
>>>        -            systemctl try-restart iscsid
>>>        -            # FIXME: iscsid is not yet ready, when the
>>>        service is :-/
>>>        -            sleep 1
>>>        -        fi
>>>             fi
>>>         fi
>>>
>>>        @@ -133,11 +128,6 @@ if [ -z $iscsi_initiator ] && [ -f
>>>        /sys/firmware/ibft/initiator/initiator-name ]
>>>                 mkdir -p /etc/iscsi
>>>                 ln -fs /run/initiatorname.iscsi
>>>        /etc/iscsi/initiatorname.iscsi
>>>                 > /tmp/iscsi_set_initiator
>>>        -        if [ -n "$DRACUT_SYSTEMD" ]; then
>>>        -            systemctl try-restart iscsid
>>>        -            # FIXME: iscsid is not yet ready, when the
>>>        service is :-/
>>>        -            sleep 1
>>>        -        fi
>>>             fi
>>>         fi
>>>
>>>        --         2.11.1
>>>
>>>    So in general you've stopped starting or restarting the iscsid
>>>    service?
>>>
>> Yes. Actually we do not even start the iscsid service from the 
>> beginning. The whole fix is to remove iscsid but only run iscsistart.
>
> Okay, I’m glad you made this clear, because this is the problem with 
> your approach.
>
> The iscsistart program is not sufficient for supporting an iSCSI 
> initiator. Namely, it does not manage sessions, so it can’t do any 
> error handling (i.e. log out, log back in).
Yes, I understand that. But I don't see this is a problem with my 
approach. From what I can see, there is no need for log out/log back in. 
iscsid is to work with iscsiadm to manage sessions. But there is no such 
usage of iscisadm in dracut as far as I can see.

There is only one iscsiadm instance, and I looked into it and made sure 
that does not need the existence of iscsid.
>
> The whole reason the iscsistart program was created was that, at iSCSI 
> boot time, we needed a lighter-weight program than the iscsiadm/iscsid 
> pair to connect to a single target.

>>>    Have you tested this with iscsiuio/brcm? I have no way currently
>>>    to test to make sure things all still work.
>>>
>> We will, and also planning to add more test cases to get more 
>> iscsiboot coverage. But because this is a significant change, we'd 
>> like to get some comments to say this is the right approach.
>>>
>>>
>>>    Note: dracut is *not* my specialty, but I have looked at this
>>>    stuff in the SUSE distribution, and it seems like a bit of a house
>>>    of cards. :(
>>>
>>
>> I agree. dracut is not my specialty either.
>>
>> Thank you very much!
>> - Cathy
>>
>
> Bottom line, I need to better understand why you are using iscsitart 
> in the first place, if you are not booting from an iSCSI disc. And if 
> you are using iscsistart, why are you running iscsid before iscsistart 
> is done?
iscsistart was used before my changes. I didn't change that. The problem 
is that iscsid was started before iscsistart and that was what I am 
trying to fix.

Hopefully my fix makes more sense now. Please let me know if you still 
have doubts.

Thanks
- Cathy
>
> -- 
> Lee Duncan
>
> "/Ambition is the last refuge of failure/." -- Oscar Wilde
>
>

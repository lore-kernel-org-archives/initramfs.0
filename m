From: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC dracut 1/1] unexpected boot failure due to races between
 iscsistart for multiple interfaces
Date: Fri, 8 Dec 2017 11:09:16 -0800
Message-ID: <e3f56fab-4a5f-da70-a975-6fc376114882@oracle.com>
References: <1512418484-3948-1-git-send-email-cathy.zhou@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=YbZ5aLQ7d/eoIRmlsWyM4abnLzL6kVMqUTIiyEiytQo=;
 b=uOeh43w7hCBRhDl8ESN9A3OIJaEfHb28zImRewZ/I97u5hM6LvoZhuW1soVDpjJolweo
 Y01jzcwA3HY4nKy4QdtWADwArXnWpN3VoUNqBtPFL1puVJMRPTg7rmoJmlz2COo8cbbk
 7+lmorNB2Nd8aQgqBj05P0BGMCKWETk/NXKS4lEofoea9OXRCqNmdPFkTK4cbvQO3x8S
 gRUcWGsFJRjMiQGz3QNkptsbpEuzT4iaYKvIFMGQxkXGim2QgrKGH6SLvrqP3DcCFVyB
 APipN9kJYrEeSL91920vmuayR5FQsdQZrjeD5b+g04SyJtuFZ7NlUFOM85d2h8ZKW6CP mw== 
In-Reply-To: <1512418484-3948-1-git-send-email-cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org

A Reminder...

Looking forward to any comments.

Thanks
- Cathy

On 12/4/2017 12:14 PM, cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org wrote:
> From: Cathy Zhou <Cathy.Zhou-veTT2BtV2gBXrIkS9f7CXA@public.gmane.org>
>
> Co-existence of iscsid and iscsistart can lead to unexpected iSCSI boot
> behavior:
>
> We ran into iSCSI netboot failure when multiple interfaces are configured
> with dhcp. The problem is that iscsistart is not designed to be working
> together with iscsid. When an interface gets the dhcp offer successfully,
> the iscsiroot script is run which starts the iscsistart service to
> establish the iSCSI session. With the existence of iscsid, the iscsistart
> service's attempt to setup its own mgmt ipc fails. Instead, the request
> to login to the iscsi target is handled by the mgmt ipc of iscsid. After
> iscsistart finishes its login attempt, it eventually sends a
> stop_event_loop request to stop the mgmt process. As the result, it
> terminates iscsid.
>
> I don't think this behavior is expected. Further, we believe the restart
> of the iscsid service in iscsiroot.sh for multiple interfaces could also
> interfere with each other and race. That could also cause unexpected
> behavior.
>
> Specifically, in our multiple interface iSCSI boot case, below is what
> happened:
>
> a. eth0 successfully got the dhcp offer, the iscsiroot script was run and
> eventually ran "system-run" to start the "oneshot" iscsistart service.
>
> b. Before step a succeeded, the iscsiroot script was also run for eth1.
> It checks the status of the first iscsistart service instance, which was
> still "activating". So the iscsistart service was restarted and that
> killed the first instance. Note that in this case, the stop_event_loop
> request has not been sent, and iscsid was not terminated. As the result,
> the second iscsistart instance also failed because of the "existing
> session" error, as the half-baked session already existed in iscsid.
>
> Based on iscsistart(8), iscsistart's primary use is to start session
> used for iSCSI root boot, and is meant to work indpependently from iscsid.
> Making the two work together would need coordination between each
> other, which would be complicate and unnecessary.
>
> Therefore, to fix the issue, we'd either choose to remove the use of
> iscsid and solely use iscsistart or to remove iscsistart and use iscsid
> and iscsiadm to manage the iSCSI sessions.
>
> Our fix chooses the former. We tested the change in our setup.
>
> Signed-off-by: Cathy Zhou <Cathy.Zhou-veTT2BtV2gBXrIkS9f7CXA@public.gmane.org>
> ---
>   modules.d/95iscsi/cleanup-iscsi.sh   |  2 +-
>   modules.d/95iscsi/iscsiroot.sh       | 25 +------------------------
>   modules.d/95iscsi/module-setup.sh    | 30 ------------------------------
>   modules.d/95iscsi/parse-iscsiroot.sh | 10 ----------
>   4 files changed, 2 insertions(+), 65 deletions(-)
>
> diff --git a/modules.d/95iscsi/cleanup-iscsi.sh b/modules.d/95iscsi/cleanup-iscsi.sh
> index bfc8aefc..e97d65ac 100755
> --- a/modules.d/95iscsi/cleanup-iscsi.sh
> +++ b/modules.d/95iscsi/cleanup-iscsi.sh
> @@ -1,4 +1,4 @@
>   #!/bin/sh
>   
> -[ -z "${DRACUT_SYSTEMD}" ] && [ -e /sys/module/bnx2i ] && killproc iscsiuio
> +[ -e /sys/module/bnx2i ] && killproc iscsiuio
>   
> diff --git a/modules.d/95iscsi/iscsiroot.sh b/modules.d/95iscsi/iscsiroot.sh
> index aefd263d..c7f1c474 100755
> --- a/modules.d/95iscsi/iscsiroot.sh
> +++ b/modules.d/95iscsi/iscsiroot.sh
> @@ -36,7 +36,7 @@ iroot=${iroot#:}
>   # figured out a way how to check whether this is built-in or not
>   modprobe crc32c 2>/dev/null
>   
> -if [ -z "${DRACUT_SYSTEMD}" ] && [ -e /sys/module/bnx2i ] && ! [ -e /tmp/iscsiuio-started ]; then
> +[ -e /sys/module/bnx2i ] && ! [ -e /tmp/iscsiuio-started ]; then
>           iscsiuio
>           > /tmp/iscsiuio-started
>   fi
> @@ -117,11 +117,6 @@ handle_netroot()
>              mkdir -p /etc/iscsi
>              ln -fs /run/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi
>              > /tmp/iscsi_set_initiator
> -           if [ -n "$DRACUT_SYSTEMD" ]; then
> -               systemctl try-restart iscsid
> -               # FIXME: iscsid is not yet ready, when the service is :-/
> -               sleep 1
> -           fi
>       fi
>   
>       if [ -z "$iscsi_initiator" ]; then
> @@ -138,11 +133,6 @@ handle_netroot()
>           mkdir -p /etc/iscsi
>           ln -fs /run/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi
>           > /tmp/iscsi_set_initiator
> -        if [ -n "$DRACUT_SYSTEMD" ]; then
> -            systemctl try-restart iscsid
> -            # FIXME: iscsid is not yet ready, when the service is :-/
> -            sleep 1
> -        fi
>       fi
>   
>   
> @@ -163,11 +153,6 @@ handle_netroot()
>       if ! [ -e /etc/iscsi/initiatorname.iscsi ]; then
>           mkdir -p /etc/iscsi
>           ln -fs /run/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi
> -        if [ -n "$DRACUT_SYSTEMD" ]; then
> -            systemctl try-restart iscsid
> -            # FIXME: iscsid is not yet ready, when the service is :-/
> -            sleep 1
> -        fi
>       fi
>   # FIXME $iscsi_protocol??
>   
> @@ -234,14 +219,6 @@ if [ "$netif" != "timeout" ] && getargbool 1 rd.iscsi.waitnet; then
>       all_ifaces_setup || exit 0
>   fi
>   
> -if [ "$netif" = "timeout" ] && all_ifaces_setup; then
> -    # s.th. went wrong and the timeout script hits
> -    # restart
> -    systemctl restart iscsid
> -    # damn iscsid is not ready after unit says it's ready
> -    sleep 2
> -fi
> -
>   if getargbool 0 rd.iscsi.firmware -d -y iscsi_firmware ; then
>       if [ "$netif" = "timeout" ] || [ "$netif" = "online" ]; then
>           handle_firmware
> diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
> index 04937b5b..1d185a84 100755
> --- a/modules.d/95iscsi/module-setup.sh
> +++ b/modules.d/95iscsi/module-setup.sh
> @@ -199,36 +199,6 @@ install() {
>       inst "$moddir/iscsiroot.sh" "/sbin/iscsiroot"
>       if ! dracut_module_included "systemd"; then
>           inst "$moddir/mount-lun.sh" "/bin/mount-lun.sh"
> -    else
> -        inst_multiple -o \
> -                      $systemdsystemunitdir/iscsi.service \
> -                      $systemdsystemunitdir/iscsid.service \
> -                      $systemdsystemunitdir/iscsid.socket \
> -                      $systemdsystemunitdir/iscsiuio.service \
> -                      $systemdsystemunitdir/iscsiuio.socket \
> -                      iscsiadm iscsid
> -
> -        mkdir -p "${initdir}/$systemdsystemunitdir/sockets.target.wants"
> -        for i in \
> -                iscsiuio.socket \
> -            ; do
> -            ln_r "$systemdsystemunitdir/${i}" "$systemdsystemunitdir/sockets.target.wants/${i}"
> -        done
> -
> -        mkdir -p "${initdir}/$systemdsystemunitdir/basic.target.wants"
> -        for i in \
> -                iscsid.service \
> -            ; do
> -            ln_r "$systemdsystemunitdir/${i}" "$systemdsystemunitdir/basic.target.wants/${i}"
> -        done
> -
> -        # Make sure iscsid is started after dracut-cmdline and ready for the initqueue
> -        mkdir -p "${initdir}/$systemdsystemunitdir/iscsid.service.d"
> -        (
> -            echo "[Unit]"
> -            echo "After=dracut-cmdline.service"
> -            echo "Before=dracut-initqueue.service"
> -        ) > "${initdir}/$systemdsystemunitdir/iscsid.service.d/dracut.conf"
>       fi
>       inst_dir /var/lib/iscsi
>       dracut_need_initqueue
> diff --git a/modules.d/95iscsi/parse-iscsiroot.sh b/modules.d/95iscsi/parse-iscsiroot.sh
> index 43b2e088..c8c66ccf 100755
> --- a/modules.d/95iscsi/parse-iscsiroot.sh
> +++ b/modules.d/95iscsi/parse-iscsiroot.sh
> @@ -116,11 +116,6 @@ if arg=$(getarg rd.iscsi.initiator -d iscsi_initiator=) && [ -n "$arg" ] && ! [
>       if ! [ -e /etc/iscsi/initiatorname.iscsi ]; then
>           mkdir -p /etc/iscsi
>           ln -fs /run/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi
> -        if [ -n "$DRACUT_SYSTEMD" ]; then
> -            systemctl try-restart iscsid
> -            # FIXME: iscsid is not yet ready, when the service is :-/
> -            sleep 1
> -        fi
>       fi
>   fi
>   
> @@ -133,11 +128,6 @@ if [ -z $iscsi_initiator ] && [ -f /sys/firmware/ibft/initiator/initiator-name ]
>           mkdir -p /etc/iscsi
>           ln -fs /run/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi
>           > /tmp/iscsi_set_initiator
> -        if [ -n "$DRACUT_SYSTEMD" ]; then
> -            systemctl try-restart iscsid
> -            # FIXME: iscsid is not yet ready, when the service is :-/
> -            sleep 1
> -        fi
>       fi
>   fi
>   

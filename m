From: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: iscsi netboot failure in case of multiple interfaces
Date: Wed, 8 Nov 2017 10:55:45 -0800
Message-ID: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Si-Wei <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Yun Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Hi,

First I am sorry for the length of the email. Hopefully my description 
of the problem is clear. Any questions/suggestions are welcome. Please 
reply all as some of us on not on the alias.

-----

We are running into a failure with iscsi netboot with the following boot 
options:

       "... rd.luks=0 rd.lvm=0 rd.md=0 rd.dm=0 ip=dhcp 
netroot=iscsi:169.254.0.2::::iqn.2015-02.oracle.boot:uefi 
iscsi_param=node.session.timeo.replacement_timeout=6000"

On the system, there are two interfaces (say eth0 and eth1) which are 
able to get dhcp offers successfully, but only one of them (eth0) is 
able to reach the specified iscsi target. After some debugging, we 
believe we've found the root cause. Here is what happened:

1. eth0 successfully got the dhcp offer, the iscsiroot script was run 
and eventually ran "system-run" to start the "oneshot" iscsistart service.
2. Before step 1 succeeds, the iscsiroot script was also run for eth1 
and it checks the status of the first iscsistart service instance, which 
was still "activating". So the iscsistart service was restarted and that 
killed the first instance. But the second instance also fails because of 
the "existing session" error.

Here are the questions we have:

a. We found in the iscsiroot script, the iscsid service was started 
before the iscsistart service. Because of this, the creation of the mgmt 
ipc socket by iscsistart failed, and iscsi login session request was 
handled by iscsid instead. In step 2 above, the first iscsistart 
instance was killed but not the iscsid daemon, hence the "existing 
error" as the first login session still existed in iscsid.

The questions is if the iscsid service is really required by the 
iscisroot script? Because the existence of iscsid, after the second 
iscsistart instance, we saw unexpected iscsid service unavailability 
because iscsid is stopped by the iscsistart instance (iscsistart.c calls 
stop_event_loop() to stop event loop in order to exits itself, but since 
the MGMT_IPC_IMMEDIATE_STOP request was handled by iscsid, iscsid's 
event loop was stopped and iscsid exited instead).

The related error messages we saw in the log:

    "iscsistart[836]: iscsistart: Can not bind IPC socket
     iscsistart[836]: iscsistart: Could not setup mgmt ipc
     ...
     iscsiadm[970]: iscsiadm: can not connect to iSCSI daemon (111)!
     iscsiadm[970]: iscsiadm: initiator reported error (20 - could not 
connect to iscsid)
     ..."

I tried to change the iscsiroot.sh script to stop the iscsid service 
instead of restarting iscsid service, it seems it fixed our problem. But 
I am not sure if this fix has any side-effect.

b. If stopping iscsid service is not the ideal fix, I am wondering if we 
can mimic the legacy way (prior systemd) and start the iscsistart 
service independently for each interface. This means, iscsistart service 
will be started for each interface without affecting the iscsistart 
instances which are already run for other interfaces. It may mean the 
service name needs to include $netif to uniquely identify each instance.

Thanks very much! Looking forward to your suggestions!

- Cathy

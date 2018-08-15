From: Siwei Liu <loseweigh@gmail.com>
Subject: virtio_net failover and initramfs (was: Re: [PATCH net-next v11 2/5]
 netvsc: refactor notifier/event handling code to use the failover framework)
Date: Tue, 14 Aug 2018 17:03:37 -0700
Message-ID: <CADGSJ22433hWW8O6j__TDX+P-Rwx+YoYR=NzU5ueCPFT2wzUDw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AK9byBSgQdpHmTg8bJBXajRWcb6Y1SFY4PalOJv3UY0=;
        b=hQxD/+Pnzkaoa0YHun/6ewlnfIHId/HEsklj1V9teFuyhZP6iDKEY4psZNOrl14n7+
         I/+kpfR7VVIjpCJmCpzBHwpLTTjcL/0jJXT/PwLL84M6fW3o25sJDEkbvR+8lSeBzt0S
         9N8iuxHE28JsBRwV133LczwvINDbrlWYAUgi8YRVNMmB0aCv+4WQCHcvSOxaXun6YoTV
         gwKbFZmXEcMY5VK8IY0QykAtxR7AaqqOEYZNaCfnUksM3M9AMGGwCJ+I/JJKIkNgG+uV
         Z1lmhNA5h28QvntLVPYJWjISu+n/szb98tOQPV970sk9QdwlfTxVWihwOHas2PsEjTAn
         90PA==
Sender: netdev-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Pirko <jiri@resnulli.us>, initramfs@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, vijay.balakrishna@oracle.com, si-wei liu <si-wei.liu@oracle.com>, liran.alon@oracle.com

Are we sure all userspace apps skip and ignore slave interfaces by
just looking at "IFLA_MASTER" attribute?

When STANDBY is enabled on virtio-net, a failover master interface
will appear, which automatically enslaves the virtio device. But it is
found out that iSCSI (or any network boot) cannot boot strap over the
new failover interface together with a standby virtio (without any VF
or PT device in place).

Dracut (initramfs) ends up with timeout and dropping into emergency shell:

[  228.170425] dracut-initqueue[377]: Warning: dracut-initqueue
timeout - starting timeout scripts
[  228.171788] dracut-initqueue[377]: Warning: Could not boot.
         Starting Dracut Emergency Shell...
Generating "/run/initramfs/rdsosreport.txt"
Entering emergency mode. Exit the shell to continue.
Type "journalctl" to view system logs.
You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
after mounting them and attach it to a bug report.
dracut:/# ip l sh
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP mode DEFAULT group default qlen 1000
    link/ether 9a:46:22:ae:33:54 brd ff:ff:ff:ff:ff:ff\
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
master eth0 state UP mode DEFAULT group default qlen 1000
    link/ether 9a:46:22:ae:33:54 brd ff:ff:ff:ff:ff:ff
dracut:/#

If changing dracut code to ignore eth1 (with IFLA_MASTER attr),
network boot starts to work.

The reason is that dracut has its own means to differentiate virtual
interfaces for network boot: it does not look at IFLA_MASTER and
ignores slave interfaces. Instead, users have to provide explicit
option e.g. bond=eth0,eth1 in the boot line, then dracut would know
the config and ignore the slave interfaces.

However, with automatic creation of failover interface that assumption
is no longer true. Can we change dracut to ignore all slave interface
by checking  IFLA_MASTER? I don't think so. It has a large impact to
existing configs.

What's a feasible solution then? Check the driver name for failover as well?

Thanks,
-Siwei



On Tue, May 22, 2018 at 10:38 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, May 22, 2018 at 06:52:21PM CEST, mst@redhat.com wrote:
>>On Tue, May 22, 2018 at 05:45:01PM +0200, Jiri Pirko wrote:
>>> Tue, May 22, 2018 at 05:32:30PM CEST, mst@redhat.com wrote:
>>> >On Tue, May 22, 2018 at 05:13:43PM +0200, Jiri Pirko wrote:
>>> >> Tue, May 22, 2018 at 03:39:33PM CEST, mst@redhat.com wrote:
>>> >> >On Tue, May 22, 2018 at 03:26:26PM +0200, Jiri Pirko wrote:
>>> >> >> Tue, May 22, 2018 at 03:17:37PM CEST, mst@redhat.com wrote:
>>> >> >> >On Tue, May 22, 2018 at 03:14:22PM +0200, Jiri Pirko wrote:
>>> >> >> >> Tue, May 22, 2018 at 03:12:40PM CEST, mst@redhat.com wrote:
>>> >> >> >> >On Tue, May 22, 2018 at 11:08:53AM +0200, Jiri Pirko wrote:
>>> >> >> >> >> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
>>> >> >> >> >> >Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrote:
>>> >> >> >> >> >>Use the registration/notification framework supported by the generic
>>> >> >> >> >> >>failover infrastructure.
>>> >> >> >> >> >>
>>> >> >> >> >> >>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>> >> >> >> >> >
>>> >> >> >> >> >In previous patchset versions, the common code did
>>> >> >> >> >> >netdev_rx_handler_register() and netdev_upper_dev_link() etc
>>> >> >> >> >> >(netvsc_vf_join()). Now, this is still done in netvsc. Why?
>>> >> >> >> >> >
>>> >> >> >> >> >This should be part of the common "failover" code.
>>> >> >> >> >> >
>>> >> >> >> >>
>>> >> >> >> >> Also note that in the current patchset you use IFF_FAILOVER flag for
>>> >> >> >> >> master, yet for the slave you use IFF_SLAVE. That is wrong.
>>> >> >> >> >> IFF_FAILOVER_SLAVE should be used.
>>> >> >> >> >
>>> >> >> >> >Or drop IFF_FAILOVER_SLAVE and set both IFF_FAILOVER and IFF_SLAVE?
>>> >> >> >>
>>> >> >> >> No. IFF_SLAVE is for bonding.
>>> >> >> >
>>> >> >> >What breaks if we reuse it for failover?
>>> >> >>
>>> >> >> This is exposed to userspace. IFF_SLAVE is expected for bonding slaves.
>>> >> >> And failover slave is not a bonding slave.
>>> >> >
>>> >> >That does not really answer the question.  I'd claim it's sufficiently
>>> >> >like a bond slave for IFF_SLAVE to make sense.
>>> >> >
>>> >> >In fact you will find that netvsc already sets IFF_SLAVE, and so
>>> >>
>>> >> netvsc does the whole failover thing in a wrong way. This patchset is
>>> >> trying to fix it.
>>> >
>>> >Maybe, but we don't need gratuitous changes either, especially if they
>>> >break userspace.
>>>
>>> What do you mean by the "break"? It was a mistake to reuse IFF_SLAVE at
>>> the first place, lets fix it. If some userspace depends on that flag, it
>>> is broken anyway.
>>>
>>>
>>> >
>>> >> >does e.g. the eql driver.
>>> >> >
>>> >> >The advantage of using IFF_SLAVE is that userspace knows to skip it.  If
>>> >>
>>> >> The userspace should know how to skip other types of slaves - team,
>>> >> bridge, ovs, etc.
>>> >> The "master link" should be the one to look at.
>>> >>
>>> >
>>> >How should existing userspace know which ones to skip and which one is
>>> >the master?  Right now userspace seems to assume whatever does not have
>>> >IFF_SLAVE should be looked at. Are you saying that's not the right thing
>>>
>>> Why do you say so? What do you mean by "looked at"? Certainly not.
>>> IFLA_MASTER is the attribute that should be looked at, nothing else.
>>>
>>>
>>> >to do and userspace should be fixed? What should userspace do in
>>> >your opinion that will be forward compatible with future kernels?
>>> >
>>> >>
>>> >> >we don't set IFF_SLAVE existing userspace tries to use the lowerdev.
>>> >>
>>> >> Each master type has a IFF_ master flag and IFF_ slave flag.
>>> >
>>> >Could you give some examples please?
>>>
>>> enum netdev_priv_flags {
>>>         IFF_EBRIDGE                     = 1<<1,
>>>         IFF_BRIDGE_PORT                 = 1<<9,
>>>         IFF_OPENVSWITCH                 = 1<<20,
>>>         IFF_OVS_DATAPATH                = 1<<10,
>>>      IFF_L3MDEV_MASTER               = 1<<18,
>>>         IFF_L3MDEV_SLAVE                = 1<<21,
>>>         IFF_TEAM                        = 1<<22,
>>>         IFF_TEAM_PORT                   = 1<<13,
>>> };
>>
>>That's not in uapi, is it?  the comment above that says:
>
> Correct.
>
>
>>
>>These flags are invisible to userspace
>>
>>
>>
>>>
>>> >
>>> >> In private
>>> >> flag. I don't see no reason to break this pattern here.
>>> >
>>> >Other masters are setup from userspace, this one is set up automatically
>>> >by kernel. So the bar is higher, we need an interface that existing
>>> >userspace knows about.  We can't just say "oh if userspace set this up
>>> >it should know to skip lowerdevs".
>>> >
>>> >Otherwise multiple interfaces with same mac tend to confuse userspace.
>>>
>>> No difference, really.
>>> Regardless who does the setup, and independent userspace deamon should
>>> react accordingly.
>>
>>If the deamon does the setup itself, it's reasonable to require that it
>>learns about new flags each time we add a new driver.  If it doesn't,
>>then I think it's less reasonable.
>
> No need. The "IFLA_MASTER" attr is always there to be looked at. That is
> enough.

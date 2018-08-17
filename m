From: Harald Hoyer <harald@redhat.com>
Subject: Re: virtio_net failover and initramfs (was: Re: [PATCH net-next v11
 2/5] netvsc: refactor notifier/event handling code to use the failover
 framework)
Date: Fri, 17 Aug 2018 11:51:06 +0200
Message-ID: <85bf8fce-8cdf-597c-3b50-a1ff2eb5c5c4@redhat.com>
References: <CADGSJ22433hWW8O6j__TDX+P-Rwx+YoYR=NzU5ueCPFT2wzUDw@mail.gmail.com>
 <58f1f440-2bf9-1436-c987-95f331ce9990@intel.com>
 <CADGSJ206hwO_3RbB8C5875updN1e=LZqw1kwNJgne_-c4=9GoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CADGSJ206hwO_3RbB8C5875updN1e=LZqw1kwNJgne_-c4=9GoQ@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, initramfs@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Netdev <netdev@vger.kernel.org>, vijay.balakrishna@oracle.com, si-wei liu <si-wei.liu@oracle.com>, liran.alon@oracle.com

On 16.08.2018 00:17, Siwei Liu wrote:
> On Wed, Aug 15, 2018 at 12:05 PM, Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
>> On 8/14/2018 5:03 PM, Siwei Liu wrote:
>>>
>>> Are we sure all userspace apps skip and ignore slave interfaces by
>>> just looking at "IFLA_MASTER" attribute?
>>>
>>> When STANDBY is enabled on virtio-net, a failover master interface
>>> will appear, which automatically enslaves the virtio device. But it is
>>> found out that iSCSI (or any network boot) cannot boot strap over the
>>> new failover interface together with a standby virtio (without any VF
>>> or PT device in place).
>>>
>>> Dracut (initramfs) ends up with timeout and dropping into emergency shell:
>>>
>>> [  228.170425] dracut-initqueue[377]: Warning: dracut-initqueue
>>> timeout - starting timeout scripts
>>> [  228.171788] dracut-initqueue[377]: Warning: Could not boot.
>>>           Starting Dracut Emergency Shell...
>>> Generating "/run/initramfs/rdsosreport.txt"
>>> Entering emergency mode. Exit the shell to continue.
>>> Type "journalctl" to view system logs.
>>> You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or
>>> /boot
>>> after mounting them and attach it to a bug report.
>>> dracut:/# ip l sh
>>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
>>> mode DEFAULT group default qlen 1000
>>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
>>> state UP mode DEFAULT group default qlen 1000
>>>      link/ether 9a:46:22:ae:33:54 brd ff:ff:ff:ff:ff:ff\
>>> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
>>> master eth0 state UP mode DEFAULT group default qlen 1000
>>>      link/ether 9a:46:22:ae:33:54 brd ff:ff:ff:ff:ff:ff
>>> dracut:/#
>>>
>>> If changing dracut code to ignore eth1 (with IFLA_MASTER attr),
>>> network boot starts to work.
>>
>>
>> Does dracut by default tries to use all the interfaces that are UP?
>>
> Yes. The specific dracut cmdline of our case is "ip=dhcp
> netroot=iscsi:... ", but it's not specific to iscsi boot. And because
> of same MAC address for failover and standby, while dracut tries to
> run DHCP on all interfaces that are up it eventually gets same route
> for each interface. Those conflict route entries kill off the network
> connection.
> 
>>
>>>
>>> The reason is that dracut has its own means to differentiate virtual
>>> interfaces for network boot: it does not look at IFLA_MASTER and
>>> ignores slave interfaces. Instead, users have to provide explicit
>>> option e.g. bond=eth0,eth1 in the boot line, then dracut would know
>>> the config and ignore the slave interfaces.
>>
>>
>> Isn't it possible to specify the interface that should be used for network
>> boot?
> As I understand it, one can only specify interface name for running
> DHCP but not select interface for network boot.  We want DHCP to run
> on every NIC that is up (excluding the enslaved interfaces), and only
> one of them can get a route entry to the network boot server (ie.g.
> iSCSI target).
> 
>>
>>
>>>
>>> However, with automatic creation of failover interface that assumption
>>> is no longer true. Can we change dracut to ignore all slave interface
>>> by checking  IFLA_MASTER? I don't think so. It has a large impact to
>>> existing configs.
>>
>>
>> What is the issue with checking for IFLA_MASTER? I guess this is used with
>> team/bonding setups.
> That should be discussed within and determined by the dracut
> community. But the current dracut code doesn't check IFLA_MASTER for
> team or bonding specifically. I guess this change might have broader
> impact to existing userspace that might be already relying on the
> current behaviour.
> 
> Thanks,
> -Siwei

Is there a sysfs flag for IFF_SLAVE? Or any "ip" output I can use to detect, that it is a IFF_SLAVE?

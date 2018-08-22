From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: virtio_net failover and initramfs
Date: Wed, 22 Aug 2018 00:27:19 -0700
Message-ID: <CADGSJ223noQzSkW9497LpK8yeUpGeDYfQjgusqVo9MQsFYG16w@mail.gmail.com>
References: <CADGSJ22433hWW8O6j__TDX+P-Rwx+YoYR=NzU5ueCPFT2wzUDw@mail.gmail.com>
 <58f1f440-2bf9-1436-c987-95f331ce9990@intel.com> <CADGSJ206hwO_3RbB8C5875updN1e=LZqw1kwNJgne_-c4=9GoQ@mail.gmail.com>
 <85bf8fce-8cdf-597c-3b50-a1ff2eb5c5c4@redhat.com> <914c05dc-4eaa-4b1b-69f1-d06676c75fd2@redhat.com>
 <132a4610-a59f-19e4-a602-ead91325fb47@intel.com> <aad05ef2-b2d2-e549-06d8-a8a9a454352d@redhat.com>
 <CADGSJ22QksMTm3CuFXUVAGoiqy5VVuGAG9FHTRy6dt60gJ7KSA@mail.gmail.com> <87171e54-1d4f-f755-ab90-7c1373268950@redhat.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KAwcWmWrJ2cCc9JFn195iuk0aweOx3eZlG9hUlxp+F4=;
        b=GepPraKkzcxCToNZQTtU/XiJfUNrgNA6gHSUpwHiEtA3Xka/hwa2c7jadaVrwF0XIS
         tfpHad+ya3cEQh2ZOUxT+/+1hy3DJYjQBo2vMvc80g9TFm6ZUGvBbQRuZFpJFW879VoK
         B3+hDQUvvMB6b2KkFhytY+OFegU3Y+PJGbNqwz0/NX2AUzl3bOadn5J9LNNzg9fVi9zt
         QVbA4OqEKKIvUoeuGpDMGq9ErETiYMcW19qOGNfGBHFSOl2WYqFsHQq/MOz2aOb0i8uK
         6OLVEXc0jZ0emzt9tnif5gAGW75dl7qIzCPChou1oAumHdDB5pxWzQYo8Jdt1x9yfjHm
         eIrg==
In-Reply-To: <87171e54-1d4f-f755-ab90-7c1373268950@redhat.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Jiri Pirko <jiri@resnulli.us>, initramfs@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Netdev <netdev@vger.kernel.org>, vijay.balakrishna@oracle.com, si-wei liu <si-wei.liu@oracle.com>, liran.alon@oracle.com

On Wed, Aug 22, 2018 at 12:23 AM, Harald Hoyer <harald@redhat.com> wrote:
> On 22.08.2018 09:17, Siwei Liu wrote:
>> On Tue, Aug 21, 2018 at 6:44 AM, Harald Hoyer <harald@redhat.com> wrote:
>>> On 17.08.2018 21:09, Samudrala, Sridhar wrote:
>>>> On 8/17/2018 2:56 AM, Harald Hoyer wrote:
>>>>> On 17.08.2018 11:51, Harald Hoyer wrote:
>>>>>> On 16.08.2018 00:17, Siwei Liu wrote:
>>>>>>> On Wed, Aug 15, 2018 at 12:05 PM, Samudrala, Sridhar
>>>>>>> <sridhar.samudrala@intel.com> wrote:
>>>>>>>> On 8/14/2018 5:03 PM, Siwei Liu wrote:
>>>>>>>>> Are we sure all userspace apps skip and ignore slave interfaces by
>>>>>>>>> just looking at "IFLA_MASTER" attribute?
>>>>>>>>>
>>>>>>>>> When STANDBY is enabled on virtio-net, a failover master interface
>>>>>>>>> will appear, which automatically enslaves the virtio device. But it is
>>>>>>>>> found out that iSCSI (or any network boot) cannot boot strap over the
>>>>>>>>> new failover interface together with a standby virtio (without any VF
>>>>>>>>> or PT device in place).
>>>>>>>>>
>>>>>>>>> Dracut (initramfs) ends up with timeout and dropping into emergency shell:
>>>>>>>>>
>>>>>>>>> [  228.170425] dracut-initqueue[377]: Warning: dracut-initqueue
>>>>>>>>> timeout - starting timeout scripts
>>>>>>>>> [  228.171788] dracut-initqueue[377]: Warning: Could not boot.
>>>>>>>>>            Starting Dracut Emergency Shell...
>>>>>>>>> Generating "/run/initramfs/rdsosreport.txt"
>>>>>>>>> Entering emergency mode. Exit the shell to continue.
>>>>>>>>> Type "journalctl" to view system logs.
>>>>>>>>> You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or
>>>>>>>>> /boot
>>>>>>>>> after mounting them and attach it to a bug report.
>>>>>>>>> dracut:/# ip l sh
>>>>>>>>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
>>>>>>>>> mode DEFAULT group default qlen 1000
>>>>>>>>>       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
>>>>>>>>> state UP mode DEFAULT group default qlen 1000
>>>>>>>>>       link/ether 9a:46:22:ae:33:54 brd ff:ff:ff:ff:ff:ff\
>>>>>>>>> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
>>>>>>>>> master eth0 state UP mode DEFAULT group default qlen 1000
>>>>>>>>>       link/ether 9a:46:22:ae:33:54 brd ff:ff:ff:ff:ff:ff
>>>>>>>>> dracut:/#
>>>>>>>>>
>>>>>>>>> If changing dracut code to ignore eth1 (with IFLA_MASTER attr),
>>>>>>>>> network boot starts to work.
>>>>>>>>
>>>>>>>> Does dracut by default tries to use all the interfaces that are UP?
>>>>>>>>
>>>>>>> Yes. The specific dracut cmdline of our case is "ip=dhcp
>>>>>>> netroot=iscsi:... ", but it's not specific to iscsi boot. And because
>>>>>>> of same MAC address for failover and standby, while dracut tries to
>>>>>>> run DHCP on all interfaces that are up it eventually gets same route
>>>>>>> for each interface. Those conflict route entries kill off the network
>>>>>>> connection.
>>>>>>>
>>>>>>>>> The reason is that dracut has its own means to differentiate virtual
>>>>>>>>> interfaces for network boot: it does not look at IFLA_MASTER and
>>>>>>>>> ignores slave interfaces. Instead, users have to provide explicit
>>>>>>>>> option e.g. bond=eth0,eth1 in the boot line, then dracut would know
>>>>>>>>> the config and ignore the slave interfaces.
>>>>>>>>
>>>>>>>> Isn't it possible to specify the interface that should be used for network
>>>>>>>> boot?
>>>>>>> As I understand it, one can only specify interface name for running
>>>>>>> DHCP but not select interface for network boot.  We want DHCP to run
>>>>>>> on every NIC that is up (excluding the enslaved interfaces), and only
>>>>>>> one of them can get a route entry to the network boot server (ie.g.
>>>>>>> iSCSI target).
>>>>>>>
>>>>>>>>
>>>>>>>>> However, with automatic creation of failover interface that assumption
>>>>>>>>> is no longer true. Can we change dracut to ignore all slave interface
>>>>>>>>> by checking  IFLA_MASTER? I don't think so. It has a large impact to
>>>>>>>>> existing configs.
>>>>>>>>
>>>>>>>> What is the issue with checking for IFLA_MASTER? I guess this is used with
>>>>>>>> team/bonding setups.
>>>>>>> That should be discussed within and determined by the dracut
>>>>>>> community. But the current dracut code doesn't check IFLA_MASTER for
>>>>>>> team or bonding specifically. I guess this change might have broader
>>>>>>> impact to existing userspace that might be already relying on the
>>>>>>> current behaviour.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> -Siwei
>>>>>> Is there a sysfs flag for IFF_SLAVE? Or any "ip" output I can use to detect, that it is a IFF_SLAVE?
>>>>>>
>>>>> Oh, it's the other way around.. dracut should ignore "master" (eth1).
>>>> In the above example eth0 is the net_failover device and eth1 is the lower virtio_net device.
>>>> "ip" output of eth1 shows "master eth0". It indicates that eth0 is its upper/master device.
>>>> This information can also be obtained via sysfs too. /sys/class/net/eth1/upper_eth0
>>>>>
>>>>> Can the master enslave the "eth0", if it is already "UP" and busy later on?
>>>> eth0 is the master/failover device and eth1 gets registered as its slave via NETDEV_REGISTER event.
>>>> dracut should ignore eth1 in this setup.
>>>
>>>
>>> Care to test, if that fixes your case?
>>> https://github.com/dracutdevs/dracut/pull/450/files
>>
>> Sorry, I forgot to mention that some of our setups do not have
>> 'ip=dhcp' explicitly specified, but are still able to boot from iSCSI
>> target using "netroot=iscsi:...". Move the iface_is_enslaved check out
>> from the parsing of ip= lines?
>>
>> -Siwei
>>
>
> Does that mean, you want to use the enslaved interface?

Not really. I would like to ignore enslaved interfaces *even if ip= is
not specified*.

-Siwei

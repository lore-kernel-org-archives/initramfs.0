From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26 -
 systemd-networkd problem
Date: Sun, 27 May 2018 13:31:17 -0700
Message-ID: <80a5da81-0ed3-14bc-2e62-bd25f05de792@gmail.com>
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
 <779f2be3-3e74-e650-5240-efaf1003d77c@wiesinger.com>
 <4f7c5173-019d-ba0e-70b3-addf64a6a9fa@gmail.com>
 <aba2788a-ba54-dbc8-dd60-e862ba31d66d@wiesinger.com>
 <53c9272a-0e1a-e8fb-a3e4-b4e23e77be10@gmail.com>
 <ba1a6179-48ff-ca2b-bb3c-f99f8376df50@wiesinger.com>
 <18ca17a1-4673-2ace-7142-d4aef6854bc4@wiesinger.com>
 <219eaac0-3d76-005a-f8d6-c54ea21f205e@wiesinger.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1kxgc/rMESZPapkLzEZeb75UK/57fk/gwSfoMkkExs=;
        b=eRSfBDxdrXkNeJOQOpp185sO4yNOaxUXSVPVwBFxOIUvDL5KUGXPbKhi4Cqa9+esxF
         O9WyKR83eb35ljwK3YPa9lGDLJcP8jf+rMADlrRluONUmFRkdUNnin78zyNFDLRiRd78
         HfR7vA11yXv6KbWB/nzY2zrx5JM1CkYNpMdyYFkz9JxbvnEp1MfAEaasb8XkfdENhHRR
         P8tjOl2LHvIMPagyOvqWxUGT4mlaUFB1O17nr2lttU9iDFHbYVjiXqnih++gdvd7P+Rv
         U/uqrmuuw2eg/i4T+8NysMcZM4Sk3Z9ygSu74eUtdzpXG/jr/l5C2pvvKu6d3GBc6LvV
         cD5A==
In-Reply-To: <219eaac0-3d76-005a-f8d6-c54ea21f205e@wiesinger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Gerhard Wiesinger <lists@wiesinger.com>, Andrew Lunn <andrew@lunn.ch>, initramfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Le 05/27/18 à 12:01, Gerhard Wiesinger a écrit :
> On 24.05.2018 08:22, Gerhard Wiesinger wrote:
>> On 24.05.2018 07:29, Gerhard Wiesinger wrote:
>>> After some analysis with Florian (thnx) we found out that the current
>>> implementation is broken:
>>>
>>> https://patchwork.ozlabs.org/patch/836538/
>>> https://github.com/torvalds/linux/commit/c499696e7901bda18385ac723b7bd27c3a4af624#diff-a2b6f8d89e18de600e873ac3ac43fa1d
>>>
>>>
>>> Florians comment:
>>>
>>> c499696e7901bda18385ac723b7bd27c3a4af624 ("net: dsa: b53: Stop using
>>> dev->cpu_port incorrectly") since it would result in no longer setting
>>> the CPU port as tagged for a specific VLAN. Easiest way for you right
>>> now is to just revert it, but this needs some more thoughts for a proper
>>> upstream change. I will think about it some more.
>>
>> Can confirm 4.14.18-200.fc26.armv7hl works, 4.15.x should be broken.
>>
>> # Kernel 4.14.x ok
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.14.43
>>
>> # Kernel 4.15.x should be NOT ok
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.15.18
>>
> 
> Kernel 4.14.18-300.fc27.armv7hl works well so far, even with FC28
> update. Florian send me a patch to try for 4.16.x

So does my patch make 4.16 work correctly for you now? If so, can I just
submit it and copy you?

> 
> I got the  commands below to work with manual script commands.
> Afterwards I wrote systemd-networkd config where I've a strage problem
> when IPv6 sends a multicast broadcast from another machine to the bridge
> this will be sent back via the network interface, but with the source
> MAC of the bridge of the other machine. dmesg from the other machine:
> [117768.330444] br0: received packet on lan0 with own address as source
> address (addr:a0:36:9f:ab:cd:ef, vlan:0)
> [117768.334887] br0: received packet on lan0 with own address as source
> address (addr:a0:36:9f:ab:cd:ef, vlan:0)
> [117768.339281] br0: received packet on lan0 with own address as source
> address (addr:a0:36:9f:ab:cd:ef, vlan:0)
> 
> And: If I just enter this command after e.g. a systemd-network restart
> everything is fine forever:
> # Not OK (dmesg message above is triggered on a remote computer, whole
> switching network gets unstable, ssh terminals close, packet loss, etc.)
> systemctl restart systemd-networkd
> # OK again when this command is entered
> bridge vlan add dev wan vid 102 pvid untagged
> 
> brctl show, ip link, bridge vlan, bridge link commands, etc. look all
> the same, also /sys/class/net/br0/bridge, /sys/class/net/br1/bridge
> settings
> 
> Systemd config correct?
> Any ideas?

You should not have eth0.101 and eth0.102 to be enslaved in a bridge at
all, this is what is causing the bridge to be confused. Remember what I
wrote to you before, with the current b53 driver that does not have any
tagging enabled the lanX interfaces and brX interfaces are only used for
control and should not be used for passing any data. The only network
device that will be passing data is eth0, which is why we need to set-up
VLAN interfaces to pop/push the VLAN id accordingly.

I have no idea why manual vs. systemd does not work but you can most
certainly troubleshoot that by comparing the bridge/ip outputs.

> 
> Thank you.
> 
> Ciao,
> Gerhard
> 
> brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.665da2abcdef       no              eth0.101
>                                                         lan1
>                                                         lan2
>                                                         lan3
>                                                         lan4
> br1             8000.9a4557abcdef      no              eth0.102
>                                                         wan
> 
> 
> bridge vlan show
> port    vlan ids
> lan2     101 PVID Egress Untagged
> 
> lan3     101 PVID Egress Untagged
> 
> lan4     101 PVID Egress Untagged
> 
> wan      102 PVID Egress Untagged
> 
> lan1     101 PVID Egress Untagged
> 
> br1     None
> br0     None
> eth0.102        None
> eth0.101        None
> 
> ================================================================================================================================================================
> 
> 
> OK: manual scripts
> 
> ================================================================================================================================================================
> 
> 
> ip link add link eth0 name eth0.101 type vlan id 101
> ip link set eth0.101 up
> ip link add link eth0 name eth0.102 type vlan id 102
> ip link set eth0.102 up
> ip link add br0 type bridge
> ip link set dev br0 type bridge stp_state 0
> ip link set lan1 master br0
> bridge vlan add dev lan1 vid 101 pvid untagged
> ip link set lan1 up
> ip link set lan2 master br0
> bridge vlan add dev lan2 vid 101 pvid untagged
> ip link set lan2 up
> ip link set lan3 master br0
> bridge vlan add dev lan3 vid 101 pvid untagged
> ip link set lan3 up
> ip link set lan4 master br0
> bridge vlan add dev lan4 vid 101 pvid untagged
> ip link set lan4 up
> ip link set eth0.101 master br0
> ip link set eth0.101 up
> ip link set br0 up
> ip link add br1 type bridge
> ip link set dev br1 type bridge stp_state 0
> ip link set wan master br1
> bridge vlan add dev wan vid 102 pvid untagged
> ip link set wan up
> ip link set eth0.102 master br1
> ip link set eth0.102 up
> ip link set br1 up
> ip addr flush dev br0
> ip addr add 192.168.0.250/24 dev br0
> ip route del default via 192.168.0.1 dev br0
> ip route add default via 192.168.0.1 dev br0
> ip addr flush dev br1
> ip addr add 192.168.1.1/24 dev br1
> 
> 
> ================================================================================================================================================================
> 
> 
> NOK: after a multicast packet is received
> 
> ================================================================================================================================================================
> 
> 
> ================================================================================
> 
> = /etc/systemd/network/40-autogen-eth0.101.netdev
> ================================================================================
> 
> [NetDev]
> Name=eth0.101
> Kind=vlan
> 
> [VLAN]
> Id=101
> ================================================================================
> 
> = /etc/systemd/network/40-autogen-eth0.102.netdev
> ================================================================================
> 
> [NetDev]
> Name=eth0.102
> Kind=vlan
> 
> [VLAN]
> Id=102
> ================================================================================
> 
> = /etc/systemd/network/40-autogen-eth0.network
> ================================================================================
> 
> [Match]
> Name=eth0
> 
> [Network]
> VLAN=eth0.101
> VLAN=eth0.102
> ================================================================================
> 
> = /etc/systemd/network/50-autogen-br0.netdev
> ================================================================================
> 
> [NetDev]
> Name=br0
> Kind=bridge
> 
> [Bridge]
> DefaultPVID=none
> VLANFiltering=false
> STP=false
> ================================================================================
> 
> = /etc/systemd/network/50-autogen-br1.netdev
> ================================================================================
> 
> [NetDev]
> Name=br1
> Kind=bridge
> 
> [Bridge]
> DefaultPVID=none
> VLANFiltering=false
> STP=false
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br0-eth0.101.network
> ================================================================================
> 
> [Match]
> Name=eth0.101
> 
> [Network]
> Bridge=br0
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br0-lan1.network
> ================================================================================
> 
> [Match]
> Name=lan1
> 
> [Network]
> Bridge=br0
> 
> [BridgeVLAN]
> VLAN=101
> EgressUntagged=101
> PVID=101
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br0-lan2.network
> ================================================================================
> 
> [Match]
> Name=lan2
> 
> [Network]
> Bridge=br0
> 
> [BridgeVLAN]
> VLAN=101
> EgressUntagged=101
> PVID=101
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br0-lan3.network
> ================================================================================
> 
> [Match]
> Name=lan3
> 
> [Network]
> Bridge=br0
> 
> [BridgeVLAN]
> VLAN=101
> EgressUntagged=101
> PVID=101
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br0-lan4.network
> ================================================================================
> 
> [Match]
> Name=lan4
> 
> [Network]
> Bridge=br0
> 
> [BridgeVLAN]
> VLAN=101
> EgressUntagged=101
> PVID=101
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br1-eth0.102.network
> ================================================================================
> 
> [Match]
> Name=eth0.102
> 
> [Network]
> Bridge=br1
> ================================================================================
> 
> = /etc/systemd/network/60-autogen-br1-wan.network
> ================================================================================
> 
> [Match]
> Name=wan
> 
> [Network]
> Bridge=br1
> 
> [BridgeVLAN]
> VLAN=102
> EgressUntagged=102
> PVID=102
> ================================================================================
> 
> = /etc/systemd/network/61-autogen-br0.network
> ================================================================================
> 
> [Match]
> Name=br0
> 
> [Network]
> Address=192.168.0.250/24
> Gateway=192.168.0.1
> DNS=192.168.0.1
> Domains=intern
> ================================================================================
> 
> = /etc/systemd/network/61-autogen-br1.network
> ================================================================================
> 
> [Match]
> Name=br1
> 
> [Network]
> Address=192.168.1.1/24
> 


-- 
Florian

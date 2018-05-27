From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26 -
 systemd-networkd problem
Date: Sun, 27 May 2018 13:35:27 -0700
Message-ID: <6c93d27e-66dc-02a9-f8f9-f349f27dfec6@gmail.com>
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
 <485b3a0e-23d6-c90c-6f41-8d9f33b1ad1f@wiesinger.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fwJtU3tK9k3z/3LMWIfk6TLeG+5ukugzubt9CCthnds=;
        b=gTi4gU15YxRxMRkTKdg9LGoH2YEEV1EiJve5fNkYBZJxvSJGcyr/1RBv2919IoKw8y
         fqtTxhP/EzvGor88EK1EeO2dJcy9YLel5sRMevjnSh9co8zYPFEPxeZ+aqEY2Jf/QmBn
         En4baMQfQ7RNWFXmY6LeW8cq4tJijiq6beYyBgj8D7blyFCQjeQoS3h1bXFiMkSKg/O/
         NIdXjEfqLc/aCXKcHqCBAaFxrxFDD3mSSfX3zJsm0sm+9LEd3GZL4HVVhSLZrA0co9Ed
         ApBbSdxGySgwWa8VUfFuQUdvHX0aIaQSTb90Xs6LRbACuNWteAFYy7DG/aW6IPmB9KBP
         VfRA==
In-Reply-To: <485b3a0e-23d6-c90c-6f41-8d9f33b1ad1f@wiesinger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Gerhard Wiesinger <lists@wiesinger.com>, Andrew Lunn <andrew@lunn.ch>, initramfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Le 05/27/18 à 12:18, Gerhard Wiesinger a écrit :
> On 27.05.2018 21:01, Gerhard Wiesinger wrote:
>> On 24.05.2018 08:22, Gerhard Wiesinger wrote:
>>> On 24.05.2018 07:29, Gerhard Wiesinger wrote:
>>>> After some analysis with Florian (thnx) we found out that the
>>>> current implementation is broken:
>>>>
>>>> https://patchwork.ozlabs.org/patch/836538/
>>>> https://github.com/torvalds/linux/commit/c499696e7901bda18385ac723b7bd27c3a4af624#diff-a2b6f8d89e18de600e873ac3ac43fa1d
>>>>
>>>>
>>>> Florians comment:
>>>>
>>>> c499696e7901bda18385ac723b7bd27c3a4af624 ("net: dsa: b53: Stop using
>>>> dev->cpu_port incorrectly") since it would result in no longer setting
>>>> the CPU port as tagged for a specific VLAN. Easiest way for you right
>>>> now is to just revert it, but this needs some more thoughts for a
>>>> proper
>>>> upstream change. I will think about it some more.
>>>
>>> Can confirm 4.14.18-200.fc26.armv7hl works, 4.15.x should be broken.
>>>
>>> # Kernel 4.14.x ok
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.14.43
>>>
>>> # Kernel 4.15.x should be NOT ok
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.15.18
>>>
>>
>>
> 
> Forgot to mention: What's also strange is that the VLAN ID is very high:
> 
> # 4.14.18-300.fc27.armv7hl, iproute-4.15.0-1.fc28.armv7hl
> ip -d link show eth0.101 | grep "vlan protocol"
>     vlan protocol 802.1Q id 3069279796 <REORDER_HDR>
> ip -d link show eth0.102 | grep "vlan protocol"
>     vlan protocol 802.1Q id 3068673588 <REORDER_HDR>
> 
> On older kernels this looks ok: 4.12.8-200.fc25.armv7hl,
> iproute-4.11.0-1.fc25.armv7hl:
>  ip -d link show eth0.101 | grep "vlan protocol"
>     vlan protocol 802.1Q id 101 <REORDER_HDR>
> ip -d link show eth0.102 | grep "vlan protocol"
>     vlan protocol 802.1Q id 102 <REORDER_HDR>
> 
> Ideas?

That is quite likely a kernel/iproute2 issue, if you configured the
switch through bridge vlan to have the ports in VLAN 101 and VLAN 102
and you do indeed see frames entering eth0 with these VLAN IDs, then
clearly the bridge -> switchdev -> dsa -> b53 part is working just fine
and what you are seeing is some for of kernel header/netlink
incompatibility.
-- 
Florian

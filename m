From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26 -
 systemd-networkd problem
Date: Sun, 27 May 2018 21:18:34 +0200
Message-ID: <485b3a0e-23d6-c90c-6f41-8d9f33b1ad1f@wiesinger.com>
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
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4RJIYUp019093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1527448715;
        bh=frUz4HEb2D/Uhzg9+JndIHOc7qiv6cB4bczpPF9Zsbg=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=x9y/kIMyKcdoQzgDYkOE4jyOHAkuRs2hViwleR19d0W3lYUqKXHf4AF85IiTxo+vU
         9J5kzL0DvIBZrfdHKDhn4Rr3j0FiROEIOwR9ozJXjQidD0HV0fY0bVylommfZTEMh4
         dW7SHonHHP3jKpG3+qBFWTLKbjXWPZ/4ygJX0qUThtiAUo8bpHXzKXdEVivN5laKr7
         xY8TrwRt4NQ/NprSku03OVZZfjA9X2KRY+myrYm/xsFueJzAbUlKTqt96XILjsyu6S
         QF1IDGuHOOPYUvCThkPg+gWolGgOw8XEQgeZG220R6HFOvBjyyQ8EHDfPmiDfAv6Bv
         pM2IAZFccJFi8fldeSsk94nghT31F/LHt3mJEbOR504m34ifdweMDwL6CAw+lAulTk
         mOZySP3QHmM3uk9kq2bduPndHtrNjyc9FvaR+KbWwPzcyV5kN/rt0BGoEf0YP8Tu+0
         pRlT7rUUtai649x72XWrON7BgcgsUiVYw6qJXwYk9O7EdBYbK4S0xqul63uf+W3aEQ
         LpBv+8LFLvQeW2JLzMdh+anCUcYuDZLiVG6Eb+jLNdxRipBuN5jkK2z4bz6 
In-Reply-To: <219eaac0-3d76-005a-f8d6-c54ea21f205e@wiesinger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, initramfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 27.05.2018 21:01, Gerhard Wiesinger wrote:
> On 24.05.2018 08:22, Gerhard Wiesinger wrote:
>> On 24.05.2018 07:29, Gerhard Wiesinger wrote:
>>> After some analysis with Florian (thnx) we found out that the 
>>> current implementation is broken:
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
>>> now is to just revert it, but this needs some more thoughts for a 
>>> proper
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
>

Forgot to mention: What's also strange is that the VLAN ID is very high:

# 4.14.18-300.fc27.armv7hl, iproute-4.15.0-1.fc28.armv7hl
ip -d link show eth0.101 | grep "vlan protocol"
     vlan protocol 802.1Q id 3069279796 <REORDER_HDR>
ip -d link show eth0.102 | grep "vlan protocol"
     vlan protocol 802.1Q id 3068673588 <REORDER_HDR>

On older kernels this looks ok: 4.12.8-200.fc25.armv7hl, 
iproute-4.11.0-1.fc25.armv7hl:
  ip -d link show eth0.101 | grep "vlan protocol"
     vlan protocol 802.1Q id 101 <REORDER_HDR>
ip -d link show eth0.102 | grep "vlan protocol"
     vlan protocol 802.1Q id 102 <REORDER_HDR>

Ideas?

Thank you.

Ciao,
Gerhard




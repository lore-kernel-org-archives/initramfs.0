From: Hanasaki Jiji <hanasaki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Only 16GB of 20GB memory / RAM : found by kernel
Date: Mon, 8 Feb 2021 20:25:10 -0500
Message-ID: <CAMr-kF222fGDaLM2RT3U6MAcukB_0nUDSQcJxpfO=bt_WxU4RQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EbaP7cgb+dpSSW9n6DszSD4KEAf456YOZfWuFAJSm30=;
        b=Vmg2qSHDvQeX1csDDVgTqZIpOWKmEhoWTfqui5flIN/wPONP5VymBaDpKDaehfR/5g
         CZYsgT2OK5Ef9hu7Hhlj6ph2aGAlRmjwqwlDS6ZVpER8cLS+NC4VLV/IkVYPJeFiDEVZ
         MJsdJRqxwrCSENT7JsUgK9eRTy8k+jvNqbV2C17X+7SOhGRtx3uTy9Rz7WoxPVv4Fz61
         z0kDgKzK15RXWKhvrELABCrm2SDTUvQ0sGPIpYAmUemqKZBLTCWFbV5/k4olzi4GXeuG
         JXmNr7FLtbHOyWDea+H6r9TbjlJFvG0gZ3pD6JWAbn/IDkcVmSI8sbsY8pxO8uYqBKAL
         AVdA==
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

free -g reports 17GB

ROM set reports 20GB as does the below (4+16GB)   How to get the 4GB
bank to usable

kernel 5.10.x

****************
dmidecode -t memory

# dmidecode 3.3
Getting SMBIOS data from sysfs.
SMBIOS 3.2.1 present.

Handle 0x000A, DMI type 16, 23 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: None
    Maximum Capacity: 32 GB
    Error Information Handle: 0x0009
    Number Of Devices: 2

Handle 0x0011, DMI type 17, 40 bytes
Memory Device
    Array Handle: 0x000A
    Error Information Handle: 0x0010
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 4 GB
    Form Factor: SODIMM
    Set: None
    Locator: DIMM 0
    Bank Locator: P0 CHANNEL A
    Type: DDR4
    Type Detail: Synchronous Unbuffered (Unregistered)
    Speed: 3200 MT/s
    Manufacturer: Hynix
    Serial Number: 00000000
    Asset Tag: Not Specified
    Part Number: HMA851S6CJR6N-XN
    Rank: 1
    Configured Memory Speed: 2400 MT/s
    Minimum Voltage: 1.2 V
    Maximum Voltage: 1.2 V
    Configured Voltage: 1.2 V

Handle 0x0014, DMI type 17, 40 bytes
Memory Device
    Array Handle: 0x000A
    Error Information Handle: 0x0013
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 16 GB
    Form Factor: SODIMM
    Set: None
    Locator: DIMM 0
    Bank Locator: P0 CHANNEL B
    Type: DDR4
    Type Detail: Synchronous Unbuffered (Unregistered)
    Speed: 2667 MT/s
    Manufacturer: A-DATA Technology
    Serial Number: 00870000
    Asset Tag: Not Specified
    Part Number:
    Rank: 1
    Configured Memory Speed: 2400 MT/s
    Minimum Voltage: 1.2 V
    Maximum Voltage: 1.2 V
    Configured Voltage: 1.2 V

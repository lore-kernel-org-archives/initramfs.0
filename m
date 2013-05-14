From: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Tue, 14 May 2013 13:27:13 +1000 (EST)
Message-ID: <alpine.LFD.2.03.1305141326120.30473@beren.home>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5191AA29.3010107-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Joseph D. Wagner" <joe-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 13 May 2013, Joseph D. Wagner wrote:
> output from `blkid'

Sorry, I missed this in my previous email.

Output from blkid:

/dev/sda1: SEC_TYPE="msdos" UUID="1400-EDC0" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="f600b7a0-dc4c-4c62-8c32-29b753877072"
/dev/sda2: UUID="009ef157-66a8-42cb-869e-436244f39ca2" TYPE="ext4" PARTUUID="1da28ac9-df4f-42c2-8988-df0d5add947d"
/dev/sda3: UUID="vpNiek-T840-JH8E-phcM-BUgl-zNeX-70HDuW" TYPE="LVM2_member" PARTUUID="d1bd9da9-ee3c-45be-8960-921f1cb4dfec"
/dev/mapper/ogopogo-root: LABEL="root" UUID="c73aa277-ff32-42d0-a6f1-681694ba7b36" TYPE="ext4"
/dev/mapper/ogopogo-home: UUID="92b64e79-7b00-401a-ba83-e2fe5fa828f4" TYPE="crypto_LUKS"
/dev/mapper/luks-swap: UUID="e553888c-42f0-42ff-ac78-ab90b5562f41" TYPE="swap"
/dev/mapper/luks-home: LABEL="home" UUID="50c2abf5-84b0-4752-b527-e94b82b208f8" TYPE="ext4"

Thanks,
Michael

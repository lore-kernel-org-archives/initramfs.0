From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 15:32:16 +0100
Message-ID: <CAPXgP13c1B80u14E4FrhZEJ89NDvDP--ciWikz0j+m4En6zPRQ@mail.gmail.com>
References: <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it>
 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
 <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
 <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it>
 <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it> <ji08e6$8kc$1@dough.gmane.org>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrfy.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HqgtKGueOXSHNfOlXftZ5+MF8+pVjNctGPz86wm63tw=;
        b=gfdFriagyIJ3Wyf4qXwHUQdArkcHpDVFqAieAJcLYjnCklj+pcyhNiExCZ5X5rWK0q
         EvyOEvn7AMqJ3jtlVnKTQWdbusyMHKx1S0G8RjU+VkfSNebPxettzc03BYolLZTX5Atv
         gR3E311vnAAEfmZ/npAtc0pPZbKLAoYngIAIk=
In-Reply-To: <ji08e6$8kc$1@dough.gmane.org>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-security-module@vger.kernel.org

On Tue, Feb 21, 2012 at 15:07, Colin Guthrie <gmane@colin.guthr.ie> wrote:

>> The code for loading IMA custom policies was placed in the initial
>> ramdisk with the purpose to avoid distribution specific dependencies.
>> However, since the SELinux initialization has been moved to Systemd
>> and Systemd itself will be used by the major distributions, i think
>> placing the IMA code here is the best solution, even if it is not the
>> most general.
>
> Just for reference, not all distros use the same initrd generator
> anyway. We're trying to move to dracut, but it's certainly not universal
> at the moment. I think Suse use something else (maybe they plan to move
> to dracut too?) and I've no idea about Ubuntu but I doubt they use dracut.
>
> So I'd suggest that at the moment, systemd will actually get you wider
> coverage... although that's just a slightly ill-informed and hand-wave
> analysis on my part. Either way, I think it's better in systemd :D

Sounds right. The initramfs is definitely less generic than systemd
is. Almost every distro has still its own here. The situation today
with initramfs generators can probably not get more distro-specific;
it is still almost at its maximum. :)

So the thinking of moving anything to the initramfs to avoid the Linux
distro balcanization problem will usually not work out.

Kay

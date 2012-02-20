From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Mon, 20 Feb 2012 20:06:42 +0100
Message-ID: <4F4299C2.5040205@polito.it>
References: <1329312229-11856-2-git-send-email-roberto.sassu@polito.it> <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com> <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com> <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it> <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com> <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com> <20120220172418.GG26356@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1W8xJ8lfe4Gr1EPwb0a4v3KXXjPwTRoTKYYxXGSr0cg=;
        b=J6uNlacznJ74W70hHrRg86GpK2fkBMYCemXkQzlm6nEUjN29HV5Y7b/iDf5DXk6ywP
         x7AkXWnETXx6lKSJGzOPm2fFXBv3XJFo3OYTyk7JVWMsVG0UB0yx8Vwx/TDmWB2UadWW
         utAkQC22zZ/06gBMlx1+NhFyPO5rUi8dUuj7c=
In-Reply-To: <20120220172418.GG26356@tango.0pointer.de>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart@poettering.net>
Cc: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, Michael Cassaniti <m.cassaniti@gmail.com>, linux-security-module@vger.kernel.org, harald@redhat.com, ramunno@polito.it

On 02/20/2012 06:24 PM, Lennart Poettering wrote:
> On Thu, 16.02.12 19:50, Gustavo Sverzut Barbieri (barbieri@profusion.mobi) wrote:
>
>>>> Then I wonder: why not make an ima-init binary that:
>>>>    - does ima_setup()
>>>>    - exec systemd || upstart || ...
>>>>
>>>> this way you only have to audit this very small file and not systemd
>>>> itself, it's very early and so on.
>>>>
>>>
>>> This does not work because SELinux is initialized inside Systemd and IMA
>>> requires it for parsing LSM rules in the policy.
>>
>> initramfs may do it as well, no? then systemd will inherit it.
>
> We moved SELinux loading out of the initrd into systemd, in order to
> support fully featured initrd-less boots. I don't think we should reopen
> this problem set by having IMA in the initrd. I believe IMA should be
> treated pretty much exactly like SELinux here: the policy should be
> loaded from PID1 and it needs to be a compile time option, and it needs
> a kernel cmdline option to disable it (i.e. like selinux=0).
>

If the SELinux module in dracut is to be considered definitively broken
probably also the IMA module should be removed, because it will not be
possible to load policies with LSM rules. But i don't know how this
feature can be supported by distributions without Systemd installed.

Regarding the kernel option, actually there is no a specific parameter
to disable IMA. However, it can be introduced in the patches proposed
by Mimi Zohar about the 'ima-appraisal' feature. This can allow to
disable IMA or to put it in permissive/enforce mode as it happens for
example in SELinux.

Thanks

Roberto Sassu


> Lennart
>


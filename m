From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ACPI: Override arbitrary ACPI tables via initrd for
 debugging
Date: Sun, 23 Sep 2012 00:25:40 -0400
Message-ID: <505E8F44.9020208@kernel.org>
References: <1348234085-39220-1-git-send-email-trenn@suse.de> <1348234085-39220-3-git-send-email-trenn@suse.de> <505DD65F.9080203@kernel.org> <201209230317.04050.trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Mr30z4nBMRl6BK/02m5MoaS683DPVIgeeG0lXBdTKXY=;
        b=wAr9EjSKx4DHzAUfGhhVEch9AGaNK0f7uI1yTTtZxbIHIPUAu49iiI36cPkBUKyt5J
         SGVMvYQrbOOBo07nD1YVHG2YAepYLnxxrGMTMlf2DxL+C+pfxn+IXumACLJ3Viid9mJE
         Zu2VBV4emZ7e98QrSrk05IQhZaeA7qJRyydavsOigwLa3KV1A66c2qnjAiE1aYjWKNth
         0pU9Z+v2YC+yJMvDBbM8pk49YnnPgxsjWKOkUcxvEwCzMd4Ovueq1jO8QVFyzw6crxIq
         ks0Ng6OawH0IA4c5y5ytGmdr/8pYSa6r2a/NG2jZpZwyZHvPP1Vgq1htHz0uBOpoyehM
         BxLw==
In-Reply-To: <201209230317.04050.trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, vojcek-wYtBgQxc//8@public.gmane.org

> +config ACPI_INITRD_TABLE_OVERRIDE
> +       bool
> +       default y

Do distros in addition to SuSE concur they want to ship this way?

The last time we tried to make debugging easier we added
ACPI_CUSTOM_METHOD, which allowed root to over-ride an AML method
on a running system.  Distro security-minded people were not amused.

thanks,
-Len Brown, Intel Open Source Technology Center

ps I noticed your reference to acpidump in the README.
That reminded me to push it to the kernel source tree.
Its new home will be tools/power/acpi/

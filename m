From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] Let user specify the action after fail
Date: Tue, 09 Apr 2013 11:15:54 +0200
Message-ID: <5163DC4A.7060107@gmail.com>
References: <30ace4e3dce0dbe9b75572e533d2084ce7c26977.1364553259.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KxLouFHyOXCXm8kLOgdKDy5hqLgTKpQ8znzahNL3cZ4=;
        b=JD2u+QQ4G4ARFVIUwDuq9IH4k8zLh8lF4yP7WCAvr7v8a9ep+VIulSkqUAwJCzSc6+
         rDxYnbfyTiCEiOSa7nr99s0yonpaVGylesjVym1pv96QF3BoRxwNBrAN50PApJOt2vuk
         QQmz3VOQ5rEhQMvVO4+9nt804BIgFWirGucnunrfZ2XiE3sOxR/TLAZ3Y2eTwq2xMvAL
         I9kb7/8mwuSp4GyxuAENR9Gv/8GDWg76ZTY6xVphGlMOAkyLJJY8pjMS1BNNoMo4dUkf
         IV+bY9o2x/1K1J4vfFHj49qFwaBQmtaoPp02OrfKY7oQud7wI/PrIMFOC3P9ZbSApBLi
         qJOw==
In-Reply-To: <30ace4e3dce0dbe9b75572e533d2084ce7c26977.1364553259.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 29.03.2013 11:36, schrieb Baoquan He:
> Currently the default action is emergency_shell when failure happened
> during system boot. In kdump, this default may not be expected. E.g,
> if dump target is not rootfs, it does not matter if mount root failed.
> Adding an action which allow dracut always go ahead though failure
> happens is needed by kdump.
> 
> So here add a function action_on_fail() and cmdline parameter
> action_on_fail=<shell | continue>. Use action_to_fail() to replace
> emergency_shell which was called after failure. By $(getarg action_on_fail=),
> decide to drop into shell, or to leave away the failure and go ahead.
> 
> v3->v4:
> add handling of selinux policy loaded failure, and change code format to
> be consitent
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---

applied and slightly edited

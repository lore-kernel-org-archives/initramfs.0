From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: Re: [PATCH] vconsole: properly set terminal UTF-8
	mode
Date: Thu, 17 Feb 2011 21:52:51 +0300
Message-ID: <AANLkTinvswsHGgEjnLf_dF+RPvc8pZH+Ku+o-2guyzsa@mail.gmail.com>
References: <1288967715-3513-1-git-send-email-arvidjaar@gmail.com>
	<AANLkTik9bv1U5_y6QV1jCJB5mj-DT3zZUucdsVmo+6Vy@mail.gmail.com>
	<AANLkTi=GFHnhnagJ-7ZfGB62oQxVeT+YOZH003CA16Rf@mail.gmail.com>
	<AANLkTi=_uDMFudNq4+jcojgGgoKvU0f2ySb+_7fTaZj7@mail.gmail.com>
	<AANLkTi=8q8K3ST5_QXyHQuUCM=W0u060wcBmBRRBWm+9@mail.gmail.com>
	<20101110224457.GE319@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=TmaaSBQuf6mqa/m2Rw7/COiF1mpud2+vppbTjDsuDog=;
	b=AF7lM5fNFjj+gAN2oxNUFqhgBJrK1XSWCukC/WOqUI9qhym408qeVcNuHVmZb22l2r
	VpfJMLJdQaPQuWrd9QZCBtylX7R89T6kiD79uKkkQOgb229u7l3PTLniCO3e/KF06sWk
	hd0uUhV5PughFQ7J4s5nOcQ6m7ZOKjAKuc+eo=
In-Reply-To: <20101110224457.GE319@tango.0pointer.de>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
To: Lennart Poettering <lennart@poettering.net>
Cc: initramfs <initramfs@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>, systemd-devel@lists.freedesktop.org

On Thu, Nov 11, 2010 at 1:44 AM, Lennart Poettering
<lennart@poettering.net> wrote:
> On Fri, 05.11.10 19:14, Andrey Borzenkov (arvidjaar@gmail.com) wrote:
>
>> >> It is rather interesting. I was testing unrelated patch for dracut
>> >> using dracut tip. It turned out, dracut now installs
>> >> systemd-vconsole-setup when available. Unfortunately it also also
>> >> changed parsing of configuration files so no locale config was
>> >> installed. Which caused vconsole-setup assume we are in non-UNICODE
>> >> mode and disable it.
>> >>
>> >> I still believe we should not make any assumption about console state
>> >> at the time of systemd startup and ensure it is configured as
>> >> requested.
>> >
>> > I see, then we should fix the vconsole setup if stuff goes wrong here.
>>
>> That is basically what my patch does.
>>
>> > We can safely assume that the kernel we rely on is utf8 by default.
>> >
>>
>> OK, do you want me to resubmit with fixed description?
>
> I think it is safe to assume that the kernel enables UTF8 by default. I
> see little need to redo what the kernel has been doing anyway already.
>
> Or, in other words: if vconsole-setup for reason didn't work properly in
> the initrd we probably should fix that, not then try to work-around this
> be enabling UTF8 a second time.
>

As it stands now, dracut 008 in generic (not hostonly) mode explicitly
disables UTF-8 because UNICODE is not set:

modules.d/10i18n/console_init:

set_keyboard() {
    local param

    [ "${UNICODE}" = 1 ] && param=-u || param=-a
    kbd_mode ${param}
}

The problem is, you do not know whether UNICODE is not set because
system is configured for non-UNICODE or because we do not know yet.

That's basically the same problem we already had in the past, and that
was fixed (for hostonly) by

commit 161da365e23cd4ac85f06e928a799f3427d8009d
Author: Andrey Borzenkov <arvidjaar@gmail.com>
Date:   Sun Nov 7 00:14:49 2010 +0300

    i18n: do not use systemd-vconsole-setup

    systemd-vconsole-setup was not designed to be run from udevd.
    It checks locale environment to decide, whether UNICODE should
    be enabled or disabled. Normally environment is setup by
    systemd; but the only environment available in udev rules is
    those from device properties. It means systemd-vconsole-setup
    always assumes default C locale and disables UNICODE.

    Revert to using built-in console_init which explicitly
    imports locale settings from /etc/vconsole.conf. Alternative
    is to revert 6545b9d7 and call console_init directly :)

I do not really see how to fix it in dracut given current
configuration. May be we should gradually move to using UNICODE=0 or
UNICODE=no to *disable* it, but still right now generic dracut image +
systemd is broken:

Feb 19 03:20:51 localhost kernel: systemd-vconsole-setup[341]:
loadkeys: warning: loading Unicode keymap on non-Unicode console
Feb 19 03:20:51 localhost kernel: systemd-vconsole-setup[341]:
(perhaps you want to do `kbd_mode -u'?)

So I humbly ask to revise whether my patch is acceptable.

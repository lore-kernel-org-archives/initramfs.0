From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: build initramfs: bad path in inst_rules when --local
Date: Thu, 22 Sep 2011 15:45:03 +0200
Message-ID: <4E7B3BDF.30104@gmail.com>
References: <4E73E5BB.90208@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lYCWJk0H9KjCTGjYkades6rdimNLmUhBCmtIzD2dleE=;
        b=o4lu1HBK3oM4qggbmRfey89Jq2fO8wCZR1tN+KkBbMEmZwA/d+4x6QVBjXXP+qYKm7
         kNxjL5/lWledBIzDJMwuIYaOy9kttUswQOfT4rrMVt2yJd9QoTyUFZ6+N4BR3PEc5X87
         kWj1YL10j4Zlvc4ep98AT4mV7Y1GQ3iKspvi4=
In-Reply-To: <4E73E5BB.90208-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 17.09.2011 02:11, John Reiser wrote:
> When dracut-013 --local, then inst_rules tests for a pathname such as
>      [[ -f /etc/udev/rules.d//ext4/dracut/modules.d/10i18n/10-console.rules ]]
> which obviously is bogus: there are two "root" there: /etc and /ext4
> [The "/ext4/dracut" is where my --local versions live.]
> Such a path never can exist, so something is wrong with the intent.
> 
> Analysis:
> modules.d/10i18n/module-setup.sh: install_base() calls
>         inst_rules ${moddir}/10-console.rules
> Note no underscore '_' in "${moddir}".
> 
> moddir is a global variable that is set by dracut:
>      for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
> When --local, then dracutbasedir is set in dracut:
>     dracutbasedir="$(readlink -f ${0%/*})"
> 
> Based on both of these, then inst_rules() in dracut-functions does:
>     for _rule in "$@"; do
>         <<snip>>
>         for r in /lib/udev/rules.d /etc/udev/rules.d; do
>             if [[ -f $r/$_rule ]]; then
> which leads to testing a pathname such as
>      [[ -f /etc/udev/rules.d//ext4/dracut/modules.d/10i18n/10-console.rules ]]
> 

http://git.surfsite.org/?p=dracut.git;a=commitdiff;h=76f5fa549c483a7a38e4757578480096b94615ac

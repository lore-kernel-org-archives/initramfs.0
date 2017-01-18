From: Philippe Troin <phil-zSL7SSj9W616jAk/7fyWoAC/G2K4zDHf@public.gmane.org>
Subject: Buglets in shutdown module in HEAD
Date: Wed, 18 Jan 2017 10:34:06 -0800
Message-ID: <1484764446.31841.5.camel@coldcreektech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coldcreektech-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=F2BBANliNwcTs4Bp/nTcYxGU5Zv2tf3TqCdT6bBWavw=;
        b=Ad40fYl+g4sQJqVtyR/h08z8pt5MsWoMBAWuD/B8lwcvAiY7/ZPGI8ir9Vfz6tcwQb
         3FhVVO8IWsA/tA5+8y56gX2CEzKXcO3JHgm6Zhfj1+jv6Y+7hbyfWLDF9ojDtNqr97oU
         qWeG0vc36Gt/Gno0j5WRIF1MvQQafPTyMp7fHDVf4gms1M5qDYWJctL+LUh6EDO1u1zh
         4ag7ifQIzVmA1zlR59eq7/guKv6Umw51SaL/CZJ23y7L9tdWk4v0keYAPup42raDNpR3
         PyVqite2XmRIpMf5cN/ppXKjmP41p768VHyiz8tfeOCFjtB6IdfF+/GnNMZqSqulzEQ2
         LooQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Dracut maintainers,

Note that I'm not subscribed to the mailing list, a CC is appreciated.

I've spotted a couple of issues in the latest shutdown module,
specifically this file: http://git.kernel.org/cgit/boot/dracut/dracut.g
it/tree/modules.d/99shutdown/shutdown.sh
918a8a4f123578e39f38404670d5cbe3e3436bb3

The unmount loop seems to be doing the opposite of what it intends to.

    _cnt=0
    while [ $_cnt -le 40 ]; do
        umount_a 2>/dev/null || break
        _cnt=$(($_cnt+1))
    done

doesn't do what's it's supposed to do as umount_a returns 0 in case of
success and 1 in case of failure.
The || should be changed into &&:

    _cnt=0
    while [ $_cnt -le 40 ]; do
        umount_a 2>/dev/null && break
        _cnt=$(($_cnt+1))
    done

[2] A little sleeping in between attempts helps too in my experience
I'd suggest changing that code to:

    _cnt=0
    while [ $_cnt -le 40 ]; do
        umount_a 2>/dev/null && break
        sleep 0.25
        _cnt=$(($_cnt+1))
    done

[3] The check_shutdown loop running all the hooks can be very verbose
and needlessly scary when luks+lvm is involved.  It generally scrolls
lots of messages about being unable to disable dm mappings before
finally succeeding.

I'd suggest using the same logic as the unmount loop:  loop quietly,
and if it fails 40 times in a row, run one last time verbosely.

So changing:

    _cnt=0
    while [ $_cnt -le 40 ]; do
        _check_shutdown && break
        _cnt=$(($_cnt+1))
    done
    [ $_cnt -ge 40 ] && _check_shutdown final

to

    _cnt=0
    while [ $_cnt -le 40 ]; do
        _check_shutdown 2> /dev/null && break
        _cnt=$(($_cnt+1))
        sleep 0.25
    done
    [ $_cnt -ge 40 ] && _check_shutdown final

Again, the chances of a clean(er) shutdown may be improved by sleeping
in between attempts.

I believe [1] is a true bug, while [2] and [3] will be the maintainers'
call.

Phil.

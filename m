From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: revisiting run/img handling patches (as v2)
Date: Thu, 12 Jan 2012 23:08:59 +0100
Message-ID: <4F0F59FB.9060502@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

They should be particulary useful w.r.t. the thread about systemd's 
storage daemon handling - as they allow by default complete independence 
from rootfs in context of starting [any] stuff inside rootfs (including 
one that should survive early boot).

I can have fresh version ready with minor adjustments quickly.

But, ... I see lots of patches staged around and there were no comments 
earlier about this approach, so any for/against now (if anyone checked 
them back) ?

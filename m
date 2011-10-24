From: Michal Soltys <nozo-qEytzWq26I5YlJzxd4HlKg@public.gmane.org>
Subject: Re: [PATCH 00/10] All recent patches linearly
Date: Mon, 24 Oct 2011 22:11:15 +0200
Message-ID: <4EA5C663.5070303@drutsystem.com>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Should I redo the set against latest HEAD ? There're few (trivial) 
conflicts regarding first patch after latest upstream updates, and some 
of the patches below were applied already. I have tiny one-liner patch 
to add as well.

Everything is well tested at this point, at least I haven't experienced 
any misbehaviour - both regarding /run treatment or ctty functionality.

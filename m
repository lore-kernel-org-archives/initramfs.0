From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: build initramfs: explain modprobe?
Date: Wed, 31 Aug 2011 14:15:22 +0200
Message-ID: <4E5E25DA.4060802@gmail.com>
References: <4E5D68A0.8020006@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9nmYqXuVnp8WelnB9mErqKGmWfFcX9B3jRUDFNf1ywQ=;
        b=VBlYaEkSadj+eUPE0Dr6DvW9FWHkVhiAMqOUeDICVsFCQweIr+tnI9CfTFI3UlrU3K
         4bSrRpmWs1pWwKUch3tyDMYKb4p80c6+35LQdhbhenBqKCese2zFe+040uXFU9LNJ1O5
         tXnlBESueDZbUYk+cDmvsdKKTVpJpLZrx/bXk=
In-Reply-To: <4E5D68A0.8020006-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 31.08.2011 00:48, John Reiser wrote:
> What properties of modprobe are essential for building initramfs?
> Modprobe works for only one kernel module at a time, and this is
> a cause of slowness.  For instance, computing the transitive
> closure of the Requires relationship over a non-small set of modules
> can be performed faster by loading modules.dep into a bash associative
> array, then processing in bash.  Also, modinfo now is invoked once per
> module to find firmware, but this can be sped up by invoking on batches
> of modules, using "split -C 32000" to avoid the argsize limit of execve.
>
> Invoking modprobe with --ignore-install seems to remove any effects
> due to (possibly host-specific) /etc/modules.d/*.conf.  Is there anything
> else that modprobe does for building initramfs, other than transitive
> closure of Requires?
>

Hmm, you are right. Modules loaded in "/etc/modules.d/*.conf" are not honored.
And yes, "modprobe" is only used to easily get the requirements.

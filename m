From: Sam Hartman <hartmans-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Producing verifiable initramfs images
Date: Wed, 05 Feb 2020 20:53:21 -0500
Message-ID: <tslzhdwh46m.fsf@suchdamage.org>
References: <CACdnJutwsCPERLR=tF65O=2tCgf+BHbWmsC6bpVrhwyOXcKCxA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACdnJutwsCPERLR=tF65O=2tCgf+BHbWmsC6bpVrhwyOXcKCxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Matthew Garrett's message of "Wed, 5 Feb 2020 16:37:39 -0800")
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is not a disagreement with anything you write.

I've noticed that there is a lot more configuration that gets encoded in
the initramfs than I thought.
The most surprising for me is that if you want to control the names of
network devices or anything else set by the .link file,
that ends up needing to go on the initramfs, because udevd will set up
network devices even if they are not needed to find the root.
Unfortunately, that means that initramfs udev configuration (including
/etc/systemd/network/*.link) tends to need to be on the initramfs.

I realize you only gave crypttab as an example, but the set of initramfs
configuration is larger than I at least expected.

--Sam

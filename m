From: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>
Subject: Re: distri: 20x faster initramfs (initrd) from scratch
Date: Wed, 29 Jan 2020 10:54:32 +0100
Message-ID: <7212371cedf396e118d6b1a712b7d5aa2e928afe.camel@suse.com>
References: <CANnVG6nFsnvva+qoQHJF+YY6Y3q46-C6tA742fMAkZFB3QFubg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANnVG6nFsnvva+qoQHJF+YY6Y3q46-C6tA742fMAkZFB3QFubg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Stapelberg <michael+lkml-Ocq5V1Lzw0iVILNE37Xk8A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2020-01-21 at 18:07 +0100, Michael Stapelberg wrote:
> Hey,
> 
> I just published a blog post about a custom proof-of-concept
> initramfs
> generator (minitrd):
> 
> https://michael.stapelberg.ch/posts/2020-01-21-initramfs-from-scratch-golang/
> 
> This demonstrates that there is still a whole bunch of optimization
> potential in existing initramfs generators such as dracut :)

Cool, but I don't think it has big chances to be adopted in larger
mainstream distros unless you add some extension/plugin functionality,
like dracut's modules.d. Such plugins should be easy to write and
maintain.

Martin




From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 	own series of hooks.
Date: Tue, 24 Feb 2009 16:42:53 +0100
Message-ID: <49A4157D.6090406@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>	 <49A301FF.2090303@redhat.com> <49A3A924.9000003@bfh.ch>	 <1235474964.28090.53.camel@sentry-no.fnordovax.org> <82ecf08e0902240435v5ebbb37clea8c8148ce19fa95@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <82ecf08e0902240435v5ebbb37clea8c8148ce19fa95-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Thiago Galesi wrote:
>>> Warren Togami wrote:
>>> A question: Why not use root=/dev/nfs and the other options according to
>>> kernel doc, like nfsroot=... and ip=autoconf? For me that is much more
>>> readable.
>> It is a matter of taste and historical contingency, I suppose.  The
>> current nfsroot mounting stuff was added way before initramfs/initrd was
>> an option, and it was probably easier to not mess up the in-kernel root=
>> handling code (which expected a device to mount).
> 
> 
> I think it is important to keep backwards compatibility in this
> specific case, and handle "root=/dev/nfs" kind of stuff. Really, think
> about keeping 2, 3 different cmdlines depending if the system is newer
> or older. It may look like a small hassle, but getting this right
> sometimes takes some time

Suggestion: Since all hook scripts are sourced, why not put the option 
parsing stuff inside pre-mount, setting global variables the mount 
scripts can depend on? That way we can handle any option passing we 
want, even through dhcp options.

Regards,
Philippe

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

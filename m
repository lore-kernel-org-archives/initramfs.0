From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5] We create our test image with root as an LVM menber.
Date: Mon, 25 May 2009 11:03:10 +0200
Message-ID: <4A1A5ECE.9000701@redhat.com>
References: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com> <21e5b98500a58b6aa6c9bf290870993c18ed87cc.1242874219.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21e5b98500a58b6aa6c9bf290870993c18ed87cc.1242874219.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/21/2009 04:55 AM, Victor Lowther wrote:
> -    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
> +    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81i" \

typo??
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

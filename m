From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH 1/4] Split out the various things into their own modules.
Date: Fri, 13 Feb 2009 14:08:08 +0100
Message-ID: <ac3eb2510902130508o3ea41614y12d9887ec605a912@mail.gmail.com>
References: <62cc4ebce1de329352ba0a5434e20f38edcdad6f.1234528086.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <62cc4ebce1de329352ba0a5434e20f38edcdad6f.1234528086.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Feb 13, 2009 at 13:37, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This rips most of the dracut script out into seperate modules that the
> main dracut script then sources.

>  modules/00dash           |    6 +++++
>  modules/90crypt          |    2 +
>  modules/90kernel-modules |    8 ++++++
>  modules/90lvm            |    2 +
>  modules/95debug          |    2 +
>  modules/95terminfo       |    3 ++
>  modules/95udev-rules     |    8 ++++++
>  modules/99base           |   13 +++++++++++

Please add and require a file extension to all modules and all similar
to-be-looked-up files. Packages are expected to drop fiules here, and
it's a useless pain to filter-out editor files and package manager
left-over files.

The 80's are over, and this is a new project, so please let us not
repeat the crap many other projects are doing here. :)

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

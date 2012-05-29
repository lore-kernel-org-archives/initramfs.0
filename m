From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-lib.sh: add copytree(), use it where applicable
Date: Tue, 29 May 2012 11:41:44 +0200
Message-ID: <4FC499D8.9050001@redhat.com>
References: <1337723700-5123-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337723700-5123-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 22.05.2012 23:55, schrieb Will Woods:
> copytree() recursively copies the contents of SRC into DEST.
> 
> If DEST doesn't exist it is created; if it exists the contents of SRC
> get merged into it (duplicate files are overwritten).
> ---
>  modules.d/45ifcfg/write-ifcfg.sh        |    2 +-
>  modules.d/90livenet/fetch-liveupdate.sh |    3 +--
>  modules.d/99base/dracut-lib.sh          |   11 +++++++++++
>  modules.d/99img-lib/img-lib.sh          |    2 +-
>  4 files changed, 14 insertions(+), 4 deletions(-)
> 

pushed

From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: fix missing slash
Date: Thu, 28 Apr 2011 15:45:24 +0200
Message-ID: <4DB96F74.7040905@redhat.com>
References: <1303597371-6280-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303597371-6280-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 24.04.2011 00:22, schrieb Michal Soltys:
> Trivial fix, though /sys is mounted just a few lines earlier, so maybe
> the 2nd check should simply be removed ?
>
> Michal Soltys (1):
>    modules.d/99base/init: missing slash in ismounted check
>
>   modules.d/99base/init |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>

pushed! thank you!

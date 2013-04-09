From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] Wait for logical interface to be up
Date: Tue, 09 Apr 2013 10:54:03 +0200
Message-ID: <5163D72B.7070407@redhat.com>
References: <cover.1365413867.git.bhe@redhat.com> <9100182be23fd2ec4e42f0ba667bc09cab6ca056.1365413867.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9100182be23fd2ec4e42f0ba667bc09cab6ca056.1365413867.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 08.04.2013 11:47, schrieb Baoquan He:
> If bootdev is logical interface like bond, bridge or vlan, we need
> wait them up.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/net-genrules.sh |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 

applied

From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] network: support multiple bonding interfaces
Date: Tue, 09 Apr 2013 10:53:46 +0200
Message-ID: <5163D71A.5010907@redhat.com>
References: <cover.1365413867.git.bhe@redhat.com> <99a1ec144499cee623d5096ce9873bf385616c16.1365413867.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99a1ec144499cee623d5096ce9873bf385616c16.1365413867.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 08.04.2013 11:47, schrieb Baoquan He:
> From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> 
> 
> Currently dracut only support 1 bond, namyly bond0 by default. However multiple
> bonds configuration may be needed. For example in kdump, in 1st kernel, more
> than one bonds may be configured, and bondX other than bond0 is used as output
> interface to remote host which will store dump core. This patch can solve this
> problem, to write real bond information to initramfs, 2nd kdump kernel will
> use it to create the relevant bondX interface.
> 
> Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/ifup.sh         |   15 ++++++++++-----
>  modules.d/40network/net-genrules.sh |    9 ++++++---
>  modules.d/40network/parse-bond.sh   |    6 +++---
>  modules.d/40network/parse-bridge.sh |    6 ------
>  modules.d/45ifcfg/write-ifcfg.sh    |    9 +++++----
>  5 files changed, 24 insertions(+), 21 deletions(-)
> 

applied

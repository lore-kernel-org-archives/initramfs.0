From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 'make rpm' fails
Date: Fri, 29 Jul 2011 10:58:16 +0200
Message-ID: <4E327628.5040604@redhat.com>
References: <j0tqfa$2kj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j0tqfa$2kj$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 29.07.2011 10:19, WANG Cong wrote:
> + /bin/cat /root/dracut/rpmbuild/0024-move-debian-to-debian.template-on-
> request-of-debian-.patch
> + /usr/bin/patch -s -p1 --fuzz=0
> /usr/bin/patch: **** Only garbage was found in the patch input.
> error: Bad exit status from /var/tmp/rpm-tmp.ERlVK0 (%prep)
> 

yes.. patch does not understand git's format for file removals :-/

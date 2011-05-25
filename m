From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Wed, 25 May 2011 16:31:36 +0200
Message-ID: <20110525143136.GJ2659@nb.net.home>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info> <20110523230507.GC2659@nb.net.home>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110523230507.GC2659-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, May 24, 2011 at 01:05:07AM +0200, Karel Zak wrote:
> On Fri, May 20, 2011 at 05:09:25PM +0200, Michal Soltys wrote:
> > +fstab_mount() {
> > +    local _dev _mp _fs _opts _dump _pass _rest
> >      test -e "$1" || return 1
> >      info "Mounting from $1"
> > -    while read dev mp type opts rest; do
> > -	[ -z "${dev%%#*}" ]&& continue # Skip comment lines
> > -	mount -v -t $type -o $opts $dev $NEWROOT/$mp
> > -    done < $1 | vinfo
> > +    while read _dev _mp _fs _opts _dump _pass _rest; do
> 
>  How does this code handle encoding in fstab? (e.g. /path/foo\x40bar)

 Sorry, should be "/path/foo\040bar".

 The mount(8) and friends use octal escapes only. 
 
    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com

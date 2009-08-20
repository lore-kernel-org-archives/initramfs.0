From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 20/18] Abstract out vol_id vs. blkid usage
Date: Thu, 20 Aug 2009 15:08:15 +0200
Message-ID: <20090820130815.GB6653@nb.net.home>
References: <59c88f499f404429ea331252bd6ad8c9d537f7d3.1250738566.git.victor.lowther@gmail.com> <20090820094420.GA6653@nb.net.home> <1250771550.4877.5.camel@sentry-no>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1250771550.4877.5.camel@sentry-no>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Aug 20, 2009 at 07:32:30AM -0500, Victor Lowther wrote:
> On Thu, 2009-08-20 at 11:44 +0200, Karel Zak wrote:
> > On Wed, Aug 19, 2009 at 10:25:01PM -0500, Victor Lowther wrote:
> > > Since different distros may or may not use vol_id in udev, and blkid
> > > is generally replacing vol_id, abstract them out into a function which
> > > tries to use vol_id first and blkid second, on the assumption that
> > > blkid can take over for vol_id if vol_id is no longer there.
> > > ---
> > >  dracut-functions         |   11 +++++++++++
> > >  modules.d/90crypt/check  |    2 +-
> > >  modules.d/90dmraid/check |    2 +-
> > >  modules.d/90lvm/check    |    4 ++--
> > >  modules.d/90mdraid/check |    2 +-
> > >  5 files changed, 16 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/dracut-functions b/dracut-functions
> > > index 1df2045..655d311 100755
> > > --- a/dracut-functions
> > > +++ b/dracut-functions
> > > @@ -48,6 +48,17 @@ derror() {
> > >      [[ -w $dracutlogfile ]] && echo "E: $@" >>"$dracutlogfile"
> > >  }
> > >  
> > > +get_fs_type() (
> > > +    if [[ -x /lib/udev/vol_id ]]; then
> > > +	eval /usr/udev/vol_id --export $1
> > > +	echo $ID_FS_TYPE
> > > +    elif find_binary >/dev/null; then
> > > +	blkid -o value -s TYPE $1
> > 
> >  This is to expensive, the blkid(8) supports two modes: low-level and
> >  high-level. The low-level mode together with "-o udev" is replacement
> >  of vol_id.
> 
> Expensive in what way?

 The high-level mode (blkid without -p option) parses and updates
 /etc/blkid.tab cache.

    Karel


-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

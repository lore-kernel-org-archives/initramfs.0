From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH cleanups] livenet: simplify writing net.ifaces
Date: Wed, 26 Sep 2012 11:52:59 -0400
Message-ID: <1348674779.4662.8.camel@samus>
References: <1348589458-13212-1-git-send-email-wwoods@redhat.com>
	 <5062D05C.40301@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5062D05C.40301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2012-09-26 at 11:52 +0200, Harald Hoyer wrote:
> Am 25.09.2012 18:10, schrieb Will Woods:
> > commit db2b12f removed the rd.neednet argument and uses /tmp/net.ifaces
> > instead. This means we don't need to mess with CMDLINE.
> > ---
> >  modules.d/90livenet/parse-livenet.sh | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
> > index 365eca1..0e61870 100755
> > --- a/modules.d/90livenet/parse-livenet.sh
> > +++ b/modules.d/90livenet/parse-livenet.sh
> > @@ -9,10 +9,7 @@
> >  updates=$(getarg live.updates=)
> >  if [ -n "$updates" ]; then
> >      # make sure network comes up even if we're doing a local live device
> > -    if [ -z "$netroot" ]; then
> > -	echo > /tmp/net.ifaces
> > -	unset CMDLINE
> > -    fi
> > +    [ -z "$netroot" ] && >> /tmp/net.ifaces
> >      echo "$updates" > /tmp/liveupdates.info
> >      echo '[ -e /tmp/liveupdates.done ]' > \
> >          $hookdir/initqueue/finished/liveupdates.sh
> > 
> 
> but commit 48dba7f9ace186871528eb4d83cd96e92e853c6c added it again :)

True! But the way network is currently handled, having
either /tmp/net.ifaces *or* rd.neednet will make the network come up.

So it's still sufficient to just create /tmp/net.ifaces, and we still
don't need to mess with CMDLINE.

It's also kind of silly - the only reason the 'unset CMDLINE' is there
is because before commit db2b12f, those two lines were:

       echo "rd.neednet=1" > /etc/cmdline.d/90livenet.conf
       unset CMDLINE

The second line is only there to "activate" the 'rd.neednet' argument.

Commit db2b12f changed the first line to 'echo > /tmp/net.ifaces', which
is sufficient by itself - the second line is no longer necessary.

So really this patch is equivalent to dropping the useless 'unset
CMDLINE', plus some other cleanups[1]. 

[1] I have a pet peeve about "echo > $file". It's not as bad as "cat
$file | grep", but it's still unnecessary.

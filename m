From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH liveupdates] apply-live-updates.sh: handle updates for
 /run
Date: Fri, 07 Sep 2012 14:09:10 +0200
Message-ID: <5049E3E6.4080304@redhat.com>
References: <1346281095-16549-1-git-send-email-wwoods@redhat.com>  <50487849.5010803@redhat.com> <1346952412.1973.56.camel@samus>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346952412.1973.56.camel@samus>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 06.09.2012 19:26, schrieb Will Woods:
> On Thu, 2012-09-06 at 12:17 +0200, Harald Hoyer wrote:
>> Am 30.08.2012 00:58, schrieb Will Woods:
>>> /run will get mounted at $NEWROOT/run after switch_root, but it's not
>>> there yet. bind-mount it in place so updates for /run actually land in
>>> /run.
>>>
>>
>> Huh? Why do you want updates in /run ?????
> 
> Short answer: because /tmp gets covered up by an empty tmpfs at (real)
> system startup, and we need to put them somewhere!
> 
> 
> Longer explanation: 
> 
> Historically, anaconda's runtime environment was read-only[1]. This
> makes sense, since it's usually squashfs (which doesn't do writes), and
> it's frequently running off a shiny, read-only plastic disc.
> 
> But how do you fix bugs (or test bugfixes) without regenerating the
> image and burning a new disk? With updates images!
> 
> To make updates work, anaconda sets its PYTHONPATH set to something
> like:
>   /tmp/updates:$PYTHONPATH
> and sets GLADEPATH, PIXMAPPATH, LD_LIBRARY_PATH, etc. similarly.
> 
> This way, updates images fetched with 'updates=http://...' get unpacked
> into /tmp/updates, and those files override the existing contents of the
> runtime image. Hooray! Bugfixes for read-only media!
> 
> These days we *do* have the magic device-mapper overlay hack, so we can
> make a squashfs image read-write[2] and just overwrite files. But we
> still use the old update method for a couple reasons:
> 
> 1) It already works,
> 2) it works with read-only filesystems (like squashfs), 
> 3) overwriting existing files can be tricky[3].
> 
> ====== A SIDE DISCUSSION ABOUT UPDATES AND READONLY ROOT/USR ======
> I admit this is all kind of a hack.
> 
> It'd be much better if there was a generally supported systemwide place
> to put 'updates' - that is, things that override the existing system
> libraries/binaries/data/config in /, /etc, and /usr.
> 
> Maybe a tmpfs mount at /usr/local would work, but that doesn't cover
> systemd configuration or ld.so. LD_LIBRARY_PATH could fix the latter,
> but it'd be better if we didn't have to change half a dozen $XXX_PATH
> variables to make this work.
> 
> I seem to remember there was some work on readonly-root systems with the
> Stateless Linux stuff, but I'm not sure how/if that solves the problem
> here..
> ===================================================================
> 
> Anyway, to make the existing method keep working, we need to unpack the
> updates image to a tmpfs that stays around after switch-root. And that's
> what /run is for. So that's why we want to put the updates in /run.
> 
> Does that answer the question?
> 
> -w
> 
> [1] Mostly because squashfs is read-only, but even if we weren't using
> squashfs the image might be on a CDROM or read-only NFS mount or
> something.
> 
> [2] This actually requires that we put the runtime image into an ext4
> image, and put *that* into squashfs - squashfs doesn't support writes at
> all, at the filesystem layer, and the device-mapper stuff redirects
> writes at the *block* layer..
> 
> [3] for example, some updates images contained /lib/libXXX.so. But then
> we overwrote the /lib -> /usr/lib symlink with the new '/lib' directory,
> thus breaking all the other libraries..
> 

Ok. Question answered. Will apply.

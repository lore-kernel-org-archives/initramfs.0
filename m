From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/8] build initramfs: speedup
Date: Fri, 02 Sep 2011 12:40:43 -0700
Message-ID: <4E61313B.8070601@bitwagon.com>
References: <4E5DBAE4.2000205@bitwagon.com> <4E5F4BD6.8090901@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5F4BD6.8090901-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/01/2011 02:09 AM, Harald Hoyer wrote:
> Regarding pat[c]h 7 and 8:
> 
> directory permissions could be copied with:
> 
> inst_simple()
> ....
> 
> -        echo "$1" >&${cpio_stdin}
> +        local _part=$1
> +        while [[ "$_part" != "${_part%/*}" ]]; do
> +            echo "$_part" >&${cpio_stdin}
> +            _part=${_part%/*}
> +        done
>          return 0
> 
> ...

Yes, cpio of a directory agrees with what we want, and can be used
as a tool.

> 
> BUT, there is a general problem with this.
> 1. the check, if the file is already present fails. This changes behaviour for
> e.g. install "bash" if /bin/sh is not yet there. In our case, of the "dash"
> dracut module is installed, bash will not be installed.
> So, we would have to bookkeep, what we already sent to cpio.

Yes, there is an issue.  It is a race, because sometimes the cpio (executing
in parallel) will finish [enough of] a previous copy soon enough for a following
inst_simple to see the result.

Low-level bookkeeping is not that difficult using a bash associative array, but:
1. All created paths must be tracked (symlink, directory, regular file, etc.)
2. Because instmods() may be called from different immediate parent shell
   processes [forks in different pipelines] then the results cannot be aggregated
   if done by any function called below instmods().  So the tracking must
   be done by a filter just before cpio, or by cpio itself: a new option
   "do not overwrite, regardless of modification times."  [Or, tell cpio
   not to preserve modification times.  Then the first copy to a given
   destination will be newer than any subsequent source for the same
   destination, so the cpio check "overwrite only if source is newer"
   always will fail.  This achieves the effect we want, at a cost of
   not preserving timestamps.]
3. Allowing a destination path which does not contain the source path
   as a tail, causes a complication because cpio cannot do this in one step.
   (It can be done using a second cpio and chdir to a temporary directory.)


> 2. postprocessing of installed files. E.g. the lvm modules changes
> /etc/lvm/lvm.conf. This could be prevented, by pulling out all post processing
> and call all modules-setup.sh with install_post() after cpio copying.

This is another race.  I agree that postprocessing should be separated.


Patch 7 illustrates the cost of design decision(s).  At a low level,
"/bin/cp is inexpensive" is true for a few, but not for 1900 of them.
My 3GHz system can do about 200 per second, so right there is 9.5 seconds
before moving any data at all.  As an end-user installer/upgrader, and as
a builder+tester of install media, that time is all waste.
At a higher level, specifying sequential processing (instead of allowing
all paths to be handled in parallel) can be costly.

For a while, I'm going to work on other pieces of build initramfs instead.

-- 

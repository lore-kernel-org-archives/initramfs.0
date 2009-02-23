From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] Hooks and modules have a .sh extension
Date: Mon, 23 Feb 2009 13:28:57 -0500
Message-ID: <20090223182857.GA30637@redhat.com>
References: <101475621c53b8698d94deb257b95ad2291f4d63.1235149680.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <101475621c53b8698d94deb257b95ad2291f4d63.1235149680.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Feb 20, 2009 at 09:24:18AM -0800, Victor Lowther wrote:
 > This makes it trivial to filter out temporary files, editor backups,
 > package management leftovers, etc.  Thanks, Kay for the idea.

I had to munge this to apply it..
 
 > --- a/Makefile
 > +++ b/Makefile
 > @@ -13,7 +13,7 @@ install:
 >  	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 >  	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
 > - 	for hook in hooks/* ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
 > -	for module in modules/*; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
 > + 	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
 > +	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
 
Your copy had those lines beginning space-tab, whereas the git repo was just a tab.
I fixed it up and it applied.

Then I tried applying your other patches, and I'm suspecting something similar may have
happened..


Applying: Hooks and modules have a .sh extension
/home/davej/dracut/.git/rebase-apply/patch:42: trailing whitespace.
 * Generator modules and hooks must have a .sh extension. 
warning: 1 line adds whitespace errors.
Applying: Make exec failure not kill init or switch_root.
Applying: tiny fixup to getarg to make handling more arguments slightly easier
Applying: We now support the noresume kernel parameter.
Applying: We now support mounting the rootfs rw.
Applying: Support rootflags and rootfstype kernel parameters.
/home/davej/dracut/.git/rebase-apply/patch:23: trailing whitespace.
ln -s "$root" /dev/root 
/home/davej/dracut/.git/rebase-apply/patch:24: trailing whitespace.
fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}" 
warning: 2 lines add whitespace errors.
Applying: Make cryptroot handling act as a real producer/consumer.
/home/davej/dracut/.git/rebase-apply/patch:16: trailing whitespace.
[ -s /cryptroot ] && { 
warning: 1 line adds whitespace errors.
Applying: cryptsetup does not like running in a while read loop.
error: patch failed: hooks/cryptroot.sh:2
error: hooks/cryptroot.sh: patch does not apply
Patch failed at 0008.
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

So, everything applied up to the cryptsetup patch.
I'll push out what applied, and you can rediff that last bit on
top of that, and hopefully it'll all work out.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC ONLY 0/5] Move argument validation to root handlers
Date: Fri,  3 Jul 2009 17:40:00 -0400
Message-ID: <cover.1246656269.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

This patchset will need to be rebased onto Harold's series from today, but
I wanted to post where I was at to get some feedback anyway.

This series moves the dracut syntax parsing and validation into the root
handlers, and leaves the legacy syntax translation and other warnings to
the command line argument parsers. Moving the parsing into the handlers
centralizes the code and allows us to leverage that work to implement a
mechanism to wait for a spanning tree to stop blocking traffic prior to
attempting a mount.

Parts of the last patch should probably be merged with patch 4 -- there
is no need to add a 'checkdhcp' command to the root handlers only to turn
around and rename it in the next patch -- and is still rather rough. I'm
not keen on using /tmp/server to pass IPs back to netroot, but having it
echo'd from the netroot handler means we break when using rdnetdebug. That
is easily fixable by not redirecting stdout during rdnetdebug, but I need
to look closer to make sure that doesn't break anything else.

Also, the waiting for spanning tree parts will need to be adapted to handle
multiple IP addresses for iSCSI, if and when we support that.

I've tried to not change syntax support during the conversion, limiting
support to the existing ones. The current test suite passes at all steps,
but a new test suite to test our parsing (with expected failures) may be
a good thing to add.

iSCSI remains a mess -- I think we need to look at what we're supporitng
there, and improve the validation. I moved some checks into iscsiroot, but
it is a bit unclear where the legacy syntaxes came from, and what we
really want to support going forward. Also, we need to be able to parse the
iSCSI firmware tables to figure out which IP to use for arping.

David Dillow (5):
  netroot: remove unused hook
  netroot: remove unhelpful argument checks
  netroot: remove netif from handler invocation
  netroot: move dracut syntax validation to root handlers
  PROOF-OF-CONCEPT: wait for spanning tree timeout via arping

 dracut                               |    2 +-
 modules.d/40network/dhclient-script  |   11 ++-
 modules.d/40network/ifup             |    8 ++-
 modules.d/40network/install          |    2 +-
 modules.d/40network/netroot          |  101 +++++++++++++++-------
 modules.d/95iscsi/iscsiroot          |   57 +++++++++----
 modules.d/95iscsi/parse-iscsiroot.sh |   21 +----
 modules.d/95nbd/nbdroot              |   37 +++++---
 modules.d/95nbd/parse-nbdroot.sh     |   34 ++------
 modules.d/95nfs/nfsroot              |  158 ++++++++++++++++++----------------
 modules.d/95nfs/parse-nfsroot.sh     |  155 ++++++++++++---------------------
 11 files changed, 302 insertions(+), 284 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

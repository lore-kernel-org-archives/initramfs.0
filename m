From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: Implementation path question for live root with nfs state mount
Date: Mon, 18 Oct 2010 18:15:27 +0300
Message-ID: <4CBC648F.7060706@hoster-ok.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

I need to add support to dracut for live (squashfs) root with a "state"
saved on nfs server.

I imagine following use case -
* initramfs includes ext3 filesystem wrapped into squashfs (like
ovirt-node-image has)
* that filesystem is used as a live root (initramfs is pulled from TFTP)
* kernel cmdline has CLIENTSTATE variable set to address of NFS mount.
Then rc.sysinit will mount $CLIENTSTATE/$HOSTNAME (as a last resort
case) and will use it as a STATE_MOUNT.

Thus, we have read-only root in RAM and all state files mounted from
NFS. So server can operate totally diskless (opposed to ovirt-node which
has to be set-up on a local disk or iSCSI target, both of which seem to
be an overkill if one has 16+ servers). An adding new servers to a pool
requires only correct DHCP server settings, nothing more (probably some
files on a nfs server too, but that's another story).

What I need from dracut is to set up networking and pass ifcfg's to a
system via /dev/.initramfs. But then I need to some-how "simulate"
networked root because otherwise there is no chance to bring network up.

STATE_MOUNT is mounted very early, no system networking is set up yet,
only what initramfs provided. And my idea is to setup bond+bridge so it
could be very tricky to make initscripts do it on a read-only root
(shared between systems) in a right way anyways - I prefer to specify
what interface is what by its macaddr, but this seems to be impossible
if I boot multiple systems from one image.

I assume it could be possible to achieve what I need with a little
"hack" - introduce new netroot handler - f.e. 'nfs-state' or 'live-nfs'
or whatever else (this is btw the biggest problem - to find proper name)
and try to pass "netroot=nfs-state root=live:blablabla
CLIENTSTATE=xxx.yyy.zzz.www:/mnt" via cmdline.

If this fail (f.e. if netroot is over-riden somewhere) I'll probably
need to patch all networking code to make it run not only if netroot is
set but also if both "root=live" and "CLIENTSTATE" are set. I generally
do not like this way very much, so I'm asking for help with this.

Could someone comment please?
Any thoughts are welcome.

Best,
Vladislav


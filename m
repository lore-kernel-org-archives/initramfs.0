From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [RFC] iscsid / systemd / dracut integration
 effort
Date: Tue, 1 Oct 2013 04:24:26 +0200
Message-ID: <20131001022426.GF14198@tango.0pointer.de>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
	<50C67697.7020208@gmail.com>
	<20121211232646.GC5307@straylight.hirudinean.org>
	<b993ef26-ea4e-4dbe-8d9a-d86ad50c9fbc@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <b993ef26-ea4e-4dbe-8d9a-d86ad50c9fbc@googlegroups.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
To: The Lee-Man <leeman.duncan@gmail.com>
Cc: initramfs@vger.kernel.org, agrover@redhat.com, open-iscsi@googlegroups.com, systemd-devel@lists.freedesktop.org

On Mon, 23.09.13 10:33, The Lee-Man (leeman.duncan@gmail.com) wrote:

> After=network.target NetworkManager-wait-online.service tgtd.service 
> targetcli.service

Please use network-online.target here instead of
NetworkManager-wait-online.service.

Please see the discussion of this unit on:

http://www.freedesktop.org/software/systemd/man/systemd.special.html

That said, this service makes local block devices available over the
network, right, and it doesn't want to connect to anything on the
network, or does it? If so, I really don't see the need for pulling in
network-online.target/NetworkManager-wait-online.service here at all. 



> iscsi.service:
> ==========

> After=network.target NetworkManager-wait-online.service iscsid.service

This one on the other hand actually wants network connectivity around,
right, since it tries to connect to other hosts? For this one using
network-online.target sounds appropriate.

> ConditionPathExists=/etc/iscsi/initiatorname.iscsi
> 
> [Service]
> Type=oneshot
> ExecStart=/sbin/iscsiadm -m node --loginall=automatic
> ExecStop=/bin/sync

Wut?? Is this really necessary? If this is really necessary (which I
doubt, appears to be snake oil to me...), then why doesn't iscsiadm do
this internally?

Lennart

-- 
Lennart Poettering - Red Hat, Inc.

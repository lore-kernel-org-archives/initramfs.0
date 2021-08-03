From: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Subject: dracut: 98syslog auto-detect feature
Date: Tue, 3 Aug 2021 17:24:56 +0200
Message-ID: <20210803152456.lkpnzijjy7pojmnw@cwe-513-vol689.cern.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnc7QrjpAY/wzlo35s1eA8Xv2Lal3LC5B84oIQgHihE=;
 b=mnVF4crxVFbp/9+4j5oIQt2pGVNVGLud7X+iQ3JnKjWRuRKayYrURSRh2hb8QWpQ3bkiBegtq7qrdBkK2hiaiNd3j/IqYGe8/8zdEhdCgCPn+8mOyVqn6si0z8qalXbzxZ7SpTFU/xRcNwMybpajByEP3k2pk0YYbHNBvM19Ad4=
Content-Disposition: inline
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I had a look to the dracut syslog module and I've notice that, despite
the code parses the syslog.type argument, it does not actually run
anything but `rsyslogd`.

It's like this since its introduction, the code seems ready to run
`syslogd` or `syslog-ng` but it does not do it.  The
`rsyslogd-start.sh`, despite the name, is written to start any of the
three services, only that at the end it runs only `rsyslogd` (so,
perhaps the name is indeed correct). Then, `syslog-cleanup.sh`
executes the stop service `"${syslogtype}"-stop`, but the only
"*-stop" script available is for rsyslogd.

Am I missing something? If not, I see the following options:

1 clarify that this module supports only "rsyslogd":
1.a by adding "warn" when syslog or syslog-ng are selected
1.b by documenting it
1.c by renaming the module 98rsyslog and removing the auto selection

2 add support for syslog and syslog-ng (even though, nobody complained in 10 years)

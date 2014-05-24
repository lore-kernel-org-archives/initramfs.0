From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Subject: failed to bring up bonding interface (dracut+system)
Date: Sat, 24 May 2014 11:02:28 +0400
Message-ID: <CACaajQtBpFPPpt01LLDsubnKczQCAO4SaQF+8G7BnjAQCss20A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfip.ru; s=google;
 h=mime-version:sender:from:date:message-id:subject:to:content-type;
 bh=9R9SJg6FQotpM4aXxPAaReKeFo/ch/t0GD/WPZ598Lc=;
 b=M5RxCRnrZ+nix6IPQYfZrBFJqqLJJgs0Akq/BDaUYChC+YUnlJitv5Z+PZUcV1S8nF
 DNyED6aTo67tIVj4yqCwVpQ1oeQzP7z1deJA1v/RUlfFsEj6wfkUss4BgBdNFtr80+VG
 R/xemGTh17rFqYo7UBbdMdZhoEmpW/uCeDfJo=
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
To: systemd-devel <systemd-devel@lists.freedesktop.org>, initramfs@vger.kernel.org

Hello.
I'm using dracut to create initramfs and systemd.
Dracut configures bond and all works fine, but then it shutdowns and
switch rooti, mac address of slave interfaces (eth0 and eth1) changed,
but bonding mac saves the same. After that bond interface not works.
How to prevent this fail?
If i rmmod igb driver and load it mac addresses change to normal and
all works fine.
dracut from current master, system - 212.

my /proc/cmdline
bond=bond0:eth0,eth1:mode=balance-xor,miimon=100,updelay=200,downdelay=200
net.ifnames=0 ip=bond0:auto6:9000 rd.bootif=0 rd.md=0 rd.dm=0 rd.lvm=0
rd.luks=0 console=tty0 console=ttyS1,115200 rw
root=live:http://[2001:db8:0:f101:92e2:baff:fe31:44c]/image/mh-vm/image.squashfs
rd.live.size=1G
chef=http://[2001:db8:0:f101:92e2:baff:fe31:44c]/chef/vm09 rd.shell
raid=noautodetect rdshell rd.debug rdnetdebug

Invalid mac addresses is
ba:ee:69:7c:ed:4e
4a:0f:e8:44:93:35
Valid mac addreses is
00:25:90:d5:bf:bc
00:25:90:d5:bf:bd


-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
jabber: vase@selfip.ru

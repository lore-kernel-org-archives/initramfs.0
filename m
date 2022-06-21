From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [ANNOUNCE] dracut 057
Date: Tue, 21 Jun 2022 11:14:59 +0200
Message-ID: <da27dbde-2290-0f4a-a22b-4d9789bee1a1@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=wtmqaDKMUc63yaN5vjJ5ayto2eoTktBDpBh9Cnkp6LE=;
        b=iYlrQSL4I4Zs6x1FsqRgOiRl+B22pIeqrwQQyIlvrh51CJ33pmsshKD4Aw4M2aVFtL
         kx0OMsCGZT8nnSSG0jTUaQPJmbmsHpj2t8uXao7LAvz4N1hIJZOPWD3GbWQ6Po0eYMad
         /V6tbs2H0hmDhXx78MP5w3wzVFlmEAOFJa+hSoCGSYTdGi161XNDVVhNtnGUd11yfh3C
         a5TFQpEM34KsL07ffcZoPs4pBVm+r4jRwyr7HWcr3Qi9c+hNN5Bf5Uls8Lo01wVYIA/d
         sD8kcZbUnD4Pcdf6nEEC+2zfOiZZk8V1lW2zuu8lICHztKLsv/8Kz2JTKPLigluVmlXH
         SWBw==
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to this release.

This will be the last release announcement on this mailing list. All discussions should happen on the github issue tracker from now on.

Release tarballs are also only available on github from now on.

The tarball can be found here:
	https://github.com/dracutdevs/dracut/archive/057/dracut-057.tar.gz
         https://github.com/dracutdevs/dracut/releases/

Report Issues:
         https://github.com/dracutdevs/dracut/issues

File Pull Requests:
         https://github.com/dracutdevs/dracut/pulls

Git:
         git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dracut.git
         https://github.com/dracutdevs/dracut.git

[Rendered view](https://github.com/dracutdevs/dracut/blob/master/NEWS.md)

dracut-057
==========

#### Bug Fixes

* **10i18n:**
   *  stop leaking shell options ([f3441cc7](https://github.com/dracutdevs/dracut/commit/f3441cc7c577554dde04a9fe90638f779bb0a411))
   *  stop leaking shell options ([35064768](https://github.com/dracutdevs/dracut/commit/35064768ebf14d3ec6bf3f7df52580fb4920ea3d))
* **Makefile:**  use of potentially unset variable ([1354d633](https://github.com/dracutdevs/dracut/commit/1354d6339a2e603fe0787bc028f9e7e1d49cbf82))
* **bluetooth:**
   *  accept compressed firmwares in inst_multiple ([09a1e5af](https://github.com/dracutdevs/dracut/commit/09a1e5afd2eaa7f8e9f3beaf8a48283357e7fea0))
   *  nullglob should not be needed ([36aaa74f](https://github.com/dracutdevs/dracut/commit/36aaa74f3641d375cb435298864fad1945444893))
   *  make $dbussystem/bluetooth.conf optional ([a38d9ec0](https://github.com/dracutdevs/dracut/commit/a38d9ec0320f3819a3b70dc5bb59f6d2fc570149))
* **configure:**  check for SYS-gettid during configure ([0ef40d88](https://github.com/dracutdevs/dracut/commit/0ef40d88124fe67726b8b5d8321dce064c727447))
* **connman:**  copy netroot.sh from the network module and install it ([f6d83f9f](https://github.com/dracutdevs/dracut/commit/f6d83f9f5cd4850468f26048f8eed015dc2bd0e0))
* **crypt:**  add missing is_keysource parameter to cryptroot-ask ([6c11a8fc](https://github.com/dracutdevs/dracut/commit/6c11a8fcee08c297a34bd5c5215a7a29d3529b85))
* **dmsquash-live:**
   *  mount live device with the correct type ([08ed7b2d](https://github.com/dracutdevs/dracut/commit/08ed7b2d0035eaa699c139bc9719f90190f6ffc1))
   *  permanent overlay on the same drive as LiveCD .iso ([9a884b3a](https://github.com/dracutdevs/dracut/commit/9a884b3afce1ebc8c6a6e5f62594ce708486a826))
* **dracut:**  default to correct firmware search paths ([95aeed89](https://github.com/dracutdevs/dracut/commit/95aeed8975dd5a2af782ec986f2af6176b585c59))
* **dracut-functions.sh:**  correct wrong comment ([0afa840e](https://github.com/dracutdevs/dracut/commit/0afa840e111e63da14edcb655886734b45d61c4b))
* **dracut-initramfs-restore.sh:**
   *  unpack uncompressed initrd as last option ([46886956](https://github.com/dracutdevs/dracut/commit/46886956211f8a436e2e9f81fc4972d2a297c3a3))
   *  check if SELINUXTYPE is set ([24d8f35b](https://github.com/dracutdevs/dracut/commit/24d8f35b9c162f42c58abd27fe9c75bbf76cbfe7))
* **dracut-install:**
   *  copy files preserving ownership attributes ([9ef73b6a](https://github.com/dracutdevs/dracut/commit/9ef73b6ad08c19c3906564e5a15c7908ed9a81c8))
   *  do not fail when SOURCE is optional and missing ([bd1a5ca9](https://github.com/dracutdevs/dracut/commit/bd1a5ca9ae9e347061e67e51be29335ab074ad95))
* **dracut-systemd:**
   *  drop misleading man page reference ([77c28b30](https://github.com/dracutdevs/dracut/commit/77c28b3020b7dede848d8282151f609d80905b05))
   *  correct service dependencies ([85fdff12](https://github.com/dracutdevs/dracut/commit/85fdff1212e708d335f035926f3c2a6b87bb1c3c))
* **dracut.cmdline.7:**  {=> must} also be specified ([27071e9a](https://github.com/dracutdevs/dracut/commit/27071e9a0e7928bccc45469eb659cdafb20f134b))
* **dracut.sh:**
   *  format usage and add missing options ([9bef7109](https://github.com/dracutdevs/dracut/commit/9bef71094eba84a9eac161fc45386ccd73bd2b34))
   *  always check that MACHINE_ID is not empty ([527fdfa1](https://github.com/dracutdevs/dracut/commit/527fdfa1517b7f010afa049fe6add71e4c916cdd))
   *  avoid calling dfatal before dracut-logger is sourced ([012d7db2](https://github.com/dracutdevs/dracut/commit/012d7db27da7416471ed49ee2ca666ab95837f47))
   *  add missing default output file paths ([28ef3bc6](https://github.com/dracutdevs/dracut/commit/28ef3bc6a6f1efcd8d8c16228a6dee9d563342e7))
   *  add missing --libdirs usage ([352e5917](https://github.com/dracutdevs/dracut/commit/352e59173152f13b242c598a735243f0f2850ff1))
   *  drop restorecon call ([33859892](https://github.com/dracutdevs/dracut/commit/3385989266ddb1c0685f9f7501f1835e9ce49730))
   *  error exporting sysctl variables ([4c355d05](https://github.com/dracutdevs/dracut/commit/4c355d05587b0432a6dc551b8693dbdc51a07962))
* **dracut.spec:**  add connman module ([d0c6ab21](https://github.com/dracutdevs/dracut/commit/d0c6ab21d906cc5b0e05e1107c48baffcbedb02c))
* **fedora.conf:**  vi binary is missing ([48541362](https://github.com/dracutdevs/dracut/commit/485413627f04fdc0c5c29958ce437718b262a99c))
* **github:**  remove packit ([8fd37d20](https://github.com/dracutdevs/dracut/commit/8fd37d20f4b7cc08ee0970e0249aac4cd5b47a4e))
* **ifcfg:**  avoid calling unavailable dracut-logger functions ([7103c4bc](https://github.com/dracutdevs/dracut/commit/7103c4bce9240d5896a0d207c216e0f6270ad2e8))
* **install:**  restore musl support ([ce55a85e](https://github.com/dracutdevs/dracut/commit/ce55a85ed5d902c19d75895508856f96ec2ceb1a))
* **integrity:**  do not display any error if there is no IMA certificate ([f63f411d](https://github.com/dracutdevs/dracut/commit/f63f411d52df613936082d646ab072447b8b9d7f))
* **iscsi:**
   *  do not exit in handle_netroot() if discovery failed ([319dc7fe](https://github.com/dracutdevs/dracut/commit/319dc7fe10585a19d1a051f8ad1ba0190f86ff1f))
   *  remove unneeded iscsi NOP-disable code ([a33a8df4](https://github.com/dracutdevs/dracut/commit/a33a8df43d33c9bdf85d7a5b7392585129a690f5))
* **kernel-network-modules:**  allow specifying empty --hostonly-nics ([ab6f5733](https://github.com/dracutdevs/dracut/commit/ab6f57339ad77b5bc116400f7b66580745bfc563))
* **lsinitrd.sh:**
   *  always check that MACHINE_ID is not empty ([d6343146](https://github.com/dracutdevs/dracut/commit/d6343146c1db69fc724ca666a5d9321af7fd0d46))
   *  add missing default paths ([49ea6c42](https://github.com/dracutdevs/dracut/commit/49ea6c42db7180eec5ba57e082a38d116f2d17a5))
* **lvm:**
   *  add missing grep requirement ([79f9d9e1](https://github.com/dracutdevs/dracut/commit/79f9d9e1c29a9c8fc046ab20765e5bde2aaa3428))
   *  ignore expected error message from lvm config ([7e03d81f](https://github.com/dracutdevs/dracut/commit/7e03d81fe3df932558d2b7280fa57da24ba955c0))
* **man:**
   *  add missing default paths ([ffc1985c](https://github.com/dracutdevs/dracut/commit/ffc1985cb26894c50487b7db2703e8715a4a7537))
   *  add missing --libdirs section ([a90dbd95](https://github.com/dracutdevs/dracut/commit/a90dbd958b19778044047f17559449fffdb94cc2))
* **network-manager:**  avoid calling unavailable dracut-logger functions ([b7059aef](https://github.com/dracutdevs/dracut/commit/b7059aef5962aad1dc8d96a0f600105a40867380))
* **nfs:**
   *  give /run/rpcbind ownership to rpc user ([d6159343](https://github.com/dracutdevs/dracut/commit/d615934311e25146bb37943bf1385a19dfdbd9e8))
   *  require and install needed binaries ([0e4df7a3](https://github.com/dracutdevs/dracut/commit/0e4df7a39dda388dc71ff6f749c8197cba4442b9))
* **nvmf:**
   *  deprecate old nvmf cmdline options ([e405501e](https://github.com/dracutdevs/dracut/commit/e405501e23462d151bba252133f4a6179bf79cf0))
   *  set executable bit on nvmf-autoconnect.sh ([25a92885](https://github.com/dracutdevs/dracut/commit/25a92885a9519701cc480298c2b082e2e2bf5ebe))
* **plymouth:**  hide dpkg-architecture stderr messages ([42e9d188](https://github.com/dracutdevs/dracut/commit/42e9d1889298c3d8badfb6f95e16e048ad83a1f6))
* **resume:**  correct call to block_is_netdevice function ([a7a4b76c](https://github.com/dracutdevs/dracut/commit/a7a4b76c4ad5794f5f8a24ecd5b495f1512d05f7))
* **shell-completion:**  add missing options ([1199f990](https://github.com/dracutdevs/dracut/commit/1199f990bb93b4e6bd56fa3df050b17fc7e6c378))
* **systemd-coredump:**  add systemd-sysusers dependency ([ce82e969](https://github.com/dracutdevs/dracut/commit/ce82e969f8faaccbb57be178833ef4e39f01cdf9))
* **systemd-journald:**  remove duplicate entry in inst_multiple ([d3ab2061](https://github.com/dracutdevs/dracut/commit/d3ab20615ef94370e43b042d913d5f787dd52430))
* **systemd-timesyncd:**  add systemd-sysusers dependency ([28b6adcb](https://github.com/dracutdevs/dracut/commit/28b6adcb27fb5240c01f7d41511ce02597aa27bd))
* **test:**
   *  dmsquash-live test without an iso ([6ee2baf3](https://github.com/dracutdevs/dracut/commit/6ee2baf314fc6aa3bb88ca52d11c9f599223eb77))
   *  remove stale comments ([b3ab3037](https://github.com/dracutdevs/dracut/commit/b3ab3037e8b9272498ed40131f30bf1831acab73))
   *  add support for dpkg to pass the test on debian ([a7dfdf6a](https://github.com/dracutdevs/dracut/commit/a7dfdf6acbf7a87fd2735541f06a062126966f69))
   *  nullglob should not be needed ([c7b3ac2b](https://github.com/dracutdevs/dracut/commit/c7b3ac2bd115521855b3ad8ce287cb1a9afca128))
* **udev-rules:**  add cdrom udev rules by default ([aebeb2ec](https://github.com/dracutdevs/dracut/commit/aebeb2ecdf76b7716fadbab8b216b8805d36a461))

#### Features

  *   add aarch64 uefi support ([8391a993](https://github.com/dracutdevs/dracut/commit/8391a993033e212a24635dd629c167354f0834f8))
  * **connman:**  introduce connman support module ([f30d0351](https://github.com/dracutdevs/dracut/commit/f30d03513f357a36d2ed48a522c7ef2a46bb0c5c))
  * **dracut:**
    *  support parallel execution with --parallel ([6d923262](https://github.com/dracutdevs/dracut/commit/6d92326201014cde9ab04b90367017f875d3b991))
    *  add zfs detection ([9582f027](https://github.com/dracutdevs/dracut/commit/9582f02773c5115e14fe0992ec2db3935cb0e6eb))
  * **dracut-install:**  support ZSTD-compressed firmware with .zst suffix ([9d8387ed](https://github.com/dracutdevs/dracut/commit/                             9d8387ed803dfc3e8b97d2e415a15083774d7ac6))
  * **dracut-systemd:**  use Documentation= to point to man page ([42e8f17c](https://github.com/dracutdevs/dracut/commit/                                       42e8f17c2481d33a3d6ba23f653c835e0cda6994))
  * **gensplash:**  remove module ([1befc641](https://github.com/dracutdevs/dracut/commit/1befc6416743a527824f0f2cc25471e86a6f8a79))
  * **lvm:**  add new module lvmthinpool-monitor ([d9812fc4](https://github.com/dracutdevs/dracut/commit/d9812fc4ae18a39c144140dd60cb03e16e0d2e06))
  * **man:**  add documentation for rd.luks.key.tout ([65e41b54](https://github.com/dracutdevs/dracut/commit/65e41b54600878e3e08bbe3b60f66524e1d166a8))
  * **squash:**
    *  add shell completion for --squash-compressor option ([e2aee2d4](https://github.com/dracutdevs/dracut/commit/e2aee2d436cf68c4515a381d620a963ff18dcf05))
    *  update the manual page for --squash-compressor ([3693bfef](https://github.com/dracutdevs/dracut/commit/3693bfef2fc252f5a4b18278c87a1076896b7fb5))
    *  decouple the compressor for dracut and dracut-squash ([90d9ae8c](https://github.com/dracutdevs/dracut/commit/90d9ae8ca814c26045ecea63fa15bd8959076d0d))
  * **url-lib.sh:**  add --retry-connrefused to default curl arguments ([90032a46](https://github.com/dracutdevs/dracut/commit/                                 90032a463190ab68f20f493894f667320466082d))
  * **virtiofs:**  virtiofs root filesystem support ([4632f799](https://github.com/dracutdevs/dracut/commit/4632f799954c18eb8f655efe05b1e6ce30246828))

#### Contributors

- Antonio Alvarez Feijoo <antonio.feijoo-IBi9RG/b67k@public.gmane.org>
- Laszlo Gombos <laszlo.gombos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Pavel Valena <pvalena-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- David Tardon <dtardon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Tao Liu <ltao-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- наб <nabijaczleweli-6FuO4tji+NtE7+NmKNA1GlEoflrkcZvj@public.gmane.org>
- German Maglione <gmaglione-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Jóhann B. Guðmundsson <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Nicolas Porcel <nicolasporcel06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Zoltán Böszörményi <zboszor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- nkraetzschmar <nkraetzschmar-KJX8L1YACloTKYOLMXNBRxrm3jAUxWOA@public.gmane.org>
- Benjamin Gilbert <bgilbert-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Coiby Xu <coxu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Conrad Hoffmann <ch-IZHJMqo5dGMxsqv6Oivclw@public.gmane.org>
- David Teigland <teigland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- James Morris <morisja-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Lee Duncan <lduncan-IBi9RG/b67k@public.gmane.org>
- Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
- Masahiro Matsuya <mmatsuya-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Michal Hecko <mhecko-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Morten Linderud <morten-cuLSc1zj+VxIoDtgeXI1Lg@public.gmane.org>
- Savyasachee Jha <genghizkhan91-1FK3PwOqqZpByuSxxbvQtw@public.gmane.org>
- Shreenidhi Shedi <sshedi-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
- Wenchao Hao <haowenchao-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

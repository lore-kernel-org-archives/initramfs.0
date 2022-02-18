From: Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>
Subject: [ANNOUNCE] dracut 056
Date: Fri, 18 Feb 2022 12:46:09 +0100
Message-ID: <515a7dd5-f535-dfd9-47f8-5d911c2c77ec@hoyer.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version.

Thanks to all who have contributed to this release.

The tarball can be found here:
         http://www.kernel.org/pub/linux/utils/boot/dracut/
         ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
         https://github.com/dracutdevs/dracut/releases/

Report Issues:
         https://github.com/dracutdevs/dracut/issues

File Pull Requests:
         https://github.com/dracutdevs/dracut/pulls

Git:
         git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dracut.git
         https://github.com/dracutdevs/dracut.git

         git://git.kernel.org/pub/scm/boot/dracut/dracut.git
         https://git.kernel.org/pub/scm/boot/dracut/dracut.git


[Rendered view](https://github.com/dracutdevs/dracut/blob/master/NEWS.md)

dracut-056
==========

#### Bug Fixes

* **base:**
     *  do not change the provided UUID ([4e858741](https://github.com/dracutdevs/dracut/commit/4e858741087a5cfea891bd2c1fd51ea9b830aeaf))
     *  add default device choice ([e8c18c9f](https://github.com/dracutdevs/dracut/commit/e8c18c9f7f5ed94898f70e9ff5a5f94a815a2b49))
     *  tr needs to be installed ([dfbfd33b](https://github.com/dracutdevs/dracut/commit/dfbfd33b24524c0c10ad3594be143192f5b7da84))
     *  do not quote $initargs for switch_root ([f649cd10](https://github.com/dracutdevs/dracut/commit/f649cd10b2e920e9d65c532db9b9f89a7370ad99))
     *  repair installing dracut-util ([d7acf107](https://github.com/dracutdevs/dracut/commit/d7acf107f2ac619f73dfa29588ea9adfaf79e296))
* **bluetooth:**
     *  make hostonly configuration files optional ([d03fb675](https://github.com/dracutdevs/dracut/commit/d03fb675d8e904c6c44de9b91814b33c45043f4f))
     *  dbus configuration path fixes ([34b1dd2e](https://github.com/dracutdevs/dracut/commit/34b1dd2e26c343e9000094db01a7985b6851adf1))
* **cms:**  reload NetworkManager connections ([07977ee5](https://github.com/dracutdevs/dracut/commit/07977ee5c5294a5d30c1f33f292a0b31303750fb))
* **cpio:**
     *  correct dev_t -> rmajor/rminor mapping ([acc629ab](https://github.com/dracutdevs/dracut/commit/acc629abb0d7a26f692f99e5a9cf8c8401bc6a86))
     *  write zeros instead of seek for padding and alignment ([0af11c5e](https://github.com/dracutdevs/dracut/commit/0af11c5ea5018a3e1049a2207a9a671049651876))
* **crypt:**  remove quotes from cryptsetupopts ([e0abf88a](https://github.com/dracutdevs/dracut/commit/e0abf88a15d23fbf793cf872397016ad86aeaaa8), closes 
[#1528](https://github.com/dracutdevs/dracut/issues/1528))
* **crypt-gpg:**
     *  tr needs to be installed ([a93fbc4a](https://github.com/dracutdevs/dracut/commit/a93fbc4ae00d8c6ecda67319a6425f7966609bbe))
     *  execute --card-status on each try ([66100936](https://github.com/dracutdevs/dracut/commit/6610093698db25fda1d584b9771da1e2c2330095))
* **dasd_rules:**
     *  correct udev dasd rules parsing ([5de6e4d5](https://github.com/dracutdevs/dracut/commit/5de6e4d56e5206cb47f645ad1cb6d39794048c68))
     *  remove collect based udev rule creators ([ebafbd82](https://github.com/dracutdevs/dracut/commit/ebafbd824175e201ae9476576588a896c6b7d7eb))
* **dmsquash-live:**
     *  option to use overlayfs on a block device root ([813577e2](https://github.com/dracutdevs/dracut/commit/813577e2ba034b448d2cf2d2857b2d20d56c0259))
     *  do not install systemd files when systemd is not enabled ([bf8738d3](https://github.com/dracutdevs/dracut/commit/bf8738d31ca53ad6410c46c1f9b2a4a12273b9a3))
     *  iso-scan requires rmdir ([e19e3890](https://github.com/dracutdevs/dracut/commit/e19e38904c054664473207d2d6ef3c53bd938867))
     *  correct regression introduced with shellcheck changes ([0c631efb](https://github.com/dracutdevs/dracut/commit/0c631efb10bf4ce18ec8640277bd94712950298a))
* **dmsquash-live-ntfs:**  fuse3 no longer requires ulockmgr_server ([75ad2699](https://github.com/dracutdevs/dracut/commit/75ad269931eccd266a5d60ba4000d93655143e00))
* **dracut:**  be more robust when using 'set -u' ([22a80629](https://github.com/dracutdevs/dracut/commit/22a80629b4bbcef02eb8fe3611ea44e253ef4c61))
* **dracut-functions.sh:**
     *  ip route parsing ([d754e1c6](https://github.com/dracutdevs/dracut/commit/d754e1c6f081a6501cb7fdcb5caaa6c4977235af))
     *  get block device driver if in a virtual subsystem ([dc3b976f](https://github.com/dracutdevs/dracut/commit/dc3b976f3393d7a3fb75b349418fc8ee2c9142bd))
* **dracut-init:**  unbreak a comment ([bc4f196f](https://github.com/dracutdevs/dracut/commit/bc4f196f9825029eaef7ccf525ec57f5229b2793))
* **dracut-initramfs-restore.sh:**
     *  add missing compression options ([e86397de](https://github.com/dracutdevs/dracut/commit/e86397de24f4efa6d36e2bb5ae84b7d9ec69b72d))
     *  add missing default paths ([3d8e1ad2](https://github.com/dracutdevs/dracut/commit/3d8e1ad2ae1e34244ddf700beea6358c1452e05c), closes [#1628](https://github.com/dracutdevs/dracut/issues/1628))
* **dracut-install:**  tweaks to get_real_file() ([1beeaf3b](https://github.com/dracutdevs/dracut/commit/1beeaf3b71aed763d5fc7a9ee044d675f8906e8c))
* **dracut-shutdown:**  add cleanup handler on failure ([7ab1d002](https://github.com/dracutdevs/dracut/commit/7ab1d00227cad6f1b86ba01fdc766769faebb031))
* **dracut-systemd:**  do not use Requires for vconsole-setup.service ([a7f5429c](https://github.com/dracutdevs/dracut/commit/a7f5429cb81f7ffdf9bd5684af8d36725170b756))
* **dracut.sh:**
     *  do not ignore invalid config file or dir path ([7de9ffc0](https://github.com/dracutdevs/dracut/commit/7de9ffc0574790ecbad74b5a000ecd022d7736d4))
     *  check kernel zstd support early ([475497b1](https://github.com/dracutdevs/dracut/commit/475497b1bd12c006c782541124b6427cb7ef4cb7))
     *  check availability of configured compression ([bdac657b](https://github.com/dracutdevs/dracut/commit/bdac657bf65615438942a872491a818750735014))
     *  inform user about auto-selected compression method ([06d47ded](https://github.com/dracutdevs/dracut/commit/06d47ded679231e1370cc655c1df408fc865baac))
     *  drop pointless check for module compression method ([586d3e76](https://github.com/dracutdevs/dracut/commit/586d3e7664c00bf144becfa69dde2dbab8711d51))
     *  change misspelled variable name ([acfd97a9](https://github.com/dracutdevs/dracut/commit/acfd97a94385c33cd6cef4e5a37f233ea4081288))
     *  remove wrong $ in loop sequence ([f1245b5b](https://github.com/dracutdevs/dracut/commit/f1245b5bc13a98ef0dcc679dcef6148214e09503))
     *  handle symlinks appropriately while using '-i' option ([c7fbc0c8](https://github.com/dracutdevs/dracut/commit/c7fbc0c8901917baf0d1f0822568e65c6ec00d18))
     *  handle '-i' option to include files beginning with '.' ([f1138012](https://github.com/dracutdevs/dracut/commit/f1138012c9dc44e6614466c0a8e929fc55e4a5dd))
* **drm:**  add privacy screen modules to the initrd ([14d97a6a](https://github.com/dracutdevs/dracut/commit/14d97a6a28c6172340c47c89374358aaf4e2629d))
* **fedora.conf.example:**  rename misspelled variable ([9371dcab](https://github.com/dracutdevs/dracut/commit/9371dcaba3c58377428eee44bd702fae7b2ab20e))
* **fido2:**  add a missing library ([4753738b](https://github.com/dracutdevs/dracut/commit/4753738b62d958955f50fb077ea21c56a8d23dc3))
* **fips:**
     *  missing sourcing of dracut-lib ([857b17f0](https://github.com/dracutdevs/dracut/commit/857b17f090bdf575292f0bd6f5e8e3d753f6b426))
     *  add and remove local variables ([e8121bfd](https://github.com/dracutdevs/dracut/commit/e8121bfddda34e20db889a74d4ac6259ed182aea))
     *  wrong error message ([7f10c483](https://github.com/dracutdevs/dracut/commit/7f10c483b6abcc8be42cf246bbdade264be68228))
     *  handle s390x OSTree systems ([78557f05](https://github.com/dracutdevs/dracut/commit/78557f05a69fe718a97df85d2ed741ce10d3f806))
* **fips.sh:**  repsect rd.fips.skipkernel ([5789abcb](https://github.com/dracutdevs/dracut/commit/5789abcbe05f30d556086590b786c4857d025d9d))
* **img-lib:**  install rmdir ([51ce8893](https://github.com/dracutdevs/dracut/commit/51ce8893d981e90640123a7dcc3e4f3621e7d819))
* **install:**
     *  segfault on popen error ([5c2f72f1](https://github.com/dracutdevs/dracut/commit/5c2f72f152ec319a8001d1ff0bfd1f81a9130b04))
     *  extend hwcaps library handling to libraries under glibc-hwcaps/ ([10ed204f](https://github.com/dracutdevs/dracut/commit/10ed204f873f454dcd15ffcc82dc3a1c781c1514))
     *  use size_t to avoid -Wsign-compare warning ([55468a2d](https://github.com/dracutdevs/dracut/commit/55468a2d40182de4cce5ba4ecd5dcd96be03bd4d))
     *  improve gettid definition ([ef0f848a](https://github.com/dracutdevs/dracut/commit/ef0f848a67fdd0a0dab135acbd1cd7fa0179a95c))
     *  validate return values log.c ([19537f89](https://github.com/dracutdevs/dracut/commit/19537f8943ac4106c6d4ab0e00a48a8c0a9a0519))
     *  rectify unused function args in log.c ([b5cf7ec7](https://github.com/dracutdevs/dracut/commit/b5cf7ec784335ec561e379f8e78f48019a344ac0))
     *  use wrapper for asprintf ([e2a61595](https://github.com/dracutdevs/dracut/commit/e2a61595d2c91202ff4ea69937064cd2c0d1f336))
     *  use unsigned int instead of unsigned ([74a41799](https://github.com/dracutdevs/dracut/commit/74a417994840f7a6119e2dee57f9a3bb4d84998b))
     *  reduce cppcheck warnings ([b0bf8187](https://github.com/dracutdevs/dracut/commit/b0bf8187d5cc51d5576d8d70a81677d7c9741b37))
     *  add a missing ret value assignment ([6a444261](https://github.com/dracutdevs/dracut/commit/6a44426162d5b1b7084b17f921799863d353f847))
* **integrity:**  add support for loading multiple EVM x509 certs ([9da76af8](https://github.com/dracutdevs/dracut/commit/9da76af8e7f0f7a939b2ee44f0b4a5ce0bdd3b0b))
* **iscsi:**  add support for the new iscsiadm "no-wait" (-W) command ([7374943a](https://github.com/dracutdevs/dracut/commit/7374943ae3d063f0142c969b132c4156030fda8b))
* **kernel-modules:**
     *  add mailbox drivers for arm ([0e80ff72](https://github.com/dracutdevs/dracut/commit/0e80ff72e01d28e7e92d3adbf98ec40bdbdc37fe))
     *  detect block device's hardware driver ([c86f4d28](https://github.com/dracutdevs/dracut/commit/c86f4d286000d1e76fd405560b4114537e2cbbff))
     *  add blk_mq_alloc_disk and blk_cleanup_disk to blockfuncs ([b292ce72](https://github.com/dracutdevs/dracut/commit/b292ce7295f18192124e64e5ec31161d09492160))
     *  add more modules on RISC-V ([3cc9f1c1](https://github.com/dracutdevs/dracut/commit/3cc9f1c10c67dcdb5254e0eb69f19e9ab22abf20))
     *  add isp1760 USB controller ([15398458](https://github.com/dracutdevs/dracut/commit/15398458685d376fef56b1bf6fe09ae7c68324c1))
     *  add Type-C USB drivers for generic initrd ([a1287c62](https://github.com/dracutdevs/dracut/commit/a1287c627f28b16b1b066b7c256549b832bd98de))
* **kernel-modules-extra:**  handle zstd module extension ([b3d2dcb7](https://github.com/dracutdevs/dracut/commit/b3d2dcb71e7af8f605f5f66041ed3c801333e5f1))
* **lvm:**
     *  restore setting LVM_MD_PV_ACTIVATED ([164e5ebb](https://github.com/dracutdevs/dracut/commit/164e5ebb1199ea3e3d641ce402d8257f0055a529))
     *  replace --partial option ([97543cca](https://github.com/dracutdevs/dracut/commit/97543cca48dfde849396f11c83f9c320e1b91c46))
* **man:**  default value of rd.retry was increased to 180 seconds ([4855242c](https://github.com/dracutdevs/dracut/commit/4855242ce5cb586afd2eebd91df57ce1d28ae6b5))
* **mdraid:**  allow UUID comparison for more than one UUID ([d364ce83](https://github.com/dracutdevs/dracut/commit/d364ce8334fef96f48492bd0fb3b7deac37bbb66))
* **memstrack:**  drop bash runtime requirement ([35822f39](https://github.com/dracutdevs/dracut/commit/35822f39970b369301e0ff54436d5714dd996896))
* **mksh:**  requires printf ([f806a628](https://github.com/dracutdevs/dracut/commit/f806a628aa9aec548e425e81b6ea4ab6f5db26f6))
* **multipath:**
     *  check if mpathconf is available ([4318533e](https://github.com/dracutdevs/dracut/commit/4318533e1493bfab622b64efc1b799426c812c26))
     *  drop ExecStop= setting from service unit ([9491e599](https://github.com/dracutdevs/dracut/commit/9491e599282d0d6bb12063eddbd192c0d2ce8acf))
     *  get config. dir from configuration ([2e3c5444](https://github.com/dracutdevs/dracut/commit/2e3c5444d271cb8f05955858b8fdc367c4ea5c48))
* **multipathd.service:**
     *  drop dependencies on iscsi and iscsid ([6246da40](https://github.com/dracutdevs/dracut/commit/6246da400fa7f527a1ff1c620bf85ac9f6644508))
     *  adapt to upstream multipath-tools unit file ([a247d2bc](https://github.com/dracutdevs/dracut/commit/a247d2bc0d4c6d37a2ea4f3da98dd7902bb37385))
     *  remove dependency on systemd-udev-settle ([371b338a](https://github.com/dracutdevs/dracut/commit/371b338a5f19d40ff4c3216dc0f27f9a00cf4e22))
* **network:**
     *  consistent use of "$gw" for gateway ([3f2c76bb](https://github.com/dracutdevs/dracut/commit/3f2c76bb1456941a28d3333569d2bf18f8624617))
     *  wrong test of wicked unit ([22e68307](https://github.com/dracutdevs/dracut/commit/22e683077a686b592da55e1d247b31f65c95d481))
     *  add errors and warnings when network interface does not exist ([79389352](https://github.com/dracutdevs/dracut/commit/7938935267dd8824f074adf84c219340ad4c8db6))
* **network-manager:**
     *  skip non-directories in /sys/class/net ([d9c3c774](https://github.com/dracutdevs/dracut/commit/d9c3c77437d91d7d66369a3ef701ffc5e501346d))
     *  disable tty output if the console is not usable ([f6e6be24](https://github.com/dracutdevs/dracut/commit/f6e6be245d0cda14d90a0442b688c8dca1410a2e))
     *  show output on console only with rd.debug enabled ([e07b7ad0](https://github.com/dracutdevs/dracut/commit/e07b7ad0e7f5dbb8024336f3075610b3b74ffb2e))
     *  write DHCP filename option to dhcpopts file ([38320fce](https://github.com/dracutdevs/dracut/commit/38320fce56a8d83b79d6c970c491a454ba9de213))
     *  check for nm-initrd-generator in both /usr/{libexec,lib} ([5ee7e249](https://github.com/dracutdevs/dracut/commit/5ee7e249b8cc74461122ccd7efe954b3402c23da))
     *  ensure safe content of /tmp/dhclient."$ifname".dhcpopts ([e509c638](https://github.com/dracutdevs/dracut/commit/e509c638e68a8e3cae446d1a4f9f86e3aa6e7a99))
     *  include nm-daemon-helper binary ([0e590531](https://github.com/dracutdevs/dracut/commit/0e5905315e92dfc095f543fd73db6190db533217))
     *  don't pull in systemd-udev-settle ([a0f12fb6](https://github.com/dracutdevs/dracut/commit/a0f12fb6a09b09f35ab28753d7c4461c10a8b562))
     *  support teaming under NM+systemd ([a97d2ced](https://github.com/dracutdevs/dracut/commit/a97d2cedcf65a9a2fbff2591171f0163c7d3cb46))
     *  pull in network.target in nm-initrd.service ([a97d6e2b](https://github.com/dracutdevs/dracut/commit/a97d6e2b13146783831b166ec5e8b33b29c514b0))
* **network-wicked:**  multiple path corrections ([d3b5bc17](https://github.com/dracutdevs/dracut/commit/d3b5bc17ebadfe8922d1144b3dfd5435d0ecc71a))
* **nvmf:**  validate_ip_conn ([655c65e6](https://github.com/dracutdevs/dracut/commit/655c65e6ced00e7a80c41e96c5f6fe108da07839))
* **qeth_rules:**  check the existence of /sys/devices/qeth/*/online beforehand ([6c71ba41](https://github.com/dracutdevs/dracut/commit/6c71ba4121ae64ccd13fefba68ca327ac623810f))
* **resume:**
     *  resume using /usr/lib64/suspend ([c4593734](https://github.com/dracutdevs/dracut/commit/c459373448d24760d15e22fde7c6f811c7891376))
     *  check for presence of /sys/power/resume ([0b977906](https://github.com/dracutdevs/dracut/commit/0b97790626bff3579755b38f78a9c524a075cfcc))
* **rootfs-block:**  make the base module dependency explicit ([3326e4c9](https://github.com/dracutdevs/dracut/commit/3326e4c957d0499495d9e91182fc574b960ace86))
* **s390_rules:**  drop collect installation ([f905c3a7](https://github.com/dracutdevs/dracut/commit/f905c3a72c975cf6006f266755cc91229132c739))
* **shutdown:**  be robust against forced shutdown ([b9ba3c8b](https://github.com/dracutdevs/dracut/commit/b9ba3c8bb8f0f1328cd1ffaa8dbf64585b28c474))
* **skipcpio:**
     *  calculate and use CPIO_MAGIC_LEN ([3fb8723c](https://github.com/dracutdevs/dracut/commit/3fb8723ce0066b4ba92f6dbfc4373a66d1f551c4))
     *  improve error checking ([f6d16b6b](https://github.com/dracutdevs/dracut/commit/f6d16b6bbd5b8b7ac238c3d2148bebf4e91140a2))
* **squash:**
     *  apply FIPS and libpthread workaround ([5ab18dee](https://github.com/dracutdevs/dracut/commit/5ab18dee996f0eeb2b0bfe354570e1b1af46d025))
     *  remove tailing '/' when installing ld.so.conf.d ([cbd85597](https://github.com/dracutdevs/dracut/commit/cbd85597e3ed6abf64ac17f431da5477eb5aefa0))
     *  keep ld cache under initdir ([dc21638c](https://github.com/dracutdevs/dracut/commit/dc21638c3f0acbb54417f3bfb6294ad5514bf2db))
     *  create relative symlinks ([a2b6be44](https://github.com/dracutdevs/dracut/commit/a2b6be44792b68218e3378a7d844b0f8527a4805))
* **systemd-sysusers:**
     *  use split systemd sysuser configs ([fec93bb2](https://github.com/dracutdevs/dracut/commit/fec93bb22181f80056b40231fca36c422248ade0))
     *  override systemd-sysusers.service ([dcbe23c1](https://github.com/dracutdevs/dracut/commit/dcbe23c14d13ca335ad327b7bb985071ca442f12))
* **tpm2-tss:**
     *  add a missing library ([c656b612](https://github.com/dracutdevs/dracut/commit/c656b612b101e4834e01f9841162e2629a7272f7))
     *  typo in depends() ([8b17105b](https://github.com/dracutdevs/dracut/commit/8b17105bed69ed90582a13d97d95ee19e6581365))
* **url-lib:**
     * SC2086: Double quote to prevent globbing and word splitting ([acb18869](https://github.com/dracutdevs/dracut/commit/acb18869e98687a3f8c172d7e7befaa5326cf67a))
     * SC2046: Quote this to prevent word splitting ([ec50cec3](https://github.com/dracutdevs/dracut/commit/ec50cec3bd9169410df409e077d0487c63c2a627))
     * improve ca-bundle detection ([e3bb1815](https://github.com/dracutdevs/dracut/commit/e3bb1815bbbff1a7e21b857d2ae32bc0410754d5))
     * make pre-pivot hook separetely per nfs mount ([2f091b17](https://github.com/dracutdevs/dracut/commit/2f091b17075f81ff490b05d3d566d736fc32f0be))
* **usrmount:**  do not empty _dev variable ([4afdcba2](https://github.com/dracutdevs/dracut/commit/4afdcba212793f136aea012b30dd7bdb5b641a5a))
* **zfcp_rules:**
     *  correct udev zfcp rules parsing ([59252668](https://github.com/dracutdevs/dracut/commit/5925266832042f9d17a3fb7a219b83118c5b16d6))
     *  remove collect based udev rule creators ([d40c49a8](https://github.com/dracutdevs/dracut/commit/d40c49a8dfe203be33af8ace5f0efd07a88856f4))

#### Features

* **Makefile:**  cargo wrapper for dracut-cpio build ([51d21c6b](https://github.com/dracutdevs/dracut/commit/51d21c6b37b0eb8566d18d665d0197ca4d68101c))
* **cpio:**
     *  add newc archive creation utility ([a9c67046](https://github.com/dracutdevs/dracut/commit/a9c67046431ccf5fd4f4c16c890695df388f0d38))
     *  add rust argument parsing library from crosvm ([94fc5026](https://github.com/dracutdevs/dracut/commit/94fc50262f5e6c28d92782dc231fbb6c61855954))
* **crypt:**
     *  check if pkcs11 module is needed in hostonly mode ([56f4fb6c](https://github.com/dracutdevs/dracut/commit/56f4fb6cb755327c77c32f8c414a4a0e64fc933c))
     *  check if fido2 module is needed in hostonly mode ([d5fd030c](https://github.com/dracutdevs/dracut/commit/d5fd030cc285730e1a1b9e0e78a1e1dc4daabfe0))
     *  check if tpm2-tss module is needed in hostonly mode ([5d990a00](https://github.com/dracutdevs/dracut/commit/5d990a004b5ae6863f2c9a633b184c07dd73563d))
* **dracut.sh:**
     *  add --aggresive-strip option ([67fc670a](https://github.com/dracutdevs/dracut/commit/67fc670a88ab6c97d22c6718082619c0cf850fc3))
     *  add "--enhanced-cpio" option for calling dracut-cpio ([afe4a6db](https://github.com/dracutdevs/dracut/commit/afe4a6dbb7df62982baab8212bba5d90010dfbac))
     *  check if target kernel has zstd support compiled in ([591118c5](https://github.com/dracutdevs/dracut/commit/591118c56da2bfcea060e3b7671bc87b23c0e44a))
* **fido2:**  introducing the fido2 module ([049973b7](https://github.com/dracutdevs/dracut/commit/049973b708298ea0ce1ac9c869b404f4c718eff3))
* **lvm:**
     *  only run lvchange for LV that is seen on devices ([1af46743](https://github.com/dracutdevs/dracut/commit/1af46743195422aaebcde5c508a5dd479eff51ea))
     *  use generated filter when none is set ([7ffc5e38](https://github.com/dracutdevs/dracut/commit/7ffc5e388bcce20785803825bdd260c3c854b34f))
     *  update lvm command options ([c0a54f29](https://github.com/dracutdevs/dracut/commit/c0a54f2993b1d3c2101202c274a41f925445d54b))
* **pcsc:**  introducing the pcsc module ([dcaff88a](https://github.com/dracutdevs/dracut/commit/dcaff88ac942042e3db0a2bbfc1c995ec0735f38))
* **pkcs11:**
     *  include the module in the spec file ([c5907f82](https://github.com/dracutdevs/dracut/commit/c5907f82d835d72e4dd7c473a86e872fce37d61e))
     *  introducing the pkcs11 module ([83ea8cf0](https://github.com/dracutdevs/dracut/commit/83ea8cf001a49356cf7814b3c08bdd1c4b4f2763))
* **spec:**  add systemd-integritysetup module ([fe8df024](https://github.com/dracutdevs/dracut/commit/fe8df0240a24b9d2d60a5b0b998f82b251ede849))
* **squash:**  install umount util ([563f5434](https://github.com/dracutdevs/dracut/commit/563f543424c66bf38e6cbd3f489655d45ad9b5c5))
* **systemd:**  enable support for systemd compiled with ASAN ([d502d2a8](https://github.com/dracutdevs/dracut/commit/d502d2a816ba8f8329b3d8616bd2a7e82a0ad21f))
* **systemd-integritysetup:**  introducing the systemd-integritysetup module ([33cf47a6](https://github.com/dracutdevs/dracut/commit/33cf47a60870cc290bd5b59c9cf87c54ad37051f))

#### Contributors

- Antonio Alvarez Feijoo <antonio.feijoo-IBi9RG/b67k@public.gmane.org>
- David Disseldorp <ddiss-l3A5Bk7waGM@public.gmane.org>
- Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
- Jóhann B. Guðmundsson <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Shreenidhi Shedi <sshedi-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
- David Teigland <teigland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Beniamino Galvani <bgalvani-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Thomas Blume <thomas.blume-IBi9RG/b67k@public.gmane.org>
- Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Laszlo Gombos <laszlo.gombos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Renaud Métrich <rmetrich-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Dusty Mabe <dusty-Y4YknsGeUCNl57MIdRCFDg@public.gmane.org>
- Masahiro Matsuya <mmatsuya-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Alexander Wenzel <alexander.wenzel-kWr3Bf9R7AqELgA04lAiVw@public.gmane.org>
- Andre Russ <andre.russ-y6kNeMnOB+c@public.gmane.org>
- Cornelius Hoffmann <coding-f0z4eocb6ZyzQB+pC5nmwQ@public.gmane.org>
- David Tardon <dtardon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Frantisek Sumsal <frantisek-I+KZ0t1yij6lVyrhU4qvOw@public.gmane.org>
- Harald Hoyer <harald-N+nATeo78kJBDgjK7y7TUQ@public.gmane.org>
- José María Fernández <josemariafg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Kairui Song <kasong-1Nz4purKYjRBDgjK7y7TUQ@public.gmane.org>
- Peter Robinson <pbrobinson-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
- Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Tony Asleson <tasleson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Zoltán Böszörményi <zboszor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Adrien Thierry <athierry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
- Andreas Schwab <schwab-l3A5Bk7waGM@public.gmane.org>
- Andrey Sokolov <keremet-u2l5PoMzF/Vg9hUCZPvPmw@public.gmane.org>
- Brandon Sloane <btsloane-H+0wwilmMs3R7s880joybQ@public.gmane.org>
- Charles Rose <charles.rose-8PEkshWhKlo@public.gmane.org>
- Coiby Xu <coxu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Dan Horák <dhorak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Dirk Müller <dirk-QVCS8j7969U@public.gmane.org>
- Glenn Morris <rgm-FGKo4X94FMn2fBVCVOL8/A@public.gmane.org>
- Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
- Henrik Gombos <henrik99999-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Jonathan Lebon <jonathan-Yl68zTAdl+XQT0dZR+AlfA@public.gmane.org>
- LinkTed <link.ted-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
- Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
- Luca BRUNO <luca.bruno-JW9irJGTvgXQT0dZR+AlfA@public.gmane.org>
- Lukas Nykryn <lnykryn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Matthias Berndt <matthias_berndt-Mmb7MZpHnFY@public.gmane.org>
- Mike Gilbert <floppym-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
- Pavel Valena <pvalena-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Stefan Berger <stefanb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
- Thomas Haller <thaller-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Tomasz Paweł Gajc <tpgxyz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Zbigniew Jędrzejewski-Szmek <zbyszek-wrcVdnn0TatmR6Xm/wNWPw@public.gmane.org>
- joshuacov1 <joshuacov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- lapseofreason <lapseofreason0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 054
Date: Fri, 14 May 2021 15:37:27 +0200
Message-ID: <6b7de7f7-86e1-1551-bc29-8d74d3d3d837@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620999455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r9izzRxtC4NslZ8SXNjR9IULId8CeyPXAXdvU1CLpwc=;
        b=b6djWb/gHiEzfiuDOBcJnxPip5J7uopfXPwyKJNGWMixZMWEptqU6N8mV8b6RoKBQDk4kF
        aOmR9mCjnF7TV+8L6xv+8IqdL5jtbnGoF2HFKSfmkivWDrlzkoAjAYq7V0N1ARb4y6osG/
        PQgxHoL3kBjVC7F48AErVJY7kcBHTM0=
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
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

dracut-054
==========

With this release dracut has undergone a major overhaul.

A lot of systemd related modules have been added.

The integration test suite has finally ironed out the flaky behaviour due to the parallel device probing of the kernel,
which bit sometimes in the non-kvm github CI. So, if you see any `/dev/sda` in a setup script with more than two hard drives,
chances are, that the script works on the wrong disk. Same goes for network interfaces.

This release is also fully `shellcheck`'ed with `ShellCheck-0.7.2` and indented with `shfmt` and `astyle`.

The dracut project builds test containers every day for:
* `opensuse/tumbleweed-dnf:latest`
* `archlinux:latest`
* `fedora:rawhide`
* `fedora:latest`
* `fedora:33`

These containers can easily be used to run the integration tests locally without root permissions via `podman`.
We hope this serves as a blueprint for your distribution's CI process.

More information can be found in [docs/HACKING.md](https://github.com/dracutdevs/dracut/blob/master/HACKING.md).

#### Bug Fixes

*   make testsuite pass on OpenSuse and Arch
([8b2afb08](https://github.com/dracutdevs/dracut/commit/8b2afb08baea7fc6e15ece94e287dcc4a008bcc4))
*   cope with distributions with `/usr/etc` files
([3ad3b3a4](https://github.com/dracutdevs/dracut/commit/3ad3b3a40d419c4386b2924f6ac25ab0c355d131))
*   deprecate gummiboot ([5c94cf41](https://github.com/dracutdevs/dracut/commit/5c94cf41e8937b6fbb72c96bc54c84fdf224c711))
*   set vimrc and emacs indention according to .editorconfig
([9012f399](https://github.com/dracutdevs/dracut/commit/9012f3996b1e5f0788f8e80dfdd5c9ab0636c355))
*   correctly handle kernel parameters
([501d82f7](https://github.com/dracutdevs/dracut/commit/501d82f79675a6bf9b37e8250152515863a80236))
*   remove dracut.pc on `make clean`
([d643156d](https://github.com/dracutdevs/dracut/commit/d643156d561d3aca816d75e403149db073617292))
*   honor KVERSION environment in the Makefile
([d8a454a5](https://github.com/dracutdevs/dracut/commit/d8a454a537c6de95033dec7d83c622fdc46c2a4f))
*   always use mkdir -p ([9cf7b1c5](https://github.com/dracutdevs/dracut/commit/9cf7b1c529442d5abd6eaec4399d4ee77b95145e))
* **dracut.sh:**
    *  prevent symbolic links containing `//`
([de0c0872](https://github.com/dracutdevs/dracut/commit/de0c0872fc858fa9ca952f79ea9f00be17c37a4c))
    *  adding missing globalvars for udev
([f35d479d](https://github.com/dracutdevs/dracut/commit/f35d479d2b718da54886a66d3b7af2132215f80a))
    *  sysctl global variables ([3ca9aa1d](https://github.com/dracutdevs/dracut/commit/3ca9aa1d7b24b82e01d16613b86ec3be97c8a1bb))
    *  add global vars for modules-load
([ec4539c6](https://github.com/dracutdevs/dracut/commit/ec4539c6066edf25e52ed8e2d35c4be7ef39f729))
    *  omission is an addition to other omissions in conf files
([96c31333](https://github.com/dracutdevs/dracut/commit/96c313333d1a4f5e2c524a3a11c5b3aab24afc20))
    *  harden dracut against GZIP environment variable
([d8e47e20](https://github.com/dracutdevs/dracut/commit/d8e47e201af4646e2a82e11220ea9c993bd2ed48))
    *   add a missing tmpfilesconfdir global variable
([8849dd8d](https://github.com/dracutdevs/dracut/commit/8849dd8d1a74a46cb761c4d8041e4582d4686724))
    *   include `modules.builtin.alias` in the initramfs
([7f633747](https://github.com/dracutdevs/dracut/commit/7f6337471312486934f9592c1c7c05ed68694454))
    *   install all depmod relevant configuration files
([50a01dd4](https://github.com/dracutdevs/dracut/commit/50a01dd4b28471c0dfa810a705e219963bd5ec3c))
    *   add `modules.builtin.modinfo` to the initramfs
([87c4c178](https://github.com/dracutdevs/dracut/commit/87c4c17850e8bb982f6c07a6d3f58124bb2875de))
    *   search for btrfs devices from actual mount poiont
([3fdc734a](https://github.com/dracutdevs/dracut/commit/3fdc734a5cc8c0b94c1da49439181d540c8a5c43))
* **dracut-functions.sh:**
    *  implement a cache for get_maj_min
([c3bb9d18](https://github.com/dracutdevs/dracut/commit/c3bb9d18dceed7db6d16f9c2a7f682c5934099d7))
    *  word splitting issue for sed in get_ucode_file
([122657b2](https://github.com/dracutdevs/dracut/commit/122657b2fedf13991597830cca4d4ddbc8038233))
* **dracut-logger.sh:**  double dash trigger unknown logger warnings during run
([4fbccde5](https://github.com/dracutdevs/dracut/commit/4fbccde50456f513d388cdfd858018cd889890dc))
* **dracut-install:**
    *  handle $LIB in ldd output parsing
([d1a36d3d](https://github.com/dracutdevs/dracut/commit/d1a36d3d80b0ed71ee814659e18a020c53cee05e))
    *  handle builtin modules ([2536a9ea](https://github.com/dracutdevs/dracut/commit/2536a9eaffbc9cc14c85579a2f537d3f3a1d5659))
* **base:**
    *  suppress calls to getarg in build phase
([6feaaabc](https://github.com/dracutdevs/dracut/commit/6feaaabc221ffbf79f652cbee3eea58f02449c50))
    *  source hooks without exec ([8059bcb2](https://github.com/dracutdevs/dracut/commit/8059bcb2c8df4d60cc2f548d3c53db25d815a7be))
    *  wait_for_dev quote shell variables
([b800edd6](https://github.com/dracutdevs/dracut/commit/b800edd69817b5e46d5f240b96d3b3648267ea21))
    *  adding crc32c for ext3 ([61f45643](https://github.com/dracutdevs/dracut/commit/61f456435879f084a1bf2c8885eaf37070035abf))
* **crypt:**
    *  install all crypto modules in the generic initrd
([10f9e569](https://github.com/dracutdevs/dracut/commit/10f9e569c52654ff54678a626a0f5dd14233716d))
    *  include cryptsetups tmpfile ([a4cc1964](https://github.com/dracutdevs/dracut/commit/a4cc196467e45f093fab7876c1c6b40798058920))
* **crypt-gpg:**
    *  cope with different scdaemon location
([44fd1c13](https://github.com/dracutdevs/dracut/commit/44fd1c13555f2e12bb566c246948629ada27d14d))
* **dbus-broker:**
    *  enable the service ([df1e5f06](https://github.com/dracutdevs/dracut/commit/df1e5f06a5449dcec6749baf742eac6eb1f0aa53))
* **dbus-daemon:**
    *  only error out in install() ([ae4fbb3d](https://github.com/dracutdevs/dracut/commit/ae4fbb3db4136e6e03a1c74d05ecc2a73b916401))
* **dracut-systemd:**
    *  don't refuse root=tmpfs when systemd is used
([a96900a8](https://github.com/dracutdevs/dracut/commit/a96900a82c3a8ec1ed2c6b2cc8862f912093fa0c))
* **examples:**  remove the examples directory and reference to it
([b37c90c8](https://github.com/dracutdevs/dracut/commit/b37c90c8e00155a1f31237ae6cf91a81677c4df5))
* **fips:**
    *  add dh and ecdh ciphers ([543b8014](https://github.com/dracutdevs/dracut/commit/543b8014fc10fc6a92ba83db0dfc994fc1d2129b))
    *  remove old udev version requirements
([be30d987](https://github.com/dracutdevs/dracut/commit/be30d98751cff4ace660215305e2468943a45754))
* **i18n:**
    *  skip if data is missing ([651fe01e](https://github.com/dracutdevs/dracut/commit/651fe01e7937d86bbd471d9621581bed44f23dfa))
* **img-lib:**
    *  ignored null byte in input ([85eb9680](https://github.com/dracutdevs/dracut/commit/85eb96802cb82ec179bd3bc429b0dad2518946c5))
* **integrity:**
    *  properly set up EVM when using an x509 cert
([4bdd7eb2](https://github.com/dracutdevs/dracut/commit/4bdd7eb23a8187c3f19797e47eee8c672cea33ae))
* **iscsi:**
    *  replace sed call with bash internals
([66b920c6](https://github.com/dracutdevs/dracut/commit/66b920c65143f4cac80385a51704ae9483305569))
    *  add iscsid.service requirements
([bb6770f1](https://github.com/dracutdevs/dracut/commit/bb6770f1a413bdc7fd570b260ee28ace1255a195))
    *  only rely on socket activiation
([0eb87d78](https://github.com/dracutdevs/dracut/commit/0eb87d78108aae9aa4692f1edfb33ded50e26409))
* **kernel-modules:**
    *  optionally add /usr/lib/modules.d to initramfs
([92e6a8f8](https://github.com/dracutdevs/dracut/commit/92e6a8f87914322994387e559cf2a00b1760b301))
    *  add watchdog drivers for generic initrd
([3a60c036](https://github.com/dracutdevs/dracut/commit/3a60c036db7caccda95475d33c8d4ce1f615d2c8))
* **mdraid:**
    *  remove dependency statements ([86b75634](https://github.com/dracutdevs/dracut/commit/86b756346a6b7c5cb5f6fda4d12e2a58b6144e40))
* **memstrack:**
    *  correct dependencies ([c2ecc4d1](https://github.com/dracutdevs/dracut/commit/c2ecc4d131876383b47820a2e8d1a6f8a11716d9))
* **multipath:**
    *  stop multipath before udev db cleanup
([3c244c7c](https://github.com/dracutdevs/dracut/commit/3c244c7ca3555b526883dc20104c469b39085cbe))
    *  revise multipathd-stop ([7b8c78ff](https://github.com/dracutdevs/dracut/commit/7b8c78ff43a1f8e3690969e980d3d9d1dcb00c87))
* **nbd:**
    *  assume nbd version >= 3.8 ([6209edeb](https://github.com/dracutdevs/dracut/commit/6209edeb5c7783d94867829bf052aa53c78a1efe))
    *  remove old udev version requirements
([fd15dbad](https://github.com/dracutdevs/dracut/commit/fd15dbad6ebad86a3753a03f98706010f3e36cf7))
    *  make nbd work again with systemd
([77906443](https://github.com/dracutdevs/dracut/commit/7790644362622097aa69107920fd26b688c855d3))
* **network:**
    *  use wicked unit instead of find_binary
([57eefcf7](https://github.com/dracutdevs/dracut/commit/57eefcf70587f06b8874a3b3cf31e9ab70c03227))
    *  user variable for sdnetworkd instead of path
([4982e16d](https://github.com/dracutdevs/dracut/commit/4982e16dd53dcbbcfbd3a6b59013a0d6f893f840))
    *  correct regression in iface_has_carrier
([36af0518](https://github.com/dracutdevs/dracut/commit/36af0518b3fe59442de206c24bbe03be6fc17095))
* **network-legacy:**
    *  add missing options to dhclient.conf
([abfd547a](https://github.com/dracutdevs/dracut/commit/abfd547a85230a4520df65280aaf195f319df464))
    *  silence getargs ([60a34d8b](https://github.com/dracutdevs/dracut/commit/60a34d8b11dd50b2cd4e0e2208bd7c5e0fc48b71))
* **network-manager:**
    *  cope with distributions not using `libexec`
([22d6863e](https://github.com/dracutdevs/dracut/commit/22d6863ef1b2eb2a22264f2bfdb2b9329ab5dfdb))
    *  set timeout via command line option
([8a51ee1f](https://github.com/dracutdevs/dracut/commit/8a51ee1fa61bd3da342be53e35730837afd2caad))
    *  run after dracut-cmdline ([4d03404f](https://github.com/dracutdevs/dracut/commit/4d03404f499064b354a58223895cc47dbb461da5))
    *  create /run directories ([49b61496](https://github.com/dracutdevs/dracut/commit/49b614961dc8684f8512febbf80da489909e4b7f))
    *  use /run/NetworkManager/initrd/neednet in initqueue
([6a37c6f6](https://github.com/dracutdevs/dracut/commit/6a37c6f6302f950df608db3fd45acf9342ee3de2))
    *  only run NetworkManager if rd.neednet=1
([ac0e8f7d](https://github.com/dracutdevs/dracut/commit/ac0e8f7dcc81432311906c3fca0d4211f6a2f68c))
    *  nm-run.service: don't kill forked processes
([1f21fac6](https://github.com/dracutdevs/dracut/commit/1f21fac646daa46cbe184ef8ff7705842f06ba15))
    *  no default deps for nm-run.service
([ba4bcf5f](https://github.com/dracutdevs/dracut/commit/ba4bcf5f4f11ad624c647ddf4f566997186135e7))
    *  nm-lib.sh does not require bash
([3402142e](https://github.com/dracutdevs/dracut/commit/3402142e344298c8f20fc52a2b064344788f1668))
* **squash:**
    *  post install should be the last step before stripping
([8c8aecdc](https://github.com/dracutdevs/dracut/commit/8c8aecdc63c9389038e78ee712d4809e49add5e1))
* **systemd:**
    *  include all nss libraries ([b3bbf5fb](https://github.com/dracutdevs/dracut/commit/b3bbf5fb6a95cfb69272da0711b5c5e0c6621de9))
    *  include hosts and nsswitch.conf in hostonly mode
([5912f4fb](https://github.com/dracutdevs/dracut/commit/5912f4fbc036cc36b9507c16dddef1ded1556572))
    *  remove old systemd version requirements
([fc53987b](https://github.com/dracutdevs/dracut/commit/fc53987bec1bc71b054d99072f62c1770a44bcca))
* **systemd-hostnamed:**  extra quote
([2aa65234](https://github.com/dracutdevs/dracut/commit/2aa652349ca83198581cccb516a241a8d0e1b4d9))
* **systemd-modules:**  remove dependency on systemd meta module
([afef4557](https://github.com/dracutdevs/dracut/commit/afef455718db69cff3797ca1a6d8bfebd2e86ab3))
* **systemd-modules-load:**
    *  misc repairs ([782ac8f1](https://github.com/dracutdevs/dracut/commit/782ac8f1f6b68edfe59630e9e4ac1673636f3a5e))
* **systemd-networkd:**
    *  make systemd-networkd a proper network provider
([ea779750](https://github.com/dracutdevs/dracut/commit/ea779750c371102c04252b48f1b7d9c7ece7cf93), closes
[#737](https://github.com/dracutdevs/dracut/issues/737))
* **systemd-resolved:**  remove nss libraries
([12bef83c](https://github.com/dracutdevs/dracut/commit/12bef83cdaf329e3ee2cc1f282bd9c128ec0fc56))
* **systemd-sysctl:**
    *  sysctl global variables ([02acedd0](https://github.com/dracutdevs/dracut/commit/02acedd09eb7222eaaf0f5256f3ddec26d658360))
* **systemd-sysusers:**
    *  misc fixes and cleanup ([7359ba8a](https://github.com/dracutdevs/dracut/commit/7359ba8acab2652cfff6b845f84a936cdec30f9d))
* **systemd-udev:**  use global vars instead of fixed path
([fd883a58](https://github.com/dracutdevs/dracut/commit/fd883a58d1360f0c6c32f64462fafdd7a54af1ee))
* **systemd-udevd:**  add udev id program files
([562cb77b](https://github.com/dracutdevs/dracut/commit/562cb77b5a28e3f31bc6d327c7712fba661e9a27))
* **systemd-verity:**
    *  incorrect reference to cryptsetup target
([ba92d1fc](https://github.com/dracutdevs/dracut/commit/ba92d1fcad68758004d7b1102fe1905c0f25e63e))
    *  re-naming module to veritysetup
([0267f3c3](https://github.com/dracutdevs/dracut/commit/0267f3c3554efd8f027afaf462347167402f5d6c))
* **tpm2-tss:**  add tpm2 requirement
([8f99fada](https://github.com/dracutdevs/dracut/commit/8f99fadabea8f279a9fe28473dba424eb38f8d60))
* **udev-rules:**
    *  remove sourcing of network link files
([69f4e7cd](https://github.com/dracutdevs/dracut/commit/69f4e7cdc3f7da24e40496b0b2f0f5022cc3376d))
    *  add btrfs udev rules by default
([567c4557](https://github.com/dracutdevs/dracut/commit/567c4557537fe7f477f0f54237df00ebc79e56be))
* **url-lib:**
    *  fix passing args ([5f6be515](https://github.com/dracutdevs/dracut/commit/5f6be51595eab878314d031d9bfebe844b639302))
* **zipl:**
    *  don't depend on grub2 ([6b499ec1](https://github.com/dracutdevs/dracut/commit/6b499ec14b3ff35d5298617b436b64563a2d8c2f))

#### Performance

*   disable initrd compression when squash module is enabled
([7c0bc0b2](https://github.com/dracutdevs/dracut/commit/7c0bc0b2fd167da42035020dae49af94844f053c))

#### Features

*   support ZSTD-compressed kernel modules
([ce9af251](https://github.com/dracutdevs/dracut/commit/ce9af251af5fca08ea206ef980005853a4dac36e))
*   also restore the initramfs from /lib/modules
([33e27fab](https://github.com/dracutdevs/dracut/commit/33e27fab59db60b1ca05a0c5b8a51fccb98578e5))
*   extend Makefile indent target ([e0a0fa61](https://github.com/dracutdevs/dracut/commit/e0a0fa61749152fd5bc837770a02cf22d7e02d40))
*   customize .editorconfig according to shfmt
([1f621aba](https://github.com/dracutdevs/dracut/commit/1f621aba3728a621b83b3b697eae6caadae9d287))
*   squash module follow --compress option
([5d05ffbd](https://github.com/dracutdevs/dracut/commit/5d05ffbd87bc27e27f517ebc3454d50729c687e6))
* **bluetooth:**  implement bluetooth support in initrd
([64ee2a53](https://github.com/dracutdevs/dracut/commit/64ee2a53864576fbedabe6b18fb9aae01b999199))
* **btrfs:**  add 64-btrfs-dm.rules rules
([d4caa86a](https://github.com/dracutdevs/dracut/commit/d4caa86aba35b51dc1adda3ee3a5bae677420082))
* **mkinitrd:**  remove mkinitrd ([43df4ee2](https://github.com/dracutdevs/dracut/commit/43df4ee274e7135aff87868bf3bf2fbab47aa8b4))
* **nbd:**  support ipv6 link local nbds
([b12f8188](https://github.com/dracutdevs/dracut/commit/b12f8188a4ffac312694ebd48a5c99ba885e6467))
* **network-manager:**  run as daemon with D-Bus
([112f03f9](https://github.com/dracutdevs/dracut/commit/112f03f9e225a790cbc6378c70773c6af5e7ee34))
* **qemu:**  include the virtio_mem kernel module
([f3dcb606](https://github.com/dracutdevs/dracut/commit/f3dcb60619671f2d353caaa42d38207172c8b3ba))
* **skipcpio:**  speed up and harden skipcpio
([63033495](https://github.com/dracutdevs/dracut/commit/630334950c9a7a714fdf31b6ff545d804b5df2f2))
* **squash:**
    *  use busybox for early setup if available
([90f269f6](https://github.com/dracutdevs/dracut/commit/90f269f6afe409925bad86f0bd7e9322ad9b4fb0))
    *  install and depmod modules seperately
([5a18b24a](https://github.com/dracutdevs/dracut/commit/5a18b24a8b9c20c98f711963ce5407ceb2f3d57b))
* **systemd-ac-power:**  introducing the systemd-ac-power module
([e7407230](https://github.com/dracutdevs/dracut/commit/e74072306958262f22a9ecf10b928647ebdacf8f))
* **systemd-hostnamed:**  introducing the systemd-hostnamed module
([bf273e3e](https://github.com/dracutdevs/dracut/commit/bf273e3e8632faff68fe19f9d7d7cc42e5a7c480))
* **systemd-initrd:**  add initrd-usr-fs.target
([5eb73610](https://github.com/dracutdevs/dracut/commit/5eb736103d06197f37283bc27815c050adec81ea))
* **systemd-journald:**  introducing the systemd-journald module
([3697891b](https://github.com/dracutdevs/dracut/commit/3697891b754493ecd6b19dbf279701bad3460fcd))
* **systemd-ldconfig:**  introducing the systemd-ldconfig module
([563c434e](https://github.com/dracutdevs/dracut/commit/563c434ecba68c628344c1a684f656cdd8f9f214))
* **systemd-network-management:**  introducing systemd-network-management module
([e942d86c](https://github.com/dracutdevs/dracut/commit/e942d86c9ddad19f9307d58cb2d99169f6e94edb))
* **systemd-resolved:**  introducing the systemd-resolved module
([b7d3caef](https://github.com/dracutdevs/dracut/commit/b7d3caef6780305c553851169ca30b0b05b6ff31))
* **systemd-rfkill:**  introducing the systemd-rfkill module
([21536544](https://github.com/dracutdevs/dracut/commit/215365441e1042793d62c4c9e146be5916ed5aeb))
* **systemd-sysext:**  introducing the systemd-sysext module
([fc88af54](https://github.com/dracutdevs/dracut/commit/fc88af54134ec021be58465b52d1271453c30c55))
* **systemd-timedated:**  introducing the systemd-timedated module
([1c41cc90](https://github.com/dracutdevs/dracut/commit/1c41cc90c52636e03abdf6d0c4fa0f557b7eb449))
* **systemd-timesyncd:**  introducing the systemd-timesyncd module
([2257d545](https://github.com/dracutdevs/dracut/commit/2257d54583d24ca69d10b5e600b986d412a21714))
* **systemd-tmpfiles:**  introducing the systemd-tmpfiles module
([2b61be32](https://github.com/dracutdevs/dracut/commit/2b61be32b890e70b1fce45d984327c27302da9bc))
* **systemd-udevd:**  introducing the systemd-udevd module
([3534789c](https://github.com/dracutdevs/dracut/commit/3534789cc42331bc22cf44d26a1d04db4e010ad9))
* **systemd-verity:**  introducing the systemd-verity module
([3d4dea58](https://github.com/dracutdevs/dracut/commit/3d4dea58f9821e58841d5c738b9935193c680181))
* **tpm2-tss:**  introducing the tpm2-tss module
([8743b073](https://github.com/dracutdevs/dracut/commit/8743b0735692ab3f333815ba311cecdc29d45ecd))

#### Contributors

- Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Jóhann B. Guðmundsson <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Dusty Mabe <dusty-Y4YknsGeUCNl57MIdRCFDg@public.gmane.org>
- Beniamino Galvani <bgalvani-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Mikhail Novosyolov <m.novosyolov-gm6MCZPbL5j4TFCr1P8HWA@public.gmane.org>
- Renaud Métrich <rmetrich-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Adam Alves <adamoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Daniel Molkentin <daniel.molkentin-IBi9RG/b67k@public.gmane.org>
- David Hildenbrand <david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- David Tardon <dtardon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Jaroslav Jindrak <dzejrou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Jonas Jelten <jj-inVfeBXuaV8@public.gmane.org>
- Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
- Lev Veyde <lveyde-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Peter Robinson <pbrobinson-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
- Stefan Berger <stefanb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
- Đoàn Trần Công Danh <congdanhqx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


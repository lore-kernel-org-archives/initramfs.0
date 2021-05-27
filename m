From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 055
Date: Thu, 27 May 2021 15:56:13 +0200
Message-ID: <99be488a-5882-3070-e667-431f882c046d@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622123778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BIHH3npnYdF3xWlQYS5eQR+RSo7kbchb0S9D9cu5Jmk=;
        b=Wl2xcl9pJZznobZ6M+swHYlt9w9m/up0eADtUTvVRVHsq7SLvhOaGpvMXgxwhcatDqTkva
        vsuAusXbTUmn4f94En0PsEvHV+rce7CZloq+xYqt30Zb0ygOQXQdtgZ0VMxGSL/BAyabtT
        aWmqplRv2X0J/pWr3FfIBotLK8JYnro=
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version.

This is mainly a regression bug fix release.

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


dracut-055
==========

#### Bug Fixes

* **base:**
    *  add missing `str_replace` to `dracut-dev-lib.sh` ([148e420b](https://github.com/dracutdevs/dracut/commit/148e420be5b5809aa8d5033f47477573bbbf3e60))
    *  split out `dracut-dev-lib.sh` ([c08bc810](https://github.com/dracutdevs/dracut/commit/c08bc8109d4c43beacfa4bcdc20a356102da6d02))
* **bash:**  minor cleanups ([9355cb8e](https://github.com/dracutdevs/dracut/commit/9355cb8ea5024533210067373657dc337d63ecb9))
* **dash:**  minor cleanups ([f4ea5f87](https://github.com/dracutdevs/dracut/commit/f4ea5f8734c4636f7d6db78da76e9525beb9a0ac))
* **dracut:**  pipe hardlink output to `dinfo` ([0a6007bf](https://github.com/dracutdevs/dracut/commit/0a6007bf4f472565d2c0c205a56edea7ba3e3bc3))
* **dracut-functions:**  get_maj_min without get_maj_min_cache_file set ([a277a5fc](https://github.com/dracutdevs/dracut/commit/a277a5fc7acc0a9e8d853f09671495f9d27645c1))
* **dracut-util:**  print error message with trailing newline ([b9b6f0ee](https://github.com/dracutdevs/dracut/commit/b9b6f0ee5b859a562e46a8c4e0dee0261fabf74d))
* **fs-lib:**  install fsck utilities ([12beeac7](https://github.com/dracutdevs/dracut/commit/12beeac741e4429146a674ef4ea9aa0bac10364b))
* **install:**
    *  configure logging earlier ([5eb24aa2](https://github.com/dracutdevs/dracut/commit/5eb24aa21d3ee639f869c2e363b3fb0b98be552b))
    *  sane default --kerneldir ([c1ab3613](https://github.com/dracutdevs/dracut/commit/c1ab36139d416e580e768c29f2addf7ccbc2c612), closes [#1505](https://github.com/dracutdevs/dracut/issues/1505))
* **integrity:**  require ALLOW_METADATA_WRITES to come from EVM config file ([b12d91c4](https://github.com/dracutdevs/dracut/commit/b12d91c431220488fecf7b4be82427e3560560cb))
* **mksh:**  minor cleanups ([6c673298](https://github.com/dracutdevs/dracut/commit/6c673298f36990665467564e6114c9ca2530f584))
* **squash:**  don't mount the mount points if already mounted ([636d6df3](https://github.com/dracutdevs/dracut/commit/636d6df3134dde1dac72241937724bc59deb9303))
* **warpclock:**  minor cleanups ([7d205598](https://github.com/dracutdevs/dracut/commit/7d205598c6a500b58b4d328e824d0446276f7ced))

#### Features

* **dracut.sh:**  detect running in a container ([7275c6f6](https://github.com/dracutdevs/dracut/commit/7275c6f6a0f6808cd939ea5bdf1244c7bd13ba44))
* **install:**  add default value for --firmwaredirs ([4cb086fa](https://github.com/dracutdevs/dracut/commit/4cb086fa2995799b95c0b25bc9a0cf72ba3868ea))

#### Contributors

- Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Jóhann B. Guðmundsson <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Marcos Mello <marcosfrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Lars Wendler <polynomial-c-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
- Stefan Berger <stefanb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
- Tomasz Paweł Gajc <tpgxyz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


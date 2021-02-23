From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 053
Date: Tue, 23 Feb 2021 16:22:20 +0100
Message-ID: <e2eb2c36-7d2c-3628-9396-6e2e74d42c57@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614093958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c2lcwgkxwQJwMevh0r3auDj5D1n63KTU5EMfUjfYaEc=;
        b=S1spEgbnYV023Qm+SgBQr3bYS+ChlqWDjMCV9gXc2/umiu6AhSKqg44yOEQ71kpClr/1JM
        oR6l3Yn5nI9aWacWa5NUfSU/YuL0g7URIeOnKPZ33juaaJl39C9MYpMUw6QZUmb707eHge
        rml+bpUqPD9sG8wlttNzNIWLX9LJsF0=
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a regression bug fix dracut version.

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

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS.md


Rendered view: https://github.com/dracutdevs/dracut/blob/master/NEWS.md

dracut-053
==========

#### Bug Fixes

* **dracut.sh:**
  *  unfreeze /boot on exit
     ([d87ae137](https://github.com/dracutdevs/dracut/commit/d87ae13721d04a8a2192d896af224ac6965caf70))
  *  proper return code for inst_multiple in dracut-init.sh
     ([d437970c](https://github.com/dracutdevs/dracut/commit/d437970c013e3287de263a1e60a117b15239896c))
* **fcoe:**
  *  rename rd.nofcoe to rd.fcoe
     ([6f7823bc](https://github.com/dracutdevs/dracut/commit/6f7823bce65dd4b52497dbb94892b637fd06471a))
  *  rd.nofcoe=0 should disable fcoe
     ([805b46c2](https://github.com/dracutdevs/dracut/commit/805b46c2a81e04d69fc3af912942568516d05ee7))
* **i18n:**
  *  get rid of `eval` calls
     ([5387ed24](https://github.com/dracutdevs/dracut/commit/5387ed24c8b33da1214232d57ab1831e117aaba0))
  *  create the keyboard symlinks again
     ([9e1c7f3d](https://github.com/dracutdevs/dracut/commit/9e1c7f3deadd387adaa97b189593b4ba3d7c6d5a))
* **network-manager:**
  *  run as a service if systemd module is present
     ([c17c5b76](https://github.com/dracutdevs/dracut/commit/c17c5b7604c8d61dd1c00ee22d44c3a5d7d6dfee))
  *  rework how NM is started in debug mode
     ([34c73b33](https://github.com/dracutdevs/dracut/commit/34c73b339baa025dfd8916379c4d191be34a8af5))
* **drm:**  skip empty modalias files in drm module setup
     ([c3f24184](https://github.com/dracutdevs/dracut/commit/c3f241849de6434d063ef92e6880f6b0335c1800))

#### Contributors

- Lukas Nykryn <lnykryn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- Andrew J. Hesford <ajh-LfGgLkH2qHZg9hUCZPvPmw@public.gmane.org>
- Evgeni Golov <evgeni-tXd1fo8541I@public.gmane.org>
- Jóhann B. Guðmundsson <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Sergei Iudin <tsipa740-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
- Tomasz Paweł Gajc <tpgxyz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


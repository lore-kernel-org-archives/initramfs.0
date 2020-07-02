From: "Carlos Pinto" <pilltime-90e5XUkte7Zhl2p70BpVqQ@public.gmane.org>
Subject: Bug in a resume module script
Date: Thu, 02 Jul 2020 11:23:52 +0000
Message-ID: <175ba0b769057cf5e5ee444df124f3d9@teknik.io>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
dkim-signature: v=1; a=rsa-sha256; d=teknik.io; s=dkim;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=XrHYpaFHb/0Tlwnuz2z6gflB5uGO0U0aWo61qdIc0JI=;
        b=M6NX30HZ3b9LFsVHGNJhojYRSDhIKxzL6O00kQWtHhBtuPEDyzWkVhDXSMmWXh49wZNC1a4f8avwPN0acb7fatzGrj6S1Vs75RMnL4PyioBq19ScjFS1vqQfUaehOSfHCku0GzpMPWUB0VLhVDPf1KrferzoSrwlXkYedStvzfnnrsUUKDznxeK6ra0fZc/szCCSS+riz8tZL9LpEaS6vAW3xZHd6HuVBrtlyyOCJJ/mtlqmn66irbCLTn
        PjLtKOmBJbEYUz7mrb7PcLDQk8ybwWTo0jYKvfwsYux/6GGpFBqce5iWsWrFXgAVKlKGgfxliK77UIZh/MnFDiIAJRyg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hey everyone,=0A=0AI'm using Void Linux and if I have the resume module a=
ctivated, I get a message early on boot saying:=0A  //lib/dracut/hooks/pr=
e-mount/10-resume.sh: line 20: echo: write error: Invalid argument=0A=0AI=
 managed to fix this with a small adjustment to /usr/lib/dracut/modules.d=
/95resume/resume.sh:=0A  20c20=0A  < echo "${maj%,}:$min"> /sys/power/res=
ume)=0A  ---=0A  > echo $maj:$min | tr -d , > /sys/power/resume)=0A=0ANev=
er had to submit a bug to such a big project, so I'm not sure if this is =
the place to do it.


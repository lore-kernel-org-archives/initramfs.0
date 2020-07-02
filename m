From: "Carlos Pinto" <pilltime-90e5XUkte7Zhl2p70BpVqQ@public.gmane.org>
Subject: Bug in a resume module script
Date: Thu, 02 Jul 2020 12:00:20 +0000
Message-ID: <a4b9e734225d5e25ce7c2b2cd157bb2a@teknik.io>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
dkim-signature: v=1; a=rsa-sha256; d=teknik.io; s=dkim;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=XrHYpaFHb/0Tlwnuz2z6gflB5uGO0U0aWo61qdIc0JI=;
        b=MlHFdT2cC4itGkXcpGfp5wVvnlqiZfKxv8bPi/5jfYCDSl5ZaQCi+qWBujUmu5miy2kxZT0nFjYwFt+Vkn0A+cMA6Sa7tfZprVg/F5oEkoYq0cIi8aZNWrtMHiy7SUthOsYf51WGZwabpz3hRkVA7VkpYNRHx0evqys+bKrwg5TYVoXfEBY5Sc3HH06jRFMowtuAtGphlLdz9YyQN8SDVPoYApND6MqBz4T66y2sXtcGNLvcskt6NLaHS5
        +E6JJOgBLTpNJwH+8PST55TkFob4BI4yGr32kQKjO4SkUzpvhRZSdDaEX5r+GKYYaSSQVltUyz54QNQGjLW4fL0ZCHTw==
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


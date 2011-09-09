From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: question - minimal mdadm version
Date: Fri, 09 Sep 2011 22:02:24 +0200
Message-ID: <4E6A70D0.2030402@ziu.info>
References: <1315261048-19544-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315261048-19544-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I've been experimenting with a bit different approach, but trying to be 
mdadm version-neutral kinda ties the hands.

Is there any minimal version that must be supported ? I was thinking 
about 3.0, but that's probably far too new - and current code assumes 
pre-udev/container version can be present.

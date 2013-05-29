From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [Dracut PATCH] usrmount: Fix miss-detection of btrfs subvolumes.
Date: Wed, 29 May 2013 10:29:09 +0100
Message-ID: <ko4hp0$l0i$1@ger.gmane.org>
References: <1367597765-26656-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367597765-26656-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Colin Guthrie at 03/05/13 17:16 did gyre and gimble:
> This causes the root FS options to be incorrectly applied to to /usr
> In some cases this can cause boot failure e.g. due to and XFS /usr
> not supporting the 'acl' option from the ext4 root FS.
> 
> https://bugs.mageia.org/show_bug.cgi?id=9884


For the sake of history, committed as
d57b8833c43d297004d8393d8e54a2ab2655a899

Thanks :)

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/

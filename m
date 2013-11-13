From: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Wed, 13 Nov 2013 11:29:21 +0600
Message-ID: <52830E31.30107@gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iyyijlbwiKFAkq01XtHhIQzraZy6R7MwNRSTcrYIVaA=;
        b=hx31ey1ZKamMeIZkEXhQYttsHqvnZObcdy5zMjt7zeIjbIRc0ZWz4lAsYbEevEJ1YJ
         jtjdUn8fht45ZhaJoNaEe9lNOKO/Um1cW35h7jw5AQ7jCxmJfM8cEEfwnUTG3KuNkXHe
         M724juUxMPehzNbUMcfTJDx4zo7LOewbrPu3jA98/6T2AZEpLgdzaD8zNr62VCE+DNr7
         8gHZCN1YbPpwtFcdkSNG+b521G3b25pnTv6iIJliTBchiNYcBevQc/NbOdkuAXbU7/wS
         PcPjUyW2OnkFApuRT830tBYx33lxSk+0w4JDdGU3ijpDfK8diSoEB1aetrr5tvVSJXAO
         +QpA==
In-Reply-To: <1384249140-20683-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Colin Guthrie wrote:
> Hi,
>
> In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
> unable to enter their encrypted root password via a wireless keyboard
> connected with a Logitech, Inc. Unifying Receiver.

Just in case, I do have the same model of wireless keyboard and will 
validate the bug (for the LUKS-password case) later today on my laptop.

The keyboard does work on my desktop, but there's no initramfs there.

-- 
Alexander E. Patrakov

From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut [PATCH] Parameter expansion occurs before command evaluation.
Date: Fri, 30 Sep 2011 13:35:56 +0200
Message-ID: <4E85A99C.8030905@redhat.com>
References: <4E7C9F7F.7010601@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E7C9F7F.7010601-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 23.09.2011 17:02, John Reiser wrote:
> Bash shell expands all ${parameter} before evaluating a command.
> For multiple declarations and assignments within the same 'local' command,
> then new variables or new values that appear towards the left
> do not affect parameter expansion towards the right.
> 


pushed to temporary http://git.surfsite.org/dracut.git

Thanks!

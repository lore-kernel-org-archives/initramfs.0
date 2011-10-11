From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [PATCH 1/2] bash3 compat patch
Date: Tue, 11 Oct 2011 10:53:44 +0200
Message-ID: <4E940418.6080102@ziu.info>
References: <1318283885-1792-1-git-send-email-soltys@ziu.info> <1318283885-1792-2-git-send-email-soltys@ziu.info> <j70q7d$ldn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j70q7d$ldn$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11.10.2011 09:11, WANG Cong wrote:
>
> Interesting function, if i understand it correctly, it parallelizes
> the stream into two so that can speed up the pattern filtering?
>
> My brain spins...
>
It was added by John Reiser (see commit 
d23159a69c818274486f1287ba6267b96f3febb7).

I just moved the main body into a function, so it's easily eval'able - 
in order to avoid {var}>& construct. As a side effect, it's 
(subjectively) a bit easier to read.

 From what I can see, the outermost parentheses along with related 
_merge fd could probably be removed. Not tested that though, no big 
difference either.

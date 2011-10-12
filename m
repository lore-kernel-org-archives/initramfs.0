From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] bash3 compat patch
Date: Wed, 12 Oct 2011 09:09:40 -0700
Message-ID: <4E95BBC4.2010106@bitwagon.com>
References: <1318283885-1792-1-git-send-email-soltys@ziu.info> <1318283885-1792-2-git-send-email-soltys@ziu.info> <j70q7d$ldn$1@dough.gmane.org> <4E940418.6080102@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E940418.6080102-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/11/2011 01:53 AM, Michal Soltys wrote:
> On 11.10.2011 09:11, WANG Cong wrote:
>>
>> Interesting function, if i understand it correctly, it parallelizes
>> the stream into two so that can speed up the pattern filtering?
>>
>> My brain spins...
>>
> It was added by John Reiser (see commit d23159a69c818274486f1287ba6267b96f3febb7).
> 
> I just moved the main body into a function, so it's easily eval'able - in order to avoid {var}>& construct. As a side effect, it's (subjectively) a bit easier to read.

It may be easier to read the latest version "in the small",
but the re-formatting has destroyed the visual parallelism of the code.
The two-dimensional presentation highlights both the similarities
and differences of the two sides, and this can be essential
for easy understanding of the global situation.  In particular,
the 2-D presentation makes it easier to trace the pipes
and to see the similarities of the two sides:
-----
       local merge side2
       ( ( local _f1 _f2
           while  read _f1; do   echo "$_f1"
               if read _f2; then echo "$_f2" 1>&${side2}; fi
           done \
           | nmf1     1>&${merge}    )           {side2}>&1 \
           | nmf1  )      {merge}>&1
-----

-- 

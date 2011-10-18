From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [PATCH] introduce optional job control
Date: Tue, 18 Oct 2011 12:23:58 +0200
Message-ID: <4E9D53BE.6090005@ziu.info>
References: <1318885310-12535-2-git-send-email-soltys@ziu.info> <j7ji8v$p6b$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j7ji8v$p6b$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 18.10.2011 11:52, WANG Cong wrote:
> On Mon, 17 Oct 2011 23:01:50 +0200, Michal Soltys wrote:
>
>> Option --ctty will optionally add setsid binary to dracut's image.
>>
>> During runtime, if rd.ctty is set and is a character device, emergency
>> shells will be spawned with job control.
>>
>
> Hi,
>
> Please also update dracut.8.xml.
>
Ah, right.

Actually, there's another fix to do, so I'll just prepare v2 with all 
the stuff.

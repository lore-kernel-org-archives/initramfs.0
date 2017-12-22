From: si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC dracut 1/1] unexpected boot failure due to races between
 iscsistart for multiple interfaces
Date: Thu, 21 Dec 2017 22:20:40 -0800
Message-ID: <ed8d3e69-1e22-356e-efd6-a2f4b277d43b@oracle.com>
References: <1512418484-3948-1-git-send-email-cathy.zhou@oracle.com>
 <9326cbf7-b533-4cf2-baac-6699ee5dc4d6@googlegroups.com>
 <a759d3d3-5c21-4a28-a205-1390561abc2a@googlegroups.com>
 <213a0c37-587e-7375-341b-680faa752cde@oracle.com>
 <B00ADBFE-F00B-4BCD-A7FE-0FEFE2A64F9D@gmail.com>
 <29030bdf-e65a-dc01-ee1e-48498dafdc8f@oracle.com>
 <C94AC86B-C41E-4B3A-B375-3405E25BD45D@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=T9mxPh1Am6C+KBuLhT9vmeCkl6qj6woobLaj4BubFrk=;
 b=J2AB8vi8T+zxqsUgHDkgmnQPuAGYIT7mmMl59BMTO42jaeD+Id/6BifMP9Y5v8aZ0HLO
 lXAZyg6AXexr5rywoyP7+M+vemIQp33S9GJo54wiynmsHjaak1GA88P6KCO5zs5zQlnI
 T7g7BNb3NXPfg2Q/kbj8T/dcfyC5S4pjxLbW/OPCeytQy0QKHfd7qX9BqWRqFGwb5DZd
 kdR0ZaW/4aSI2cnGyu2c87t6is4hPdcbY9pTmpqhZ+zjTkeRV6C4bWkArZhVcwWQAAkl
 1tLNDTuVv8MfsM94Dbmm22gsBvDXUJgMXukVdzqbPu7BuUkpcdQvBorzRi634eADEzv2 fA== 
In-Reply-To: <C94AC86B-C41E-4B3A-B375-3405E25BD45D-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Lee Duncan <leeman.duncan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: open-iscsi <open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On 12/21/2017 05:03 PM, Lee Duncan wrote:
> That seems like the wrong approach to me. iscsiadm/iscsid were designed for this. The iscsistart script was designed for sing, one-shot use, and is not used in dracut now at all, AFAIK.
The latter is not true, unfortunately. Distros like OpenSUSE and SLES 
does move to iscsiadm to manage sessions for their dracut fork,  
however, the upstream dracut still uses iscsistart now. The context is 
that it might take a while for the SUSE patches to be upstream ready, 
hence we need an interim that addressed the particular iSCSI boot issue 
when dealing with multiple interfaces, until iscsiadm dracut patches 
become avail. Please see:

https://www.spinics.net/lists/linux-initramfs/msg04502.html
https://www.spinics.net/lists/linux-initramfs/msg04505.html
https://www.spinics.net/lists/linux-initramfs/msg04506.html


Thanks,
-Siwei

>
> —
> Lee Duncan
>

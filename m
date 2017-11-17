From: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Fri, 17 Nov 2017 10:34:49 -0800
Message-ID: <0a3f48bc-d110-e163-22a5-795c2d554297@oracle.com>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
 <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
 <1510751540.17501.55.camel@suse.de>
 <d15c3567-509e-7bcd-62e9-6930b203753b@oracle.com>
 <08997d6f-0b94-af50-d407-0c4803a70697@oracle.com>
 <1510837385.10823.6.camel@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510837385.10823.6.camel-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>, si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Martin,

Thanks. I will take a detail look of the diff you sent. But a brief=20
browse of it raised one question: assuming we solely use iscsid and=20
iscsiadm instead of iscsistart, wouldn't iscsid be started outside of=C2=A0=
=20
iscsiroot.sh? Otherwise, the restart/stop/start of iscsid for one=20
interface could interfere with another iscsiroot instance for another=20
interface?

Thanks
- Cathy

On 11/16/2017 5:03 AM, Martin Wilck wrote:
> On Wed, 2017-11-15 at 11:47 -0800, si-wei liu wrote:
>> On 11/15/2017 11:17 AM, Cathy Zhou wrote:
>> Please let us know if it's desirable to keep iscsid around, or we
>> can
>> post patch to make iscsistart manage iscsid instead (or leave iscsid
>> disabled).
> IMO dracut should ditch iscsistart and work cleanly with iscsid and
> iscsiadm. We have some patches in openSUSE that unfortunately never
> quite hit upstream, see e.g. here:
>
> https://github.com/danimo/dracut/commit/5ac36324e3daa897152929e67718250
> 1b9d20c1f#diff-6dcf84c45218f1adf71f53a6cd80b5c9
>
> Martin
>

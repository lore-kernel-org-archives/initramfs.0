From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 15:40:39 +0200
Message-ID: <4A292057.704@bfh.ch>
References: <4A2907E7.1080008@bfh.ch> <4A292005.4000404@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A292005.4000404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Harald Hoyer wrote:
> On 06/05/2009 01:56 PM, Seewer Philippe wrote:
> ...
> 
>> +incol2() {
>> + local dummy check;
>> + local file="$1";
>> + local str="$2";
>> +
>> + [ -z "$file" ] && return;
>> + [ -z "$str" ] && return;
>> +
>> + while read dummy check ; do
>> + [ "$check" = "$str" ] && return 0
>> + done < $file
>> + return 1
>> +}
> 
> This better has to be:
> 
> - while read dummy check ; do
> + while read dummy check restofline; do

Aye. copy/paste mistake. sorry about that


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

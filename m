From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] dracut-gencmdline: emit "resume="
Date: Thu, 29 Oct 2009 10:06:09 +0000
Message-ID: <4AE96911.6070207@tuffmail.co.uk>
References: <4AE95FEB.7090304@tuffmail.co.uk> <4AE96826.4010908@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1f1/XajkeEjsCpu146r9wIxcLT/xYjqyC8J0ufOj2tw=;
        b=pT7LeYakFnBQeSW5D0uVXJwYUwxu+HoBm0/oyTj6d/0XBwcEKmaxawYNDCQQAjkLAT
         F8VVjKPbPDzu0oYm2U6hpN8raWVna7km9PLZfmkQYzzOPOU5U8j1LyC2XiITtDQ6Lga7
         tUgUKrebpyT0f3pdbMpKa/reujgSiEa+QB/JA=
In-Reply-To: <4AE96826.4010908-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer wrote:
> On 10/29/2009 10:27 AM, Alan Jenkins wrote:
>> I haven't tested resume either way, but I can't imagine it working if
>> we don't tell it which device to use :-).
>>
>> diff --git a/dracut-gencmdline b/dracut-gencmdline
>> index 978f5a2..625546c 100755
>> --- a/dracut-gencmdline
>> +++ b/dracut-gencmdline
>> @@ -711,5 +711,9 @@ if [ -n "$rootdev" ]; then
>>       echo -n "root=$rootdev "
>>   fi
>>
>> +if [ -n "$swsuspdev" ]; then
>> +    echo -n "resume=$swsuspdev "
>> +fi
>> +
>>   echo
>>   # vim:ts=8:sw=4:sts=4:et
>>
>>
>
> well, it works, because it finds the suspend signature :-)

Ah, I missed the rules file.  Clearly a failure of imagination on my
part.  Colour me impressed :).

Ta
Alan

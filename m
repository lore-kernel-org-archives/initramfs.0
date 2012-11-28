From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] add function getargnum
Date: Wed, 28 Nov 2012 13:51:44 +0800
Message-ID: <50B5A670.6040109@redhat.com>
References: <20121126023847.GA6884@localhost.localdomain> <20121127222846.GF6964@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121127222846.GF6964-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 11/28/2012 06:28 AM, Vivek Goyal wrote:

> On Mon, Nov 26, 2012 at 10:38:47AM +0800, Dave Young wrote:
>>
>>
>> For cmdline argument with numeric value, add a new function getargnum
>> It will get proper value with default value as $1, max value as $2.
>> valid result will be echo to stdout, for nul or value not valid it will just
>> echo the default value.
>>
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/99base/dracut-lib.sh |   19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> --- dracut.orig/modules.d/99base/dracut-lib.sh
>> +++ dracut/modules.d/99base/dracut-lib.sh
>> @@ -167,6 +167,25 @@ getargbool() {
>>      return 0
>>  }
>>  
>> +# getargnum <defaultval> <maxval> <args...>
> 				      ^^^^^^
> Is above one arg or multiple args. I thought in one call we will resolve
> the value of one parameter?


It is one arg. will s/args.../arg

> 
>> +# Will echo the arg if it's in range [0 - maxval].
> 
> You might want to consider passing in minval instead of assuming it
> is always 0. It just makes function more generic.


Make sense. I would like to assume the arg as a number >=0 even with the
minval added which means minval should be >=0.


> 
> Thanks
> Vivek
> 
>> +# If it's not set or it's not valid, will set it <defaultval>.
>> +getargnum() {
>> +    local _b
>> +    unset _b
>> +    local _default
>> +    local _max
>> +    _default=$1; shift
>> +    _max=$1; shift
>> +    _b=$(getarg "$@")
>> +    [ $? -ne 0 -a -z "$_b" ] && _b=$_default
>> +    if [ -n "$_b" ]; then
>> +        [[ "$_b" =~ ^[0-9]+$ ]] && _b=$(($_b)) && \
>> +        [[ $_b -ge 0 && $_b -le $_max ]] && echo $_b && return
>> +    fi
>> +    echo $_default
>> +}
>> +
>>  _dogetargs() {
>>      debug_off
>>      local _o _found _key



-- 
Thanks
Dave

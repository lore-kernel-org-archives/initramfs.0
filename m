From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH 2/2] crypt: Only write udev rules to unlock when the device
 is added
Date: Tue, 28 Jan 2014 15:41:52 +0000
Message-ID: <52E7CFC0.4020205@colin.guthr.ie>
References: <1388093183-19045-1-git-send-email-colin@mageia.org> <1388093183-19045-2-git-send-email-colin@mageia.org> <52E7C138.4060909@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52E7C138.4060909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Harald Hoyer at 28/01/14 14:39 did gyre and gimble:
> On 12/26/2013 10:26 PM, Colin Guthrie wrote:
>> It seems that when the device is unlocked, it will trigger a change
>> event which in turn re-writes the settled job which was diligently
>> removed after it was run.
>>
>> Due to the previous fix, this isn't crazy important as the triggered
>> job should exit, but avoiding this in the first place is still
>> desirable.
>> ---
>>
>> Note, I'm not sure if this is wise or not. The previous patch alone
>> fixes the issue, so this is just an efficiency saving. It might be
>> that this is needed - e.g. if you have any encrypted volume on top
>> of some other mapped device such as RAID, so please only apply this
>> patch if you are sure it will not cause regressions!!
>>
>>
>>
>>  modules.d/90crypt/parse-crypt.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
>> index a6b5252..cfa6ac9 100755
>> --- a/modules.d/90crypt/parse-crypt.sh
>> +++ b/modules.d/90crypt/parse-crypt.sh
>> @@ -10,7 +10,7 @@ if ! getargbool 1 rd.luks -d -n rd_NO_LUKS; then
>>  else
>>      {
>>          echo 'SUBSYSTEM!="block", GOTO="luks_end"'
>> -        echo 'ACTION!="add|change", GOTO="luks_end"'
>> +        echo 'ACTION!="add", GOTO="luks_end"'
>>      } > /etc/udev/rules.d/70-luks.rules.new
>>  
>>      LUKS=$(getargs rd.luks.uuid -d rd_LUKS_UUID)
>>
> 
> Hmm, dm-devices get only active on "change" :-/ So, if a crypt device is on
> another dm-device, the rule would not trigger anymore.


Cool, I was unsure about this one as mentioned in the message, so thanks
for clarifying. It did solve things in a test case I had but I did
wonder if it would cause regressions elsewhere!

Thanks!

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/

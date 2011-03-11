From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] cryptroot-ask: check that plymouth is running before use
Date: Fri, 11 Mar 2011 12:43:51 +0300
Message-ID: <AANLkTiktfbVu4SqV0Y+2=GQ3iGJjTGKXVJDHr0mEAMjf@mail.gmail.com>
References: <1299797644-6951-1-git-send-email-arvidjaar@gmail.com>
	<4D79E052.6020806@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b9d50b4af8f049e31cc09
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8eB8BwUmLPEILTvR28xhJZCHA7e+yjQbXuRiKkNWuTI=;
        b=qv0D0oOWkTscasEUrO9jsZ6bmjvKOegIODt6ltlx10r3UkhsOFTZQBuwhIebnppCX1
         SZlLtI9cCQ3LbiXY9x20AjaLBZhTgg0M8YfMWiok6DDli0NZs+eVZPXAJFZpzX1UTEOT
         k1OPvPMsnizefZA72XFUlS+mv9o8Q4ZRGc0Bk=
In-Reply-To: <4D79E052.6020806-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--0016363b9d50b4af8f049e31cc09
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2011 at 11:41 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Am 10.03.2011 23:54, schrieb Andrey Borzenkov:
>> Otherwise there is no way to skip pasword prompt. --has-active-vt
>> seems to correctly catch also the case when plymouthd is started
>> but splash is disabled.
>>
>> Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> ---
>> =A0modules.d/90crypt/cryptroot-ask.sh | =A0 =A05 ++---
>> =A01 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryp=
troot-ask.sh
>> index 5150688..9c99ccc 100755
>> --- a/modules.d/90crypt/cryptroot-ask.sh
>> +++ b/modules.d/90crypt/cryptroot-ask.sh
>> @@ -80,9 +80,8 @@ if [ -n "$(getarg rd.luks.key)" ]; then
>> =A0 =A0 =A0rmdir "$mntp"
>> =A0 =A0 =A0unset mntp keypath keydev
>> =A0else
>> - =A0 =A0# Prompt for password with plymouth, if installed.
>> - =A0 =A0# Should we check if plymouthd is running?
>> - =A0 =A0if [ -x /bin/plymouth ]; then
>> + =A0 =A0# Prompt for password with plymouth, if installed and running.
>> + =A0 =A0if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
>> =A0 =A0 =A0 =A0 =A0prompt=3D"Password [$device ($luksname)]:"
>> =A0 =A0 =A0 =A0 =A0if [ ${#luksname} -gt 8 ]; then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sluksname=3D${sluksname##luks-}
>
> Very nice! Thank you!
>

I think attached patch still makes sense in addition to (or probably
even instead of) this one.

--0016363b9d50b4af8f049e31cc09
Content-Type: text/x-patch; charset=US-ASCII; name="dracut-plymouth-password-retries.patch"
Content-Disposition: attachment; 
	filename="dracut-plymouth-password-retries.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gl4x5frs0

RnJvbTogQW5kcmV5IEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT4KU3ViamVjdDogW1BB
VENIXSBjcnlwdG9yb290LWFzazogbGltaXQgbnVtYmVyIG9mIHBseW1vdXRoIHBhc3N3b3JkIHJl
cXVlc3RzCgpTZXQgbnVtYmVyIG90IHJldHJpZXMgdG8gNSB0byBhbGlnbiB3aXRoIG5vbi1wbHlt
b3V0aCBjYXNlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdt
YWlsLmNvbT4KCi0tLQogbW9kdWxlcy5kLzkwY3J5cHQvY3J5cHRyb290LWFzay5zaCB8ICAgIDIg
Ky0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL21vZHVsZXMuZC85MGNyeXB0L2NyeXB0cm9vdC1hc2suc2ggYi9tb2R1bGVzLmQv
OTBjcnlwdC9jcnlwdHJvb3QtYXNrLnNoCmluZGV4IDljOTljY2MuLjRhNjVjMjMgMTAwNzU1Ci0t
LSBhL21vZHVsZXMuZC85MGNyeXB0L2NyeXB0cm9vdC1hc2suc2gKKysrIGIvbW9kdWxlcy5kLzkw
Y3J5cHQvY3J5cHRyb290LWFzay5zaApAQCAtOTIsNyArOTIsNyBAQCBlbHNlCiAgICAgICAgICMg
ZmxvY2sgYWdhaW5zdCBvdGhlciBpbnRlcmFjdGl2ZSBhY3Rpdml0aWVzCiAgICAgICAgIHsgZmxv
Y2sgLXMgOTsgCiAgICAgICAgICAgICAvYmluL3BseW1vdXRoIGFzay1mb3ItcGFzc3dvcmQgXAot
ICAgICAgICAgICAgICAgIC0tcHJvbXB0ICIkcHJvbXB0IiBcCisgICAgICAgICAgICAgICAgLS1w
cm9tcHQgIiRwcm9tcHQiIC0tbnVtYmVyLW9mLXRyaWVzPTUgXAogICAgICAgICAgICAgICAgIC0t
Y29tbWFuZD0iL3NiaW4vY3J5cHRzZXR1cCBsdWtzT3BlbiAtVDEgJGRldmljZSAkbHVrc25hbWUi
CiAgICAgICAgIH0gOT4vLmNvbnNvbGUubG9jawogICAgICAgICAKLS0gCnRnOiAoNjY0MTkzZS4u
KSB1cHN0cmVhbS9wYXNzd2QtcmV0cmllcyAoZGVwZW5kcyBvbjogdXBzdHJlYW0vY3J5cHRvLXBs
eW1vdXRoKQo=
--0016363b9d50b4af8f049e31cc09--

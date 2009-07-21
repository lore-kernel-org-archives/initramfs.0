From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 07/14] remove partitions from raid devices before they
 are used for something else
Date: Tue, 21 Jul 2009 11:32:22 +0200
Message-ID: <4A658B26.2000605@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com> <1247676646-3837-8-git-send-email-harald@redhat.com> <4A64A9DB.6060701@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010306060107060104050707"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A64A9DB.6060701-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Jacek Danecki <Jacek.Danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a cryptographically signed message in MIME format.

--------------ms010306060107060104050707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/20/2009 07:31 PM, Jacek Danecki wrote:
> Harald Hoyer wrote:
>> diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules
>> b/modules.d/90dmraid/61-dmraid-imsm.rules
>> index 3b3eb7f..6bcf052 100644
>> --- a/modules.d/90dmraid/61-dmraid-imsm.rules
>> +++ b/modules.d/90dmraid/61-dmraid-imsm.rules
>> @@ -12,4 +12,10 @@ ENV{ID_FS_TYPE}=3D=3D"*_raid_member", \
>> TEST!=3D"/tmp/.dmraid_scan-%k", \
>> RUN+=3D"/bin/sh -c '>/tmp/.dmraid_scan-%k; /bin/ln -fs /sbin/dmraid_sc=
an
>> /initqueue/dmraid_scan.sh'"
>>
>> +
>> +ENV{ID_FS_TYPE}=3D=3D"*_raid_member", \
>> + TEST!=3D"/tmp/.dmraid_scan-%k", \
>> + ATTR{partition}!=3D"?*", \
>> + RUN+=3D"/sbin/partx -d $env{DEVNAME}"
>
> /sbin/partx is missing in image created by dracut-0.5

thx, fixing



--------------ms010306060107060104050707
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKYjCC
BS0wggMVoAMCAQICAwbD1jANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wOTA0
MjIxMzEzNDFaFw0xMTA0MjIxMzEzNDFaMDkxFTATBgNVBAMTDEhhcmFsZCBIb3llcjEgMB4G
CSqGSIb3DQEJARYRaGFyYWxkQHJlZGhhdC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDcYRNZNcpUzmHaTtZXCPoLNJW7g0iD9Oo8BgGQDmLQPEIw05SINqk5f+YvIvoo
a85lze7+bfhDg3MJmcTu5C8OKnej+GfZV8qVnLLg0F1d2pSc1oKTarasUN+BSNTn8mc+BlKM
jEF5I4faGGATEgM/1pkscRofiQoWDvMAHsD/UVErVTKzLT03vczQutUYfHJuGJohXdJubQdJ
C2AyXqLJBkvns+0pNGB7qMHTVPWm9+v1I18iz0sXe5hOsTMIJFFCkia41ZVpGkwU/9ITVLtY
E+UmW897Tpi4uUE5YsPVoA3u5YIFlQFkwW1Zp9bAlmFGNlUUe2UEvpTAWWVte+qBAgMBAAGj
gf0wgfowDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNl
cnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcw
QAYDVR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMD
BglghkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5j
YWNlcnQub3JnMBwGA1UdEQQVMBOBEWhhcmFsZEByZWRoYXQuY29tMA0GCSqGSIb3DQEBBQUA
A4ICAQCh+mhGXDvGVDStE8cUUqnDjLL6JOcsJIrfQV/aqEQMSwD3CijxO1Q1GAp0520W71Bk
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
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGw9YwCQYFKw4DAhoF
AKCCAegwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDkwNzIx
MDkzMjIyWjAjBgkqhkiG9w0BCQQxFgQU3XxyKw1cP8TPX6AjWian6o/RJV4wXwYJKoZIhvcN
AQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAw
eTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIw
IAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBw
b3J0QGNhY2VydC5vcmcCAwbD1jCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMH
Um9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBD
ZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5v
cmcCAwbD1jANBgkqhkiG9w0BAQEFAASCAQAjjeeWR2EIspYZcoQDFwW+igTXR4OHiXQTQxjs
3CYl4M6ecCYkvyA5HGgenxKUTRyD0Q3yYoYxn8/sCc959NYav85iok4gyP1I18uhMDYM7UwG
ifjnkXzTGfTo0x2W7yMyoIyAMBx5IaV4V3Xn3OtRfMNx2b3HyDYhi5ApzEBSen3GQ6lnLEV1
A838GS2Sr4N3I3yOZnVsGSIrDUBDiT293+T2VUHgFOyvBSZOn1idOseO39gUaEiNcS2ZelIF
Xq91nV64HIL8zOp7s4HdI8oi96OhQhtphh5rTqeAVufFDLgUc+k/BKHzLu8yiUB0GnkVv1FY
6UW+rYK+bLF5H9fJAAAAAAAA
--------------ms010306060107060104050707--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

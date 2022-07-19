From: Roberto Sassu <roberto.sassu@huawei.com>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 19 Jul 2022 06:55:50 +0000
Message-ID: <8e6a723874644449be99fcebb0905058@huawei.com>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
 <4bc349a59e4042f7831b1190914851fe@huawei.com>
 <20220615092712.GA4068@lxhi-065>
 <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
 <f82d4961986547b28b6de066219ad08b@huawei.com>
 <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jim Baxter <jim_baxter@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry

PiBGcm9tOiBKaW0gQmF4dGVyIFttYWlsdG86amltX2JheHRlckBtZW50b3IuY29tXQ0KPiBTZW50
OiBNb25kYXksIEp1bHkgMTgsIDIwMjIgODowOCBQTQ0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IA0KPiAqSmltIEJheHRlcioNCj4gDQo+IFNpZW1lbnMgRGlnaXRhbCBJbmR1c3RyaWVz
IFNvZnR3YXJlDQo+IEF1dG9tb3RpdmUgQnVzaW5lc3MgVW5pdA0KPiBESSBTVyBTVFMgQUJVDQo+
IFVLDQo+IFRlbC46ICs0NCAoMTYxKSA5MjYtMTY1Ng0KPiBtYWlsdG86amltLmJheHRlckBzaWVt
ZW5zLmNvbSA8bWFpbHRvOmppbS5iYXh0ZXJAc2llbWVucy5jb20+DQo+IHN3LnNpZW1lbnMuY29t
IDxodHRwczovL3N3LnNpZW1lbnMuY29tLz4NCj4gDQo+IE9uIDE4LzA3LzIwMjIgMTc6NDksIFJv
YmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4+IEZyb206IEppbSBCYXh0ZXIgW21haWx0bzpqaW1fYmF4
dGVyQG1lbnRvci5jb21dDQo+ID4+IFNlbnQ6IE1vbmRheSwgSnVseSAxOCwgMjAyMiA2OjM2IFBN
DQo+ID4+DQo+ID4+DQo+ID4+IEhlbGxvLA0KPiA+Pg0KPiA+PiBJIGhhdmUgYmVlbiB0ZXN0aW5n
IHRoZXNlIHBhdGNoZXMgYW5kIGRvIG5vdCBzZWUgdGhlIHhhdHRyIGluZm9ybWF0aW9uIHdoZW4N
Cj4gPj4gdHJ5aW5nIHRvIHJldHJpZXZlIGl0IHdpdGhpbiB0aGUgaW5pdHJhbWZzLCBkbyB5b3Ug
aGF2ZSBhbiBleGFtcGxlIG9mIGhvdw0KPiA+PiB5b3UgdGVzdGVkIHRoaXMgb3JpZ2luYWxseT8N
Cj4gPg0KPiA+IEhpIEppbSwgYWxsDQo+ID4NCj4gPiBhcG9sb2dpZXMsIEkgZGlkbid0IGZpbmQg
eWV0IHRoZSB0aW1lIHRvIGxvb2sgYXQgdGhpcy4NCj4gDQo+IEhlbGxvIFJvYmVydG8sDQo+IA0K
PiBUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2UsIEkgY2FuIHdhaXQgdW50aWwgeW91IGhhdmUg
bG9va2VkIGF0IHRoZSBwYXRjaGVzLA0KPiBJIGFza2VkIHRoZSBxdWVzdGlvbiB0byBtYWtlIHN1
cmUgaXQgd2FzIG5vdCBzb21ldGhpbmcgd3JvbmcgaW4gbXkNCj4gY29uZmlndXJhdGlvbi4NCj4g
DQo+ID4NCj4gPiBVaG0sIEkgZ3Vlc3MgdGhpcyBjb3VsZCBiZSBzb2x2ZWQgd2l0aDoNCj4gPg0K
PiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9vcGVuZXVsZXItDQo+IG1pcnJvci9rZXJuZWwvY29tbWl0
LzE4YTUwMmY3ZTNiMWRlN2I5YmEwYzcwODk2Y2UwOGVlMTNkMDUyZGENCj4gPg0KPiA+IGFuZCBh
ZGRpbmcgaW5pdHJhbXRtcGZzIHRvIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLiBZb3UgYXJlDQo+
ID4gcHJvYmFibHkgdXNpbmcgcmFtZnMsIHdoaWNoIGRvZXMgbm90IGhhdmUgeGF0dHIgc3VwcG9y
dC4NCj4gPg0KPiANCj4gDQo+IFRoYW5rIHlvdSwgSSBoYXZlIHRlc3RlZCB0aGF0IHBhdGNoIGJ1
dCB0aGUgcHJvYmxlbSByZW1haW5lZC4gSGVyZSBpcyBteQ0KPiBjb21tYW5kIGxpbmUsIEkgd29u
ZGVyIGlmIHRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZy4NCj4gDQo+IEtlcm5lbCBjb21tYW5kIGxp
bmU6IHJ3IHJvb3Rmc3R5cGU9aW5pdHJhbXRtcGZzIHJvb3Q9L2Rldi9yYW0wDQo+IGluaXRyZD0w
eDUwMDAwMDAwMCByb290d2FpdA0KDQpJdCBpcyBqdXN0IGluaXRyYW10bXBmcywgd2l0aG91dCBy
b290ZnN0eXBlPS4NCg0KUm9iZXJ0bw0K

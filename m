From: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 19 Jul 2022 12:26:02 +0000
Message-ID: <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
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
        <8e6a723874644449be99fcebb0905058@huawei.com>
 <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dc86769f-0ac6-d9f3-c003-54d3793ccfec-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>
Cc: "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <masahiroy-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Mimi Zohar <zohar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org" <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, "linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bug-cpio-mXXj517/zsQ@public.gmane.org" <bug-cpio-mXXj517/zsQ@public.gmane.org>, "zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Silviu Vlasceanu <Silviu.Vlasceanu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Dmitry Kasatkin <dmitry.kasatkin-hv44wF8Li91hl2p70BpVqQ@public.gmane.org>

PiBGcm9tOiBSb2IgTGFuZGxleSBbbWFpbHRvOnJvYkBsYW5kbGV5Lm5ldF0NCj4gU2VudDogVHVl
c2RheSwgSnVseSAxOSwgMjAyMiAxOjUxIFBNDQo+IE9uIDcvMTkvMjIgMDE6NTUsIFJvYmVydG8g
U2Fzc3Ugd3JvdGU6DQo+ID4+IFRoYW5rIHlvdSwgSSBoYXZlIHRlc3RlZCB0aGF0IHBhdGNoIGJ1
dCB0aGUgcHJvYmxlbSByZW1haW5lZC4gSGVyZSBpcyBteQ0KPiA+PiBjb21tYW5kIGxpbmUsIEkg
d29uZGVyIGlmIHRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZy4NCj4gPj4NCj4gPj4gS2VybmVsIGNv
bW1hbmQgbGluZTogcncgcm9vdGZzdHlwZT1pbml0cmFtdG1wZnMgcm9vdD0vZGV2L3JhbTANCj4g
Pj4gaW5pdHJkPTB4NTAwMDAwMDAwIHJvb3R3YWl0DQo+ID4NCj4gPiBJdCBpcyBqdXN0IGluaXRy
YW10bXBmcywgd2l0aG91dCByb290ZnN0eXBlPS4NCj4gDQo+IFdob2V2ZXIgd3JvdGUgdGhhdCBw
YXRjaCByZWFsbHkgZG9lc24ndCB1bmRlcnN0YW5kIGhvdyB0aGlzIHN0dWZmIHdvcmtzLiBJIGNh
bg0KPiB0ZWxsIGZyb20gdGhlIG5hbWUuDQoNCkhpIFJvYg0KDQpzdXJlbHksIEkgc2hvdWxkIGhh
dmUgYmVlbiBtb3JlIGNhcmVmdWwgaW4gY2hvb3NpbmcgdGhlIG5hbWUgb2YNCnRoZSBvcHRpb24u
DQoNCj4gVGVjaG5pY2FsbHksIGluaXRyYW1mcyBpcyB0aGUgbG9hZGVyLCBJLkUuICJpbml0IHJh
bWZzIi4gVGhlIGZpbGVzeXN0ZW0gaW5zdGFuY2UNCj4gaXMgY2FsbGVkICJyb290ZnMiIChoZW5j
ZSB0aGUgbmFtZSBpbiAvcHJvYy9tb3VudHMgd2hlbiB0aGUgaW5zYW5lIHNwZWNpYWwgY2FzZQ0K
PiB0aGUga2VybmVsIGFkZGVkIGRvZXNuJ3QgaGlkZSBpbmZvcm1hdGlvbiBmcm9tIHBlb3BsZSwg
bWFraW5nIGFsbCB0aGlzIGhhcmRlciB0bw0KPiB1bmRlcnN0YW5kIGZvciBubyBvYnZpb3VzIHJl
YXNvbikuDQoNCk9rLCB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4NCg0KPiByYW1mcyBhbmQg
dG1wZnMgYXJlIHR3byBkaWZmZXJlbnQgZmlsZXN5c3RlbXMgdGhhdCBDT1VMRCBiZSB1c2VkIHRv
IGltcGxlbWVudA0KPiByb290ZnMuIChMYXN0IEkgY2hlY2tlZCB0aGV5IHdlcmUgdGhlIG9ubHkg
cmFtIGJhY2tlZCBmaWxlc3lzdGVtcyBpbiBMaW51eC4pDQoNClllcywgdGhhdCBwYXJ0IEkgZ290
IGl0Lg0KDQo+IElmIGEgc3lzdGVtIGFkbWluaXN0cmF0b3Igc2F5cyB0aGV5J3JlIGdvaW5nIHRv
IGluc3RhbGwgeW91ciBzZXJ2ZXIncyByb290DQo+IHBhcnRpdGlvbiB1c2luZyB0aGUgInJlaXNl
cnhmcyIgZmlsZXN5c3RlbSwgSSB3b3VsZCBub3QgYmUgcmVhc3N1cmVkLg0KDQpEZWZpbml0ZWx5
Lg0KDQpbLi4uXQ0KDQo+IFAuUC5TLiBJZiB5b3Ugd2FudCB0byBydW4gYSBjb21tYW5kIG90aGVy
IHRoYW4gL2luaXQgb3V0IG9mIGluaXRyYW1mcyBvciBpbml0cmQsDQo+IHVzZSB0aGUgcmRpbml0
PS9ydW4vdGhpcyBvcHRpb24uIE5vdGUgdGhlIHJvb3Q9IG92ZXJtb3VudCBtZWNoYW5pc20gaXMN
Cj4gY29tcGxldGVseSBkaWZmZXJlbnQgY29kZSBhbmQgdXNlcyB0aGUgaW5pdD0vcnVuL3RoaXMg
YXJndW1lbnQgaW5zdGVhZCwgd2hpY2gNCj4gbWVhbnMgbm90aGluZyB0byBpbml0cmFtZnMuIEFn
YWluLCBzcGVjaWZ5aW5nIHJvb3Q9IHNheXMgd2UgYXJlIE5PVCBzdGF5aW5nIGluDQo+IGluaXRy
YW1mcy4NCg0KU29ycnksIGl0IHdhcyBzb21lIHRpbWUgYWdvLiBJIGhhdmUgdG8gZ28gYmFjayBh
bmQgc2VlIHdoeSB3ZSBuZWVkZWQNCmEgc2VwYXJhdGUgb3B0aW9uLiBNYXliZSBvbWl0dGluZyBy
b290PSB3YXMgaW1wYWN0aW5nIG9uIG1vdW50aW5nDQp0aGUgcmVhbCByb290IGZpbGVzeXN0ZW0u
IFdpbGwgZ2V0IHRoYXQgaW5mb3JtYXRpb24uDQoNCkludHVpdGl2ZWx5LCBnaXZlbiB0aGF0IHJv
b3Q9IGlzIGNvbnN1bWVkIGZvciBleGFtcGxlIGJ5IGRyYWN1dCwgaXQgc2VlbXMNCmEgc2FmZXIg
Y2hvaWNlIHRvIGhhdmUgYW4gb3B0aW9uIHRvIGV4cGxpY2l0bHkgY2hvb3NlIHRoZSBkZXNpcmVk
IGZpbGVzeXN0ZW0uDQoNClJvYmVydG8NCg==

Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF613E3F2
	for <initramfs@vger.kernel.org>; Wed, 19 Jun 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798914; cv=fail; b=CMfKk7G9eDgVrXxj4PPtMRPPa8Jm01nnxiLeuYkq2Y9F1dZbtFZRKnkBWGpjrGB6zsgExHrIYD4+LUWj/F5nyJGbtubEC/I9so/NhbC2E2LBk92YUDq+1eIGr12PBQgEdurkBRlkKnRB1hBkdlJfrE9mEw9YX8pElBX+F09jtcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798914; c=relaxed/simple;
	bh=Ct52jet9ZJfkTUinCI2ZS9CTkLhGgw4WoH/bh7LPG6o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s21LCTmnWW5CYEVhSu4vjuJEvH+vlsKkLuReQd2/yzXuDy24x5hIpWhFg5s3J2/cxZkAVHHmIQSXPAouFes2JEOqLD284GCs5zzGpEmCYOR1U//+0GmoMOIfizLoIUS9ySrdgOB/efLrpariOHtMrPXzANbS5o5w5zyuq3N3YmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOO4OQuI; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOO4OQuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOolFLu8lcWGaRzGuTsHScTSey2zRnqor85m1/D94bWihNkX3mPdmqcjTYU79N1XC3ADqA1r9JUyyLGazgDpYrbNCLguVZ87d2npdAwTI0oalErLYta3BR9aDeCbdao3hGIlJVSBp+5jNjuauO3e1gLiORH31X0F+HVHS9nbT0TJ4mEXXbH4uVrTBCQhXNK8ArnHGn98nLs6dvkIaximntPcmX6/rLUpTZPf/jI0mveR8CHA+V477Io3JMDbysua9rIjTbsHBfVFgmagOd0RELbzX2r/dG6xtxVsHGw92Pm7Edy2X5EKvAiHn6lnw5FU1B/Smwb8fz+5YSU0QX++Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct52jet9ZJfkTUinCI2ZS9CTkLhGgw4WoH/bh7LPG6o=;
 b=EmPEm14lZiLQCDOT4vVGGwn+5OOf9Q8qX2Dmhb5ge4nz0V3NgenawOpQPtOmwRFJiEMR+IjUC4kFJkesoecSov1E6WmhrRwPUqY9hG49AcU2q7X9uYcm7v8fIPRRyHRf7wX1tnNp29vbz3HOJWsPZEMljCSVSxzvanOCxTOftI9JCffGhROHqoIlpRknY+fb5rPc4++XITxc/UBvnejzY9bse4rvUyAYeQDj9QNI8X0ONHhmbzRtAd4vWmZdwpbx9xiWzJFBDZoq7PRii0R5iAyXZIPX1ipwm7U+wBBDTQvnGIZRjOeuvQSqL180zP+dEaHwbiLu4jaU6gupewj1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct52jet9ZJfkTUinCI2ZS9CTkLhGgw4WoH/bh7LPG6o=;
 b=jOO4OQuIlGmHV/R2XC5YFhctA/KMsRo7jbudhMcr2KFRc5XJYuwUsZYKjyvls780hY8jOBeIdGe4jQg2D0jfiMgp72uLWbk20F/60vbeEk9Sp14kbbyjPEv6+T+rUiaK9LV4484BhkVhIwL5qTon9/Ztx+xTRD4R20GTCjZZyDUDbj3x+gh1k+zIyL3yceQwjmlgIf5C8AjQprBOZ9mHbpfkVQlJvtONqcVVLER3BdlQMN3AWrqQb2j8BlxUcya0x7rSd7gVmHQuYCnuhPZZeXJuiWAL0FK3atXZQfPw3laYz7QSqH2QdOY7OlaysVBQqMXqbHYWH+CMg8TFekvUGQ==
Received: from BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 12:08:27 +0000
Received: from BYAPR12MB3318.namprd12.prod.outlook.com
 ([fe80::698a:d943:647a:c89f]) by BYAPR12MB3318.namprd12.prod.outlook.com
 ([fe80::698a:d943:647a:c89f%3]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 12:08:26 +0000
From: Carolina Jubran <cjubran@nvidia.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>, "initramfs@vger.kernel.org"
	<initramfs@vger.kernel.org>
Subject: Re: Load modules in initrd
Thread-Topic: Load modules in initrd
Thread-Index: AQHawj7tJouVjcxTPkqesc7Dd3UMtrHO+peAgAAC25Q=
Date: Wed, 19 Jun 2024 12:08:26 +0000
Message-ID:
 <BYAPR12MB331896441988496DB332DD1DCBCF2@BYAPR12MB3318.namprd12.prod.outlook.com>
References:
 <BYAPR12MB3318839A4B6BE11ECB13E06BCBCF2@BYAPR12MB3318.namprd12.prod.outlook.com>
 <3e5f74f5-3af5-4368-bfa6-b436bd44c1de@gmail.com>
In-Reply-To: <3e5f74f5-3af5-4368-bfa6-b436bd44c1de@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3318:EE_|DS7PR12MB6214:EE_
x-ms-office365-filtering-correlation-id: fbb46b70-7685-476a-63e1-08dc90588686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?muwki/HWelr4hLXyGGaavgxSNvtIsfhLqFJVnRPaW8fzhvMya7Nbk9baJC?=
 =?iso-8859-1?Q?xfLrFkAx86YMTxGK8OcDwr5rHdwMn8v4EdtR4M8BCUtd8lIGAUjxl8OTPj?=
 =?iso-8859-1?Q?5VmZfRROhdIvn10swIcoJvNfTi2FK6xBJyCliSjHnwaZAZHr03jdoAE5dQ?=
 =?iso-8859-1?Q?zR/MppMcZqmWt9bMeaz/LP5/TuHZk8kI/ffbehtclk4cEQHpy3LjeWUnaW?=
 =?iso-8859-1?Q?+YDfsVJn3VIptgf8baK8EyfsH0Gz6RqGJd57k4+hoaBenPjF8Bl5jkNn/6?=
 =?iso-8859-1?Q?i/zOEjIzPAuL97R6PkMCETpowMuL10oW4Jw/VjaWgI8pm7n02XfU7dczDj?=
 =?iso-8859-1?Q?KiruC4JZK3dwSshtMn6zYYgUdgstdlrsdmxk7yhsog+itzNki87b4rqahR?=
 =?iso-8859-1?Q?0ON/9cozkyDJ0UG3JS37NOQjbDK3Vge+EKw7j8QZ3BnomG1fJE4SXAsEYE?=
 =?iso-8859-1?Q?KvamHkxQTJhFsTGaQPWg1bxzKf/6szXoB45Pd3RPADUPs24UGjaxZBVowx?=
 =?iso-8859-1?Q?Cs8VR+k3VWmmkrYoyOuv74rASsH9QIfef4+GdfhqlCeUx1tfDDAKTrja6T?=
 =?iso-8859-1?Q?TRRP2Z9GAw+dRghdMoksvAkT4aXLHqFWgodfsJwTaAazCjLbPPBgr4/g8u?=
 =?iso-8859-1?Q?KARshE3YjNNfbRr8G35eAmOeK5x/RXEUMoFu0gq6jSCjlOodcsmFLGiQUF?=
 =?iso-8859-1?Q?wq/himZQzuSbG3TRKrsHfa5UafAcVPbga1RtBCBC+IRQaN1cLbK6F4VPau?=
 =?iso-8859-1?Q?+lV4dWE8Oo935iKwBqg+LVBVKXQZ6NnLp81v9uvWs9urgdtKdOcc+Ek1vu?=
 =?iso-8859-1?Q?kFkIU/FzfzoMtshYP4FRZc1xfHCnyfuZKr7vh2dfL8c4hpZkyKwI+IWwPL?=
 =?iso-8859-1?Q?9+U7qKLXZELombOOZCgWROFdlE0qKoYFyLAu0Tb+DKPLhHjX3PLjYK0SJA?=
 =?iso-8859-1?Q?/bgzL7RRyLuHByQ5/O39Wg5uQYWhtaLs5r3UNdG5q6R+oyE+4+OcuUrmvL?=
 =?iso-8859-1?Q?Mq6OFpywyIj8NZ1c1ZaV0ApikOjG7L8yuU7nOMBGSnCCc98cfVLBekegg6?=
 =?iso-8859-1?Q?/nPHku4Au2tRmx+n9XKrWZqic1BZdhbyCKWpcRwwD53qRK7r1sCzjCTGn6?=
 =?iso-8859-1?Q?CpQVcMSiKILSEsqjDhHhpuHaNgTlfLCcxo6BuinFAEEeNf6NpwiNwf5aoU?=
 =?iso-8859-1?Q?8qSGqFLj9C2c4aqMwDYnivipRk7+7iVTC2ilL/yWveNid9hmdOUp1qjIE4?=
 =?iso-8859-1?Q?5JIoArLUY6obvBDREjFwyYdfdqKdN38duJMq/KvT+GcDCVkfyhkoaPOxyv?=
 =?iso-8859-1?Q?Bu1xxJO3gr9p84cpne6CeBE9dwxu/SBZMK73hDKmc7oyy71T45H6rQLD7o?=
 =?iso-8859-1?Q?/eTqdzoThXTF3aTnz4U3zphlrBQ/H2N6/6DmXqZ05iAl91UuVKFNw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3318.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fTZSQsdE6IhT4DiuKvzrEYDb0ePyPiTnoENPWv4P6qFottl5lAbbmdfyRf?=
 =?iso-8859-1?Q?ClhBviXBavCavbRJz1QRMeu3kujyD5/uV3bPjW0J7DRYjnhIP5HJXLmtC7?=
 =?iso-8859-1?Q?WAsbQx2vgPh/wtsaPGGefY5DQdlWXKZ+qU5gvkrLDjMtTjLbF7V8vKtvwU?=
 =?iso-8859-1?Q?SJNDBzv3NwL1UuldfwJsMLje22VcVrT6dFaJVRzk0DFy7gSGI8RnEm78Qb?=
 =?iso-8859-1?Q?J5ei4OVovs9TvdLjbLtk3WXB1t+O2FlVv6fv17tyDLGz6gSg80KrrhSbP0?=
 =?iso-8859-1?Q?WYNghAcI7Evj3jVfd6Zb4pyAfeIzT71F63dmce3PfS6iwfL5tUyFaUBqLd?=
 =?iso-8859-1?Q?+MjLdlwCONZ4FUGDaA36NMoH4tHWapKkoJKMXFh5dCh52xbdid/ibHyvB0?=
 =?iso-8859-1?Q?14aI7H8yc8nxuhddyQCNqLY9T2+5aev3BcvwOat7iz8Sw7REDAFFSY1Hrp?=
 =?iso-8859-1?Q?q/TmH0bz0Af3zA1AyID9y6+dFrGZN9XV2Grzrr7kISamhnUqHLWp6Ju7Qu?=
 =?iso-8859-1?Q?s4asxZkKY08Xm3hi49WfwPJy6fRneWHeJkus3icg7OXcQEU9JauvCdyV+f?=
 =?iso-8859-1?Q?tIqnIoE7e0jdj57B95NlWLaHF/a1mG/eCl35RUXGgUa5zIcZvay9+XB0G2?=
 =?iso-8859-1?Q?z8h1pKmDry9JZ/9fnmuCnqds4l6lPbZ7oQJQDNXJs4FXf+qbw1Hrodc4Dr?=
 =?iso-8859-1?Q?i4HWIniCKdVThVFRt44+YMU6j9P7kE23ni6LyhhBK3ne118ZhIICfVeyJ7?=
 =?iso-8859-1?Q?tD0rgiGktpY3On8cC5j6arg584zYFqSKLB6tGXyPOIBStYgkgm2f9/NLH+?=
 =?iso-8859-1?Q?l+UvXqUwHJLGuQqfPrz5ZNIzF8rInfi5utB1W2fyYlt/gEeCvhnlkIBYjq?=
 =?iso-8859-1?Q?znFPHcpISakHY7TiZjLtJD4U5dAjHDt2+jCJyJgTm9ByQuG2tcd1p+QKzE?=
 =?iso-8859-1?Q?o8/I0ZQDz7Ua5tHKrCBZTa9/P0dctDeFmwddsXy5ix/V80s6oDTm/qe0Me?=
 =?iso-8859-1?Q?wyk/6m00131uO564IsHml/qwiAY+HlH7kgO0wqWFKqnilPlbvO/59mQNDe?=
 =?iso-8859-1?Q?nBTGxOC0H763pRlY6nPrPI+dXpuscnWXvfB+8tLFBhz03NoWr/zT/InYJ/?=
 =?iso-8859-1?Q?wIeu8GimzO+O02uEu6cGEJkBKT823Kqx1riI7qJKj4tNhb1M1dmqLQMBtC?=
 =?iso-8859-1?Q?7Yaud3Dr2wC50fim/Qt6BMv4xh6skQf/gmnP0AhUpVXPAXezv2mIQ09g21?=
 =?iso-8859-1?Q?bd3Nm6DXfg7vgqEC/bTdOzCi2SiBXtQECdCbM4iw0lxN70zNTnSltNp3Hl?=
 =?iso-8859-1?Q?6b6BdLGvw9Qxn0rv02lHZ8tyUbruwh6Prqlgh0h6Y3FTMkNneFd3pzF6A0?=
 =?iso-8859-1?Q?pp7YaEpsCq41ECDiVRTST1d2OgfPYqpLVkI4DZ1LqOF6TBHcwujJFTg6yx?=
 =?iso-8859-1?Q?5bK92139cACM4YmZ6DPkHXRBQ0+9toyp/XKmUllKHm0ZqDpB7hhc1jl1LP?=
 =?iso-8859-1?Q?cgjbWz7zfjacE5LXaQt2dluIEmFJgfiFicDrPPcWcHwcCDXOmcP7C8VYpH?=
 =?iso-8859-1?Q?1H7wJHt9tJceygJ4c7vPnaGLSvy5LV+FbzrNkJZt8ajZh+vlHhlHpo4Dhi?=
 =?iso-8859-1?Q?kM1e05v3xTTgU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3318.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb46b70-7685-476a-63e1-08dc90588686
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 12:08:26.8000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nu35nT9dTfUIYvsRDxh/rSkdgR5owvzQxsGQb1YFyiC1d9vVpnqty7qIIKSThwYiffmuav90vs/gLoVY12Oq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

On 19.06.2024 14:51, Carolina Jubran wrote:=0A=
>>=0A=
>> Hello!=0A=
>>=0A=
>> I need to load RDMA modules in initrd, and I have a systemd service for =
that. However, when we start running in the initrd, the initrd-cleanup.serv=
ice kills the service.=0A=
=0A=
>You already posted this in systemd list and you still failed to explain=0A=
>how kernel module is related to user space program.=0A=
=0A=
Attempting an NFS mount over RDMA will fail unless the RDMA NFS module is p=
re-loaded which is done by the systemd service.=0A=
=0A=
>> The Dracut arrangement only installs the service if the necessary hardwa=
re is present.=0A=
>> I tried to add dependencies to the systemd service "Before=3Dinitrd.targ=
et" to ensure that the service loads the drivers in initrd.=0A=
>> Unfortunately, this was inconsistent; sometimes we load in initrd and so=
metimes we don't.=0A=
>>=0A=
>> Then I discovered that adding a "$SYSTEMCTL -q --root "$initdir" add-wan=
ts initrd.target <our-service>" in the module-setup.sh helps with the issue=
, and the driver consistently runs in initrd.=0A=
>> My question is, how does "add-wants initrd.target" fit into the picture =
with the initramfs image and systemd?=0A=
>> Do I need to make any further changes to my systemd service, or is build=
ing the image using dracut sufficient?=0A=
>>=0A=
>> Thank you,=0A=
>> Carolina Jubran=0A=
=0A=

---
author:
  name: "Pablo"
date: 2026-09-02
enableComments: true
draft: false
linktitle: Fail-closed VPC
title: Fail-closed VPC
cover: /media/blog/2026/09/02_aws-network-setup/2026-09-2_vpc-article.jpeg
coverAlt: Pirate sealing a heavy fail-closed gate door
coverCaption: Pirate sealing a heavy fail-closed gate door
type:
- blog
- blogs
weight: 10
aliases:
- /blog/aws-network-setup
categories:
- Tooling
- AWS
tags:
- aws
- cdk
- cloudformation
- vpc
- vpn
- networking
---

  > IPTABLES(8)
  >
  > Each  chain is a list of rules which can match a set of packets.  Each rule specifies what to do with a packet that matches. This is called a `target', which may be a jump to a user-defined chain in the same table.

Hello there!

I have been using this setup to deploy VPCs in my own projects and dev environments for a while. It did the job, so at some point I decided to clean it up, make it better, and pull it out into its own project. That is [cdk-vpc-vpn-gw](https://github.com/trucoit/cdk-vpc-vpn-gw). It is a VPC with public subnets, optional private subnets, and an optional egress gateway that can carry a VPN. This is a brief comment on how it works and why it looks the way it does. The [README](https://github.com/trucoit/cdk-vpc-vpn-gw#deploy) has the deploy steps, so I am not repeating them here.

There are three network modes and they build on each other. `PublicOnly` is the default, so you get three public subnets, an internet gateway, one route table, and nothing private. `PublicPrivate` adds three private subnets and a single managed NAT gateway in the first public subnet, and every private subnet routes its egress through it. `PublicPrivateCustomRouting` drops the managed NAT and puts a size-1 Spot Auto Scaling group in its place, an instance you actually control. Any mode also gives you VPC flow logs to CloudWatch and an optional set of SSM interface endpoints. Other features may come later.

A managed NAT gateway bills around $0.045 an hour before it moves a single byte, close to $32 a month, and then another $0.045 per GB processed on top (this is just for reference as it may vary, always check [the pricing](https://aws.amazon.com/pricing/)). A size-1 Spot instance does the NAT job for a few dollars a month, and you throw it away when you are done, which is all a cheap dev environment with no high availability needs. It also hands you the box itself, and once it is yours you can route private egress through a VPN. That matters when you are doing security testing, exploit work, or malware analysis, where you want every byte of outgoing traffic to leave through a channel you own and to stay put if that channel goes down. Custom mode is a fail-closed VPN router by default. It creates a private encrypted S3 bucket for your OpenVPN client files, and until a valid profile is sitting in the bucket the gateway drops all private egress. Nothing leaks while you are still setting up, and nothing leaks if the tunnel drops. You drop one `.ovpn` profile in, optionally a credentials file, then refresh the gateway, because it only reads the bucket at boot. You reach the instance over SSM Session Manager, so there is no inbound port and no key to manage, the same trick as my [bastion](/blog/bastion). Set `EnableVpn=false` and it becomes a plain NAT instance egressing through the internet gateway.

The source code is a TypeScript CDK app, and the way it ships is the part I am happiest with. I did not want to force CDK on anyone who just wants a VPC, so the same code produces two things. If you use CDK, you import the `VpcPublicPrivateSetup` construct and it builds the network inside your own stack, with hashed logical IDs so you can create more than one within the same stack. If you do not, you take the committed `cdk-vpc-vpn-gw.yaml` and deploy it with plain CloudFormation. No bootstrap and no toolkit. The construct props mirror the template parameters, so both options behave the same way.

The committed YAML is generated from that same CDK source. The `make test` command runs ESLint, Prettier, Jest, and cdk-nag's AwsSolutions rules, and CI runs the same on every push and pull request. On pushes to `main` and `dev` it re-synthesizes the template and commits the YAML back, so the checked-in file has already passed cdk-nag before it lands. The synthesizer emits no bootstrap parameters, so that YAML deploys as plain CloudFormation with nothing CDK-specific left in it.

A few things to know before you run it. The custom gateway is a single Spot instance with no high availability, so treat `PublicPrivateCustomRouting` as dev/test at best. A Spot reclaim or an AZ loss drops private egress until a replacement boots. One gateway serves all three private subnets, so traffic from a subnet in a different AZ than the gateway crosses the AZ boundary at $0.01/GB in each direction, which can become the biggest line on the bill at volume. The SSM interface endpoints are useful but bill around $22/month for three in one AZ, so they are opt-in. Custom mode needs `CAPABILITY_IAM`. And the construct package is still private, so there is no `npm install` yet and you build it from source.

I want to be clear about what this is. It runs against production best practices, and it is the wrong choice for anything that needs stability or has to stay up. It is meant for development and testing, where the point is keeping the bill small and the setup disposable. I am also not inventing anything here. There are plenty of other similar projects. This one just happens to be the one I have created and used for a while, adding the features I needed for specific projects along the way, almost always as optional flags, so the defaults stay simple and you only turn on what your case requires.

Go read the [README](https://github.com/trucoit/cdk-vpc-vpn-gw) for the modes, the parameters, and the deploy steps!

P.

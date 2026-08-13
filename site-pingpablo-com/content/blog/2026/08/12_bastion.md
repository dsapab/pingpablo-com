---
author:
  name: "Pablo"
date: 2026-08-12
enableComments: true
draft: false
linktitle: Bastion
title: Bastion
cover: /media/blog/2026/08/12/2026-08-12_Bastion-article_2.jpeg
coverAlt: Humanoid Knight guarding castle
coverCaption: Humanoid Knight guarding castle
type:
- blog
- blogs
weight: 10
aliases:
- /blog/bastion
categories:
- Tooling
- Linux
tags:
- ssh
- bastion
- linux
---

  > SSH(1)
  >
  > ssh (SSH client) is a program for logging into a remote machine and for executing commands on a remote machine.  
  > It is intended to provide secure encrypted communications between two untrusted hosts over an insecure network.

Hello there!

You already know what a bastion host is. I built one on AWS and put the [CloudFormation](https://docs.aws.amazon.com/cloudformation/) template on GitHub, [ec2-spot-bastion](https://github.com/dsapab/aws-cloudformation-samples/tree/master/ec2-spot-bastion#how-it-works). CloudFormation is AWS's infrastructure-as-code service, you write a template describing the resources you want and it builds them for you. This is just a short review, the [README](https://github.com/dsapab/aws-cloudformation-samples/tree/master/ec2-spot-bastion#how-it-works) has the full walkthrough. You will need some basic AWS knowledge to get it running.

It runs on EC2 Spot with lowest-price allocation, so it stays cheap, and a size-1 Auto Scaling group relaunches it whenever Spot reclaims the instance. An optional encrypted gp3 volume keeps your data across those reclaims. The instance finds the volume by tag, attaches it and mounts it at boot, so the box is disposable while your files are not.

You don't need to treat it just as a jump box. With a persistent volume and a decent instance type it also makes a fine remote work machine. Run day-to-day shell work, ML and AI jobs, etc. You can scale up to a compute or memory-heavy instance when a job actually needs it, and drop back down after. Pick the right machine by checking the [EC2 instance types](https://aws.amazon.com/ec2/instance-types/) and [pricing](https://aws.amazon.com/ec2/pricing/) references.

My favourite part is how you get in. Every instance runs the SSM agent with the `AmazonSSMManagedInstanceCore` role, so Session Manager drops you into a shell using nothing but IAM. You don't need a key or a public IP, and you never open a port. When I want a proper SSH session I tunnel it over SSM with `AWS-StartSSHSession`, and even then the security group stays empty. Setting that up requires a `ProxyCommand` block in your `~/.ssh/config` and the Session Manager plugin installed locally:

```sshconfig
# SSH over Session Manager
Host i-* mi-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
    User ec2-user
```

The [SSH over SSM](https://github.com/dsapab/aws-cloudformation-samples/tree/master/ec2-spot-bastion#2-ssh-over-ssm-tunneled-still-private) section of the README walks through it. Nothing is reachable from the internet, which is the whole reason I run it this way.

Go read the [README](https://github.com/dsapab/aws-cloudformation-samples/tree/master/ec2-spot-bastion#how-it-works) for more details on how it works, from distro detection at boot to keeping a stable IP without a fixed instance, the AZ-pinned data volume, and running several bastions from one stack.

P.


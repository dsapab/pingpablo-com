---
author:
  name: "Pablo"
date: 2024-05-31
enableComments: true
linktitle: Are you talking to me?
title: Are you talking to me?
cover: media/blog/2024/05/31_are_you_talking_to_me/message-bottle.png
coverAlt: Message in a bottle
coverCaption: Message in a bottle
type:
- blog
- blogs
weight: 10
categories:
- Opinion
- Announcements
- Tooling
tags:
- giscus
- utterances
---


>It doesn't matter from which machine the recipient replies, as long as his login name is the same. Once communication is established, the two parties may type simultaneously; their output will appear in separate windows. 


Hello there! I am enabling comments for the blog today. I guess I am traveling down the same road as every single blog out there. Hopefully this one does not end up abandoned in the shady internet backyard. 


## What tool are we going to use?

Exploring the [Hugo comments integrations](https://gohugo.io/content-management/comments/), we can see there are many available options. For some of them, it is not clear if they are still being actively maintained or not. There are also some paid options, which offer nice features such as social medial login and statistics. This sounds interesting, but at the time of writing I don’t consider I need any of those functionalities. Additionally, there are concerns about those services and data privacy. A decision about a paid (or freemium) service which handles user data will require a much more depth analysis.

For now, I am mainly looking for:

* 100% server-less, without needing to install nor maintain anything.
* Log in via 3rd party, I don’t want to handle any credentials.
* Support for comments, reactions, replies and threads.
* If open source, better.


We end up with two good options: [**utteranc.es**](https://utteranc.es/) and [**giscus.app**](https://giscus.app/). I ended up deciding for **Giscus**, as the project looks much more active and better maintained. I also really valued it supports GitHub discussions, which grants a much better forum-like experience.

Commenting is done via the GitHub account. I would expect most of the audience (if there is anyone reading this blog besides me!) to be technical anyway. Most probably active users and well familiarised with GitHub. It is also possible to comment directly in the GitHub issue/thread in case you prefer to not use Giscus, comments will come up in the blog.

That’s all for today. Thanks for reading!

P.

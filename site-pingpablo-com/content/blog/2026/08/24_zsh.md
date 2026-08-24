---
author:
  name: "Pablo"
date: 2026-08-24
enableComments: true
draft: false
linktitle: Find your terminal
title: Find your terminal
cover: /media/blog/2026/08/24_zsh/zsh-terminal.jpeg
coverAlt: Crowded airport terminal
coverCaption: Crowded airport terminal
type:
- blog
- blogs
weight: 10
aliases:
- /blog/zsh
categories:
- Tooling
- Linux
tags:
- zsh
- shell
- terminal
- security
- iterm2
- scripting
---

  > ZSH(1)
  >
  > zsh is a UNIX command interpreter (shell) usable as an interactive login shell
  > and as a shell script command processor.

Hello there!

I've been running a plain zsh setup for years, without reaching for any of the popular frameworks. I eventually wrote mine down as [zsh-setup](https://github.com/dsapab/wizardly-snippets/tree/main/zsh-setup), a framework-free config that is just a handful of small files you can read top to bottom in a couple of minutes. That is the part I want to talk about, because the reason to run something like this is mostly about what you are *not* installing.

Frameworks like Oh My Zsh and Powerlevel10k are great projects, and they pack a lot of features. I have used them and enjoyed them. You paste one line, get a pretty prompt, git status in your prompt, autosuggestions, and you move on. My concern is not much about the features, it is about the attack surface. A framework loads third-party plugins and an autoloader into every shell you open, and that code runs with your user and your keys. The more you add, the larger that surface grows, and the more of a supply chain you take on trust.

Most of what people reach for a framework to get is already shipped by zsh. Git info in the prompt is `vcs_info`, built in. Completion is `compinit`, built in. History search on the arrow keys is a few lines in your `.zshrc`. The two extras worth adding, `zsh-syntax-highlighting` and `zsh-autosuggestions`, are single Homebrew packages you source at the bottom of the file. That is pretty much the whole story. No framework, and you can still explain every line in your own config to a friend.

The install is a `curl ... | sh` one-liner, and so is almost every framework installer out there. Piping a URL straight into a shell means you run whatever is on that server today, sight unseen, and a compromised repo or a hijacked domain runs as you. Download it, open it in `less`, read it, then run it. That is why I wrote the [README](https://github.com/dsapab/wizardly-snippets/tree/main/zsh-setup) to share with you, and why the installer backs up your old config to `~/.zsh/backups/` before touching anything so you can roll back. Do the same with any installer, mine included, especially the ones that hand you a prompt in five seconds.

On macOS, I chose to pair it with [iTerm2](https://iterm2.com/). Split panes, search, a proper scrollback, and the nerd-font support you need for the prompt icons, all in the emulator. Between zsh and iTerm2 you already have many features people go hunting for in plugins. Fewer moving parts, nothing running that you did not read, and a config small enough to actually own.

My goal here is to encourage the community to be a bit more mindful about what we run on our computers. I like those frameworks, and I even replicated their look and feel in my own setup. But once you have worked with the terminal for a while and have a good grasp of the exact features you need, it is sensible to build a minimal config you can maintain, understand, and back up.

P.

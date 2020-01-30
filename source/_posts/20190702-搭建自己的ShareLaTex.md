---
title: 搭建自己的ShareLaTex
urlname: 搭建自己的ShareLaTex
date: 2019-07-02 14:04:00
tags:
---

OverLeaf平台有一分钟的编译时间限制，不想花钱升级那就用开源的版本。

<!-- more -->

# 安装与启动
建议使用docker compose直接进行编排👇

```
mkdir sharelatex && cd sharelatex
wget https://raw.githubusercontent.com/sharelatex/sharelatex/master/docker-compose.yml
docker-compose up -d
```

然后访问本地80端口的`launchpad`路径即可进行注册，如果想避免端口占用就修改下compose文件。

# Latex Package缺失
`免费`带来的问题就是`麻烦`，因为在实际使用过程中会遇到很多没有预装的包，所以需要手动安装。

大多数情况下如果shareLaTex提示缺少什么file就直接使用`tlmgr`安装相应的package即可，例如提示`LaTeX Error: File \'comment.sty' not found.`，那么直接使用命令`tlmgr install comment`安装就可以了，但是有些情况下，缺少的file是被包含着另一个package中的，那么就需要先找到相应的package再进行安装，例如提示`LaTeX Error: File 'balance.sty' not found.`，如果你直接使用命令`tlmgr install balance`进行安装，那么tlmgr会报错如下

```
tlmgr install: package balance not present in repository.
tlmgr: action install returned an error; continuing.
tlmgr: An error has occurred. See above messages. Exiting.
```

因为balance不是package的名字，你可以去[https://ctan.org](https://ctan.org/)上检索balance，会得到如下结果⤵️

<img style="display:block; margin-left:auto; margin-right:auto; width:300px;" src="https://cdn.safeandsound.cn/ML_Study_Notes/image/20190702141635.png?imageslim"/>

可以看到balance被包含在preprint这个package中，那么直接安装preprint即可。
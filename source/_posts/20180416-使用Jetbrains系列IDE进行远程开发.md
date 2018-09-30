---
title: 使用Jetbrains系列IDE进行远程开发
urlname: How2DevelopRemotelyWithJetbarinsIDE
date: 2018-04-16 21:36:33
tags: [IDE, Tips+Tricks]
---

有时候, 我们的开发环境会受到所使用平台的限制而导致无法进行某些开发, 例如有些库在linux平台上被支持的很好, 而要移植到windows的话就要话不少的精力(还得冒着不小的搞砸的风险), 而现在已经有不少的IDE提供了远程开发的功能, 我们可以很好的利用起来, 在此以JetBrains系列的IDE为例进行演示.

<!--more-->

# 前言
先简单介绍一下情况吧, 之前接触了一下一个开源的python人脸识别库 👉 [Face Recognition](https://github.com/ageitgey/face_recognition), linux平台上很简单的操作就安装配置好了, 但是官方并不提供windows上的安装方法, 虽然有老哥提供了相关的教程, 但是看了看下面的网友提出的那么一系列的问题, 想了想生产环境最终还是在linux上, 算了, 还是在linux环境下开发吧, 想起原来在哪看过IDEA可以利用远程的环境进行开发, 估计JetBrains系列的IDE大都可以, PyCharm搞起.

# 同步项目内容
要远程开发, 你得先把项目文件同步到远程服务器吧? 先搞定这个

## 上传项目文件 
到`菜单栏` -> `Tools` -> `Deployment` -> `Configuration`进行配置, 如下图: 
![进入菜单栏进行配置](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev0.png)

点击绿色的+符号添加远程服务器, Name任起, Type选择SFTP, OK进入详细配置页面, 如下图: 
![服务器详细配置](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev1.png)

完成后由`Connection`框进入`Mappings`框继续配置, 如下图:
![相关路径配置](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev2.png)

完成后在项目根路径上右击, 到`Deployment` -> `Upload to *`上传项目到服务器即可.
![上传项目](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev3.png)

## 关于自动上传功能
上面说最好是勾选自动上传的功能, 因为如果你不勾选的话, 每次都需要你手动上传, ,而且如果你都是直接上传根文件夹, 那么有些文件虽然没有被修改, 还是会被重传一边(而且这是大多数文件, 因为你用框架的话会有很多的库文件之类的), 这就会导致费时费力还不讨好了

# 配置本地使用远程服务器的环境
上面我们同步了本地的开发项目到服务器, 但是我们本地的开发环境还是没有变化啊, 那我们怎么利用远程开发环境呢? 下面讲配置:

## 添加远程python interpreter
进入`Settings` -> `Project: ` ->`Project Interpreter`设置当前项目的python翻译器, 点击右边的小齿轮进行设置, 选择`add`进行添加:
![添加interpreter](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev4.png)

然后选择`SSH Interpreter`, 选择下面的`Existing server configuration`, 在框中选择之前我们已经配置过的远程服务器:
![添加interpreter](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev5.png)

然后点击next, 进行详细配置:
![添加interpreter](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev6.png)

完成配置后点击apply进行应用.

## 选用interpreter
到项目设置里应用我们刚刚配置的远程服务器的interpreter就好了, 完成配置后IDE会从远程服务器上下载环境文件, 都是自动化进行的, 无需干预, 等全部完成了就可以使用服务器上的开发环境了.

# 关于库的安装
在库的安装方面（由于jetbrains的IDE自身特性），如果你不通过IDE而使用其他终端软件连上服务器然后安装库的话，IDE是不会主动感知到库文件的增加或减少的，所以不会自动同步，只有在你重启IDE或手动刷新该Interpreter的库文件路径之后才会自动同步到本地，在Jetbrains社区中对于该问题有提及， 请参考👉 [见此](https://intellij-support.jetbrains.com/hc/en-us/community/posts/205813579-Any-way-to-force-a-refresh-of-external-libraries-on-a-remote-interpreter-)

# 赘述
## 同步远程文件到本地
**注:**在开发项目的过程中, 如果服务器的项目文件主动变化的话, 本地的IDE并不会主动进行同步, 需要你手动进行同步, 例如, 我的整个项目在服务器和本地之间同步完成后, 我在服务器端主动修改了一个views.py文件内容, 在最后加上了一句`print("this is just a test")`, 但是本地PyCharm并不会主动将修改的内容同步过来, 如果我想要同步的话, 需要手动进行:
在项目根路径上右击, 到`Deployment` -> `Sync with Deployed to *`
![选择同步](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev7.png)

然后IDE会将两地的文件进行比较,
![配置同步](https://cdn.safeandsound.cn/image/pycharmRemoteDev/pycharm-remote-dev8.png)

**注:** 如果你在修改远程文件后, 在本地也进行修改的话(此时你开启了自动上传的配置), 保存本地文件后, IDE会自动将本地文件上传到远程并覆盖远程的修改内容. 所以建议远程开发的话, 操作什么的尽量都在IDE上进行, 方便保持一致.

## JetBrains其他IDE
JetBrains系列其他的IDE(IDEA, webstorm等)也都差不多是这样配置.
本文是以本地项目上传到远程服务器为例讲解的, 当然也可以配置后再从远程服务器上拉项目到本地的, 只不过一开始不是upload而是download罢了, 不再赘述.
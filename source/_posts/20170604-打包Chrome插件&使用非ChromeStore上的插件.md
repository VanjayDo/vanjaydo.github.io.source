---
title: 打包Chrome插件&使用非ChromeStore上的插件
urlname: How2PackChromePlugin&UsePluginsNotFromChromeStore
date: 2017-06-04
tags: [Tips+Tricks]
---

最近在使用Chrome插件json-viewer的时候遇到了一些功能限制问题, 在找到了一个开源的增强版, 于是自己修改了下样式打包成插件, 在此总结一下.

<!-- more -->

### 前述
最近在学习维护学校iptv服务器时获得了电视墙缓存图片的json数据，chrome打开页面后jsonViewer无法格式化代码，如图（jsonViewer此时并没有启动，因为它并不会格式化本地文件）：

![json.png](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/json.png)

在网上找到了一个[ 网友自己拓展的json-viewer ](http://www.aneasystone.com/archives/2015/07/second-chrome-extension-jsonview-enhencement.html)，与 [http://www.jsonohyeah.com/](http://www.jsonohyeah.com/)上的效果相近，不过可以本地格式化，省去联网了，觉得很好用。

觉得样式丑的可以去github拉取代码自己改下样式（样式表在WebContent\viewer\index.html文件中），然后chrome打包拓展程序安装。

### 打包与安装拓展程序
首先下载插件源码, 以这里的[JSONView](https://github.com/VanjayDo/JSONView-for-Chrome)为例, 解压后会得到一个`WebContent`文件夹, 然后进入chrome的插件管理界面, 打开地址`chrome://extensions`, 会看到有如下`打包拓展程序`的按钮: 

![Alt text](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore\packButton.png)

点击打开打包对话框, 在`拓展程序根目录`一栏中填入`WebContent`文件夹路径(否则会报错“清单文件缺失或不可读”), `私钥文件`一栏不用管,  如下图:

![Alt text](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore\packIt.png)

点击`打包拓展程序` ( 如果报错“指定扩展程序的私有密钥已存在。请重复使用该密钥，或者先删除它” 则删除pem密钥文件即可 ), 会在WebContent文件夹的同级目录下得到`WebContent.crx`和`WebContent.pem`两个文件, pem密钥文件对我们来说并没有什么用, 我们直接将得到的`WebContent.crx`文件拖放到`chrome://extensions`页面上即可安装.

本人已修改样式且打包了的JsonViewer拓展程序[下载地址在此](https://github.com/VanjayDo/JSONView-for-Chrome/raw/master/Json-viewer.crx) , 是github的地址, 可能会报"危害计算机"警报, 信任即可, 有疑虑也可以自己打包.

### 授权
安装后你会发现程序是被禁用的状态, 因为这并不是Chrome Store上的插件, 所以chrome为了安全会直接禁用这种插件, 如下图:
![插件被禁用](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/warning.png)

但是我们可以通过Chrome的配置策略来将插件加入白名单, 请记住你自己被禁用插件的类似上图中的插件ID, 等会有用 .

**注:** 接下来的操作需要用到windows系统的组策略机制, 但自win8开始组策略只在专业版/企业版/教育版才有, 所以请确保你的系统版本拥有组策略机制.

#### 下载Chrome ADM模板
进入[Chrome官方下载地址](https://support.google.com/chrome/a/answer/187202?hl=zh-Hans)下载策略包, 如下图:

![下载策略包](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/downloadADM.png)

👉 [直接下载传送门](https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip) 👈 

下载后解压得到一个`policy_templates`文件夹,  我们需要的策略文件是`policy_templates\windows\adm\zh-CN`目录下的`chrome.adm`文件, 请记住它的绝对路径, 等会有用.

#### 添加组策略
然后我们在`运行`里输入`gpedit.msc`打开组策略编辑器, 进行如下操作:

* 选择添加模板:
![gpedit0](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/gpedit0.png)

* 点击添加按钮, 进入刚才`chrome.adm`文件的路径, 选择添加`chrome.adm`, 效果如下图, 然后点击关闭按钮:
![gpedit1](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/gpedit1.png)

* 进入Chrome模板填加白名单, 如下图: 
![gpedit2](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/gpedit2.png)

* 依次操作, 添加之前记住的拓展程序的ID号码, 保存即可:
![gpedit3](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/gpedit3.png)
![gpedit4](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/gpedit4.png)

再看插件的状态不会有红色的警告文字。

#### 成果
最终格式化电视墙缓存图片的json数据效果如图：
![效果图](https://cdn.safeandsound.cn/image/How2PackChromePlugin&UsePluginsNotFromChromeStore/finish.png)

### 赘述
安装时也可以开启开发者模式，选择“加载已解压的拓展程序”，从WebContent文件夹直接安装源码。这样安装后就不会有被直接禁用的问题, 但是每次打开chrome都会提醒你禁用开发者模式下安装的拓展, 很烦人, 加入白名单即可.
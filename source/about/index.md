---
title: 有些关于
date: 2017-07-27 15:04:16
---
#### 2017 年
##### 11 月
* ###### 2017-11-12
最近比较迷Alvaro Soler的Sofía（一开始以为是情歌，结果查资料才知道是Alvaro Soler失恋后写的），虽然是西班牙语的民谣，根本不知道在唱什么😂但是曲子很有活力，节奏感很强，口哨可以轻松带起来。很棒的歌。
<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=110 src="https://music.163.com/outchain/player?type=1&id=34609360&auto=1&height=90"></iframe>

* ###### 2017-11-10
今天趁着田老师有空，请他带着我去文理楼机房调整维护了自己的两台服务器，因为没有远程控制卡（毕竟之前是废弃在仓库的老机器了），所以只要出现故障就只能现场维修，有一台还是自己七月份时候配iptables规则的时候不小心把网络全封了……很蛋疼🌚。
不得不说田老师的为人真的超赞，不仅网络方面的技术好，作为指导老师也很平易，非常照顾学生。
感觉自己虽然会用linux，但是在系统的管理和维护上的能力还有欠缺。打算明年考RHCE的认证，不得不准备就业的事了。

* ###### 2017-11-09
[Get full version of StarUML](https://gist.github.com/trandaison/40b1d83618ae8e3d2da59df8c395093a)    startUML获取证书，V2.8.0亲测可用.

* ###### 2017-11-01
最近配置nginx时总是遇到nginx -t测试配置文件时没问题，但是restart服务却一直失败，重启一下吧又好了，突然想起来会不会是端口被占了，查一下：
```bash
# netstat -anp|grep ":80"   
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      8205/nginx.conf 
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1356/java
```
	端口果然被占用了，kill掉这个进程即可。

##### 10 月
* ###### 2017-10-27
强推一款跨平台的终端连接工具：[Termius](https://www.termius.com/)，尤其是在IOS上，好用又良心。在此之前我在手机上使用的SSH连接工具是Shelly，它仅支持SSH，而且不购买专业版的话就无法保存密码，每次都要重新输入，简直是要逼死使用长密码的人，在我准备购买专业版时发现当前下载的shelly是使用之前的一个Apple ID获取的，购买的话就需要使用现在的账号重新获取，于是删除了shelly后我到App store中搜索了ssh，出现的第一个结果就是Termius，五星的好评让我尝试了一下它，结果就没再安装shelly。

* ###### 2017-10-24
上校图书馆网站查书发现一个很有趣的现象，阿加莎、松本清张的书没人借，退一步，岛田庄司的也没人借，然而东野圭吾的书都基本被借光，不好做什么评论，只觉得挺有意思。

* ###### 2017-10-21
之前linux下查命令参数总是用man配合字符匹配，突然发现有[tldr](https://github.com/tldr-pages/tldr)这种利器，赶紧推一下。
<img src="https://cdn.safeandsound.cn/image/about/tldr.png" width="500px">

* ###### 2017-10-18
推荐一款linux下递归搜索文件内容的软件：[ag](https://github.com/ggreer/the_silver_searcher)，安装步骤：
```bash
git clone https://github.com/ggreer/the_silver_searcher.git
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build
sudo make install
```
	体验还不错，在linux子系统下运行效果图
<img src="https://cdn.safeandsound.cn/image/about/show-ag.png" width="500px">

* ###### 2017-10-13
发现IOS下的Workflow可以提取网页的json数据，这样就能访问有些网站提供的API直接拿数据了，简直就是一只小爬虫，自己做了一个根据书名从豆瓣拉取图书相关信息的workflow -->[豆瓣读书](https://workflow.is/workflows/cae2c0ec4dd540dab6a773eb0de982bb) <--，感觉查书什么的挺好用的
<img src="https://cdn.safeandsound.cn/image/about/%E8%B1%86%E7%93%A3%E8%AF%BB%E4%B9%A6workflow.png" width="300px">

* ###### 2017-10-09
当觉得生活无趣又无望时就应该读汪曾祺。
虽说小波的文字也是颇有趣的，但哪个百无聊赖的人喜欢听那么理性的话。
可这么说肯定是有人不同意第二句的。

* ###### 2017-10-08
今天是在行政楼实验室的最后一天。从我的位置看出去的风景还是挺让人放松的。
<img src="https://cdn.safeandsound.cn/image/about/SDN.jpg" width="500px">
因为领导换届和单位转型为管理单位，所以废除掉SDN实验室，再加上“新增了领导办公室不够用”、“一个领导一个作风，这个实验室是老领导设办的”、“这是和华三一起做的SDN实验室，但你们在这里的学生有几个是做SDN的”等理由，看上去总是很合理的。
但还是感觉似乎不该这样。
可能是因为喜欢在这边学习的氛围和深夜写代码的自由。
我们都知道归属感来之不易。不过这么说起来就很像是心情不好想埋怨些什么的借口了。

* ###### 2017-10-05
推荐一款cli下的mysql客户端，[mycli](https://github.com/dbcli/mycli)，支持语法高亮和命令补全，linux下直接install就有，效果相当棒。
<img src="https://cdn.safeandsound.cn/image/about/mycli.png">

##### 8月
* ###### 2017-08-15
又在开源论坛上看到有人在黑php。
php因为其一开始的自身定位问题导致现在的特性有很多地方好像不是那么讨（有些）人喜欢，但是这么些年来的不断改进已经让其无愧于其自身定位了，在小规模的站点开发中，缺点基本可以忽略，况且易上手又适合快速开发让它的门槛变得很低。当然了，有人也因为以上的优点而称PHP为屌丝语言，我个人觉得没必要这样，每一门语言都有其自身的特性，优点和缺点都算是，语言只是一个工具，实在不喜欢换一门就行，没必要一边用一边黑。
开发本来应该是一件很愉快的事，这样可就搞糟了。

##### 7月
* ###### 2017-07-29
感觉自己的大学生活好像今天坐公交遇到的小男孩，正经时很可爱，冲我笑时却很丑。
但我到底还是喜欢的。
这么说好像不负责任的旁观者。

* ###### 2017-07-21
powershell启动加速。参见该[官方博文](https://blogs.msdn.microsoft.com/powershell/2007/11/08/update-gac-ps1/),将以下命令粘贴到powershell，等待执行完毕。
```
Set-Alias ngen @(
dir (join-path ${env:\windir} “Microsoft.NET\Framework”) ngen.exe -recurse |
sort -descending lastwritetime
)[0].fullName
[appdomain]::currentdomain.getassemblies() | %{ngen $_.location}
```
* ###### 2017-07-20
windows下在资源管理器右键打开powershell /cmd。进regedit，定位到HKEY_CLASSES_ROOT\Directory\Background\shell\cmd\command表项，对右侧的字符串项的值进行修改：
```
#用powershell打开则改为：
powershell.exe -NoExit Set-Location “%V”
#用cmd打开则改为：
cmd.exe /s /k pushd "%V"
```
	确定保存即可

~~一些想说的话和零碎的知识点放在这里~~ 
~~以上~~
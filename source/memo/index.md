---
title: 备忘录
date: 2017-07-27 15:04:16
---
#### 2017 年
##### 12月
* ###### 2017-12-09
有时候需要在当前文件夹开一个临时的端口来访问一下看看效果可以使用<code class="shortCode">http-server</code>.
需要使用npm全局安装http-sever: <code class="shortCode">npm install -g http-server</code>
使用http-server在本地开一个临时的server: <code class="shortCode">http-server -a 127.0.0.1 -p [端口号]</code>根目录默认为当前目录,也可以直接在http-server后面指定目录地址(相对/绝对都可以),如果不加<code class="shortCode">-a</code>参数的话则会默认在本地的几个网卡地址上都进行设置(如:你有一个10.10.10.1的虚拟网卡,如果你有一台虚拟机使用的是这个网卡,则虚拟机也可以访问当前设置的地址)

* ###### 2017-12-06
有些同学不会下载离线完整版的chrome,方法是:google搜索关键词"chrome 帮助",会得到结果"Google Chrome帮助 - Google Support",下面的小标题有"下载和安装Google Chrome",点进去,在"在 Windows 设备上安装 Chrome"下方会有小标题"离线安装 Chrome",点击展开,会出现链接[备用 Chrome 安装程序](https://www.google.com/intl/zh-CN/chrome/browser/desktop/index.html?standalone=1),点击后可以看到打开的页面URL最后有属性<code class="shortCode">standalone=1</code>,在该页面下载的chrome即是离线版的.

* ###### 2017-12-01
从浏览器复制网站地址后粘贴到别处,如果地址中有中文,往往发现地址里的中文被转码成了[URL编码](https://zh.wikipedia.org/wiki/百分号编码),如<code class="shortCode">https://zh.wikipedia.org/wiki/维基百科</code>被转成了<code class="shortCode">https://zh.wikipedia.org/wiki/%E7%BB%B4%E5%9F%BA%E7%99%BE%E7%A7%91</code>,其实使用剪切而非复制就不会出现这种尴尬的问题.

##### 11 月
* ###### 2017-11-29
今天在使用服务器做ss代理的时候一直提示<code class="shortCode">ERROR: unable to resolve……</code>，很奇怪，这个配置已经用过很多遍都没出问题，而且明明服务器配置了多个DNS，却显示无法解析域名。
最后还是查相关文档后，在配置文件里加了<code class="shortCode">"nameserver": "8.8.8.8"</code>这个字段，问题就解决了。
然后，在使用proxifier时突然报错
```
[11.29 16:56:25] Error: Windows network (Winsock) is not properly configured to work with Proxifier. 
[11.29 16:56:25] Proxifier or some of its parts may work incorrectly. 
[11.29 16:56:25] It is highly recommended that you run SysSettings tool to address this problem.
```
	一脸懵逼，之前用还好好的，估计可能是前几天一次win10版本大更新导致的，根据提示中的<code class="shortCode">SysSettings</code>，用everything查找了一下系统，发现是proxifier自带的一个设置程序，就在proxifier的安装目录下，进去之后先运行了64位的“SysSettings64.exe”，显示<code class="shortCode">proxifier module is not installed</code>，当然是点击install了，安装后重启proxifier，并没什么用（挠头），索性运行了32位的“SysSettings32.exe”，也安装了下，重启，成了。应该是更新时系统把proxifier的部分模块给删了导致的问题。

* ###### 2017-11-29
[Tiny Core](http://distro.ibiblio.org/tinycorelinux/)，仅10+M的linux，因为轻量而被追捧，网上的教程也不少。
进入系统后输入命令，<code class="shortCode">tce</code>可以进入Tiny Core Extension，即CLI应用浏览器，按<code class="shortCode">s</code>进入搜索模式，输入需要的软件/库名即可，系统会列出相关的选择。
关于Tiny Core Plus，是带GUI的版本，稍大，100+M，在vmware直接从IOS启动时只有选择"Boot Core with only X/GUI (TinyCore)"及以下的启动项才能正常启动，原因未知。

* ###### 2017-11-27
发现<code class="shortCode">curl v4.ifconfig.co</code>命令获取本机ip地址的速度比<code class="shortCode">curl ifconfig.co</code>来的快得多，好用。
注：适用于虚拟机、云服务器之类使用NAT转换、使用ifconfig命令无法直接获取公网地址的主机。

* ###### 2017-11-20
今天更新kali后发现shadowsocks无法使用，运行后报错：
```bash
AttributeError: /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1: undefined symbol: EVP_CIPHER_CTX_cleanup
```
	看错误应该是加密方面的问题，因为ss依赖openssl，那就应该是openssl的问题了，上网搜了下，[解决办法在此](https://blog.lyz810.com/article/2016/09/shadowsocks-with-openssl-greater-than-110/)

* ###### 2017-11-12
最近比较迷Alvaro Soler的Sofía（一开始以为是情歌，结果查资料才知道是歌手失恋后写的,感情上可以说很乐观了），虽然是西班牙语的民谣，根本不知道在唱什么😂但是曲子很有活力，节奏感很强，口哨可以轻松带起来。很棒的歌。
<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=110 src="https://music.163.com/outchain/player?type=1&id=34609360&auto=1&height=90"></iframe>

* ###### 2017-11-10
今天趁着田老师有空，请他带着我去文理楼机房调整维护了自己的两台服务器，因为没有远程控制卡（毕竟之前是废弃在仓库的老机器了），所以只要出现故障就只能现场维修，有一台还是自己七月份时候配iptables规则的时候不小心把网络全封了……很蛋疼🌚。
不得不说田老师的为人真的超赞，不仅网络方面的技术好，作为指导老师也很平易，非常照顾学生。
感觉自己虽然会用linux，但是在系统的管理和维护上的能力还有欠缺。打算明年考RHCE的认证，不得不准备就业的事了。

* ###### 2017-11-09
[Get full version of StarUML](https://gist.github.com/trandaison/40b1d83618ae8e3d2da59df8c395093a)    startUML获取证书，V2.8.0亲测可用.

* ###### 2017-11-05
之前的ssl证书都是在七牛上获取的trustasia颁发的免费证书，但是过程比较繁琐，需要先申请然后用dns或文件的方式验证，一般一天后通过验证，然后要把证书下载下来传到服务器，再配置nginx……
发现lnmp现在自带了有ssl添加功能，试了下，报错：
```
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/virtualenv.py", line 2363, in <module>
    main()
  File "/usr/lib/python3/dist-packages/virtualenv.py", line 719, in main
    symlink=options.symlink)
  File "/usr/lib/python3/dist-packages/virtualenv.py", line 988, in create_environment
    download=download,
  File "/usr/lib/python3/dist-packages/virtualenv.py", line 918, in install_wheel
    call_subprocess(cmd, show_stdout=False, extra_env=env, stdin=SCRIPT)
  File "/usr/lib/python3/dist-packages/virtualenv.py", line 812, in call_subprocess
    % (cmd_desc, proc.returncode))
OSError: Command /opt/eff.org/certbot/venv/bin/python2.7 - setuptools pkg_resources pip wheel failed with error code 2
Let's Encrypt SSL Certificate create failed!
```
	[在此找到解决办法](https://github.com/certbot/certbot/issues/2883)，最终是用@knowThis小伙伴的办法解决的：
```
$ apt-get purge python-virtualenv python3-virtualenv virtualenv 
$ pip install --upgrade pip
$ pip install virtualenv
$ vim /bin/lnmp  #将"/bin/certbot certonly"替换成"/bin/certbot --no-bootstrap certonly"。仅一处。
```
使用lnmp自带的添加ssl功能有个好处就是它会配置默认将http流量直接转发到https;
直接使用lnmp 生成ssl后，vhost站点的配置文件在/usr/local/nginx/conf/vhost，需要进行配置的话可以进去修改，80端口的server是http的配置，443端口的是https，以下举例：
***1.*** 需要启用404页面，当资源访问错误时跳转到指定页面：
取消error_page的注释，将其修改为<code class="shortCode">error_page  404 403 500 502 503 504  = /404.html;</code>
注意：/404.html文件的路径是相对于配置中的<code class="shortCode">root</code>字段的值，所以如果<code class="shortCode">root</code>字段的值为<code class="shortCode">/home/wwwroot/default</code>,那么404.html在系统中的绝对路径为/home/wwwroot/default/404.html。其次，http和https的配置是分开的，所以如果只配置了http的404页面，那么在https协议访问发生资源错误时是不会跳转到http配置中设置的404页面的。
***2.*** http访问配置好的404页面发现不会自动跳转到https。需要我们手动把http流量强制转发到https，在http配置中添加<code class="shortCode">rewrite ^ https://$server_name$request_uri? permanent;</code>
***3.*** 修改配置文件后需要重启nginx服务才能生效。如果无法重启，首先使用<code class="shortCode">nginx -t</code>命令检测配置文件，如果报错说明是配置文件的错；如果没有报错，使用<code class="shortCode">netstat -anp|grep :80</code>查看80端口是否被占，如果被占则需要kill掉使用80端口的进程；如果没有被占，使用<code class="shortCode">journalctl -xe</code>查看启动服务时的报错日志进行调试解决。


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

~~一些零碎的知识点和想说的话放在这里~~ 
~~以上~~
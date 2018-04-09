---
title: 备忘录
date: 2017-07-27 15:04:16
---
#### 2018 年
##### 4 月
* ###### 2018-04-09
今天在PowerShell中使用`virtualenv`为django工程搭建python虚拟环境的过程中在执行activate脚本进行激活时发生错误: 
```
.\proVirtualEnv\Scripts\activate : 无法加载文件 C:\Users\jay\Documents\Code\dja
ngo\proVirtualEnv\Scripts\activate.ps1，因为在此系统上禁止运行脚本。有关详细信
息，请参阅 https:/go.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_P
olicies。
```
原因是: PS的现用执行策略是 Restricted（默认设置）, 而Restricted策略为了系统安全不允许任何脚本运行, 执行命令`set-executionpolicy remotesigned `后将PS执行策略修改为系统可以运行编写的未签名脚本和来自其他用户的签名脚本即可(需使用有管理员权限的PS, 选择A后回车).

##### 3 月
* ###### 2018-03-28
推荐命令行版的图片压缩工具[nie](http://feg.netease.com/archives/605.html)
顺便提一下关于在linux与windows下查看环境变量的不同:
*查看所有环境变量的名称和值：*
Linux下：`export`
Windows下：`set`
*根据名称查该环境变量的值：*
Linux下：`echo $环境变量名`
Windows下：`set 环境变量名`

* ###### 2018-03-26
CSS否定选择器`:not()`不能嵌套使用, 但是可以并列使用, 形如: `:not():not()`。
例如我要选择所有p元素下的非(类a和类b)的元素, 则可以写作: `p:not(.a):not(.b)`。

* ###### 2018-03-25
今天发现了一个关于[算法复杂度大O表示法](https://www.jianshu.com/p/59d09b9cee58)的[cheat sheet](http://bigocheatsheet.com), 非常清晰的展示了算法时间复杂度之间的区别.

* ###### 2018-03-16
很多时候我们在新建的docker镜像里面查找配置文件的时候会很麻烦, 使用`locate`命令会提示没有此命令, 这是我们可以安装mlocate软件, 这样`updatedb`和`locate`命令就都可以使用了.

* ###### 2018-03-14
win10的MS store以及在上面下载的app都是运行在沙箱中的, 其网络流量收到了系统的限制而从本地走, 所以像其他exe程序一样直接使用系统代理, 我们可以通过设置来进行修改, 具体可以参照[该知乎专栏](https://zhuanlan.zhihu.com/p/29989157).


* ###### 2018-03-06
关于各种开源协议的不同, 推荐阮一峰老师一篇博文中的一张图,一看就懂.
![Alt text](https://cdn.safeandsound.cn/image/memo/%E5%BC%80%E6%BA%90%E5%8D%8F%E8%AE%AE.png)

* ###### 2018-03-05
win下使用`power /energy`命令后,正常使用电脑一分钟可以得到电脑的能源效率分析报告.
使用`power /batteryreport`命令后,可以得到一份本机电池的报告,包含电池损耗等信息.

##### 2 月
* ###### 2018-02-26
安装系统时提示硬盘格式不符, 需转换成GPT/MBR时,可在安装界面使用Shift+F10快捷键调出cmd, 使用命令进行转换
```
list disk：显示本机安装的硬盘，编号为0、1、2……
select disk X：选择上面列出的硬盘
clean：清空选中硬盘原有分区信息
convert gpt/mbr：将分区格式转换为GPT/MBR
list partition：显示已有分区
```

* ###### 2018-02-02
cmd下输入`ipconfig /flushdns`, 回车, 即可刷新hosts文件

##### 1 月
* ###### 2018-01-10
今天centos上在安装软件之后手动将软件命令文件所在的bin目录加入`/etc/environment`, 因为我个人喜欢在该文件中配置环境变量, 但是centos7下好像该文件默认为空, 于是我手动添加`PATH=/usr/local/freeradius/bin`, 结果source之后发现其他的环境变量里的命令都找不到了, 如使用`vi`会提示command not found, 要使用`/bin/vi`才行, 于是到现在才发现这样引入环境变量是清空重新引入的过程, 并非是简单的添加, 所以最好还是这样写`PATH=/usr/local/freeradius/bin:$PATH`, 但是有个劣势就是如果多次source的话会让PATH变量中包含多个/usr/local/freeradius/bin路径.

* ###### 2018-01-07
JUnit4中测试中几种常用的注解(主要是@AfterClass,@BeforeClass,@after,@before的区别):
`@Before`：初始化方法,对于每一个测试方法都要执行一次
`@After`：释放资源,对于每一个测试方法都要执行一次
`@Test`：测试方法，在这里可以测试期望异常和超时时间, 如: @Test(expected=ArithmeticException.class)检查被测方法是否抛出ArithmeticException异常
`@Ignore`：忽略的测试方法
`@BeforeClass`：针对所有测试，只执行一次，且必须为static void
`@AfterClass`：针对所有测试，只执行一次，且必须为static void
一个JUnit4的单元测试用例执行顺序为：
`@BeforeClass` -> `@Before` -> `@Test` -> `@After` -> `@AfterClass`
每一个测试方法的调用顺序为：
`@Before` -> `@Test` -> `@After`

* ###### 2018-01-06
今天在Atom的`Sync Settings`插件中用到了github的gist服务, 该服务专门用来存放代码片段, 相当于小的git仓库. 特点是用户可以无限制创建私有gist, 也可以不登陆直接匿名创建gist, 其唯一识别是gist ID, 只要知道id就可以查看内容, 无论其是public || secret, 且与用户无关.
在Gist URL后加上`.pibb`后缀, 可以得到一个纯HTML的版本, 如:`https://gist.github.com/anonymous/cc370d24d7f4be3363ec2f09ad1e0628.pibb`, 这样就可以直接复制粘贴到其他地方了, 如论坛之类.
这方面的使用感觉和n`https://paste.ubuntu.com`有点像.<br>
另,
```shell
:<<BLOCK
这里
全部是
注释
BLOCK
```
可以在shell脚本中进行大段注释;

* ###### 2018-01-03
从GitHub下载单个文件 => `https://raw.githubusercontent.com/username/repository/branch(master)/filename`

#### 2017 年
##### 12 月
* ###### 2017-12-24
从[阮一峰老师的博客](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)学习了一下git commit的写法,在这里摘抄一下:
commit message包括三个部分:`header`,`Body`和`footer`, 形如:
```
<type>(<scope>): <subject>
// 空一行
<body>
// 空一行
<footer>
```
{%note info%}其中`header`是必须的,`body`和`footer`可以省略.
<strong>Header</strong>
header部分只有一行，包括三个字段：type（必需）、scope（可选）和subject（必需）。
`(1)type`
type用于说明 commit 的类别，只允许使用下面7个标识。
feat：新功能（feature）
fix：修补bug
docs：文档（documentation）
style： 格式（不影响代码运行的变动）
refactor：重构（即不是新增功能，也不是修改bug的代码变动）
test：增加测试
chore：构建过程或辅助工具的变动
如果type为feat和fix，则该 commit 将肯定出现在 Change log 之中。其他情况（docs、chore、style、refactor、test）由你决定，要不要放入 Change log，建议是不要。
`(2)scope`
scope用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。
`(3)subject`
subject是 commit 目的的简短描述，不超过50个字符。
以动词开头，使用第一人称现在时，比如change，而不是changed或changes
第一个字母小写
结尾不加句号（.）
<strong>Body</strong>
Body 部分是对本次 commit 的详细描述，可以分成多行。下面是一个范例。
More detailed explanatory text, if necessary.  Wrap it to
about 72 characters or so.
Further paragraphs come after blank lines.
-Bullet points are okay, too
-Use a hanging indent
有两个注意点。
（1）使用第一人称现在时，比如使用change而不是changed或changes。
（2）应该说明代码变动的动机，以及与以前行为的对比。
<strong>Footer</strong>
Footer 部分只用于两种情况。
`(1)不兼容变动`
如果当前代码与上一个版本不兼容，则 Footer 部分以BREAKING CHANGE开头，后面是对变动的描述、以及变动理由和迁移方法。
<pre>BREAKING CHANGE: isolate scope bindings definition has changed.
    To migrate the code follow the example below:
    Before:
    scope: {
      myAttr: 'attribute',
    }
    After:
    scope: {
      myAttr: '@',
    }
    The removed inject wasn't generaly useful for directives so there should be no code using it.</pre>
`(2)关闭 Issue`
如果当前 commit 针对某个issue，那么可以在 Footer 部分关闭这个 issue 。
<pre>Closes #234
也可以一次关闭多个 issue 。
Closes #123, #245, #992</pre>
<strong>Revert</strong>
还有一种特殊情况，如果当前 commit 用于撤销以前的 commit，则必须以revert:开头，后面跟着被撤销 Commit 的 Header。
<pre>revert: feat(pencil): add 'graphiteWidth' option
This reverts commit 667ecc1654a317a13331b17617d973392f415f02.
</pre>
Body部分的格式是固定的，必须写成This reverts commit &lt;hash>.，其中的hash是被撤销 commit 的 SHA 标识符。
如果当前 commit 与被撤销的 commit，在同一个发布（release）里面，那么它们都不会出现在 Change log 里面。如果两者在不同的发布，那么当前 commit，会出现在 Change log 的Reverts小标题下面。
{%endnote%}

* ###### 2017-12-21
在使用`maven package`命令打包项目的时候, 如果我们需要临时跳过测试, 可以加上`-D skipTests`参数来进行设置, 如果是在IDEA上有直接可使用的maven工具插件在项目右侧栏, 其工具栏有一个带闪电的小球, 可触发"skipTests"模式 .

* ###### 2017-12-17
[USTC的ubuntu源文件自动生成器](https://mirrors.ustc.edu.cn/repogen/)

* ###### 2017-12-09
有时候需要在当前文件夹开一个临时的端口来访问一下看看效果可以使用`http-server`.
需要使用npm全局安装http-sever: `npm install -g http-server`
使用http-server在本地开一个临时的server: `http-server -a 127.0.0.1 -p [端口号]`根目录默认为当前目录,也可以直接在http-server后面指定目录地址(相对/绝对都可以),如果不加`-a`参数的话则会默认在本地的几个网卡地址上都进行设置(如:你有一个10.10.10.1的虚拟网卡,如果你有一台虚拟机使用的是这个网卡,则虚拟机也可以访问当前设置的地址)

* ###### 2017-12-06
有些同学不会下载离线完整版的chrome,方法是:google搜索关键词"chrome 帮助",会得到结果"Google Chrome帮助 - Google Support",下面的小标题有"下载和安装Google Chrome",点进去,在"在 Windows 设备上安装 Chrome"下方会有小标题"离线安装 Chrome",点击展开,会出现链接[备用 Chrome 安装程序](https://www.google.com/intl/zh-CN/chrome/browser/desktop/index.html?standalone=1),点击后可以看到打开的页面URL最后有属性`standalone=1`,在该页面下载的chrome即是离线版的.

* ###### 2017-12-01
从浏览器复制网站地址后粘贴到别处,如果地址中有中文,往往发现地址里的中文被转码成了[URL编码](https://zh.wikipedia.org/wiki/百分号编码),如`https://zh.wikipedia.org/wiki/维基百科`被转成了`https://zh.wikipedia.org/wiki/%E7%BB%B4%E5%9F%BA%E7%99%BE%E7%A7%91`,其实使用剪切而非复制就不会出现这种尴尬的问题.

##### 11 月
* ###### 2017-11-29
今天在使用服务器做ss代理的时候一直提示`ERROR: unable to resolve……`，很奇怪，这个配置已经用过很多遍都没出问题，而且明明服务器配置了多个DNS，却显示无法解析域名。
在GitHub[该issue](https://github.com/shadowsocks/shadowsocks-libev/issues/804)中找到了解决办法，在配置文件里加了`"nameserver": "8.8.8.8"`(也就是google的一个DNS)这个字段，问题就解决了，开发者说并不确定问题的根源,但ss是默认从/etc/resolv.conf获取默认DNS服务器的。
然后，在使用proxifier时突然报错
```
[11.29 16:56:25] Error: Windows network (Winsock) is not properly configured to work with Proxifier.
[11.29 16:56:25] Proxifier or some of its parts may work incorrectly.
[11.29 16:56:25] It is highly recommended that you run SysSettings tool to address this problem.
```
	一脸懵逼，之前用还好好的，估计可能是前几天一次win10版本大更新导致的，根据提示中的`SysSettings`，用everything查找了一下系统，发现是proxifier自带的一个设置程序，就在proxifier的安装目录下，进去之后先运行了64位的“SysSettings64.exe”，显示`proxifier module is not installed`，当然是点击install了，安装后重启proxifier，并没什么用（挠头），索性运行了32位的“SysSettings32.exe”，也安装了下，重启，成了。应该是更新时系统把proxifier的部分模块给删了导致的问题。

* ###### 2017-11-29
[Tiny Core](http://distro.ibiblio.org/tinycorelinux/)，仅10+M的linux，因为轻量而被追捧，网上的教程也不少。
进入系统后输入命令，`tce`可以进入Tiny Core Extension，即CLI应用浏览器，按`s`进入搜索模式，输入需要的软件/库名即可，系统会列出相关的选择。
关于Tiny Core Plus，是带GUI的版本，稍大，100+M，在vmware直接从IOS启动时只有选择"Boot Core with only X/GUI (TinyCore)"及以下的启动项才能正常启动，原因未知。

* ###### 2017-11-27
发现`curl v4.ifconfig.co`命令获取本机ip地址的速度比`curl ifconfig.co`来的快得多，好用。
注：适用于虚拟机、云服务器之类使用NAT转换、使用ifconfig命令无法直接获取公网地址的主机。

* ###### 2017-11-20
今天更新kali后发现shadowsocks无法使用，运行后报错：
```bash
AttributeError: /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1: undefined symbol: EVP_CIPHER_CTX_cleanup
```
	看错误应该是加密方面的问题，因为ss依赖openssl，那就应该是openssl的问题了，上网搜了下，[解决办法在此](https://blog.lyz810.com/article/2016/09/shadowsocks-with-openssl-greater-than-110/)

* ###### 2017-11-12
最近比较迷Alvaro Soler的Sofía（一开始以为是情歌，结果查资料才知道是歌手失恋后写的,感情上可以说很乐观了），虽然是西班牙语的民谣，根本不知道在唱什么🌚但是曲子很有活力，节奏感很强，口哨可以轻松带起来。很棒的歌。

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
取消`error_page`的注释，将其修改为`error_page  404 403 500 502 503 504  = /404.html;`
注意：/404.html文件的路径是相对于配置中的`root`字段的值，所以如果`root`字段的值为`/home/wwwroot/default`,那么404.html在系统中的绝对路径为/home/wwwroot/default/404.html。其次，http和https的配置是分开的，所以如果只配置了http的404页面，那么在https协议访问发生资源错误时是不会跳转到http配置中设置的404页面的。
***2.*** http访问配置好的404页面发现不会自动跳转到https。需要我们手动把http流量强制转发到https，在http配置中添加`rewrite ^ https://$server_name$request_uri? permanent;`
***3.*** 修改配置文件后需要重启nginx服务才能生效。如果无法重启，首先使用`nginx -t`命令检测配置文件，如果报错说明是配置文件的错；如果没有报错，使用`netstat -anp|grep :80`查看80端口是否被占，如果被占则需要kill掉使用80端口的进程；如果没有被占，使用`journalctl -xe`查看启动服务时的报错日志进行调试解决。


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
之前linux下查命令参数总是用man配合字符匹配，突然发现有[tldr](https://github.com/tldr-pages/tldr)这种利器，赶紧推一下, `npm install tldr`
<img src="https://cdn.safeandsound.cn/image/memo/tldr.png" width="500px">

* ###### 2017-10-18
推荐一款linux下递归搜索文件内容的软件：[ag](https://github.com/ggreer/the_silver_searcher)，安装步骤：
```bash
git clone https://github.com/ggreer/the_silver_searcher.git
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build
sudo make install
```
	体验还不错，在linux子系统下运行效果图
<img src="https://cdn.safeandsound.cn/image/memo/show-ag.png" width="500px">

* ###### 2017-10-13
发现IOS下的Workflow可以提取网页的json数据，这样就能访问有些网站提供的API直接拿数据了，简直就是一只小爬虫，自己做了一个根据书名从豆瓣拉取图书相关信息的workflow -->[豆瓣读书](https://workflow.is/workflows/cae2c0ec4dd540dab6a773eb0de982bb) <--，感觉查书什么的挺好用的
<img src="https://cdn.safeandsound.cn/image/memo/%E8%B1%86%E7%93%A3%E8%AF%BB%E4%B9%A6workflow.png" width="300px">

* ###### 2017-10-09
当觉得生活无趣又无望时就应该读汪曾祺。
虽说小波的文字也是颇有趣的，但哪个百无聊赖的人喜欢听那么理性的话。
可这么说肯定是有人不同意第二句的。

* ###### 2017-10-08
今天是在行政楼实验室的最后一天。从我的位置看出去的风景还是挺让人放松的。
<img src="https://cdn.safeandsound.cn/image/memo/SDN.jpg" width="500px">
因为领导换届和单位转型为管理单位，所以废除掉SDN实验室，再加上“新增了领导办公室不够用”、“一个领导一个作风，这个实验室是老领导设办的”、“这是和华三一起做的SDN实验室，但你们在这里的学生有几个是做SDN的”等理由，看上去总是很合理的。
但还是感觉似乎不该这样。
可能是因为喜欢在这边学习的氛围和深夜写代码的自由。
我们都知道归属感来之不易。不过这么说起来就很像是心情不好想埋怨些什么的借口了。

* ###### 2017-10-05
推荐一款cli下的mysql客户端，[mycli](https://github.com/dbcli/mycli)，支持语法高亮和命令补全，linux下直接install就有，效果相当棒。
<img src="https://cdn.safeandsound.cn/image/memo/mycli.png">

##### 9 月
* ###### 2017-09-21
ES6的暂时性死区

```
//(1). ES6中的let命令不像var那样具有“变量提升”现象。
console.log(foo);//ReferenceError
let foo=2;
//(2). ES6中只要块级作用域内存在let命令，它所声明的变量就“绑定”（binding）这个区域而不受外部的影响。
var tmp=123;
if (true)
{
  tmp="abc";//ReferenceError
  let tmp;
}

//ES6明确规定，如果区块中存在let和const命令，则这个区块对这些命令声明的变量从一开始就形成封闭作用域。
//总之在代码块内，在let命令声明变量之前，该变量都是不可用的，
//这在语法上成为“暂时性死区”(TDZ,temporal dead zone)。
//再来一个例子:
if(true)
{
  //TDZ开始
  tmp="abc";//ReferenceError
  console.log(tmp);//ReferenceError
  let tmp;//TDZ结束
  console.log(tmp);//undefined
  tmp="abc";
  console.log(tmp);//123
}
```

##### 8 月
* ###### 2017-08-15
又在开源论坛上看到有人在黑php。
php因为其一开始的自身定位问题导致现在的特性有很多地方好像不是那么讨（有些）人喜欢，但是这么些年来的不断改进已经让其无愧于其自身定位了，在小规模的站点开发中，缺点基本可以忽略，况且易上手又适合快速开发让它的门槛变得很低。当然了，有人也因为以上的优点而称PHP为屌丝语言，我个人觉得没必要这样，每一门语言都有其自身的特性，优点和缺点都算是，语言只是一个工具，实在不喜欢换一门就行，没必要一边用一边黑。
开发本来应该是一件很愉快的事，这样可就搞糟了。

* ###### 2017-08-10
今天发现在文件夹下按住shift+鼠标右击打开的cmd/powershell窗口无法获取到在该次登录系统后添加的环境变量, 也就是说你刚添加了环境变量, 但是使用这种方法, 或者在IDE中,如idea里面打开cmd/powershell窗口后却无法使用该环境变量, 需要注销后重新登录系统才会加载, 但是使用传统办法(如run)打开的是可以直接使用的.

##### 7 月
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

* ###### 2017-07-03
第一步，安装中文包：
`sudo apt-get install language-pack-zh-hant language-pack-zh-hans`

第二步，配置相关环境变量：
`sudo vim /etc/environment`
在文件内容末尾另起一行增加语言和编码的设置：

```
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"
```
第三步，重新设置本地配置：
`sudo dpkg-reconfigure locales`
都选择zh_CN.UTF-8

保存重启即可

~~一些零碎的知识点和想说的话放在这里~~
~~以上~~
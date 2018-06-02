vanjaydo.github.io.source 
=========================
[![Build Status]][Appveyor]

该Repo为作者基于hexo框架的博客源码，生成的网站已发布到GitHub Pages，并绑定到[个人域名](http://blog.safeandsound.cn)。

* ### 个性化修改
源码中除了hexo框架和next主题的源码外，作者自己修改的代码部分均用“j's自定义修改”和“j's自定义修改结束”注释进行标注，方便日后修改与他人参考（由于数据量并不小，linux平台下可使用[ag](https://github.com/ggreer/the_silver_searcher)进行文件内容递归查找，windows下可在linux子系统中运行ag。[ag使用教程](https://blog.safeandsound.cn/memo/#2017-10-18)）。<br>
**注：** 其中的404页面作者组合了两个[codepen](https://codepen.io/)上的开源项目， [详情请见此](https://github.com/VanjayDo/front-end-repos/tree/master/404)。

* ### CI
该Repo采用[AppVeyor](https://ci.appveyor.com/projects)平台进行持续集成([教程在此](https://blog.safeandsound.cn/post/Introduction2Appveyor.html))，生成的静态文件发布到 Repo：[vanjaydo.github.io](https://github.com/VanjayDo/vanjaydo.github.io)。

* ### 彩蛋
* #### 404与t-rex-runner游戏页面
访问404页面, 输入back后回车即可返回前一页(若没有前一页则跳转到博客首页), 输入game后回车则可跳转到`t-rex-runner`小恐龙快跑游戏页面.

* #### 控制台中console的输出
在博客的任意非404页面下打开浏览器的控制台, 进入console栏目, 即可看到彩蛋.

* #### 页脚的Innovation
在博客拥有页脚的页面下(如首页), 点击页脚中的Innovation链接, 即可看到彩蛋

* #### 侧边栏的"好听的"按钮
电脑打开侧边栏(移动端则点击顶部的收放按钮), 点击`好听的`按钮即可看到彩蛋

[Appveyor]:    https://ci.appveyor.com/project/VanjayDo/vanjaydo-github-io-source
[Build Status]:https://ci.appveyor.com/api/projects/status/tfw57q6eecippsl5/branch/master?svg=true

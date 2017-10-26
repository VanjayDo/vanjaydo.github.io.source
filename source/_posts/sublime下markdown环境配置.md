---
title: sublime下markdown环境配置
date: 2017-06-06 20:04:46
tags: [sublime]
---
### 介绍
因为用的挺顺手的，所以推荐一下。
我在sublime上编写markdown文档的环境配置是:

*** Markdown Editing + OmniMarkupPreviewer + Markdown Extended + Monokai Extended ***
<!--more-->
#### 插件介绍

[MarkdownEditing](https://github.com/SublimeText-Markdown/MarkdownEditing)作为sublime上编写Markdown必备的插件，不仅可以高亮显示Markdown语法还支持很多编程语言的语法高亮显示（需要主题支持）。

[OmniMarkupPreviewer](https://github.com/timonwong/OmniMarkupPreviewer)用来渲染和预览markdown文档的效果。

这两个插件安装完了以后我们在编写markdown时会发现Markdown文档在Sublime中是默认无高亮的，而且很多主题也不支持Markdown的高亮，而
[Monokai Extended](https://github.com/jonschlinkert/sublime-monokai-extended)和[Markdown Extended ](https://github.com/jonschlinkert/sublime-markdown-extended)的组合很好的解决了这个问题。


以上插件都安装完成后，重启sublime，然后在preferences->color scheme->Monokai Extended 选择一项你顺眼的作为配色模式，再将Markdown Extended选为markdown文档的语法规则即可（view->systax->open all with current extension as 如图）：

<img src="https://cdn.safeandsound.cn/image/sublime下markdown环境配置/markdownExtended.png"  alt="选择markdown extended">

#### Tips
* 1.具体的markdown语法可以参照wowubuntu上的 [这一篇文章](http://wowubuntu.com/markdown/)
* 2.插件使用的小技巧去搜一下就有了，在此就不赘述了

---
title: <p class="entriesTitle"><i class="upside-down" style="font-size:120%;"><i class="fa fa-smile-o" aria-hidden="true" ></i></i><i class="upside-down-right">一些我平时遇到的不理解的词条整理后放在这</i> <i class="fa fa-smile-o" aria-hidden="true" style="font-size:120%;"></i></p>
date: 2017-07-27 15:04:16
---
<title>一些我平时遇到的不理解的词条整理后放在这</title>
<link href="/css/myCSS.css" rel="stylesheet" type="text/css">
<!--////////////////////////////////////////////////////////////////////////-->

* ### 鸭子类型(duck typing)
鸭子类型是动态语言所特有的概念。[Wiki](https://en.wikipedia.org/wiki/Duck_typing)上的解释，有趣的类比"If it walks like a duck and it quacks like a duck, then it must be a duck." 其意为，一个对象的到底是什么是由它的行为所决定的，我们并不关心它本质上是什么(继承自什么对象实现了什么接口)，我们是通过它能干什么来判断它是什么🤔很有趣嘛。

* ### 猴子补丁(monkey patching)
起源:猴子补丁的这个叫法起源于Zope框架，大家在修正Zope的Bug的时候经常在程序后面追加更新部分，这些被称作是“杂牌军补丁(guerilla patch)”，后来guerilla就渐渐的写成了gorllia(猩猩)，再后来就写了monkey(猴子)，所以猴子补丁的叫法是这么莫名其妙的得来的。
它是动态语言所特有的概念，在动态语言中，一切皆对象，例如你可以用一个对象去替换另一个对象的属性，那么这样的话你就可以非常灵活的去进行功能的追加或删改。
关于实际例子，StackOverflow上有相关的问题:[What is monkey patching?](https://stackoverflow.com/questions/5626193/what-is-monkey-patching)

* ### 阻抗失谐(impedance mismatch)
`该词是数据库领域术语, 反用了微波电子学术语"阻抗匹配"(impedance match),用来比喻数据模型与实际编程语言不搭调的窘境。`--摘自《NoSQL精粹(NoSQL Distilled)》
这种"阻抗失谐"的现象(尤其是在关系型数据库中)表现为:关系模型和内存中的数据结构之间存在差异, 如编程语言在内存中构造的数据结构中有"嵌套"的表示, 但是在关系型数据库中却无法包含嵌套记录, 它的关系元组必须是简单的, 这就导致如果要把内存中数据结构的对象持久化到关系型数据库中就必须要将其转换成"关系"形式, 这样关系型数据库才能保存并表达, 这就发生了"阻抗失谐": 需要在两种不同的表示形式之间转译.

* ### 微服务结构 & 单体式应用
最近看书时总是看到拿[微服务结构](https://zh.wikipedia.org/wiki/微服務)与[单体式应用](https://zh.wikipedia.org/wiki/單體式應用程式)对比, 在此归纳总结一下.
#### *微服务*
微服务是以专注于单一责任与功能的小型功能模块为基础，利用模组化的方式组合出复杂的大型应用程序。
其比较明显的特性有:1.独立性(有些地方也叫真空性),微服务模式中的每一个组成部分都是一个服务,各个服务彼此独立, 有完整的运行机制与对外接口; 2.服务是粒度最小的单位, 不可再分, 即一个微服务不能进一步划分为多个更小的服务; 3.服务能够快速重组成新的系统, 就像积木一样, 体现了模块化.
#### *单体式应用*
一个单体式应用里面有许多的逻辑、服务，并且都有密不可分的关系。一旦其中一个服务不可用时，就会造成另一个服务也无法使用.虽然外部结构看起来会比较简单, 但是在资源分配、测试、拓展等各方面看来都不够灵活.（所以你知道微服务的优势在哪了）
	一个比较好理解二者之间区别的例子就是, 微服务就像是docker, 而单体式应用就像是传统的虚拟机(这只是我在理解过程中的一个比喻, 不一定准确).

* ### IaaS/PaaS/SaaS/XaaS
这里所谓的`*aaS`即"`* as a Service`", 本质就是把`*`当作服务来进行出售.
[IaaS](https://zh.wikipedia.org/wiki/基础设施即服务)(Infrastructure as a Service, 基础设施即服务),其意指如果你只是要使用硬件设备罢了, 那就没有必要花巨资购买整套设备并为设备用地以及今后的维护、设备拓展/更新买单,你可以租用硬件, IaaS方面的公司(如Amazon[AWS])会提供服务器,存储器等硬件设备,这样就可以节约成本，利用对方公司提供的服务， 你可以随时使用这些设备来运行你的服务/应用。
[PaaS](https://zh.wikipedia.org/wiki/平台即服务)(Platform as a Service,平台即服务)，这里的平台有时也叫做中间件，即云计算环境中的应用基础设施服务，也就是支撑应用和运行时环境，如虚拟服务器、操作系统、应用服务器、数据库等
[SaaS](https://zh.wikipedia.org/wiki/软件即服务)(Software as a Service,软件即服务),也就是软件提供服务了, 这个很好理解
	IaaS,PaaS,SaaS其实是云计算领域的三个概念,基础设施在最下面,平台在中间,软件则在最上面, 如果你什么都有, 那么就是本地部署, 也就无所谓这些*aaS了. 
XaaS也就是Anything as a Service，可以说IaaS，PaaS，SaaS是其子集
以上内容部分参考了<i class="from fa fa-arrow-circle-right"> 何足道 [知乎回答](https://www.zhihu.com/question/21641778/answer/62523535)</i>

* ### 方言 Dialect(computing)
此处指计算机行业中的dialect, 其意为一门编程语言或数据交换语言的拓展或者变种形式(摘自<a href="https://en.wikipedia.org/wiki/Dialect_(computing)">wiki</a>,`A dialect of a programming language or a data exchange language is a (relatively small) variation or extension of the language that does not change its intrinsic nature`)
如各个关系型数据库厂商的SQL方言; Clojure是一种Lisp方言; 等

* ### CI/CD/CR
[持续集成](https://zh.wikipedia.org/wiki/持续集成)(CI, Continuous integration),[持续交付](https://zh.wikipedia.org/wiki/持续交付)(CD, Continuous delivery),[持续部署](https://zh.wikipediaorg/wiki/持续部署)(CR, Continuous release)
所谓`持续`的思想就是: 既然我们知道开发的需求很难一次性完整的定下来, 那么我们就一点一点的开发, 每一次功能完成后再加到主体上去, 这样使得开发过程更加(敏捷&灵活), 有错可以及时更改, 与最后一次性对系统进行合并/集成然后再构建 测试 发布相比(风险&损失)更小, 也就符合了极限编程的要求. 持续是指整个过程中项目功能的合并, 构建, 测试, 发布产品等, 这些环节是持续的.
持续集成很好理解, 给出的wiki链接页面中解释得很清楚, 就是每次一点代码(在开发者通过构建&测试之后)集成到主线.
持续交付是指将集成后的代码通过更真实的类生产环境的测试后部署到生产环境中, 但是是否部署是可选的, 部署是手动的.
而持续部署就是在持续交付的基础上进行全自动的部署. 如wiki中所描述的`如果要实施持续部署，必须先实施持续交付`.



* ### 几种流行的部署技术
#### *蓝绿部署*
[蓝绿部署](http://sunitspace.blogspot.jp/2013/10/blue-green-deployment.html)(Blue/Green Deployment)的特点是无停机时间且风险较小,具体的流程介绍在链接的博客里已经说的很清楚了,在此不赘述.
#### *滚动部署*
停止部分服务并对其进行更新,完成后投入重新使用.如此重复直到所有服务都更新为新的版本.但是在升级的过程中,服务运行的环境是变化的,你并不知道哪个时候的环境是稳定,所以如果需要回滚的话,那就要回滚到稳定的环境里,意味着可能要从头再来.
#### *灰度部署*
不停止老版本的服务,另外开一个新版本的服务给用户使用,新版本出现问题即可回滚.
因为跳跃式发布是很危险的,所以需要像灰度(指从黑白之间)这种平滑过渡的发布.
与A/B测试一样,本质就是发布多个版本看效果如何,也就是试错,有问题就回滚,经过一段时间的验证后没问题就正式发布.


* ### REST架构
根据[wiki定义](https://zh.wikipedia.org/wiki/%E5%85%B7%E8%B1%A1%E7%8A%B6%E6%80%81%E4%BC%A0%E8%BE%93)："具象状态传输（REST，英文：Representational State Transfer）是Roy Thomas Fielding博士于2000年在他的博士论文[1] 中提出来的一种万维网软件架构风格，目的是便于不同软件/程序在网络（例如互联网）中互相传递信息。"wiki中提到“REST是设计风格而不是标准”，这是很重要的一点，首先在理解之前你不能误解它本身的含义和存在的意义。
<div class="div-border-left-yellow">具象状态传输架构风格最重要的架构约束有6个[2]：
客户-服务器（Client-Server）
通信只能由客户端单方面发起，表现为请求-响应的形式。
无状态（Stateless）
通信的会话状态（Session State）应该全部由客户端负责维护。
缓存（Cache）
响应内容可以在通信链的某处被缓存，以改善网络效率。
统一接口（Uniform Interface）
通信链的组件之间通过统一的接口相互通信，以提高交互的可见性。
分层系统（Layered System）
通过限制组件的行为（即每个组件只能“看到”与其交互的紧邻层），将架构分解为若干等级的层。
按需代码（Code-On-Demand，可选）
支持通过下载并执行一些代码（例如Java Applet、Flash或JavaScript），对客户端的功能进行扩展。"。
<i class="from fa fa-arrow-circle-right"> wiki  [具象状态传输](https://zh.wikipedia.org/wiki/具象状态传输)
</div>
	我的理解是，REST就是定义一个系统/软件的架构,以及如何设计出RESTful API的，它让系统对外提供的接口更加规范（也就是符合REST风格），如REST的提出者Roy Thomas Fielding在他提出REST的[博士论文](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)中所说:"My work is motivated by the desire to understand and evaluate the architectural design of network-based application software through principled use of architectural constraints, thereby obtaining the functional, performance, and social properties desired of an architecture."这些RESTful的接口将会“功能强大，性能出色且友好易用”。

* ### 编程语言的自举
首先一提，能够自举是一门编程语言成熟的标志之一（不能不代表不成熟）。简单来说就是语言自身的编译器可以编译自己的编译器。引用知乎上轮子哥的回答比较简单易懂：
<div class="div-border-left-yellow">你想创造一门V语言而且用V语言来写V编译器的话，你得按照下面的方法做：
1、用C++把那个编译器（A）写出来，顺便留下很多测试用例。
2、用V语言把那个编译器写（B）出来，用A.exe来编译B，修改直到所有测试用例都通过为止。
3、B.exe来编译B自己得到B2.exe，修改直到B2.exe所有测试用例都通过为止。这是为了保证，就算B本身有很多bug，至少编译自己是没有bug的，从而你就可以走到第四步。
4、当你觉得有信心了，用A.exe把B编译一遍，就得到了B.exe。然后A的代码和A.exe都在也不需要存在了，删掉他们。以后你就不断的用B.exe来编译下一个版本的B就好了。就自举了。
<i class="from fa fa-arrow-circle-right">  vczh [知乎回答](https://www.zhihu.com/question/28513473/answer/41094452)</i>
</div>
	那么图灵完备的语言是不是都可以自举呢？从我个人“没有哪一门图灵完备语言实现的功能是另一门图灵完备语言所不能实现的”的观点来看答案是肯定的。觉得没有必要在“能不能”和“有没有实现”这个问题上纠结，这只是编程语言的一种性质，能不能自举是一回事，有没有必要真的实现就是另一回事了。

* ### 图灵完备
wiki描述：“在可计算性理论里，如果一系列操作数据的规则（如指令集、编程语言、细胞自动机）可以用来模拟单带图灵机，那么它是图灵完备的”。图灵机的基本思想是“用机器来模拟人们用纸笔进行数学运算的过程”，也就是说图灵机能执行所有可被描述的计算。
存在着一类问题我们人类能构造出来而图灵机是不能解的，那就是悖论。悖论是不具有可计算性的，如典型的停机问题等。
关于图灵机推荐[这一篇论文](http://www.swarma.net/vm/articles/turing.pdf)。
#### * 编程语言的图灵完备性 *
图灵完备的语言也就是可以模拟出图灵机的语言，大部分的GPL（General Purpose Language，通用编程语言）基本都是（所以在项目实践中谈语言是否图灵完备的意义并不大），所以也易知没有哪门图灵完备语言实现的功能是另一门图灵完备语言所不能实现的（只是过程的难易程度，也就是开发成本不同）。
相对于GPL，大部分的DSL（Domain Specific Language，领域专用语言）都不是图灵完备的，典型的就是SQL（指SQL92标准，T-SQL之类不属于）、html等。

* ### 语法糖
wiki描述：“语法糖（Syntactic sugar），也译为糖衣语法，是由英国计算机科学家彼得·兰丁发明的一个术语，指计算机语言中添加的某种语法，这种语法对语言的功能没有影响，但是更方便程序员使用。语法糖让程序更加简洁，有更高的可读性”。
在我理解，语法糖的存在其实就是为了让代码写起来更简洁&读起来更舒服（但是我感觉它与可读性的关系并不是绝对的正相关，因为一种写法对熟悉这门语言特性的人来说可能很舒服，但是不熟悉的人可能就很难理解，编程和理解的能力永远是相对而言的），其在绝大多数情况下并不会影响到语言（特别是编译型语言）执行的效率，因为它在被语言处理器（编译器、静态分析器等）处理的过程中就被转换掉了（有点类似C++内联函数的意思），该过程如wiki所言：“把‘加糖’的结构变成基本的结构，这个过程叫做‘去糖’”。
#### *语法盐*
类似的也有语法盐。wiki描述：“语法盐（英语：syntactic salt）是指在计算机语言中为了降低程序员撰写出不良程式码的设计，但其中仍会有潜藏错误存在的可能。例如，C语言或C++语言中Switch指令的case中若不加break编译器并不会产生错误讯息，部分程序员认为宣告变数型态也是语法盐的一种”。
Wiki上还举了一个容易理解的java的例子：Java中并不允许将一个宣告为float类型的变量赋值给一个宣告为int类型的变量，但是C和C++会自动把float类型的变量舍去小数并赋值给int类型的变量。
```java
int num1;
float pi=3.14159;
num1=pi;  //赋值错误
```

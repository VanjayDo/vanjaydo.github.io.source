---
title: <p class="entriesTitle"><i class="upside-down" style="font-size:120%;"><i class="fa fa-smile-o" aria-hidden="true" ></i></i><i class="upside-down-right">一些我平时遇到的不理解的词条整理后放在这</i> <i class="fa fa-smile-o" aria-hidden="true" style="font-size:120%;"></i></p>
date: 2017-07-27 15:04:16
---
<title>一些我平时遇到的不理解的词条整理后放在这</title>
<link href="/css/myCSS.css" rel="stylesheet" type="text/css">

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
<i class="from fa fa-arrow-circle-right"> wiki https://zh.wikipedia.org/wiki/具象状态传输
</div>
	我的理解是，REST就是定义如何设计出RESTful API的，它让系统对外提供的接口更加规范（也就是符合REST风格），如REST的提出者Roy Thomas Fielding在他提出REST的[博士论文](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)中所说:"My work is motivated by the desire to understand and evaluate the architectural design of network-based application software through principled use of architectural constraints, thereby obtaining the functional, performance, and social properties desired of an architecture."这些RESTful的接口将会“功能强大，性能出色且友好易用”。

* ### 编程语言的自举
首先一提，能够自举是一门编程语言成熟的标志之一（不能不代表不成熟）。简单来说就是语言自身的编译器可以编译自己的编译器。引用知乎上轮子哥的回答比较简单易懂：
<div class="div-border-left-yellow">你想创造一门V语言而且用V语言来写V编译器的话，你得按照下面的方法做：
1、用C++把那个编译器（A）写出来，顺便留下很多测试用例。
2、用V语言把那个编译器写（B）出来，用A.exe来编译B，修改直到所有测试用例都通过为止。
3、B.exe来编译B自己得到B2.exe，修改直到B2.exe所有测试用例都通过为止。这是为了保证，就算B本身有很多bug，至少编译自己是没有bug的，从而你就可以走到第四步。
4、当你觉得有信心了，用A.exe把B编译一遍，就得到了B.exe。然后A的代码和A.exe都在也不需要存在了，删掉他们。以后你就不断的用B.exe来编译下一个版本的B就好了。就自举了。
<i class="from fa fa-arrow-circle-right">  vczh https://www.zhihu.com/question/28513473/answer/41094452</i>
</div>
	那么图灵完备的语言是不是都可以自举呢？从我个人“没有哪一门图灵完备语言实现的功能是另一门图灵完备语言所不能实现的”的观点来看答案是肯定的。觉得没有必要在“能不能”和“有没有实现”这个问题上纠结，这只是编程语言的一种性质，能不能自举是一回事，有没有必要真的实现就是另一回事了。

* ### ES6的暂时性死区

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
#### * 语法盐 *
类似的也有语法盐。wiki描述：“语法盐（英语：syntactic salt）是指在计算机语言中为了降低程序员撰写出不良程式码的设计，但其中仍会有潜藏错误存在的可能。例如，C语言或C++语言中Switch指令的case中若不加break编译器并不会产生错误讯息，部分程序员认为宣告变数型态也是语法盐的一种”。
Wiki上还举了一个容易理解的java的例子：Java中并不允许将一个宣告为float类型的变量赋值给一个宣告为int类型的变量，但是C和C++会自动把float类型的变量舍去小数并赋值给int类型的变量。
```java
int num1;
float pi=3.14159;
num1=pi;  //赋值错误
```

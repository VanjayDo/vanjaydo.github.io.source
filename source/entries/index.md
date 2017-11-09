---
title: <p class="entriesTitle"><i class="upside-down" style="font-size:120%;"><i class="fa fa-smile-o" aria-hidden="true" ></i></i><i class="upside-down-right">一些我平时遇到的不理解的词条整理后放在这</i> <i class="fa fa-smile-o" aria-hidden="true" style="font-size:120%;"></i></p>
date: 2017-07-27 15:04:16
---
<title>一些我平时遇到的不理解的词条整理后放在这</title>
<link href="/css/myCSS.css" rel="stylesheet" type="text/css">
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

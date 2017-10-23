---
title: web应用从网页插入中文到mysql变成乱码的解决办法
date: 2017-03-12 22:15:13
tags: [mysql]
---
### 前言
相信既然这么进来了，那么问题肯定是差不多的，下面直接讲述解决办法：
<!-- more -->
### 解决办法

#### 首先在mysql配置文件my.ini中进行配置修改

```
#搜索找到[mysqld]，在它下面添加配置，如下
[mysqld]
character-set-server = utf8

#搜索找到[mysql]，在它下面添加配置，如下
[mysql]
default-character-set = utf8
```
#### 修改连接编码和中文字段编码
接下来我是从phpmyadmin上操作的，如果你没有可视化操作界面，那就转换成sql语句来操作吧。

```sql
set names "uft8";
```

再将所有需要插入中文的字段进行结构修改：
例如下面的message字段
![修改结构](http://cdn.safeandsound.cn/image/web应用从网页插入中文到mysql变成乱码的解决办法/修改.png)


将排序规则修改为utf8_general_ci

![排序规则](http://cdn.safeandsound.cn/image/web应用从网页插入中文到mysql变成乱码的解决办法/utf8.png)


### 赘述
我曾多次遇到这种问题都是这么解决的，也曾利用修改排序规则的方法帮同学结果过类似问题，在此仅供参考。
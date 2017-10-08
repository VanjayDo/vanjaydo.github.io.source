---
title: 关于php下实现异步计划任务的一种方法
date: 2017-09-10 10:23:21
tags: [php]
---
### 前言
在一个网络管理系统的实现过程中需要完成这样一个功能，老师在上课时通过交互界面将该教室的网络关闭，课程结束后系统将自动将教室网络开放，这有两方面的要求，首先是计划任务的实现：下课后自动恢复网络，这里使用循环来检查任务执行情况，因为如果全部都写到操作系统的计划任务中那就太繁重了（当然也可以只写一个系统的计划任务，将它和数据库结合起来实现，这是我最后采用的方法）；二就是老师提交“关闭网络”的请求时应当异步处理，因为计划任务是死循环，如果不进行异步处理则页面将永远处于加载状态直到用户强制阻断或任务执行结束。

<!-- more -->
### 具体过程

#### 计划任务唯一化
因为一堂课上可能会多次切换网络状态，所以必须让当前教室的网络恢复计划任务唯一化，新的计划任务应当取代旧的，这里我使用文件flag的方式来实现：用$_SESSION['ID']加上当前时间戳的方式来命名flag文件，$_SESSION['ID']为用户ID，由于老师一堂课只能在一个教室上课，所以这是唯一的；当前时间戳（time()函数获取）精确到秒，足够保证用户在这个时间段内操作唯一。
每一次生成计划任务时我们都生成这样一个文件保存在flag文件夹中，并将文件名传给任务函数，让它去检查这个文件状态，存在的话则任务有效，否则终止任务；相对的，生成新任务时，我们把flag文件夹中的所有以当前$_SESSION['ID']开头的flag文件全部删除，再生成新的任务和flag，这样旧的任务就会失效，由此保证任务的唯一性。

#### 异步
这里是用fsockopen函数来实现异步，这样实现的好处就是有很大的自定义空间，例如相比于popen()函数的不可传递参数。

#### 代码
```php
//user.php
//作用：用户交互界面，提交数据给set-network.php
//代码如下：
$url = "http://localhost:8081/tch/set-network.php";
sock_get($url, $_GET["network"], $_GET["classroomName"],$endTimestamp);
//fsockopen模拟get提交函数
function sock_get($url, $network, $classroomName, $endTimestamp)
{
    //设置get提交的数据
    $data = array(
        "network" => $network,
        "classroomName" => $classroomName,
        "endTimestamp" => $endTimestamp);
    $http_data = http_build_query($data);
    $info = parse_url($url);
    $fp = fsockopen($info["host"], $info["port"], $errno, $errstr, 3);
    $head = "GET " . $info['path'] . "?" . $http_data . " HTTP/1.0\r\n";
    $head .= "Host: " . $info['host'] . ":" . $info['port'] . "\r\n";
    $head .= "\r\n";
    fputs($fp, $head);
    fclose($fp);
}



//set-network.php
//作用：从用户操作接收数据用来生成计划任务
//代码如下：
require "restore-network.php"
//查找当前用户有无已存在的flag，有的话删除，即终止已存在的恢复网络计划任务
$search = glob("./flags/" . $_SESSION['ID'] . "*");
if ($search) {
    foreach ($search as $item) {
        unlink($item);
    }
}
$flag = "./flags/" . $_SESSION["ID"] . time() . ".flag";
file_put_contents($flag, "", FILE_APPEND);
$schedule = new restore_network();
$schedule->keepWake($flag, $endTimestamp);



//restore-network.php
//作用：计划任务和恢复网络的功能实现
//代码如下：
ignore_user_abort();//关掉浏览器，PHP脚本也可以继续执行.
set_time_limit(0);//设置不响应最长时间不受限制,让程序可以无限制的执行下去
//定时任务函数，不断循环来定时执行任务
function keepWake($flagFile, $endTimestamp)
{
    //当前时间戳比结束时间戳小则一直循环
    while (time() < $endTimestamp) {
        // 定时任务终止条件:本任务的flag文件不存在
        if (!file_exists($flagFile)) {
            die('process terminated');
        }
        sleep(120);
    }
    //删除flag文件
    unlink($flagFile);
    //执行恢复网络功能函数，这不是重点，在此忽略函数内容
    $this->restoreNet();
}

```

### 赘述
尽管我最后用的并不是这种解决办法，因为考虑到万一web服务器软件宕掉的话那么这些计划任务都会丢失，我采用了将定时任务所需的参数存入数据库，再将一个php脚本写入操作系统计划任务中（如linux的crontab），每隔几分钟执行一遍，由这个脚本去数据库查询是否有到期的定时任务，有的话则调出数据进行执行，再数据库中相应的任务删除。整个过程可能考虑的不是很周到，只能算是一个实现目标的方法。
---
title: 使用Mysql2Redis自动更新数据到Redis
urlname: PushData2RedisWithMysql2Redis
date: 2018-05-21 23:33:49
tags: [Mysql, Redis, Docker]
---

最近在写的项目想用上Redis作为缓存层, 但是对于后端的mysql数据在数据写入后如何更新到缓存却感到很棘手, 后了解到mysql的udf+trigger可以实现, GitHub开源项目[mysql2redis](https://github.com/dawnbreaks/mysql2redis)刚好解决了更新数据所需的udf的问题.

在使用过程中踩了一些坑, 在此总结一下.

<!-- more -->

### 前述
首先需要说明的是, 对于mysql2redis作者在项目readme中提及的[项目依赖](https://github.com/dawnbreaks/mysql2redis#dependencies), 其中的[lib_mysqludf_json](https://github.com/mysqludf/lib_mysqludf_json)库主要是添加的mysql对于json数据的支持, 但需要说明的是自mysql5.7.8, mysql已经支持原生json数据类型, 而mysql 中也有了原生的json_array和json_object函数, 故`lib_mysqludf_json`库在mysql5.7.8版本以后是不需要的. 如果你想要使用`lib_mysqludf_json`, 那么你需要注意: 

1. `lib_mysqludf_json`项目中编译好的`lib_mysqludf_json.so`文件是32位的, 如果你的mysql是64位的, 那么你需要自己编译该文件; 
2. 由于mysql5.7.8及以后的版本中有了原生的json_array和json_object函数, 所以, `lib_mysqludf_json`库中的`json_array`和`json_object`函数是不能直接注册到mysql中的, 因为不能有重名函数, 所以你需要在`lib_mysqludf_json.c`文件中将`json_array`和`json_object`函数重命名; 
这里有我将整个项目中的函数名修改好了的库 👉 [VanjayDo/lib_mysqludf_json](https://github.com/VanjayDo/lib_mysqludf_json)

### Docker
由于类似的应用场景也不少, 所以我构建了一个包含mysql2redis库中所有udf的mysql镜像 👇 可以直接使用

#### Dockerfile
[Mysql2Redis Dockerfile](https://github.com/VanjayDo/store/blob/master/docker-MysqlWithMysql2Redis/Dockerfile)

#### DockerImage
[DockerHub 👉 vanjaydo/mysql2redis](https://hub.docker.com/r/vanjaydo/mysql2redis/)

使用命令`docker run -d --name mysql2redis --env MYSQL_ROOT_PASSWORD=123456 vanjaydo/mysql2redis --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci`即可启动使用

### 使用教程
进入mysql后, 使用`use mysql;`命令切到mysql库, 然后使用`select * from func;`即可查看到之前设置的mysql2redis相关的udf, 如下👇

```
mysql> select * from func;
+----------------------+-----+--------------------------+----------+
| name                 | ret | dl                       | type     |
+----------------------+-----+--------------------------+----------+
| redis_servers_set_v2 |   2 | lib_mysqludf_redis_v2.so | function |
| redis_command_v2     |   2 | lib_mysqludf_redis_v2.so | function |
| free_resources       |   2 | lib_mysqludf_redis_v2.so | function |
+----------------------+-----+--------------------------+----------+
3 rows in set (0.00 sec)
```

#### 设置Trigger
推数据到redis的功能已经在mysql2redis库的函数中实现了, 现在的关键是什么时候推, 总不能每次都手动调用函数. 这里我们可以在相关的数据库中设置触发器, 根据一定的条件自动调用执行函数推送数据到redis

切到你要使用的数据库后, 设置能实现你想要效果的触发器, 例如👇

```
DELIMITER $$
CREATE TRIGGER Your_Trigger_Name AFTER INSERT ON Your_Table
FOR EACH ROW 
BEGIN
SET @ret1=redis_servers_set_v2("redis_server_ip", 6379);
SET @ret2=redis_command_v2("set", concat("id:", NEW.id), NEW.value);
SET @ret3=free_resources()
END$$
DELIMITER ;
```
**注:**mysql的trigger中不能用select直接返回函数结果, 如下👇

```
DELIMITER $$
CREATE TRIGGER Your_Trigger_Name AFTER INSERT ON Your_Table
FOR EACH ROW 
BEGIN
select redis_servers_set_v2("redis_server_ip", 6379);
select redis_command_v2("set", concat("id:", NEW.id), NEW.value);
END$$
DELIMITER ;
```

否则会报错 👉 `ERROR 1415 (0A000): Not allowed to return a result set from a trigger`.

这是因为mysql限制触发器不允许返回数据集，所以触发器所调用的函数或存储过程也不可以返回数据集

以上的例子使用的是redis中的`set`命令, 简单的设置一个键值对, 如果你想要缓存到redis的字段很多, 可以使用`hmset`命令进行设置.
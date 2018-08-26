---
title: SpringBoot多个数据源配置
urlname: ConfigSpringBootWithMultiDataSources
date: 2018-08-10 23:50:26
tags: [Java, SpringBoot]
---

本文涉及SpringBoot框架在使用过程的数据源配置, 主要是多数据源配置以及一些常见问题的解决办法.

<!-- more -->

### 前述
有些时候一个后端程序中会有配置多个数据源的需求, 由于之前并没有相关的实践, 最近在项目实现的时候遇到了, 在此记录一下. 

关于配置多个DataSource的实现参考的是廖雪峰老师的博客文章[Spring Boot配置多个DataSource](https://www.liaoxuefeng.com/article/001484212576147b1f07dc0ab9147a1a97662a0bd270c20000)以及[CSDN](https://blog.csdn.net/anxpp/article/details/52274120)上的一篇文章.

#### 完整的项目
完整的项目地址 👉 [eduroamControlSystem-Backend](https://github.com/UPC-eduroam/eduroamControlSystem-Backend)

### 配置步骤与实现
此处的两个数据源都是mysql的数据库. 

值得一提的是, 下面的`primary`是项目自己的数据库, 而`radius`则是外部的数据库, 只是读取数据用来进行分析的.

#### 配置文件
项目配置文件`application.yml`中关于数据源的配置 👇

```
spring:
    primary:
        datasource:
            url: jdbc:mysql://ip:3306/eduroam_control_system?useSSL=false
            username: eduroam
            password: eduroam_control_system
            driver-class-name: com.mysql.jdbc.Driver
            test-while-idle: true
            validation-query: SELECT 1

    #配置对eduroam进行AAA的radius服务器数据库,注意数据库名一致
    radius:
        datasource:
            url: jdbc:mysql://ip:3306/radius?useSSL=false
            username: eduroam
            password: eduroam_control_system
            driver-class-name: com.mysql.jdbc.Driver
            test-while-idle: true
            validation-query: SELECT 1

    jpa:
        show-sql: true
        hibernate:
            ddl-auto: update
            naming:
              physical-strategy: org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy
```

#### 配置数据源
配置两个数据源 👇

```
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {
    @Bean(name = "primaryDataSource")
    @Primary
    @ConfigurationProperties(prefix = "spring.primary.datasource")
    public DataSource primaryDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "radiusDataSource")
    @ConfigurationProperties(prefix = "spring.radius.datasource")
    public DataSource secondDataSource() {
        return DataSourceBuilder.create().build();
    }
}
```

#### 分别配置详细信息
`primary`的配置 👇

```
import java.util.Map;
import javax.persistence.EntityManager;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.orm.jpa.JpaProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
        entityManagerFactoryRef = "entityManagerFactoryPrimary",
        transactionManagerRef = "transactionManagerPrimary",
        basePackages = {"cn.edu.upc.eduroamcontrolsystembackend.dao.primary"}) //设置该数据源的DAO(repo)层所在目录

public class PrimaryDBConfig {
    @Autowired
    private JpaProperties jpaProperties;

    @Autowired
    @Qualifier("primaryDataSource")
    private DataSource primaryDataSource;

    @Bean(name = "entityManagerPrimary")
    @Primary
    public EntityManager entityManager(EntityManagerFactoryBuilder builder) {
        return entityManagerFactoryPrimary(builder).getObject().createEntityManager();
    }

    @Bean(name = "entityManagerFactoryPrimary")
    @Primary
    public LocalContainerEntityManagerFactoryBean entityManagerFactoryPrimary(EntityManagerFactoryBuilder builder) {
        return builder
                .dataSource(primaryDataSource)
                .properties(getVendorProperties(primaryDataSource))
                .packages("cn.edu.upc.eduroamcontrolsystembackend.model.primary") //设置该数据源的实体类所在目录
                .persistenceUnit("primaryPersistenceUnit")
                .build();
    }

    private Map<String, String> getVendorProperties(DataSource dataSource) {
        return jpaProperties.getHibernateProperties(dataSource);
    }

    @Bean(name = "transactionManagerPrimary")
    @Primary
    PlatformTransactionManager transactionManagerPrimary(EntityManagerFactoryBuilder builder) {
        return new JpaTransactionManager(entityManagerFactoryPrimary(builder).getObject());
    }
}
```

`radius`的配置👇

```
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.orm.jpa.JpaProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import javax.persistence.EntityManager;
import javax.sql.DataSource;
import java.util.Map;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
        entityManagerFactoryRef = "entityManagerFactoryRadius",
        transactionManagerRef = "transactionManagerRadius",
        basePackages = {"cn.edu.upc.eduroamcontrolsystembackend.dao.radius"}) //设置该数据源的DAO(repo)层所在目录
public class RadiusDBConfig {

    @Autowired
    private JpaProperties jpaProperties;

    @Autowired
    @Qualifier("radiusDataSource")
    private DataSource radiusDataSource;

    @Bean(name = "entityManagerRadius")
    public EntityManager entityManager(EntityManagerFactoryBuilder builder) {
        return entityManagerFactoryRadius(builder).getObject().createEntityManager();
    }

    @Bean(name = "entityManagerFactoryRadius")
    public LocalContainerEntityManagerFactoryBean entityManagerFactoryRadius(EntityManagerFactoryBuilder builder) {
        return builder
                .dataSource(radiusDataSource)
                .properties(getVendorProperties(radiusDataSource))
                .packages("cn.edu.upc.eduroamcontrolsystembackend.model.radius") //设置该数据源的实体类所在目录
                .persistenceUnit("radiusPersistenceUnit")
                .build();
    }

    private Map<String, ?> getVendorProperties(DataSource dataSource) {
        return jpaProperties.getHibernateProperties(dataSource);
    }

    @Bean(name = "transactionManagerRadius")
    PlatformTransactionManager transactionManagerRadius(EntityManagerFactoryBuilder builder) {
        return new JpaTransactionManager(entityManagerFactoryRadius(builder).getObject());
    }
}
```

### 多个数据源中数据库服务器版本不一致
如果出现了配置的多个数据源中使用的同一种数据库服务器, 但是数据库服务器的版本不一致, 比如有5和8两种, 官网对于`MySQL Connector/J 8.0`给出的说法是`MySQL Connector/J 8.0 is compatible with all MySQL versions starting with MySQL 5.5. `, 即8的驱动可以兼容mysql5.5及以上的版本. 如果有mysql服务器的版本更低的话, 那么在不可升级(升级代价比兼容代价更高)的情况下只能使用5的版本去兼容8的服务器, 我在本项目中的数据库服务器就是这种情况, 一个是学校的生产环境服务器上的`5.1.73`版本, 一个是分配给我的服务器中跑的`8.0`的docker容器. 效果并没有那么差.

关于常见的几个因为mysql8使用版本5驱动 的错误, 在之前的备忘录中也有提及, 链接如下 👇

* [Public Key Retrieval is not allowed](https://blog.safeandsound.cn/memo/#2018-08-21)

* [Unknown system variable 'query_cache_size'](https://blog.safeandsound.cn/memo/#2018-07-31)

* [Unable to load authentication plugin 'caching_sha2_password'](https://blog.safeandsound.cn/memo/#2018-07-29)

### 关于mysql自动断开连接
mysql默认维持一个连接8小时, 如果一个连接在8小时内没有操作的话, 服务器会主动将连接关闭, 其后果就是你的后端在此之后无法访问数据库.

解决办法有三👇

#### 修改mysql配置
其一修改mysql的配置文件, 将该时间延长, windows下为`my.ini`文件, linux下为`my.cnf`文件, 增加如下内容(如果是linux下则需要加到`[mysqld]`该行下)👇

```
interactive_timeout=n
wait_timeout= n
```

以上n为整数, 单位为秒, 不配置的话则默认为28800, 即八小时
但该值无法被设置为无限大, 而且修改配置文件比较繁琐, 所以不建议使用该方法

#### 添加jdbc链接参数
设置jdbc链接中的参数`autoReconnect`值为true, 如下 👇

```
jdbc:mysql://localhost:3306/test?autoReconnect=true
```

但是该参数在mysql8的官方文档中并不建议使用, 👉[官方文档见此](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-configuration-properties.html)👈, 相关部分摘写如下 👇

{%note default%}
autoReconnect

Should the driver try to re-establish stale and/or dead connections? If enabled the driver will throw an exception for a queries issued on a stale or dead connection, which belong to the current transaction, but will attempt reconnect before the next query issued on the connection in a new transaction. The use of this feature is not recommended, because it has side effects related to session state and data consistency when applications don't handle SQLExceptions properly, and is only designed to be used when you are unable to configure your application to handle SQLExceptions resulting from dead and stale connections properly. Alternatively, as a last option, investigate setting the MySQL server variable "wait_timeout" to a high value, rather than the default of 8 hours.

Default: false

Since version: 1.1
{%endnote%}

#### 开发配置文件
第三个方法就是让后端主动去维护这个链接, 让它在数据库连接空闲的时候去产生动作进行测试, 以保证连接的有效性

这里以Springboot为例, datasource配置如下 👇

```
spring:
	datasource:
        url: jdbc:mysql://localhost:3306/test?useSSL=false
        username: ***
        password: ***
        driver-class-name: com.mysql.jdbc.Driver
        test-while-idle: true  					# 当连接空闲的时候进行测试
        validation-query: SELECT 1 		# 用来验证连接有效性的sql语句
```

这样配置数据源就可以保证程序运行过程中数据源连接的有效性了.
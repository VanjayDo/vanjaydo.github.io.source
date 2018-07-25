---
title: 初试Spring Security
urlname: Introduction2SpringSecurity
date: 2018-07-21 18:59:19
tags: [Java, Spring]
---

最近在写的一个项目要使用到对于用户身份的认证以及授权(这应该都很常见吧), 所以在此使用了Spring Security, 由于之前自己并没有动手配置过, 在此记录一下.

<!-- more -->

### 前述
首先, 当前的这个项目需要一个典型的认证和授权的机制, 这里使用security与jwt来实现的话过程大致如下, 即, 用户输入用户名密码进行登录, 后端接收到后验证用户是否存在,  如果用户存在则我们验证其密码是否正确, 如果错误则拒绝登录; 如果正确, 我们生成一个token, 将用户的信息和token放在一起返回给前端.

后面用户在操作的时候如果与后端进行交互, 则前端需要携带该token进行请求, 后端接收到请求后首先检测token的有效性(即验证该token仍在有效期内且在该token生成后, 密码并未修改过), 有效则允许操作进一步进行, 无效则返回401权限错误. 

token可以限定有效时长, 如果在这个有效时长内该token一直未刷新, 则token失效, 无法再作为身份认证的凭据, 需要重新登录以获取新的token; 在token有效期间可以调用相应的接口对token的有效时长进行刷新, 以延长token的有效时长.

本项目参考GitHub上的该repo 👉 [jwt-spring-security-demo](https://github.com/szerhusenBC/jwt-spring-security-demo)

本项目的GitHub地址 👉 [eduroamControlSystem-Backend](https://github.com/UPC-eduroam/eduroamControlSystem-Backend) 

### 环境
这里使用的是spring boot版本是`1.5.4`, 
#### 项目依赖
如下是项目所有maven依赖 👇

```
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>

    <!--swagger 依赖-->
    <dependency>
        <groupId>io.springfox</groupId>
        <artifactId>springfox-swagger2</artifactId>
        <version>2.8.0</version>
    </dependency>
    <dependency>
        <groupId>io.springfox</groupId>
        <artifactId>springfox-swagger-ui</artifactId>
        <version>2.8.0</version>
    </dependency>

    <dependency>
        <groupId>io.jsonwebtoken</groupId>
        <artifactId>jjwt</artifactId>
        <version>0.7.0</version>
    </dependency>
</dependencies>
```

#### 配置
项目配置文件(这里是yml格式)中添加如下内容, 

```
jwt:
    header: Authorization
    secret: adAhDsfHasDpvo
    expiration: 604800
```

这是定义token的一些配置(请求头中token字段的名称, 加密用的密钥, 有效时长), 本应该在用到的时候再添加, 但怕后面添加会乱, 所以提前声明一下.

### 代码实现
#### 定义用户与权限
首先我们要定义用户与权限这些基本表.

* 用户表 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String userId;

    @JsonIgnore
    private String password;

    private Date LastPasswordResetDate;

    @JsonIgnore
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_authority",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "authority_id"))
    private List<Authority> authorities = new ArrayList<>();

	//构造方法与get/set方法这里因篇幅限制省略
}
```

* 添加一个枚举权限类型的类👇

```
public enum AuthorityType {
	//本项目中仅有学生用户与管理员两种用户类型
    ROLE_USER, ROLE_ADMIN
}
```

* 权限表 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "authority")
public class Authority {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private AuthorityType authorityType;

    @ManyToMany(mappedBy = "authorities", fetch = FetchType.LAZY)
    private List<User> users;

    //构造方法与get/set方法这里因篇幅限制省略
}
```

DAO与Service这些就不贴代码了, 都是基于基本表的基本操作.

#### 配置Security
配置Security的话, 我们首先需要继承`WebSecurityConfigurerAdapter`类来实现我们自己的security配置类, 这里我把它叫做`SecurityConfig`, 但是在写`SecurityConfig`之前, 我们要先完成它所依赖的一些类.

##### JwtUser类
* 首先是实现`UserDetails`接口, 实现后的类是服务于Security的, 里面存放基本表User中的用户信息, 以及重写原接口的一些方法, 它用于token的生成之类, 所以这里叫它`JwtUser` 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Date;
import java.util.Collection;
import java.util.List;

public class JwtUser implements UserDetails {
    private int id;
    private String userId;
    private String password;
    private final Date LastPasswordResetDate;
    private final Collection<? extends GrantedAuthority> authorities;

    public JwtUser(int id, String userId, String password, Date LastPasswordResetDate, List<GrantedAuthority> authorities) {
        this.id = id;
        this.userId = userId;
        this.password = password;
        this.LastPasswordResetDate = LastPasswordResetDate;
        this.authorities = authorities;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getLastPasswordResetDate() {
        return LastPasswordResetDate;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return userId;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
```

##### JwtUserFactory类
* 这里再为`JwtUser`新建一个工厂方法, 方便在后面快速生成JwtUser, 这里叫它`JwtUserFactory` 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.service;

import cn.edu.upc.eduroamcontrolsystembackend.model.Authority;
import cn.edu.upc.eduroamcontrolsystembackend.model.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import java.util.List;
import java.util.stream.Collectors;

public class JwtUserFactory {
    public static JwtUser createJwtUser(User user) {
        return new JwtUser(
                user.getId(),
                user.getUserId(),
                user.getPassword(),
                user.getLastPasswordResetDate(),
                mapToGrantedAuthorities(user.getAuthorities())
        );
    }

    private static List<GrantedAuthority> mapToGrantedAuthorities(List<Authority> authorities) {
        return authorities.stream()
                .map(authority -> new SimpleGrantedAuthority(authority.getAuthorityType().name()))
                .collect(Collectors.toList());
    }
}
```

##### JwtUserDetailsService类
* 然后我们再需要实现`UserDetailsService`接口, 这个接口仅有一个方法`loadUserByUsername`, 就是根据用户名(也不一定得是用户名, 这里的意思就是用户表中可以唯一识别用户的字段罢了)去查找用户, 虽然功能上与基本表User的service类似, 但它是服务于Security的(你要鉴权什么的, 首先得确定用户存在吧), 且依赖于基本表User的service进行用户查找, 这里叫它`JwtUserDetailsService`👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.service;

import cn.edu.upc.eduroamcontrolsystembackend.dao.UserDAO;
import cn.edu.upc.eduroamcontrolsystembackend.model.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class JwtUserDetailsService implements UserDetailsService {
    private final Log logger = LogFactory.getLog(this.getClass());
    @Autowired
    private UserDAO userDAO;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        // 从数据库里的用户表里查找用户, 用于生成JwtUser
        User user = userDAO.findFirstByUserId(userId);
        if (user == null) {
            logger.warn("用户 \"" + userId + "\" 不存在");
            throw new UsernameNotFoundException(String.format("没有该用户 '%s'.", userId));
        } else {
            //这里返回上面继承了UserDetails接口的用户类,
            return JwtUserFactory.createJwtUser(user);
        }
    }
}
```
##### JwtTokenUtil类
* 然后我们定义token相关操作(生成/刷新等)的类, 这里叫它`JwtTokenUtil` 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.SignatureAlgorithm;

@Component
public class JwtTokenUtil implements Serializable {

    static final String CLAIM_KEY_USERID = "123";
    static final String CLAIM_KEY_CREATED = "created";

    @Value("${jwt.secret}") 
    private String secret;

    @Value("${jwt.expiration}")
    private Long expiration;

    public String getUserIdFromToken(String token) {
        String userId;
        try {
            final Claims claims = getClaimsFromToken(token);
            userId = claims.get(CLAIM_KEY_USERID).toString();
        } catch (Exception e) {
            userId = null;
        }
        return userId;
    }

    public Date getCreatedDateFromToken(String token) {
        Date created;
        try {
            final Claims claims = getClaimsFromToken(token);
            created = new Date((Long) claims.get(CLAIM_KEY_CREATED));
        } catch (Exception e) {
            created = null;
        }
        return created;
    }

    public Date getExpirationDateFromToken(String token) {
        Date expiration;
        try {
            final Claims claims = getClaimsFromToken(token);
            expiration = claims.getExpiration();
        } catch (Exception e) {
            expiration = null;
        }
        return expiration;
    }

    private Claims getClaimsFromToken(String token) {
        Claims claims;
        try {
            claims = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            claims = null;
        }
        return claims;
    }

    private Boolean isTokenExpired(String token) {
        final Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }

    private Boolean isCreatedBeforeLastPasswordReset(Date created, Date lastPasswordReset) {
        return (lastPasswordReset != null && created.before(lastPasswordReset));
    }

    public String generateToken(JwtUser userDetails) {
        Map<String, Object> claims = new HashMap<>();
        claims.put(CLAIM_KEY_CREATED, new Date());
        claims.put(CLAIM_KEY_USERID, userDetails.getId());
        return doGenerateToken(claims);
    }

    private String doGenerateToken(Map<String, Object> claims) {
        final Date createdDate = (Date) claims.get(CLAIM_KEY_CREATED);
        final Date expirationDate = new Date(createdDate.getTime() + expiration * 1000);

        System.out.println("doGenerateToken " + createdDate);

        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(expirationDate)
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }

    public Boolean canTokenBeRefreshed(String token, Date lastPasswordResetDate) {
        final Date created = getCreatedDateFromToken(token);
        return !isCreatedBeforeLastPasswordReset(created, lastPasswordResetDate)
                && !isTokenExpired(token);
    }

    public String refreshToken(String token) {
        String refreshedToken;
        try {
            final Claims claims = getClaimsFromToken(token);
            claims.put(CLAIM_KEY_CREATED, new Date());
            refreshedToken = doGenerateToken(claims);
        } catch (Exception e) {
            refreshedToken = null;
        }
        return refreshedToken;
    }

    public Boolean validateToken(String token, UserDetails userDetails) {
        JwtUser user = (JwtUser) userDetails;
        final String username = getUserIdFromToken(token);
        final Date created = getCreatedDateFromToken(token);
        return (
                username.equals(user.getUsername())
                        && !isTokenExpired(token)
                        && !isCreatedBeforeLastPasswordReset(created, user.getLastPasswordResetDate()));
    }
}
```

##### JwtAuthenticationTokenFilter类
* 然后定义对于请求进行token过滤的类, 这里叫做`JwtAuthenticationTokenFilter` 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {
    private final Log logger = LogFactory.getLog(this.getClass());

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Value("${jwt.header}")
    private String tokenHeader;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        String authToken = request.getHeader(this.tokenHeader);
        String userId = jwtTokenUtil.getUserIdFromToken(authToken);

        if (userId != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            logger.info("checking authentication for user " + userId);
            UserDetails userDetails = this.userDetailsService.loadUserByUsername(userId);
            if (jwtTokenUtil.validateToken(authToken, userDetails)) {
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                logger.info("authenticated user " + userId + ", setting security context");
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        chain.doFilter(request, response);
    }
}
```

##### JwtAuthenticationEntryPoint类
* 再实现`AuthenticationEntryPoint`接口, 用于对鉴权的时候出现的权限问题进行处理, 这里叫它`JwtAuthenticationEntryPoint` 👇 

```
package cn.edu.upc.eduroamcontrolsystembackend.security.service;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;

@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint, Serializable {

    private static final long serialVersionUID = -8970718410437077606L;

    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         AuthenticationException authException) throws IOException {
        // 如果用户无凭证访问被security保护的资源, 则返回401 "Unauthorized" 错误
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
    }
}
```

##### AuthenticationController类
* 现在我们可以来定义权限操作相关的API(登录与刷新token)了, 这里就直接叫它`AuthenticationController` 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.controller;

import cn.edu.upc.eduroamcontrolsystembackend.dao.UserDAO;
import cn.edu.upc.eduroamcontrolsystembackend.dto.ResponseMessage;
import cn.edu.upc.eduroamcontrolsystembackend.model.User;
import cn.edu.upc.eduroamcontrolsystembackend.security.service.JwtTokenUtil;
import cn.edu.upc.eduroamcontrolsystembackend.security.service.JwtUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@RestController
public class AuthenticationController {

    private final Log logger = LogFactory.getLog(this.getClass());

    @Value("${jwt.header}")
    private String tokenHeader;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private UserDAO userDAO;

    //登录接口, 生成token
    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public Object createAuthenticationToken(String username, String password) throws AuthenticationException {
        final UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        if (!bCryptPasswordEncoder.matches(password, userDetails.getPassword())) {
            return new ResponseMessage(-1, "登录失败, 用户名或密码错误");
        }
        // 生成token
        final String token = jwtTokenUtil.generateToken((JwtUser) userDetails);
        Map<Object, Object> map = new HashMap<>();
        User user = userDAO.findFirstByUserId(userDetails.getUsername());
        map.put("user", user);
        map.put("token", token);
        return map;
    }

    //刷新token接口
    @RequestMapping(value = "/token/refresh", method = RequestMethod.GET)
    public ResponseEntity<?> refreshAndGetAuthenticationToken(HttpServletRequest request) {
        String token = request.getHeader(tokenHeader);
        String username = jwtTokenUtil.getUserIdFromToken(token);
        JwtUser user = (JwtUser) userDetailsService.loadUserByUsername(username);
        if (jwtTokenUtil.canTokenBeRefreshed(token, user.getLastPasswordResetDate())) {
            logger.info("已为用户 " + username + " 刷新token");
            String refreshedToken = jwtTokenUtil.refreshToken(token);
            return ResponseEntity.ok(refreshedToken);
        } else {
            return ResponseEntity.badRequest().body(null);
        }
    }
}
```

##### SecurityConfig类
* 好啦, 最后我们来完成对于security的配置类`SecurityConfig` 👇

```
package cn.edu.upc.eduroamcontrolsystembackend.security.config;

import cn.edu.upc.eduroamcontrolsystembackend.security.service.JwtAuthenticationEntryPoint;
import cn.edu.upc.eduroamcontrolsystembackend.security.service.JwtAuthenticationTokenFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@SuppressWarnings("SpringJavaAutowiringInspection")
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    //无需权限即可访问的白名单
    private static final String[] AUTH_WHITELIST = {
            "/",
            "/*.html",
            "/favicon.ico",
            "/**/*.html",
            "/**/*.css",
            "/**/*.js",

            // -- swagger ui
            "/swagger-resources/**",
            "/swagger-ui.html",
            "/v2/api-docs",
            "/webjars/**"

    };

    @Autowired
    private JwtAuthenticationEntryPoint unauthorizedHandler;

    // Spring会自动寻找实现接口的类注入,会找到我们自己实现的UserDetailsService类
    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    public void configureAuthentication(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
        authenticationManagerBuilder
                // 设置UserDetailsService
                .userDetailsService(this.userDetailsService)
                // 使用BCrypt对密码进行加密
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public JwtAuthenticationTokenFilter authenticationTokenFilterBean() throws Exception {
        return new JwtAuthenticationTokenFilter();
    }

    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                //禁用csrf防护功能,因为使用token进行身份验证,所以较为安全,而且禁用后也方便开发
                .csrf().disable()
                //添加对于出现权限问题的异常处理
                .exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()
                //禁用session,因为使用token,所以不需要session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
                .authorizeRequests()
                .antMatchers(HttpMethod.GET, AUTH_WHITELIST).permitAll()
                //允许匿名访问获取token的api
                .antMatchers("/user/login").permitAll()
                //除上面允许匿名的api外,其他的全部需要身份认证
                .anyRequest().authenticated();

        //根据token进行身份过滤
        httpSecurity
                .addFilterBefore(authenticationTokenFilterBean(), UsernamePasswordAuthenticationFilter.class);

        // 禁用缓存
        httpSecurity.headers().cacheControl();
    }
}
```

### 最后登录效果
启动项目, postman使用post方法以`x-www-form-urlencoded`方式提交用户名与密码到后端的`/user/login`接口, 可以看到类似如下的效果

```
{
    "user": {
        "id": 2,
        "userId": "devUser",
        "password": "$2a$10$LBOqtklE0chvs8jiV6XS/O4eVt.7H3jhvbQTq6AEzgIelE/afYzbi",
        "lastPasswordResetDate": null
    },
    "token": "eyJhbGciOiJIUzUxMiJ9.eyIxMjMiOjIsImNyZWF0ZWQiOjE1MzI0MDkyMjAzMTUsImV4cCI6MTUzMzAxNDAyMH0.0CQYfpG9X4PeVX23DoFVjR3iHNe_DswI85ejaoWYqSgHgGf6tIfcBU11ChkSwpMXRQRjjuZzSRMLXxtxq-4m0w"
}
```
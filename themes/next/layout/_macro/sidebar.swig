{% macro render(is_post) %}
  <div class="sidebar-toggle">
    <div class="sidebar-toggle-line-wrap">
      <span class="sidebar-toggle-line sidebar-toggle-line-first"></span>
      <span class="sidebar-toggle-line sidebar-toggle-line-middle"></span>
      <span class="sidebar-toggle-line sidebar-toggle-line-last"></span>
    </div>
  </div>

  <aside id="sidebar" class="sidebar">
    {% if theme.sidebar.onmobile %}
      <div id="sidebar-dimmer"></div>
    {% endif %}
    <div class="sidebar-inner">

      {% set display_toc = is_post and theme.toc.enable or is_page and theme.toc.enable %}

      {% if display_toc and toc(page.content).length > 1 %}
        <ul class="sidebar-nav motion-element">
          <li class="sidebar-nav-toc sidebar-nav-active" data-target="post-toc-wrap" >
            {{ __('sidebar.toc') }}
          </li>
          <li class="sidebar-nav-overview" data-target="site-overview">
            {{ __('sidebar.overview') }}
          </li>
        </ul>
      {% endif %}

      <section class="site-overview sidebar-panel{% if not display_toc or toc(page.content).length <= 1 %} sidebar-panel-active{% endif %}">
        <div class="site-author motion-element" itemprop="author" itemscope itemtype="http://schema.org/Person">
          <img class="site-author-image" itemprop="image"
               src="{{ url_for( theme.avatar | default(theme.images + '/avatar.gif') ) }}"
               alt="{{ theme.author }}" />
          <p class="site-author-name" itemprop="name">{{ theme.author }}</p>
           {% if theme.seo %}
              <p class="site-description motion-element" itemprop="description">{{ theme.signature }}</p>
           {% else %}
              <p class="site-description motion-element" itemprop="description">{{ theme.description }}</p>
          {% endif %}
        </div>


<!--j's自定义修改-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/velocity/1.5.0/velocity.min.js"></script>
<script>
   /*high一下js脚本*/
    function go() {
    /*歌曲数组
    *crazy bird
    *shape of my heart
    *Sofía
    */
    var songs = [
                "https://cdn.safeandsound.cn/music/crazy-bird.m4a",
                "https://cdn.safeandsound.cn/music/shape-of-my-heart.m4a",
                "https://cdn.safeandsound.cn/music/Sof%C3%ADa.m4a"
    ];

    
    function c() {
        var e = document.createElement("link");
        e.setAttribute("type", "text/css");
        e.setAttribute("rel", "stylesheet");
        e.setAttribute("href", f);
        e.setAttribute("class", l);
        document.body.appendChild(e)
    }
 
    function h() {
        var e = document.getElementsByClassName(l);
        for (var t = 0; t < e.length; t++) {
            document.body.removeChild(e[t])
        }
    }
 
    function p() {
        var e = document.createElement("div");
        e.setAttribute("class", a);
        document.body.appendChild(e);
        setTimeout(function() {
            document.body.removeChild(e)
        }, 100)
    }
 
    function d(e) {
        return {
            height : e.offsetHeight,
            width : e.offsetWidth
        }
    }
 
    function v(i) {
        var s = d(i);
        return s.height > e && s.height < n && s.width > t && s.width < r
    }
 
    function m(e) {
        var t = e;
        var n = 0;
        while (!!t) {
            n += t.offsetTop;
            t = t.offsetParent
        }
        return n
    }
 
    function g() {
        var e = document.documentElement;
        if (!!window.innerWidth) {
            return window.innerHeight
        } else if (e && !isNaN(e.clientHeight)) {
            return e.clientHeight
        }
        return 0
    }
 
    function y() {
        if (window.pageYOffset) {
            return window.pageYOffset
        }
        return Math.max(document.documentElement.scrollTop, document.body.scrollTop)
    }
 
    function E(e) {
        var t = m(e);
        return t >= w && t <= b + w
    }

    function S() {
        var e = document.getElementById("audio_element_id");
        if(e != null){
            var index = parseInt(e.getAttribute("curSongIndex"));
            if(index > songs.length - 2) {
                index = 0;
            } else {
                index++;
            }
            e.setAttribute("curSongIndex", index);
            N();
        }

        e.src = i;
        e.play()
    }
 
    function x(e) {
        e.className += " " + s + " " + o
    }
 
    function T(e) {
        e.className += " " + s + " " + u[Math.floor(Math.random() * u.length)]
    }
 
    function N() {
        var e = document.getElementsByClassName(s);
        var t = new RegExp("\\b" + s + "\\b");
        for (var n = 0; n < e.length; ) {
            e[n].className = e[n].className.replace(t, "")
        }
    }

    function initAudioEle() {
        var e = document.getElementById("audio_element_id");
        if(e === null){
            e = document.createElement("audio");
            e.setAttribute("class", l);
            e.setAttribute("curSongIndex", 0);
            e.id = "audio_element_id";
            e.loop = false;
            e.bgcolor = 0;
            e.addEventListener("canplay", function() {
            setTimeout(function() {
                x(k)
            }, 500);
            setTimeout(function() {
                N();
                p();
                for (var e = 0; e < O.length; e++) {
                    T(O[e])
                }
            }, 15500)
        }, true);
        e.addEventListener("ended", function() {
            N();
            h();
            go();
        }, true);
        e.innerHTML = " <p>If you are reading this, it is because your browser does not support the audio element. We recommend that you get a new browser.</p> <p>";
        document.body.appendChild(e);
        }
    }
    
    initAudioEle();
    var e = 30;
    var t = 30;
    var n = 350;
    var r = 350;

    var curSongIndex = parseInt(document.getElementById("audio_element_id").getAttribute("curSongIndex"));
    var i = songs[curSongIndex];
    
    var s = "mw-harlem_shake_me";
    var o = "im_first";
    var u = ["im_drunk", "im_baked", "im_trippin", "im_blown"];
    var a = "mw-strobe_light";

    /* harlem-shake-style.css，替换成你的css文件位置，也可以直接使用：//s3.amazonaws.com/moovweb-marketing/playground/harlem-shake-style.css */
    var f = "//cdn.safeandsound.cn/css/harlem-shake-style.css";
    
    var l = "mw_added_css";
    var b = g();
    var w = y();
    var C = document.getElementsByTagName("*");
    var k = null;
    for (var L = 0; L < C.length; L++) {
        var A = C[L];
        if (v(A)) {
            if (E(A)) {
                k = A;
                break
            }
        }
    }
    if (A === null) {
        console.warn("Could not find a node of the right size. Please try a different page.");
        return
    }
    c();
    S();
    var O = [];
    for (var L = 0; L < C.length; L++) {
        var A = C[L];
        if (v(A)) {
            O.push(A)
        }
    }
    };

    /*鼠标移动到sidebar后才渐渐显示出站点信息*/
    $("#sidebar").hover(function(){
      $("#2-show-or-not-2-show").velocity('stop').velocity({opacity: 1});
      },function(){
        $("#2-show-or-not-2-show").velocity('stop').velocity({opacity: 0});
    });


</script>
<style type="text/css">
/*字符上下颠倒*/
#upside-down
{
filter:  progid:DXImageTransform.Microsoft.BasicImage(rotation=2);  /* IE6,IE7 */
ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=2)"; /* IE8 */
-moz-transform: rotate(-180deg);  /* 火狐3.5+ */
-o-transform: rotate(-180deg);  /* Opera 10.5 */
-webkit-transform: rotate(-180deg);  /* Safari 3.1+, Chrome */
}

a.change {
    display: inline-block;
    padding: 0 10px;
    border: 2px solid #000;
    border-radius: 2px;
    transition: all .5s ease;
    font-weight: 700;
}
a.change:hover{
    font-size: 115%;
}


#high{
    color: #000;
    background:#fff;
    border: 2px solid #000;
    opacity:0.5;
}
#high:hover{
    color: #fff;
    background: #000;
    border: 2px solid #fff;
    opacity:1;
}

.social{
   margin-top:5px;
}
#social-links{
    color:#FC6423;
    background:#fff;
    border: 2px solid #FC6423;
    opacity:0.5;
}

#social-links:hover{
  color:#fff;
  background:#FC6423;
  border: 2px solid #fff;
  opacity:1;
}
#cangshu{
  margin-top:55px;
}
#cangshu embed{
  width:300px;
  height:220px;
  opacity:0.5;
}

</style>

    <div id="2-show-or-not-2-show">
        <nav class="site-state motion-element">

          {% if config.archive_dir != '/' %}
            <div class="site-state-item site-state-posts">
              <a href="{{ url_for(theme.menu.archives) }}">
                <span class="site-state-item-count">{{ site.posts.length }}</span>
                <span class="site-state-item-name">{{ __('state.posts') }}</span>
              </a>
            </div>
          {% endif %}

          {% if site.categories.length > 0 %}
            {% set categoriesPageQuery = site.pages.find({type: 'categories'}, {lean: true}) %}
            {% set hasCategoriesPage = categoriesPageQuery.length > 0 %}
            <div class="site-state-item site-state-categories">
              {% if hasCategoriesPage %}<a href="{{ url_for(categoriesPageQuery[0].path) }}">{% endif %}
                <span class="site-state-item-count">{{ site.categories.length }}</span>
                <span class="site-state-item-name">{{ __('state.categories') }}</span>
              {% if hasCategoriesPage %}</a>{% endif %}
            </div>
          {% endif %}

          {% if site.tags.length > 0 %}
            {% set tagsPageQuery = site.pages.find({type: 'tags'}, {lean: true}) %}
            {% set hasTagsPage = tagsPageQuery.length > 0 %}
            <div class="site-state-item site-state-tags">
              {% if hasTagsPage %}<a href="{{ url_for(tagsPageQuery[0].path) }}">{% endif %}
                <span class="site-state-item-count">{{ site.tags.length }}</span>
                <span class="site-state-item-name">{{ __('state.tags') }}</span>
              {% if hasTagsPage %}</a>{% endif %}
            </div>
          {% endif %}
        </nav>
          <!--High一下-->
  <div class="high-once" style="margin-top:10px">
    <a class="change" id="high" onclick="go()" href="#">
      <i class="menu-item-icon fa fa-music fa-fw"></i>
      好听的
      <i class="fa fa-smile-o" aria-hidden="true" style="font-size:120%" id="upside-down"></i>
    </a>
  </div>

  <div class="social">
    <!--github-->
    <a class="change" id="social-links" href="https://github.com/WenjayDu">
      <i class="fa fa-github-alt" aria-hidden="true"></i>
      GitHub
    </a>
    <!--mailto-->
    <a class="change" id="social-links" href="mailto:wenjay.du@gmail.com">
      <i class="fa fa-envelope-o" aria-hidden="true"></i>
      Gmail
    </a>
  </div>

  <!--添加仓鼠
  <div id="cangshu">
    <embed class="cangshu" src="/images/cangshu.swf" allowNetworking="all" onmouseover="$(this).velocity('stop').velocity({opacity: 1})" onmouseout="$(this).velocity('stop').velocity({opacity:0.5})"">
    </embed>
  </div>-->



        {% if theme.rss %}
          <div class="feed-link motion-element">
            <a href="{{ url_for(theme.rss) }}" rel="alternate">
              <i class="fa fa-rss"></i>
              RSS
            </a>
          </div>
        {% endif %}

        <div class="links-of-author motion-element">
          {% if theme.social %}
            {% for name, link in theme.social %}
              <span class="links-of-author-item">
                <a href="{{ link }}" target="_blank" title="{{ name }}">
                  {% if theme.social_icons.enable %}
                    <i class="fa fa-fw fa-{{ theme.social_icons[name] | default('globe') | lower }}"></i>
                  {% endif %}
                  {{ name }}
                </a>
              </span>
            {% endfor %}
          {% endif %}
        </div>

        {% set cc = {'by': 1, 'by-nc': 1, 'by-nc-nd': 1, 'by-nc-sa': 1, 'by-nd': 1, 'by-sa': 1, 'zero': 1} %}
        {% if theme.creative_commons in cc %}
          <div class="cc-license motion-element" itemprop="license">
            <a href="https://creativecommons.org/{% if theme.creative_commons === 'zero' %}publicdomain/zero/1.0{% else %}licenses/{{ theme.creative_commons }}/4.0{% endif %}/" class="cc-opacity" target="_blank">
              <img src="{{ url_for(theme.images) }}/cc-{{ theme.creative_commons }}.svg" alt="Creative Commons" />
            </a>
          </div>
        {% endif %}

        {# Blogroll #}
        {% if theme.links %}
          <div class="links-of-blogroll motion-element {{ "links-of-blogroll-" + theme.links_layout | default('inline') }}">
            <div class="links-of-blogroll-title">
              <i class="fa  fa-fw fa-{{ theme.links_icon | default('globe') | lower }}"></i>
              {{ theme.links_title }}
            </div>
            <ul class="links-of-blogroll-list">
              {% for name, link in theme.links %}
                <li class="links-of-blogroll-item">
                  <a href="{{ link }}" title="{{ name }}" target="_blank">{{ name }}</a>
                </li>
              {% endfor %}
            </ul>
          </div>
        {% endif %}

        {% include '../_custom/sidebar.swig' %}
      


      </section>
      </div>
      <!--修改结束-->
      {% if display_toc and toc(page.content).length > 1 %}
      <!--noindex-->
        <section class="post-toc-wrap motion-element sidebar-panel sidebar-panel-active">
          <div class="post-toc">

            {% if page.toc_number === undefined %}
              {% set toc = toc(page.content, { "class": "nav", list_number: theme.toc.number }) %}
            {% else %}
              {% set toc = toc(page.content, { "class": "nav", list_number: page.toc_number }) %}
            {% endif %}

            {% if toc.length <= 1 %}
              <p class="post-toc-empty">{{ __('post.toc_empty') }}</p>
            {% else %}
              <div class="post-toc-content">{{ toc }}</div>
            {% endif %}

          </div>
        </section>
      <!--/noindex-->
      {% endif %}

      {% if theme.sidebar.b2t %}
        <div class="back-to-top">
          <i class="fa fa-arrow-up"></i>
          {% if theme.sidebar.scrollpercent %}
            <span id="scrollpercent"><span>0</span>%</span>
          {% endif %}
        </div>
      {% endif %}

    </div>
  </aside>
{% endmacro %}

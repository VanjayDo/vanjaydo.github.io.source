<div class="site-brand-wrapper">
  <div class="site-meta {% if theme.custom_logo.enabled %}custom-logo{% endif %}">
    {% if theme.custom_logo.image and theme.scheme === 'Muse' %}
      <div class="site-meta-headline">
        <a>
          <img class="custom-logo-image" src="{{ theme.custom_logo.image }}"
               alt="{{ config.title }}"/>
        </a>
      </div>
    {% endif %}

    <div class="custom-logo-site-title">
      <a href="{{ config.root }}"  class="brand" rel="start">
        <span class="logo-line-before"><i></i></span>
        <span class="site-title">{{ config.title }}</span>
        <span class="logo-line-after"><i></i></span>
      </a>
    </div>
      {% if theme.seo %}
        <h1 class="site-subtitle" itemprop="description">{{ config.subtitle }}</h1>
      {% else %}
        <p class="site-subtitle">{{ config.subtitle }}</p>
      {% endif %}
  </div>

  <div class="site-nav-toggle">
    <button>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
    </button>
  </div>
</div>

<nav class="site-nav">
  {% set hasSearch = theme.swiftype_key || theme.algolia_search.enable || theme.tinysou_Key || theme.local_search.enable %}

  {% if theme.menu %}
    <ul id="menu" class="menu">
      {% for name, path in theme.menu %}
        {% set itemName = name.toLowerCase() %}
        <li class="menu-item menu-item-{{ itemName }}">
          <a href="{{ url_for(path) }}" rel="section">
            {% if theme.menu_icons.enable %}
              <i class="menu-item-icon fa fa-fw fa-{{theme.menu_icons[itemName] | default('question-circle') | lower }}"></i> <br />
            {% endif %}
            {{ __('menu.' + name) }}
          </a>
        </li>
      {% endfor %}

      {% if hasSearch %}
        <li class="menu-item menu-item-search">
          {% if theme.swiftype_key %}
            <a href="javascript:;" class="st-search-show-outputs">
          {% elseif theme.local_search.enable || theme.algolia_search.enable %}
            <a href="javascript:;" class="popup-trigger">
          {% endif %}
            {% if theme.menu_icons.enable %}
              <i class="menu-item-icon fa fa-search fa-fw"></i> <br />
            {% endif %}
            {{ __('menu.search') }}
          </a>
        </li>
      {% endif %}
      
      <!--j's自定义修改-->
      <!--手机浏览器中在导航栏显示High一下-->
      <script>
        function go() {
          /*歌曲数组
           *crazy bird
           *shape of my heart
           *
           */
          var songs = [
            "http://mp3.qqmusic.cc/yq/5028219.mp3",
            "http://mp3.qqmusic.cc/yq/4832020.mp3"
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
              height: e.offsetHeight,
              width: e.offsetWidth
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
            if (e != null) {
              var index = parseInt(e.getAttribute("curSongIndex"));
              if (index > songs.length - 2) {
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
            for (var n = 0; n < e.length;) {
              e[n].className = e[n].className.replace(t, "")
            }
          }

          function initAudioEle() {
            var e = document.getElementById("audio_element_id");
            if (e === null) {
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

          /* harlem-shake-style.css，替换成你的位置，也可以直接使用：//s3.amazonaws.com/moovweb-marketing/playground/harlem-shake-style.css */
          var f = "//s3.amazonaws.com/moovweb-marketing/playground/harlem-shake-style.css";

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
        }
      //end High一下 
      //检测是否是手机
      var ua =  navigator.userAgent;
      isAndroid = /Android/i.test(ua);
      isBlackBerry = /BlackBerry/i.test(ua);
      isWindowPhone = /IEMobile/i.test(ua);
      isIOS = /iPhone|iPad|iPod/i.test(ua);
      isMobile = isAndroid || isBlackBerry || isWindowPhone || isIOS;
      if(isAndroid) isMobile = 'android';
      if(isBlackBerry) isMobile = 'BlackBerry';
      if(isWindowPhone) isMobile = 'WindowPhone';
      if(isIOS) isMobile = 'IOS';

      if(isMobile)
      {
        document.write('<li class="menu-item"><a onclick=go()><i class="menu-item-icon fa fa-music fa-fw"></i>High一下</a></li>');
      }
      </script>
    <!--j's自定义修改结束-->

    </ul>
  {% endif %}

  {% if hasSearch %}
    <div class="site-search">
      {% include 'search.swig' %}
    </div>
  {% endif %}
</nav>

{% include '../_custom/header.swig' %}

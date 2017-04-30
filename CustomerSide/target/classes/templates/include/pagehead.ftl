<header id="header">
    <nav class="nav navbar-highness navbar-static-top">
        <div class="container">
            <div class="navbar-header">
                <button id="btn" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav_list" aria-expanded="false">
                    <span class="sr-only">切换菜单</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">
                    <i class="iconfont icon-feiji"></i>
                </a>
            </div>
            <div id="nav_list" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">机票搜索</a></li>
                    <li><a href="#">航班信息</a></li>
                    <li><a href="question.html">常见问题</a></li>
                    <li><a href="travel.html">旅游资讯</a></li>
                    <li><a href="about.html">关于MSA</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right hidden-sm">
                    <#if isLogin == false>
                        <li><a href="../../loginPage">登录</a></li>
                        <li><a href="../../registePage">注册</a></li>
                    <#else>
                        <li><a href="../../usercenter">个人中心</a></li>
                        <li><a href="../../logout">登出</a></li>
                    </#if>

                </ul>
            </div>
        </div>
    </nav>
</header>
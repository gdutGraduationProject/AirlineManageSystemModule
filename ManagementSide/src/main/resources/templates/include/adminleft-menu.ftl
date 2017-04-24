<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="/lte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>${admin!"管理员"}</p>
                <a href="#"><i class="fa fa-circle text-success"></i>在线</a>
            </div>
        </div>
        <!-- search form -->
    <#--<form action="#" method="get" class="sidebar-form">
        <div class="input-group">
            <input type="text" name="q" class="form-control" placeholder="Search...">
      <span class="input-group-btn">
        <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
        </button>
      </span>
        </div>
    </form>-->
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">

            <!-- Optionally, you can add icons to the links -->




        <#if adminMenus??>
            <#list adminMenus as menu>
                <li class="${menu.activStatus?string("active","treeview")}">
                <a href="${menu.jumpUrl}">
                    <#--<i class="fa fa-link"></i>-->
                    <span>${menu.menuText}</span>
                    <span class="pull-right-container">
              <#--<i class="fa fa-angle-left pull-right"></i>-->
            </span>
                </a>
                </li>
                            <#--<ul class="">-->
                                        <#--<li  class="" >-->
                                            <#--<a href="${menu.jumpUrl}">-->
                                                <#--<i class="fa fa-circle-o"></i> ${menu.menuText}-->
                                            <#--</a>-->
                                        <#--</li>-->
                            <#--</ul>-->
            </#list>
        </#if>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
<!--导航begin-->
<div class="top-navbar navbar navbar-default navbar-fixed-top container nav-container" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">导航栏</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="index-link <{if $nav_show=='index'}>index-link-active<{/if}>"
           href="<{$smarty.const._site_domain}>"><span class="glyphicon glyphicon-home"></span>&nbsp;主页</a>
    </div>
    <div class="navbar-collapse collapse" style="height: 1px;">
        <ul id="main-menu" class="nav navbar-nav navbar-left">
            <li
            <{if $nav_show=='course_data'}>class="active"<{/if}>>
            <a href="<{$smarty.const._site_domain}>course_data_list">课件资料</a>
            </li>
            <li
            <{if $nav_show=='work'}>class="active"<{/if}>>
            <a href="<{$smarty.const._site_domain}>work_list">作业</a></li>
            <li
            <{if $nav_show=='question'}>class="active"<{/if}>>
            <a href="<{$smarty.const._site_domain}>question_list">答疑</a>
            </li>
            <li
            <{if $nav_show=='about'}>class="active"<{/if}>>
            <a href="<{$smarty.const._site_domain}>about">关于</a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="divider"></li>
            <{if isset($user_info['is_login'])&&$user_info['is_login']=='true'}>
            <li>
                <a href="#">
                    <span class="glyphicon glyphicon-user"></span>&nbsp;
                    <{if isset($user_info['user_name'])}><{$user_info['user_name']|truncate:10:'..'}><{/if}>
                </a>
            </li>
            <li><a href="<{$smarty.const._site_domain}>user_login/login_out">退出</a></li>
            <{else}>
            <li><a href="<{$smarty.const._site_domain}>user_login">登录</a></li>
            <li><a href="<{$smarty.const._site_domain}>user_reg">注册</a></li>
            <{/if}>
            <li><span>&nbsp;&nbsp;</span></li>
        </ul>
    </div>
</div>
<!--导航end-->
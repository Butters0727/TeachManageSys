<%@ page language="java" import="dao.*" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@page import="util.*" %>


<li class="sidebar-list-item">
    <a href="javascript:;" data-toggle="collapse" data-target="#pages0" aria-expanded="false" aria-controls="pages"
       class="sidebar-link text-muted">
        <span>账号管理</span>
    </a>
    <div id="pages0" class="collapse">
        <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
            <li class="sidebar-list-item"><a href="admins_list.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">管理员账号管理</a>
            </li>
            <li class="sidebar-list-item"><a href="admins_add.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">管理员账号添加</a>
            </li>
            <li class="sidebar-list-item"><a href="mod.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">密码修改</a>
            </li>
        </ul>
    </div>
</li>
<li class="sidebar-list-item">
    <a href="javascript:;" data-toggle="collapse" data-target="#pages1" aria-expanded="false" aria-controls="pages"
       class="sidebar-link text-muted">
        <span>学生管理</span>
    </a>
    <div id="pages1" class="collapse">
        <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
            <li class="sidebar-list-item"><a href="xuesheng_add.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">添加学生</a>
            </li>
            <li class="sidebar-list-item"><a href="xuesheng_list.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">学生查询</a>
            </li>
        </ul>
    </div>
</li>
<li class="sidebar-list-item">
    <a href="javascript:;" data-toggle="collapse" data-target="#pages5" aria-expanded="false" aria-controls="pages"
       class="sidebar-link text-muted">
        <span>学期管理</span>
    </a>
    <div id="pages5" class="collapse">
        <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
            <li class="sidebar-list-item"><a href="xueqi_add.jsp" target="main" class="sidebar-link text-muted pl-lg-5">学期添加</a>
            </li>
            <li class="sidebar-list-item"><a href="xueqi_list.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">学期查询</a>
            </li>
        </ul>
    </div>
</li>

<li class="sidebar-list-item">
    <a href="javascript:;" data-toggle="collapse" data-target="#pages2" aria-expanded="false" aria-controls="pages"
       class="sidebar-link text-muted">
        <span>课程管理</span>
    </a>
    <div id="pages2" class="collapse">
        <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
            <li class="sidebar-list-item"><a href="kecheng_add.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">课程添加</a>
            </li>
            <li class="sidebar-list-item"><a href="kecheng_list.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">课程查询</a>
            </li>
        </ul>
    </div>
</li>
<li class="sidebar-list-item">
    <a href="javascript:;" data-toggle="collapse" data-target="#pages4" aria-expanded="false" aria-controls="pages"
       class="sidebar-link text-muted">
        <span>已修课管理</span>
    </a>
    <div id="pages4" class="collapse">
        <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
            <li class="sidebar-list-item"><a href="chengji_list.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">已修课查询</a>
            </li>
        </ul>
    </div>
</li>
<li class="sidebar-list-item">
    <a href="javascript:;" data-toggle="collapse" data-target="#pages3" aria-expanded="false" aria-controls="pages"
       class="sidebar-link text-muted">
        <span>选课管理</span>
    </a>
    <div id="pages3" class="collapse">
        <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
            <li class="sidebar-list-item"><a href="xuanke_list.jsp" target="main"
                                             class="sidebar-link text-muted pl-lg-5">选课查询</a>
            </li>
        </ul>
    </div>
</li>



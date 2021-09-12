<%@ page language="java" import="dao.*" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@page import="util.*" %>


<%@ include file="head.jsp" %>

<div style="padding: 10px">
    <%
        //------------------------------------------------
        String orderby = util.Request.get("order", "id");  // 获取搜索框中的排序字段、默认为发布时间
        String sort = util.Request.get("sort", "desc");   // 获取搜索框中的排序类型、默认为倒序

        String where = " 1=1 ";   // 防止sql 搜索条件为： where and a=b 这样的错误


// 以下是检测搜索框中是否填写了或者选择了什么，则写入sql 语句中

        if ("学生".equals(session.getAttribute("cx"))) {
            where += " AND xuehao='" + session.getAttribute("username") + "' ";
        }

        if (request.getParameter("kechengid") != null && !"".equals(request.getParameter("kechengid"))) {
            where += " AND kechengid='" + request.getParameter("kechengid") + "' ";

        }
        if (request.getParameter("xueqi") != null && !"".equals(request.getParameter("xueqi"))) {
            where += " AND xueqi ='" + request.getParameter("xueqi") + "'";
        }
        if (request.getParameter("kechengming") != null && !"".equals(request.getParameter("kechengming"))) {
            where += " AND kechengming LIKE '%" + request.getParameter("kechengming") + "%'";
        }
        if (request.getParameter("xuehao") != null && !"".equals(request.getParameter("xuehao"))) {
            where += " AND xuehao LIKE '%" + request.getParameter("xuehao") + "%'";
        }

        List<HashMap> list = Query.make("chengji").where(where).order(orderby + " " + sort).page(15);

    %>


    <div class="panel panel-default">
        <div class="panel-heading">
        <span class="module-name">
            成绩        </span>
            <span>列表</span>
        </div>
        <div class="panel-body">
            <div class="pa10 bg-warning">
                <form class="form-inline" action="?"><!-- form 标签开始 -->

                    <div class="form-group">


                        <i class="glyphicon glyphicon-search"></i>

                    </div>
                    <div class="form-group">
                        学期

                        <select class="form-control class_xueqi4"
                                data-value="<%= request.getParameter("xueqi") !=null ? request.getParameter("xueqi") : "" %>"
                                id="xueqi" name="xueqi">
                            <option value="">请选择</option>
                            <%
                                List<HashMap> select = new CommDAO().select("SELECT * FROM xueqi ORDER BY id desc");
                            %>
                            <% for (HashMap m : select) { %>
                            <option value="<%= m.get("id") %>"><%= m.get("xueqiming") %>
                            </option>
                            <% } %>

                        </select>
                        <script>
                            $(".class_xueqi4").val($(".class_xueqi4").attr("data-value"))</script>

                    </div>
                    <div class="form-group">
                        课程名

                        <input type="text" class="form-control" style="" name="kechengming"
                               value="<%= request.getParameter("kechengming") !=null ? request.getParameter("kechengming") : "" %>"/>
                    </div>
                    <div class="form-group">
                        学生

                        学号：<input type="text" class="form-control" style="" name="xuehao"
                                  value="<%= request.getParameter("xuehao") !=null ? request.getParameter("xuehao") : "" %>"/>

                    </div>
                    <select class="form-control" name="sort" id="sort">

                        <option value="desc">倒序</option>
                        <option value="asc">升序</option>

                    </select>
                    <script>$("#orderby").val("<%= orderby %>");
                    $("#sort").val("<%= sort %>");</script>
                    <button type="submit" class="btn btn-default">
                        搜索
                    </button>


                    <!--form标签结束--></form>
            </div>


            <div class="">
                <table width="100%" border="1" class="table table-list table-bordered table-hover">
                    <thead>
                    <tr align="center">
                        <th width="60" data-field="item">序号</th>
                        <th> 学期</th>
                        <th> 课程名</th>
                        <th> 学分</th>
                        <th> 学号</th>
                        <th> 姓名</th>
                        <th> 成绩</th>
                        <th width="180" data-field="addtime">添加时间</th>
                        <% if ("管理员".equals(request.getSession().getAttribute("cx"))) { %>
                        <th width="220" data-field="handler">操作</th>
                        <% } %>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int i = 0;
                        for (HashMap map : list) {
                            i++;
                    %>
                    <tr id="<%= map.get("id") %>" pid="">
                        <td width="30" align="center">
                            <label>
                                <%= i %>
                            </label>
                        </td>
                        <td><%
                            HashMap mapxueqi1 = new CommDAO().find("SELECT xueqiming FROM xueqi where id='" + map.get("xueqi") + "'");
                        %><%= mapxueqi1.get("xueqiming") %>
                        </td>
                        <td><%= map.get("kechengming") %>
                        </td>
                        <td><%= map.get("xuefen") %>
                        </td>
                        <td><%= map.get("xuehao") %>
                        </td>
                        <td><%= map.get("xingming") %>
                        </td>
                        <td><%= map.get("chengji") %>
                        </td>
                        <td align="center"><%= map.get("addtime") %>
                        </td>
                        <% if ("管理员".equals(request.getSession().getAttribute("cx"))) { %>
                        <td align="center">

                            <a href="chengji_updt.jsp?id=<%= map.get("id") %>">修改</a>
                            <a href="chengji.jsp?a=delete&id=<%= map.get("id") %>"
                               onclick="return confirm('真的要删除？')">删除</a>
                            <!--qiatnalijne-->
                        </td>
                        <% } %>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            ${page.info}


        </div>


    </div>


</div>
<%@ include file="foot.jsp" %>

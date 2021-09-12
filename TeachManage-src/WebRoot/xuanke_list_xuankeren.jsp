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
        where += " AND xuankeren='" + request.getSession().getAttribute("username") + "' "; //  设置xuankeren为当前登录用户


// 以下是检测搜索框中是否填写了或者选择了什么，则写入sql 语句中


        if (request.getParameter("kechengid") != null && !"".equals(request.getParameter("kechengid"))) {
            where += " AND kechengid='" + request.getParameter("kechengid") + "' ";

        }
        if (request.getParameter("kechengming") != null && !"".equals(request.getParameter("kechengming"))) {
            where += " AND kechengming LIKE '%" + request.getParameter("kechengming") + "%'";
        }
        List<HashMap> list = Query.make("xuanke").where(where).order(orderby + " " + sort).page(15);

        HashMap total = Query.make("xuanke").field("(sum(xuefen)) sum_xuefen").where(where).field("(sum(xuefen)) sum_xuefen").find();

    %>


    <div class="panel panel-default">
        <div class="panel-heading">
        <span class="module-name">
            选课        </span>
            <span>列表</span>
        </div>
        <div class="panel-body">
            <div class="pa10 bg-warning">
                <form class="form-inline" action="?"><!-- form 标签开始 -->

                    <div class="form-group">


                        <i class="glyphicon glyphicon-search"></i>

                    </div>
                    <div class="form-group">
                        课程名

                        <input type="text" class="form-control" style="" name="kechengming"
                               value="<%= request.getParameter("kechengming") !=null ? request.getParameter("kechengming") : "" %>"/>
                    </div>
                    <select class="form-control" name="order" id="orderby">

                        <option value="id">按发布时间</option>

                    </select>
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
                        <th> 课程名</th>
                        <th> 学分</th>
                        <th> 上课时间</th>
                       <%-- <th> 第几节</th>--%>
                        <th> 选课人</th>
                        <th width="180" data-field="addtime">添加时间</th>
                        <th width="90" data-field="handler">操作</th>
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
                        <td><%= map.get("kechengming") %>
                        </td>
                        <td><%= map.get("xuefen") %>
                        </td>
                        <td><%= map.get("xingqi") %> <%= map.get("dijijie") %>
                        </td>
                        <%--<td><%= map.get("dijijie") %>
                        </td>--%>
                        <td><%= map.get("xuankeren") %>
                        </td>
                        <td align="center"><%= map.get("addtime") %>
                        </td>
                        <td align="center">
                            <a href="xuanke.jsp?a=delete&id=<%= map.get("id") %>"
                               onclick="return confirm('真的要删除？')">删除</a>
                            <!--qiatnalijne-->
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            ${page.info}

            <p>
                已选学分：
                <%
                    double xuefen = Double.valueOf(total.get("sum_xuefen") == null || "".equals(total.get("sum_xuefen")) ? "0" : total.get("sum_xuefen").toString()).doubleValue();
                %>
                <span style="color: #c8192d"><%= total.get("sum_xuefen")%></span>　　&nbsp;
                可选学分：
                <span style="color: #ff180a"><%= 21- xuefen %></span> 　
            </p>

        </div>


    </div>


</div>
<%@ include file="foot.jsp" %>

<%@ page language="java" import="dao.*" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@page import="util.*" %>


<%@ include file="head.jsp" %>
<link href="js/tree/tree.css" rel="stylesheet">
<script src="js/tree/tree.js"></script>

<div style="padding: 10px">
    <%
        //------------------------------------------------
        String orderby = util.Request.get("order", "id");  // 获取搜索框中的排序字段、默认为发布时间
        String sort = util.Request.get("sort", "desc");   // 获取搜索框中的排序类型、默认为倒序

        String where = " 1=1 ";   // 防止sql 搜索条件为： where and a=b 这样的错误


// 以下是检测搜索框中是否填写了或者选择了什么，则写入sql 语句中


        if (request.getParameter("dingjifenlei") != null && !"".equals(request.getParameter("dingjifenlei"))) {
            where += " AND dingjifenlei in (" + Info.getAllChild("kecheng", "dingjifenlei", request.getParameter("dingjifenlei")) + ")";
        }
        if (request.getParameter("kechengming") != null && !"".equals(request.getParameter("kechengming"))) {
            where += " AND kechengming LIKE '%" + request.getParameter("kechengming") + "%'";
        }
        List<HashMap> list = Query.make("kecheng").where(where).order(orderby + " " + sort).select();

    %>


    <div class="panel panel-default">
        <div class="panel-heading">
        <span class="module-name">
            课程        </span>
            <span>列表</span>
        </div>
        <div class="panel-body">
            <div class="pa10 bg-warning">
                <form class="form-inline" action="?"><!-- form 标签开始 -->

                    <div class="form-group">


                        <i class="glyphicon glyphicon-search"></i>

                    </div>
                    <div class="form-group">
                        课程
                        <select class="form-control" name="dingjifenlei" id="dingjifenlei">
                            <option value="0">课程名称</option>
                        </select><% ArrayList<HashMap> treeOption = Query.make("kecheng").order("id asc").select(); %>
                        <script> (function () {
                            var value = "<%= request.getParameter("dingjifenlei") !=null ? request.getParameter("dingjifenlei") : "" %>";
                            var OptionList = <%= Info.jsonEncode(treeOption) %>;
                            var tree = new Tree(OptionList);
                            tree.setPid("dingjifenlei");
                            var options = tree.getTreeOption("0", value, "kechengming");
                            $("#dingjifenlei").append(options);
                        })();  </script>
                    </div>
                    <div class="form-group">
                        课程名

                        <input type="text" class="form-control" style="" name="kechengming"
                               value="<%= request.getParameter("kechengming") !=null ? request.getParameter("kechengming") : "" %>"/>
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


            <div class=" list-tree">
                <table width="100%" border="1" class="table table-list table-bordered table-hover">
                    <thead>
                    <tr align="center">
                        <th width="60" data-field="item">序号</th>

                        <th data-field="kechengming"> 课程名</th>
                        <th data-field="xuefen"> 学分</th>
                        <th data-field="xingqi"> 上课时间</th>
                        <%-- <th data-field="dijijie"> 第几节</th>--%>
                        <th width="180" data-field="addtime">添加时间</th>
                        <th width="220" data-field="handler">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int i = 0;
                        for (HashMap map : list) {
                            i++;
                    %>
                    <tr id="<%= map.get("id") %>" pid="<%= map.get("dingjifenlei") %>">
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
                        <td align="center"><%= map.get("addtime") %>
                        </td>
                        <td align="center">

                            <%

                                if ("学生".equals(session.getAttribute("cx"))) {

                                    // 取最新学期
                                    Map xueqi = Query.make("xueqi").order("id desc").find();

                                    long chengji = Query.make("chengji").where("kechengid", map.get("dingjifenlei"))
                                            .where("xuehao", session.getAttribute("username")).where("xueqi", xueqi.get("id")).count();

                                    long xuanke = Query.make("xuanke").where("kechengid", map.get("dingjifenlei"))
                                            .where("xuankeren", session.getAttribute("username")).count();

                                    if (map.get("dingjifenlei").equals("0") ||
                                            (chengji > 0 && xuanke > 0)) {
                                        String[] jikes = map.get("dijijie").toString().split(",");
                                        boolean isChongtu = false;
                                        for (String jie : jikes) {
                                            long count = Query.make("xuanke").where("xingqi", map.get("xingqi"))
                                                    .where("find_in_set('" + jie + "',dijijie)")
                                                    .where("xuankeren", session.getAttribute("username"))
                                                    .where("id", "neq", map.get("id")).count();
                                            if (count > 0) {
                                                isChongtu = true;
                                                break;
                                            }
                                        }
                                        if (!isChongtu) {
                                            if (Query.make("xuanke").where("xuankeren", session.getAttribute("username")).sum("xuefen") + Double.valueOf(map.get("xuefen").toString()).doubleValue() <= 21) {
                            %>
                            <a href="xuanke_add.jsp?id=<%= map.get("id") %>">选课</a>

                            <% } %>
                            <% } %>
                            <% } %>
                            <% } %>

                            <% if ("管理员".equals(request.getSession().getAttribute("cx"))) { %>


                            <a href="chengji_add.jsp?id=<%= map.get("id") %>">成绩录入</a>

                            <a href="kecheng_updt.jsp?id=<%= map.get("id") %>">修改</a>
                            <a href="kecheng.jsp?a=delete&id=<%= map.get("id") %>"
                               onclick="return confirm('真的要删除？')">删除</a>
                            <% } %>
                            <!--qiatnalijne-->
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>


        </div>


    </div>


    <script>
        $('.list-tree').hide();
        Tree.searchTable('.list-tree', 'kechengming');
        $('.list-tree').show();
    </script>


</div>
<%@ include file="foot.jsp" %>

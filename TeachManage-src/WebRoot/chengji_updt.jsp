<%@ page language="java" import="dao.*" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@page import="util.*" %>


<%@ include file="head.jsp" %>
<script src="js/jquery.validate.js"></script>
<script>
    window.searchSelectUrl = "ajax.jsp?a=selectUpdate";
    window.selectUpdateUrl = "ajax.jsp?a=table";
</script>
<script src="js/selectUpdate.js"></script>

<div style="padding: 10px">


    <% if (request.getSession().getAttribute("username") == null || "".equals(request.getSession().getAttribute("username"))) { %>
    <script>
        alert('对不起,请您先登陆!');
        location.href = 'login.jsp';
    </script>
    <%
            return;
        } %>


    <%
        // 获取需要编辑的数据
        String updtself = "0"; // 设置更新
        HashMap mmm = new CommDAO().getmap(request.getParameter("id"), "chengji");
    %>


    <div class="container"><!-- 使用bootstrap css框架，container定宽，并剧中 https://v3.bootcss.com/css/#overview-container -->

        <div class="panel panel-default">
            <div class="panel-heading">
                编辑成绩:
            </div>
            <div class="panel-body">
                <form action="chengji.jsp?a=update" method="post" name="form1" id="form1"><!-- form 标签开始 -->

                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">学期</label>
                            <div class="col-sm-8">

                                <select class="form-control class_xueqi6"
                                        data-value="<%= Info.html(mmm.get("xueqi")) %>" id="xueqi" name="xueqi"
                                        style="width:250px">
                                    <%
                                        List<HashMap> select = new CommDAO().select("SELECT * FROM xueqi ORDER BY id desc");
                                    %>
                                    <% for (HashMap m : select) { %>
                                    <option value="<%= m.get("id") %>"><%= m.get("xueqiming") %>
                                    </option>
                                    <% } %>

                                </select>
                                <script>
                                    $(".class_xueqi6").val($(".class_xueqi6").attr("data-value"))</script>

                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">课程名</label>
                            <div class="col-sm-8">

                                <%= mmm.get("kechengming") %><input type="hidden" id="kechengming" name="kechengming"
                                                                    value="<%= Info.html(mmm.get("kechengming")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">学分</label>
                            <div class="col-sm-8">

                                <%= mmm.get("xuefen") %><input type="hidden" id="xuefen" name="xuefen"
                                                               value="<%= Info.html(mmm.get("xuefen")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">学生</label>
                            <div class="col-sm-8">

                                <select id="xuesheng" name="xuesheng"
                                        onchange="getAjaxData('xuesheng' , this.value,'xuehao,xingming')">
                                    <option value="">请选择学生</option>
                                    <%
                                        List<HashMap> xueshengList = new CommDAO().select("SELECT * FROM xuesheng ORDER BY id desc");
                                    %><% for (HashMap tempMap : xueshengList) { %>
                                    <option value="<%= tempMap.get("id") %>"><%= tempMap.get("xuehao") %>
                                        - <%= tempMap.get("xingming") %>
                                    </option>
                                    <% } %></select>
                                <table>
                                    <tr>
                                        <td width="120">学号</td>
                                        <td><input type="text" class="form-control" style="width:150px;"
                                                   readonly="readonly" data-rule-required="true"
                                                   data-msg-required="请填写学号" id="xuehao" name="xuehao"
                                                   value="<%= Info.html(mmm.get("xuehao")) %>"/></td>
                                    </tr>
                                    <tr>
                                        <td width="120">姓名</td>
                                        <td><input type="text" class="form-control" style="width:150px;"
                                                   readonly="readonly" data-rule-required="true"
                                                   data-msg-required="请填写姓名" id="xingming" name="xingming"
                                                   value="<%= Info.html(mmm.get("xingming")) %>"/></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">成绩<span
                                    style="color: red;">*</span></label>
                            <div class="col-sm-8">

                                <input type="number" class="form-control" style="width:150px;" data-rule-required="true"
                                       data-msg-required="请填写成绩" number="true" data-msg-number="输入一个有效数字" id="chengji"
                                       name="chengji" value="<%= Info.html(mmm.get("chengji")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2"> </label>
                            <div class="col-sm-8">

                                <input name="id" value="<%= mmm.get("id") %>" type="hidden"/>
                                <input name="kechengid" value="<%= mmm.get("kechengid") %>" type="hidden"/>
                                <input name="referer" value="<%=request.getHeader("referer")%>" type="hidden"/>
                                <input name="updtself" value="<%= updtself %>" type="hidden"/>


                                <button type="submit" class="btn btn-primary" name="Submit">
                                    提交
                                </button>
                                <button type="reset" class="btn btn-default" name="Submit2">
                                    重置
                                </button>


                            </div>
                        </div>
                    </div>

                    <!--form标签结束--></form>
            </div>
        </div>

        <!-- container定宽，并剧中结束 --></div>


    <script>
        $(function () {
            $('#form1').validate();
        });
    </script>


</div>
<%@ include file="foot.jsp" %>

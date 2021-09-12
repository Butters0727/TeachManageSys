<%@ page language="java" import="dao.*" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@page import="util.*" %>


<%@ include file="head.jsp" %>
<script src="js/jquery.validate.js"></script>

<div style="padding: 10px">


    <% if (request.getSession().getAttribute("username") == null || "".equals(request.getSession().getAttribute("username"))) { %>
    <script>
        alert('对不起,请您先登陆!');
        location.href = 'login.jsp';
    </script>
    <%
            return;
        } %>


    <% if (null == request.getParameter("id") || "".equals(request.getParameter("id"))) { %>
    <script>
        alert('非法操作');
        history.go(-1);
    </script>
    <% out.close(); %>
    <% } %>        <% HashMap readMap = Query.make("kecheng").where("id", request.getParameter("id")).find(); %>


    <div class="container"><!-- 使用bootstrap css框架，container定宽，并剧中 https://v3.bootcss.com/css/#overview-container -->

        <div class="panel panel-default">
            <div class="panel-heading">
                添加选课:
            </div>
            <div class="panel-body">
                <form action="xuanke.jsp?a=insert" method="post" name="form1" id="form1"><!-- form 标签开始 -->

                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">课程名</label>
                            <div class="col-sm-8">

                                <%= readMap.get("kechengming") %><input type="hidden" id="kechengming"
                                                                        name="kechengming"
                                                                        value="<%= Info.html(readMap.get("kechengming")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">学分</label>
                            <div class="col-sm-8">

                                <%= readMap.get("xuefen") %><input type="hidden" id="xuefen" name="xuefen"
                                                                   value="<%= Info.html(readMap.get("xuefen")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">星期</label>
                            <div class="col-sm-8">

                                <%= readMap.get("xingqi") %><input type="hidden" id="xingqi" name="xingqi"
                                                                   value="<%= Info.html(readMap.get("xingqi")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">第几节</label>
                            <div class="col-sm-8">

                                <%= readMap.get("dijijie") %><input type="hidden" id="dijijie" name="dijijie"
                                                                    value="<%= Info.html(readMap.get("dijijie")) %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">选课人</label>
                            <div class="col-sm-8">

                                <input type="text" class="form-control" style="width:150px;" readonly="readonly"
                                       id="xuankeren" name="xuankeren"
                                       value="<%= request.getSession().getAttribute("username") !=null ? request.getSession().getAttribute("username") : "" %>"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2"> </label>
                            <div class="col-sm-8">

                                <input type="hidden" name="kechengid"
                                       value="<%= request.getParameter("id") !=null ? request.getParameter("id") : "" %>"/>
                                <input name="referer" value="<%=request.getHeader("referer")%>" type="hidden"/>


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

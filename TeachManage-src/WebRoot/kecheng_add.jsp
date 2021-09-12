<%@ page language="java" import="dao.*" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@page import="util.*" %>


<%@ include file="head.jsp" %>
<script src="js/jquery.validate.js"></script>
<link href="js/tree/tree.css" rel="stylesheet">
<script src="js/tree/tree.js"></script>

<div style="padding: 10px">


    <% if (request.getSession().getAttribute("username") == null || "".equals(request.getSession().getAttribute("username"))) { %>
    <script>
        alert('对不起,请您先登陆!');
        location.href = 'login.jsp';
    </script>
    <%
            return;
        } %>


    <div class="container"><!-- 使用bootstrap css框架，container定宽，并剧中 https://v3.bootcss.com/css/#overview-container -->

        <div class="panel panel-default">
            <div class="panel-heading">
                添加课程:
            </div>
            <div class="panel-body">
                <form action="kecheng.jsp?a=insert" method="post" name="form1" id="form1"><!-- form 标签开始 -->

                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">先修课</label>
                            <div class="col-sm-8">

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
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">课程名<span
                                    style="color: red;">*</span></label>
                            <div class="col-sm-8">

                                <input type="text" class="form-control" style="width:150px;" data-rule-required="true"
                                       data-msg-required="请填写课程名"
                                       remote="factory/checkno.jsp?checktype=insert&table=kecheng&col=kechengming"
                                       data-msg-remote="内容重复了" id="kechengming" name="kechengming" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">学分</label>
                            <div class="col-sm-8">

                                <input type="number" class="form-control" style="width:150px;" number="true"
                                       data-msg-number="输入一个有效数字" id="xuefen" name="xuefen" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">星期</label>
                            <div class="col-sm-8">

                                <select class="form-control class_xingqi1" data-value="" id="xingqi" name="xingqi"
                                        style="width:250px">
                                    <option value="周一">周一</option>
                                    <option value="周二">周二</option>
                                    <option value="周三">周三</option>
                                    <option value="周四">周四</option>
                                    <option value="周五">周五</option>
                                    <option value="周六">周六</option>
                                    <option value="周日">周日</option>

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2">节数</label>
                            <div class="col-sm-8">

                                <select class="form-control class_dijijie2" data-value="" id="dijijie" name="dijijie"
                                        multiple="multiple" style="height:150px;width:250px">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label style="width: 120px;min-height:18px;text-align: right" class="col-sm-2"> </label>
                            <div class="col-sm-8">


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

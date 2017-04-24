<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 机场管理</title>
    <#include "/include/head.ftl">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper" id="main-containter">
<#include "/include/admintop-menu.ftl"/>
    <!-- Left side column. contains the logo and sidebar -->
<#include "/include/adminleft-menu.ftl"/>
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                机型列表
            </h1>
            <ol class="breadcrumb">
                <li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">机型管理</li>
            </ol>
        </section>
        <!-- /.content -->

        <section class="content">
            <div class="row">


                <div class="col-xs-12">
                    <form class="form-inline well" style="text-align: right">
                        <button type="button" class="btn" id="btn-advanced-add"
                                onclick="addData('/plane/edit')">
                            <i class="fa fa-add"></i>新增机型
                        </button>
                    </form>

                    <div class="box">
                        <div class="box-body">
                            <table id="staffTable" style="text-align: center" class="table table-bordered table-striped">
                                <thead>
                                <tr >
                                    <th style="text-align: center">序号</th>
                                    <th style="text-align: center">品牌</th>
                                    <th style="text-align: center">型号</th>
                                    <th style="text-align: center">最大载客数</th>
                                    <th style="text-align: center">最大里程数</th>
                                    <th style="text-align: center">操作</th>
                                </tr>
                                </thead>

                            </table>
                        </div>
                    </div>

                </div>
        </section>


    </div>
    <!-- /.content-wrapper -->
    <#include "/include/adminfoot.ftl">
</div>


<script>

    var table;


    $(function () {
        //  $('#permTable').DataTable();
        table= $('#staffTable').DataTable({
//           "sPaginationType" : "full_numbers",//设置分页控件的模式
//            "bPaginate": true, //翻页功能
//            "bLengthChange": false, //改变每页显示数据数量
//            "bFilter": false, //过滤功能
//            "bSort": false, //排序功能
//            "bInfo": true,//页脚信息
//            "bAutoWidth": true,//自动宽度
//            "stateSave":true,//设置缓存页页码数据
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "抱歉， 没有找到",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                },
                "sZeroRecords": "没有检索到数据",
                "sProcessing": "<img src='./loading.gif' />",
                "sSearch": "搜索"
            },

            "bStateSave" : false,
            "bJQueryUI" : true,
            "bPaginate" : true,// 分页按钮
            "bFilter" : false,// 搜索栏
            "bLengthChange" : false,// 每行显示记录数
            "iDisplayLength" : 10,// 每页显示行数
            "bSort" : false,// 排序
            "bInfo" : true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息
            "bWidth" : true,
            "bScrollCollapse" : true,
            "sPaginationType" : "full_numbers", // 分页，一共两种样式 另一种为two_button // 是datatables默认
            //  "bProcessing" : true,
            "bServerSide" : true,
            "bDestroy" : true,
            "bSortCellsTop" : true,
            "sAjaxSource" : "${ctx}/plane/list",
            //  "sScrollY": "100%",
            "fnInitComplete": function() {
                this.fnAdjustColumnSizing(true);
            },
            "fnServerParams" : function(aoData) {

            },
            "aoColumns" : [
                {"data" :  function(row, type, set, meta) {
                    var c = meta.settings._iDisplayStart + meta.row + 1;
                    return c;
                }},
                {"data" : "company"},
                {"data" : "modelName"},
                {"data" : "seatCount"},
                {"data" : "maxMileage"}
                ],
            "createdRow": function ( row, data, index ) {
            },
            "aoColumnDefs":[
                {
                    "sClass":"center",
                    "aTargets":[5],
                    "data":"id",
                    "mRender":function(a,b,c,d){//id，c表示当前记录行对象
                    return  '<a href=\"${ctx}/plane/edit?id='+a+'\" >修改</a>';
                    }
                }
            ],
            "fnRowCallback" : function(nRow, aData, iDisplayIndex) {//相当于对字段格式化

            },

            "fnServerData" : function(sSource, aoData, fnCallback) {
                var serializeData = function(aoData){
                    var data = {};
                    for(var i = 0 ;i<aoData.length ;i++){
                        var dd = aoData[i];
                        if(dd['value']){
                            data[ dd['name'] ]= dd['value'];
                        }
                    }
                    return $.param(data);

                };

                $.ajax({
                    "type" : 'post',
                    "url" : sSource,
                    //"dataType" : "json",
                    ///"dataSrc": "data",
                    "data" :serializeData(aoData),
                    "success" : function(resp) {
                        fnCallback(resp);
                    }
                });
            }

        });

    });


    function addData(url){
            window.location.href = url;
    }

    function changeDisable(id){
        var url = "${ctx}/plane/changeDisable";
                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType: 'json',
                    data: {id: id},
                })
                        .done(function (data) {
                            window.wxc.xcConfirm(data.message, "success");
                            table.ajax.reload();
                        })
                        .fail(function () {
                            window.wxc.xcConfirm("异常，请联系管理员。", "error");
                        });

    }

</script>

</body>
</html>

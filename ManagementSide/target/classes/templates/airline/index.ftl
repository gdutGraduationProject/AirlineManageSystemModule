<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 航线管理</title>
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
                航班列表
            </h1>
            <ol class="breadcrumb">
                <li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">航班管理</li>
            </ol>
        </section>
        <!-- /.content -->

        <section class="content">
            <div class="row">


                <div class="col-xs-12">
                    <form class="form-inline well" style="text-align: right">
                        <button type="button" class="btn" id="btn-advanced-add"
                                onclick="addData('/airline/edit')">
                            <i class="fa fa-add"></i>新增航班
                        </button>
                    </form>

                    <div class="box">
                        <div class="box-body">
                            <table id="staffTable" style="text-align: center" class="table table-bordered table-striped">
                                <thead>
                                <tr >
                                    <th style="text-align: center">序号</th>
                                    <th style="text-align: center">航班号</th>
                                    <th style="text-align: center">出发地及时间</th>
                                    <th style="text-align: center">目的地及时间</th>
                                    <th style="text-align: center">航班状态</th>
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
            "sAjaxSource" : "${ctx}/airline/list",
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
                {"data" : "airlineNum"},
                {"data" : "status"},
                {"data" : "status"},
                {"data" : "status"}
                ],
            "createdRow": function ( row, data, index ) {
                var startTime = new Date(data['startTime']);
                var startTimeString = (startTime.getHours()<10?('0'+startTime.getHours()):startTime.getHours())+':'+(startTime.getMinutes()<10?('0'+startTime.getMinutes()):startTime.getMinutes());
                var departureString = data['departure']['city']+' - '+data['departure']['airportName']+' - '+startTimeString;
                $('td', row).eq(2).html(departureString);

                var arriveTime = new Date(data['arriveTime']);
                var arriveTimeString = (arriveTime.getHours()<10?('0'+arriveTime.getHours()):arriveTime.getHours())+':'+(arriveTime.getMinutes()<10?('0'+arriveTime.getMinutes()):arriveTime.getMinutes());
                var destinationString = data['destination']['city']+' - '+data['destination']['airportName']+' - '+arriveTimeString;
                $('td', row).eq(3).html(destinationString);

                if ( data['status'] == 1 ) {
                    $('td', row).eq(4).html('未开售');
                }else if(data['status'] == 2){
                    $('td', row).eq(4).html('已开售');
                }else if(data['status'] == 3){
                    $('td', row).eq(4).html('已停售');
                }

            },
            "aoColumnDefs":[
                {
                    "sClass":"center",
                    "aTargets":[5],
                    "data":"id",
                    "mRender":function(a,b,c,d){//id，c表示当前记录行对象
                        var charString;
                        if(c.status==1){
                            charString="开售";
                        }else if(c.status==2){
                            charString="停售";
                        }else if(c.status==3){
                            charString="开售";
                        }
                        var returnStirng = '<a href=\"javascript:void(0);\" onclick=\"changeDisable(\''+a+'\')\">'+charString+'</a>';
                        if(c.status == 1){
                            returnStirng = returnStirng +'&nbsp;&nbsp;&nbsp;&nbsp;'+'<a href=\"${ctx}/airline/edit?id='+a+'\" >修改</a>';
                        }if(c.status == 1 || c.status == 3){
                            returnStirng = returnStirng +'&nbsp;&nbsp;&nbsp;&nbsp;'+'<a href=\"javascript:void(0);\" onclick=\"confirmDelete(\''+a+'\')\">'+'删除'+'</a>';
                        }
                    return  returnStirng;
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
        var url = "${ctx}/airline/changeDisable";
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

    function confirmDelete(id){
        var url = "${ctx}/airline/delete";
        var tipTxt = "温馨提示:删除后无法恢复，是否确定删除？";
        var option = {
            title: "提示",
            btn: parseInt("0011", 2),
            onOk: function () {
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
        }
        window.wxc.xcConfirm(tipTxt, "confirm", option);
    }

</script>

</body>
</html>

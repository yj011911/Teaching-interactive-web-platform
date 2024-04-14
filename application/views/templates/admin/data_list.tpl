<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理后台-<{$web_title}></title>
    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="<{$smarty.const._site_css}>bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="<{$smarty.const._site_css}>iCheck_square_blue.css"/>
    <link type="text/css" rel="stylesheet" href="<{$smarty.const._admin_css}>default.css"/>
    <!--IE8 css query-->
    <script src="<{$smarty.const._site_js}>respond.min.js"></script>
</head>
<body>
<{include file="admin/nav.tpl"}>
<div class="content">
    <ol class="breadcrumb">
        <li class="active"><a href="<{$smarty.const._admin_domain}>">管理后台</a></li>
        <li class="active">课件资料</li>
        <li><{$web_title}></li>
    </ol>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">资料列表</h3>
        </div>
        <table id="admin_table" class="table table-striped table-hover table-condensed">
            <tr>
                <th class="text-center"><input id="all_check" type="checkbox" disabled="disabled"></th>
                <th class="text-left">ID</th>
                <th class="text-center">标题</th>
                <th class="text-center">上传教师</th>
                <th class="text-center">类型</th>
                <th class="text-center">最后编辑时间</th>
                <th class="text-center">操作</th>
            </tr>
            <{foreach from=$data_info_list item=val key=key}>
            <tr>
                <td class="text-center"><input class="item_check" type="checkbox" data-did="<{$val.did}>"
                                               disabled="disabled"></td>
                <td class="text-left"><{$val.did}></td>
                <td class="text-center"><a target="_blank" href="<{$smarty.const._site_domain}>course_data/index/<{$val.did}>"><{$val.title}></a></td>
                <td class="text-center"><{$val.user_name}></td>
                <td class="text-center">
                    <{if $val.type==1}>
                    <span class="alert-success">课件</span>
                    <{else}>
                    <span class="alert-info">资料</span>
                    <{/if}>
                </td>
                <td class="text-center">
                    <{if !empty($val.edit_time)}>
                    <{$val.edit_time|date_format:'%Y-%m-%d %H:%M:%S'}>
                    <{else}>
                    暂无记录
                    <{/if}>
                </td>
                <td class="text-center">
                    <div class="btn-group" role="group">
                        <a href="<{$smarty.const._admin_domain}>data_edit/index/<{$val.did}>"
                           class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil"></span>
                            编辑
                        </a>
                        <a href="#" class="del_btn btn btn-default btn-sm"
                           data-did="<{$val.did}>" data-title="<{$val.title}>">
                            <span class="glyphicon glyphicon-trash"></span>
                            删除
                        </a>
                    </div>
                </td>
            </tr>
            <{/foreach}>
        </table>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="pull-left">
                <a href="<{$smarty.const._admin_domain}>data_edit/" class="btn btn-success" style="margin-top: 20px">
                    <span class="glyphicon glyphicon-plus"></span>
                    添加新资料
                </a>
                &nbsp;&nbsp;
            </div>
            <nav class="pull-right">
                <{$page_string}>
            </nav>

        </div>
    </div>

</div>


<{include file="admin/footer.tpl"}>
<script type="text/javascript">
    //删除资料
    $(document).delegate('.del_btn', 'click', function () {
        var did = $(this).data('did');
        var title = $(this).data('title');
        my_dialog('确认删除', '确定要删除资料<span id="del_data_name" class="text-danger">' + title + '</span>吗?删除后将无法恢复!', {
            btn_text: '删除',
            btn_class: 'danger',
            show_cancel: true,
            call_back: function () {
                $.ajax({
                    type: 'post',
                    url: '<{$smarty.const._admin_domain}><{$controller_name}>/del/' + did,
                    success: function (res) {
                        var return_arr = eval('(' + res + ')');
                        switch (return_arr.status) {
                            case '1':
                                my_dialog('消息', return_arr.msg, {
                                    btn_class: 'info',
                                    call_back: function () {
                                        location.reload();
                                    },
                                    cancel_call_back: function () {
                                        location.reload();
                                    }
                                });
                                break;
                            default :
                                my_dialog('提示', '操作失败:' + return_arr.msg, false);
                                break;
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>
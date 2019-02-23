<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>demo</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script src="../js/jquery.js"></script>
    <script src="/bootstrap-3.3.7-dist/js/bootstrap-treeview.js"></script>
    <script>
        $(function () {
            var defaultData;
            $.ajax({
                type: "post",
                url: "http://192.168.1.32:8083/getAllTreeList",
                dataType: "json",
                success: function (result) {
                    defaultData=result;
                    var initSearchableTree = function() {
                        return $('#treeview-searchable').treeview({
                            data: defaultData,
                            nodeIcon: 'glyphicon glyphicon-globe',
                            emptyIcon: '', //没有子节点的节点图标
                            //collapsed: true,
                        });
                    };
                    var $searchableTree = initSearchableTree();
                    $('#treeview-searchable').treeview('collapseAll', {
                        silent : false//设置初始化节点关闭
                    });
                    var findSearchableNodes = function() {
                        return $searchableTree.treeview('search', [ $.trim($('#input-search').val()), { ignoreCase: false, exactMatch: false } ]);
                    };
                    var searchableNodes = findSearchableNodes();
                    // Select/unselect/toggle nodes
                    $('#input-search').on('keyup', function (e) {
                        var str = $('#input-search').val();
                        if($.trim(str).length>0){
                            searchableNodes = findSearchableNodes();
                        } else {
                            $('#treeview-searchable').treeview('collapseAll', {
                                silent : false  //设置初始化节点关闭
                            });
                        }
                        //$('.select-node').prop('disabled', !(searchableNodes.length >= 1));
                    });
                    var search = function(e) {
                        var pattern = $.trim($('#input-search').val());
                        var options = {
                            ignoreCase: $('#chk-ignore-case').is(':checked'),
                            exactMatch: $('#chk-exact-match').is(':checked'),
                            revealResults: $('#chk-reveal-results').is(':checked')
                        };
                        var results = $searchableTree.treeview('search', [ pattern, options ]);

                        var output = '<p>' + results.length + ' 匹配的搜索结果</p>';
                        $.each(results, function (index, result) {
                            output += '<p>- <span style="color:red;">' + result.text + '</span></p>';
                        });
                        $('#search-output').html(output);
                    }
                    $('#btn-search').on('click', search);
                    $('#input-search').on('keyup', search);
                    $('#btn-clear-search').on('click', function (e) {
                        $searchableTree.treeview('clearSearch');
                        $('#input-search').val('');
                        $('#search-output').html('');
                        $('#treeview-searchable').treeview('collapseAll', {
                            silent : false//设置初始化节点关闭
                        });
                    });

                },
                error: function () {
                    alert("获取目录失败！")
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <h4>快捷搜索</h4>
            <!-- <form> -->
            <div class="form-group">
                <label for="input-search" class="sr-only">快捷搜索:</label>
                <input type="input" class="form-control" id="input-search" placeholder="请输入" value="">
            </div>
            <button type="button" class="btn btn-success" id="btn-search">搜索</button>
            <button type="button" class="btn btn-default" id="btn-clear-search">清除</button>
            <!-- </form> -->
        </div>
        <div class="col-sm-4">
            <h4>2019年海关进出口税则</h4>
            <div id="treeview-searchable" class=""></div>
        </div>
        <div class="col-sm-4">
            <h4>查询结果展示</h4>
            <div id="search-output"></div>
        </div>
    </div>
</div>
</body>
</html>
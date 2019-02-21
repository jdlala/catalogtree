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
            $.ajax({
                type: "Post",
                url: "",
                dataType: "json",
                success: function (result) {
                    var data = JSON.stringify(result);
                    $('#tree').treeview({
                        data: data,
                        levels: 1,
                        onNodeSelected:function (event,data) {
                            $.ajax({
                                type: "Post",
                                url: "",
                                dataType: "json",
                                data:{"pid":data.pid},
                                success:function (result) {
                                    var sondata = JSON.stringify(result);
                                    console.log(sondata)
                                    $('#tree').treeview({
                                        data:sondata,
                                        onNodeSelected:function (event,data) {

                                        }
                                    })
                                }
                            })
                        }
                    });
                }
            });
        })
    </script>
</head>
<body>
<div id="tree"></div>
</body>
</html>
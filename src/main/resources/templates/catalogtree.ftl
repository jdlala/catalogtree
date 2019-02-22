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
                url: "http://192.168.1.32:8083/getFirstTreeList",
                dataType: "json",
                success: function (firstData) {
                    $('#tree').treeview({
                        data: firstData,
                        showIcon: false,
                        onhoverColor: "#E8E8E8",
                        showBorder: false,
                        showTags: true,
                        highlightSelected: true,
                        highlightSearchResults: false,
                        selectedBackColor: "#8D9CAA",
                        levels: 3,
                        onNodeSelected:function (event,firstData) {
                            $.ajax({
                                type: "Post",
                                url: "http://192.168.1.32:8083/getSecondTreeList",
                                dataType: "json",
                                data:{"firstId":firstData.id},
                                success:function (secondData) {
                                    for (var index = 0;index < secondData.length; index++){
                                        var item = secondData[index];
                                        $("#tree").treeview("addNode",[firstData.nodeId,{node:{text:item.text,id:item.id},silent: true}]);
                                        // $("#tree").treeview({
                                        //     onNodeSelected: function (event,secondData) {
                                        //         $.ajax({
                                        //             type: "Post",
                                        //             url: "http://192.168.1.32:8083/getThirdTreeList",
                                        //             dataType: "json",
                                        //             data: {"secondId": secondData.id},
                                        //             success: function (thirdData) {
                                        //                 for (var index = 0; index < thirdData.length; index++) {
                                        //                     var item = thirdData[index];
                                        //                     $("#tree").treeview("addNode", [secondData.nodeId, {
                                        //                         node: {
                                        //                             text: item.text,
                                        //                             id: item.id
                                        //                         }, silent: true
                                        //                     }]);
                                        //                 }
                                        //             }
                                        //         })
                                        //     }
                                        // })
                                        // thirdClick(item);
                                    }
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
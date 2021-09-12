/**
 * @author 陈举民
 * @version 1.0
 * @link http://chenjumin.iteye.com/blog/419522
 */
TreeGrid = function (_config) {
    _config = _config || {};

    var s = "";
    var rownum = 0;
    var __root;

    var __selectedData = null;
    var __selectedId = null;
    var __selectedIndex = null;

    var folderOpenIcon = (_config.folderOpenIcon || TreeGrid.FOLDER_OPEN_ICON);
    var folderCloseIcon = (_config.folderCloseIcon || TreeGrid.FOLDER_CLOSE_ICON);
    var defaultLeafIcon = (_config.defaultLeafIcon || TreeGrid.DEFAULT_LEAF_ICON);

    //显示表头行
    drowHeader = function () {
        s += "<tr class='header' height='" + (_config.headerHeight || "25") + "'>";
        var cols = _config.columns;
        for (i = 0; i < cols.length; i++) {
            var col = cols[i];
            s += "<td align='" + (col.headerAlign || _config.headerAlign || "center") + "' width='" + (col.width || "") + "'>" + (col.headerText || "") + "</td>";
        }
        s += "</tr>";
    }

    //递归显示数据行
    drowData = function () {
        var rows = _config.data;
        var cols = _config.columns;
        drowRowData(rows, cols, 1, "");
    }

    //局部变量i、j必须要用 var 来声明，否则，后续的数据无法正常显示
    drowRowData = function (_rows, _cols, _level, _pid) {
        var folderColumnIndex = (_config.folderColumnIndex || 0);

        for (var i = 0; i < _rows.length; i++) {
            var id = _pid + "_" + i; //行id
            var row = _rows[i];

            s += "<tr id='TR" + id + "' data-pid='" + ((_pid == "") ? "0" : ("TR" + _pid)) + "' data-open='Y' data-rowIndex='" + rownum++ + "'>";
            for (var j = 0; j < _cols.length; j++) {
                var col = _cols[j];
                s += "<td align='" + (col.dataAlign || _config.dataAlign || "left") + "'";

                //层次缩进
                if (j == folderColumnIndex) {
                    s += " style='text-indent:" + (parseInt((_config.indentation || "20")) * (_level - 1)) + "px;'> ";
                } else {
                    s += ">";
                }

                //节点图标
                if (j == folderColumnIndex) {
                    if (row.children && row.children.length > 0) { //有下级数据
                        s += "<img data-folder='Y' data-trid='TR" + id + "' src='" + folderOpenIcon + "' class='image_hand'> ";
                    } else {
                        s += "&nbsp;&nbsp;&nbsp;&nbsp;";
                    }
                }

                //单元格内容
                if (col.handler) {
                    if (jQuery.isFunction(col.handler)) {
                        s += col.handler(row, col);
                    } else {
                        s += (eval(col.handler + ".call(new Object(), row, col)") || "") + "</td>";
                    }

                } else {
                    s += (row[col.dataField] || "") + "</td>";
                }
            }
            s += "</tr>";

            //递归显示下级数据
            if (row.children) {
                drowRowData(row.children, _cols, _level + 1, id);
            }
        }
    }

    //主函数
    this.show = function () {
        this.id = _config.id || ("TreeGrid" + TreeGrid.COUNT++);

        s += "<table id='" + this.id + "' cellspacing=0 cellpadding=0 width='" + (_config.width || "100%") + "' class='TreeGrid'>";
        drowHeader();
        drowData();
        s += "</table>";

        __root = jQuery(_config.renderTo);
        __root.append(s);

        //初始化动作
        init();
    }

    init = function () {
        //以新背景色标识鼠标所指行
        if ((_config.hoverRowBackground || "false") == "true") {
            __root.find("tr").hover(
                function () {
                    if (jQuery(this).attr("class") && jQuery(this).attr("class") == "header") return;
                    jQuery(this).addClass("row_hover");
                },
                function () {
                    jQuery(this).removeClass("row_hover");
                }
            );
        }

        //将单击事件绑定到tr标签
        __root.find("tr").bind("click", function () {
            __root.find("tr").removeClass("row_active");
            jQuery(this).addClass("row_active");

            //获取当前行的数据
            __selectedData = jQuery(this).attr('data-row');
            __selectedId = jQuery(this).attr('id');
            __selectedIndex = jQuery(this).attr('data-rowIndex');

            //行记录单击后触发的事件
            if (_config.itemClick) {

                if (jQuery.isFunction(_config.itemClick)) {
                    _config.itemClick(__selectedId, __selectedIndex, TreeGrid.str2json(__selectedData));
                }
                //eval(_config.itemClick + "(__selectedId, __selectedIndex, TreeGrid.str2json(__selectedData))");
            }
        });

        //展开、关闭下级节点
        __root.find("img[data-folder='Y']").bind("click", function () {
            var trid = jQuery(this).attr("data-trid");
            var isOpen = __root.find("#" + trid).attr("data-open");

            isOpen = (isOpen == "Y") ? "N" : "Y";
            __root.find("#" + trid).attr("data-open", isOpen);
            showHiddenNode(trid, isOpen);
        });
    }

    //显示或隐藏子节点数据
    showHiddenNode = function (_trid, _open) {
        if (_open == "N") { //隐藏子节点
            __root.find("#" + _trid).find("img[data-folder='Y']").attr("src", folderCloseIcon);
            __root.find("tr[id^=" + _trid + "_]").css("display", "none");
        } else { //显示子节点
            __root.find("#" + _trid).find("img[data-folder='Y']").attr("src", folderOpenIcon);
            showSubs(_trid);
        }
    }

    //递归检查下一级节点是否需要显示
    showSubs = function (_trid) {
        var isOpen = __root.find("#" + _trid).attr("data-open");
        if (isOpen == "Y") {
            var trs = __root.find("tr[data-pid=" + _trid + "]");
            trs.css("display", "");

            for (var i = 0; i < trs.length; i++) {
                showSubs(trs[i].id);
            }
        }
    }

    //展开或收起所有节点
    this.expandAll = function (isOpen) {
        var trs = __root.find("tr[data-pid='0']");
        for (var i = 0; i < trs.length; i++) {
            var trid = trs[i].id || trs[i].getAttribute("id");
            showHiddenNode(trid, isOpen);
        }
    }

    //取得当前选中的行记录
    this.getSelectedItem = function () {
        return new TreeGridItem(__root, __selectedId, __selectedIndex, TreeGrid.str2json(__selectedData));
    }

};

//公共静态变量
TreeGrid.FOLDER_OPEN_ICON = "images/folderOpen.gif";
TreeGrid.FOLDER_CLOSE_ICON = "images/folderClose.gif";
TreeGrid.DEFAULT_LEAF_ICON = "images/defaultLeaf.gif";
TreeGrid.COUNT = 1;

//将json对象转换成字符串
TreeGrid.json2str = function (obj) {
    var arr = [];

    var fmt = function (s) {
        if (typeof s == 'object' && s != null) {
            if (s.length) {
                var _substr = "";
                for (var x = 0; x < s.length; x++) {
                    if (x > 0) _substr += ", ";
                    _substr += TreeGrid.json2str(s[x]);
                }
                return "[" + _substr + "]";
            } else {
                return TreeGrid.json2str(s);
            }
        }
        return /^(string|number)$/.test(typeof s) ? "'" + s + "'" : s;
    }

    for (var i in obj) {
        if (typeof obj[i] != 'object') { //暂时不包括子数据
            arr.push(i + ":" + fmt(obj[i]));
        }
    }

    return '{' + arr.join(', ') + '}';
}

TreeGrid.str2json = function (s) {
    var json = null;
    if (jQuery.browser.msie) {
        json = eval("(" + s + ")");
    } else {
        json = new Function("return " + s)();
    }
    return json;
}

//数据行对象
function TreeGridItem(_root, _rowId, _rowIndex, _rowData) {
    var __root = _root;

    this.id = _rowId;
    this.index = _rowIndex;
    this.data = _rowData;

    this.getParent = function () {
        var pid = jQuery("#" + this.id).attr("data-pid");
        if (pid != "") {
            var rowIndex = jQuery("#" + pid).attr("data-rowIndex");
            var data = jQuery("#" + pid).attr("data-row");
            return new TreeGridItem(_root, pid, rowIndex, TreeGrid.str2json(data));
        }
        return null;
    }

    this.getChildren = function () {
        var arr = [];
        var trs = jQuery(__root).find("tr[data-pid='" + this.id + "']");
        for (var i = 0; i < trs.length; i++) {
            var tr = trs[i];
            arr.push(new TreeGridItem(__root, tr.id, tr.rowIndex, TreeGrid.str2json(tr.data)));
        }
        return arr;
    }
};

function Tree(array) {
    this.icon = ['│', '├', '└'];
    this._arrayList = array || [];
}

Tree.prototype = {
    // 树形结构
    icon: [],
    nbsp: "&nbsp;",
    _arrayList: [],
    pk: 'id',
    pid: 'parentid',
    _ret: '',
    /**
     * 设置数组
     * @param Array array
     * @returns {Tree}
     */
    set: function (array) {
        this._arrayList = array;
        return this;
    },
    /**
     * 设置主键
     * @param string pk
     * @returns {Tree}
     */
    setPk: function (pk) {
        this.pk = pk;
        return this;
    },
    /**
     * 设置父级id
     * @param pid
     * @returns {Tree}
     */
    setPid: function (pid) {
        this.pid = pid;
        return this;
    },
    getChild: function (pid) {
        var result = [];
        for (var i in this._arrayList) {
            var ci = this._arrayList[i];
            if (ci[this.pid] == pid) {
                result.push(ci);
            }
        }
        return result;
    },
    getTreeOption: function ($bid, $sid, $name) {
        return this.getTree($bid, "<option value='$id' $selected>$spacer $" + $name + "</option>", $sid);
    },
    getTreeChilds: function ($bid, $name) {
        $name = $name || 'children';
        var $child = this.getChild($bid);
        if ($child.length > 0) {
            for (var i in $child) {
                var ci = $child[i];
                var $id = ci[this.pk];
                ci[$name] = this.getTreeChilds($id, $name);
            }
        }
        return $child;
    },
    getTree: function (parentid, html, selectid, $adds) {
        var $parent_id = '';
        var $nstr = '';
        var $number = 1;
        var $child = this.getChild(parentid);
        var $this = this;
        if ($child.length > 0) {
            var $total = $child.length;
            for (var i = 0; i < $total; i++) {
                var $temp = deepClone($child[i]);
                var $id = $temp[$this.pk];
                var $j = '', $k = '';
                if ($number == $total) {
                    $j += $this.icon[2];
                } else {
                    $j += $this.icon[1];
                    $k = $adds ? $this.icon[0] : '';
                }
                var $spacer = $adds ? $adds + $j : '';
                var $selected = $id == selectid ? 'selected' : '';

                $temp['spacer'] = $spacer;
                $temp['selected'] = $selected;
                $temp["adds"] = $adds;
                $this._ret += $this.parseVars(html, $temp);
                var $nbsp = $this.nbsp;
                $this.getTree($id, html, selectid, ($adds ? $adds : '') + $k + $nbsp);
                $number++;
            }
        }
        return $this._ret;
    },
    parseVars: function (html, vars) {
        var result = html;
        for (var k in vars) {
            var reg = new RegExp('\\$' + k, 'ig');
            result = result.replace(reg, vars[k]);
        }
        return result;
    }
};

Tree.searchTable = function (listTree, col, parentid) {
    // 搜索列信息


    $(listTree).each(function () {
        try {
            var table = $(this).find('table');
            // 取出列
            var columns = [];
            var colnumber = 0;
            table.find('thead>tr>th').each(function (index) {
                var th = $(this);
                var obj = {
                    headerText: $.trim(th.text()),
                    dataField: th.attr('data-field'),
                    headerAlign: "left",
                    dataAlign: 'left'
                };
                if (obj.dataField == col) {
                    colnumber = index;
                }
                columns.push(obj);
            });

            var result = [];
            table.find('tbody>tr').each(function () {
                // 将数据收集起来
                var $this = $(this);
                var item = {
                    id: Math.floor($this.attr('id')),
                    parentid: Math.floor($this.attr('pid'))
                };
                $this.find('>td').each(function (index) {
                    item[columns[index].dataField] = $.trim($(this).html());
                });
                result.push(item);
            });


            var tree = new Tree(result);
            var datas = tree.getTreeChilds(parentid || 0);

            var config = {
                id: "tg1",
                renderTo: this,
                headerAlign: "left",
                headerHeight: "30",
                dataAlign: "left",
                indentation: "4",
                folderOpenIcon: "js/tree/collapse.png",
                folderCloseIcon: "js/tree/expand.png",
                defaultLeafIcon: "js/tree/file.png",
                hoverRowBackground: "false",
                folderColumnIndex: colnumber,
                itemClick: null, // 行被点击
                columns: columns,
                data: datas
            };
            $(this).html('');
            var treeGrid = new TreeGrid(config);
            treeGrid.show();
        } catch (e) {
            console.error(e);
        }

    })
};


function deepClone(origin, target) {
    var target = target || {},
        toStr = Object.prototype.toString,
        arrStr = "[object Array]";
    for (var prop in origin) {
        if (origin.hasOwnProperty(prop)) {
            if (origin[prop] !== "null" && typeof (origin[prop]) == "object") {
                target[prop] = (toStr.call(origin[prop]) == arrStr) ? [] : {};
                deepClone(origin[prop], target[prop]);
            } else {
                target[prop] = origin[prop]
            }
        }
    }
    return target;
}

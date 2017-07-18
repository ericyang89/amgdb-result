/**
 * 搜索井
 */

var mock = {
	"Status" : "ok",
	"MetaData" : [{
			"TableName" : null,
			"ColumnName" : "BGRQ",
			"ColumnTitle" : "变更日期",
			"ColumnRuTitle" : "дата изменений",
			"DataType" : "D",
			"DisplayIndex" : 3,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JH",
			"ColumnTitle" : "井号",
			"ColumnRuTitle" : "№ скв.",
			"DataType" : "C",
			"DisplayIndex" : 2,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "CJDM",
			"ColumnTitle" : "车间",
			"ColumnRuTitle" : "цех",
			"DataType" : "C",
			"DisplayIndex" : 8,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "CLCDM",
			"ColumnTitle" : "处理厂",
			"ColumnRuTitle" : "ГПЗ",
			"DataType" : "C",
			"DisplayIndex" : 9,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "QKDM",
			"ColumnTitle" : "区块",
			"ColumnRuTitle" : "блок",
			"DataType" : "C",
			"DisplayIndex" : 4,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "KFDYDM",
			"ColumnTitle" : "开发单元",
			"ColumnRuTitle" : "элемент по разработке",
			"DataType" : "C",
			"DisplayIndex" : 5,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "CWDM",
			"ColumnTitle" : "层位",
			"ColumnRuTitle" : "пачка",
			"DataType" : "C",
			"DisplayIndex" : 6,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "CYCDM",
			"ColumnTitle" : "采油厂",
			"ColumnRuTitle" : "НГДУ",
			"DataType" : "C",
			"DisplayIndex" : 7,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "MQJB",
			"ColumnTitle" : "目前井别",
			"ColumnRuTitle" : "текущий тип скв.",
			"DataType" : "C",
			"DisplayIndex" : 13,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "CQRQ",
			"ColumnTitle" : "采气日期",
			"ColumnRuTitle" : "дата добычи газа",
			"DataType" : "D",
			"DisplayIndex" : 20,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "ZQRQ",
			"ColumnTitle" : "注汽日期",
			"ColumnRuTitle" : "дата закачки пара",
			"DataType" : "D",
			"DisplayIndex" : 21,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "YSDCWD",
			"ColumnTitle" : "原始地层温度",
			"ColumnRuTitle" : "начальная температура в пл.усл.",
			"DataType" : "N",
			"DisplayIndex" : 25,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "YSDCYL",
			"ColumnTitle" : "原始地层压力",
			"ColumnRuTitle" : "начальное пластовое давление",
			"DataType" : "N",
			"DisplayIndex" : 23,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "SJJB",
			"ColumnTitle" : "设计井别",
			"ColumnRuTitle" : "проектный тип скв.",
			"DataType" : "C",
			"DisplayIndex" : 14,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "TCRQ",
			"ColumnTitle" : "投产日期",
			"ColumnRuTitle" : "дата ввода в эксплуатацию",
			"DataType" : "D",
			"DisplayIndex" : 16,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "PSRQ",
			"ColumnTitle" : "排水日期",
			"ColumnRuTitle" : "дата водоотвода",
			"DataType" : "D",
			"DisplayIndex" : 18,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "ZSRQ",
			"ColumnTitle" : "注水日期",
			"ColumnRuTitle" : "дата закачки воды",
			"DataType" : "D",
			"DisplayIndex" : 17,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JYZDM",
			"ColumnTitle" : "集油站",
			"ColumnRuTitle" : "комплексный сборный пункт",
			"DataType" : "C",
			"DisplayIndex" : 10,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JLJ",
			"ColumnTitle" : "计量间",
			"ColumnRuTitle" : "АГЗУ",
			"DataType" : "C",
			"DisplayIndex" : 11,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JDCSL",
			"ColumnTitle" : "阶段产水量",
			"ColumnRuTitle" : "добыча воды на этапе",
			"DataType" : "N",
			"DisplayIndex" : 28,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "YSBHYL",
			"ColumnTitle" : "原始饱和压力",
			"ColumnRuTitle" : "начальное насыщенное давление",
			"DataType" : "N",
			"DisplayIndex" : 24,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "BZ1",
			"ColumnTitle" : "泵站",
			"ColumnRuTitle" : "БКНС",
			"DataType" : "C",
			"DisplayIndex" : 32,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "BGYY",
			"ColumnTitle" : "变更原因",
			"ColumnRuTitle" : "причина изменений",
			"DataType" : "C",
			"DisplayIndex" : 26,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JDCYL",
			"ColumnTitle" : "阶段产油量",
			"ColumnRuTitle" : "добыча нефти на этапе",
			"DataType" : "N",
			"DisplayIndex" : 27,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JDCQL",
			"ColumnTitle" : "阶段产气量",
			"ColumnRuTitle" : "добыча газа на этапе",
			"DataType" : "N",
			"DisplayIndex" : 29,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JDZSL",
			"ColumnTitle" : "阶段注水量",
			"ColumnRuTitle" : "закачка воды на этапе",
			"DataType" : "N",
			"DisplayIndex" : 30,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "TSBZ",
			"ColumnTitle" : "特殊标志",
			"ColumnRuTitle" : "специальный знак",
			"DataType" : "C",
			"DisplayIndex" : 33,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "BGRA",
			"ColumnTitle" : "气计量间",
			"ColumnRuTitle" : "БГРА",
			"DataType" : "C",
			"DisplayIndex" : 34,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "YQTDM",
			"ColumnTitle" : "油气田",
			"ColumnRuTitle" : "месторождение",
			"DataType" : "C",
			"DisplayIndex" : 1,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JLX",
			"ColumnTitle" : "井类型",
			"ColumnRuTitle" : "вид скв.",
			"DataType" : "C",
			"DisplayIndex" : 12,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "JSRQ",
			"ColumnTitle" : "见水日期",
			"ColumnRuTitle" : "дата работы с водой",
			"DataType" : "D",
			"DisplayIndex" : 22,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "TCJB",
			"ColumnTitle" : "投产井别",
			"ColumnRuTitle" : "тип скв.ввода в эксплуатацию",
			"DataType" : "C",
			"DisplayIndex" : 15,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "CYRQ",
			"ColumnTitle" : "采油日期",
			"ColumnRuTitle" : "дата добычи нефти",
			"DataType" : "D",
			"DisplayIndex" : 19,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}, {
			"TableName" : null,
			"ColumnName" : "BZ",
			"ColumnTitle" : "备注",
			"ColumnRuTitle" : "примечание",
			"DataType" : "C",
			"DisplayIndex" : 31,
			"DataLength" : 0,
			"DataScale" : 0,
			"Unit" : null,
			"IsPK" : false,
			"NotNull" : false,
			"IsUserAdd" : false
		}
	],
	"Data" : [{
			"BGRQ" : "2002-05-01",
			"JH" : "1333",
			"CJDM" : "肯采油三车间",
			"CLCDM" : null,
			"QKDM" : "主力区块",
			"KFDYDM" : "中侏罗(中)",
			"CWDM" : "中侏罗(中)",
			"CYCDM" : "肯基亚克采油厂",
			"MQJB" : "采油井",
			"CQRQ" : null,
			"ZQRQ" : null,
			"YSDCWD" : null,
			"YSDCYL" : null,
			"MQJB1" : null,
			"TCRQ" : "1983-11-30",
			"PSRQ" : null,
			"ZSRQ" : null,
			"JYZDM" : null,
			"JLJ" : "计量间-3",
			"JDCSL" : null,
			"YSBHYL" : null,
			"BZ1" : null,
			"BGYY" : null,
			"JDCYL" : null,
			"JDCQL" : null,
			"JDZSL" : null,
			"TSBZ" : "1",
			"BGRA" : null,
			"YQTDM" : "肯基亚克盐上",
			"JLX" : null,
			"JSRQ" : null,
			"TCJB" : null,
			"CYRQ" : null,
			"BZ" : null
		}
	]
};
 

function renderTable(data) {
    var html =
    '<table class="table table-hover">\
        <tr>\
            <th>井号</th><th>车间</th><th>处理厂</th><th>区块</th><th>开发单元</th><th>层位</th><th>采油厂</th><th>目前井别</th><th>投产日期</th><th>计量间</th><th>油气田</th>\
        </tr>\
        {str}\
    </table>'
    
    data = data.Data;
    
    var str = '';
    for(var i=0, len=data.length; i<len; i++) {
        str += '<tr>'
            + '<td>'+ data[i].JH +'</td>'
            + '<td>'+ data[i].CJDM +'</td>'
            + '<td>'+ data[i].CLCDM +'</td>'
            + '<td>'+ data[i].QKDM +'</td>'
            + '<td>'+ data[i].KFDYDM +'</td>'
            + '<td>'+ data[i].CWDM +'</td>'
            + '<td>'+ data[i].CYCDM +'</td>'
            + '<td>'+ data[i].MQJB +'</td>'
            + '<td>'+ data[i].TCRQ +'</td>'
            + '<td>'+ data[i].JLJ +'</td>'
            + '<td>'+ data[i].YQTDM +'</td>'
            + '</tr>';
    }
    
    html = html.replace('{str}', str);
    
    document.getElementById('searchContainer').innerHTML = html;
}


$(document).ready(function(){
    var jingsearchbtn = document.getElementById('jingsearchbtn');
    
    jingsearchbtn.onclick = function(e) {
        //renderTable(mock);
        //return;
        
        var wellName = document.getElementById('jingvalue').value;
        wellName = jQuery.trim(wellName);
        
        if(!wellName) {
            alert('请输入搜索关键字');
            return;
        }
        
        $.ajax({
                url: 'http://192.168.212.60:81/DataService.asmx/QueryWellInfo',
                type: "POST",
                data: { "para": wellName },
                dataType: "json",
                success: function (data) {
                    renderTable(data)
                }
        });
    };
});
 
//$Id: checkForm.js,$
//tony 2004-3-30
//新增了对form的查询条件进行自动拼装的功能getQueryString();
/**
 * 检查送出的form的每个表单元素是否符合填写要求
 * @fm 需要检查的form元素。
 * @return 如果form的所有表单元素都符合要求，将返回true，
 * 否则将会报告不符合的原因，同时返回false。
 * 示例：
 * <form onsubmit="return checkForm(this)">
 *  	<input type=submit>
 *  	<input name=email title="请填写邮件地址~email!">
 * </form>
 * 说明：
 * 在form表单元素的title属性中指明此表单元素期望的格式。
 * 此格式说明如下
 *          请填写邮件地址~email!
 * 以最后一个"~"为界，前面的是提示信息，后面是格式信息。
 * 格式信息请遵守以下规则：
 * [number[f]:][type][!]
 * 说明：
 * number[f]:	一个数值后面跟一个":",表示此域的文本长度不可以超过指定的数值，如果在数值后面有个f表示固定长度必须为多少位
 * type可以是如下表达式
 *	 email	邮件地址
 *	 int		整数
 *	 float	浮点数
 *	 date		日期
 *	 time		时间
 *	 hasChinese     含有中文
 *	 allChinese	全部是中文
 *	 noChinese	没有中文
 *	 /.../[gi]	自定义正则式
 * !表示此处文本不可以为空。
 * 对于<input type=radio > 格式串为
 * "请选择一个选项~!"表示此radio组必须选择一个选项
 * "请选择一个选项~"表示此radio组的选项可以不选。
 * 对于<input type=checkbox >或者<select multiple></select>格式串的意义为
 * 说明信息~min:0max:3
 * 对于<select ></select>非multiple类型
 * "请选择一个选项~!"表示此select不可以选择第一个选项
 * "请选择一个选项~"表示此select可以选择第一个选项
 */
function killErrors() {
return true;
}

	function checkForm(fm)
	{
	//window.onerror = killErrors; 
		for(var i=0;i<fm.length;i++)
		{
			var title=fm[i].title;
			if(title=="")continue;//忽略未定义title的元素
			var p=title.lastIndexOf("~");
			if(p<0)continue;//忽略title中未定义检查格式的元素
			var info=title.substring(0,p);
			var format=title.substring(p+1,title.length);
			var format1=title.substring(p+1,title.length);
			var format2=title.substring(p+1,title.length);
			var name=fm[i].name;
			if(name=="")continue;//忽略没有名字的元素
			var value=trim(fm[i].value);
			//fm[i].value=value;//自动除去送出项的两端的空格
			
			if(fm[i].type=="radio")
			{
				if(checkRadio(fm,fm[i]))
				{
					continue;
				}
				else
				{
					return false;
				}
			}
			if(fm[i].type=="checkbox")
			{
				if(checkCheckbox(fm,fm[i]))
				{
					continue;
				}
				else
				{
				 	return false;
				}
			}
			if(fm[i].type=="select-one")
			{
				if(checkSelectOne(fm[i]))
				{
					continue;
				}
				else
				{
					return false;
				}
			}
			if(fm[i].type=="select-multiple")
			{
				if(checkSelectMultiple(fm[i]))
				{
					continue;
				}
				else
				{
					return false;
				}
			}
			var notNull=false;
			if(format.charAt(format.length-1)=="!")
			{
				notNull=true;
				format=format.substring(0,format.length-1);
			}
			if(notNull)
			{
				if(value=="")
				{
					//alert(info+"\n"+name+"的内容不可以为空。");
					alert(info+"\n其内容不可以为空。");
					try {
						fm[i].focus();  
					}
					catch (e){
					}
					finally {
						
						}
					
					return false;
				}
			}
			else
			{
				//内容可以为空时，
				if(value=="")
					continue;
			}
			
			///判断是否为int类型
			if(format2.charAt(format2.length-1)=="!")
			{
				format2=format2.substring(0,format2.length-1);
			}
			var colonP2=format2.indexOf(":");
			format2=format2.substring(colonP2+1,format2.length);
			//alert (format2);
			var colonP=format.indexOf(":");
			if(format2 != "int")
			{
				//内容的长度判断
				//var colonP=format.indexOf(":");
				if(colonP>0)
				{
					if(format.charAt(colonP-1)=='f')
					{
						var lengthLimit=format.substring(0,colonP-1);
						if(!isNaN(lengthLimit))
						{
							if(value.length!=lengthLimit)
							{
								//alert(info+"\n"+name+"的长度为"+value.length+"位，必须为"+lengthLimit+"位");
								alert(info+"\n其长度为"+value.length+"位，必须为"+lengthLimit+"位");
								fm[i].focus();
								return false;
							}
						}
					}
					else
					{
						var lengthLimit=format.substring(0,colonP);
						if(!isNaN(lengthLimit))
						{
							if(value.length>lengthLimit)
							{
								//alert(info+"\n"+name+"的长度("+value.length+")超过限制"+lengthLimit);
								alert(info+"\n其长度("+value.length+")超过限制"+lengthLimit);
								fm[i].focus();
								return false;
							}
						}
					}
				}
				
			}
			format=format.substring(colonP+1,format.length);
			//alert (format);
			if(format=="email")
			{
			    //电子邮件格式
			    var found = value.match(/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/);
				if(found==null)
				{
					alert(info+"\n其格式不正确:\n\""+value+"\"不是一个Email地址");
					fm[i].focus();
					return false;
				}
				//console.log(value);
			}
			else if (format == "mobile") {
			    //验证手机
			    var found = value.match(/^1[3|4|5|7|8][0-9]\d{8}$/);
			    if (found == null) {
			        alert(info + "\n请输入正确手机号码");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "m") {
			    //验证手机
			    var found = value.match(/^1[3|4|5|7|8][0-9]\d{8}$/);
			    var found_tel = value.match(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/);
			    if (found == null && found_tel == null) {
			        alert(info + "\n请输入正确手机号码或电话号码");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "tel") {
			    //验证座机
			    var found = value.match(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/);
			    if (found == null) {
			        alert(info + "\n请输入正确座机号码");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "email|mobile") {
			    var found_1 = value.match(/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/);
			    var found_2 = value.match(/^1[3|4|5|7|8][0-9]\d{8}$/);
			    if (found_1 == null && found_2 == null) {
			        alert(info + "\n请输入正确手机号码或邮箱地址");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "userid") {

			    //注册账号
			    var found = value.match(/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/);
			    if (found == null) {
			        alert(info + "\n其格式不正确:\n 4-19位英文加数字以英文字母开头");
			        fm[i].focus();
			        return false;
			    }
			}

			else if (format == "pwd") {

			    //密码格式
			    var found = value.match(/^(\w){6,20}$/);
			    if (found == null) {
			        alert(info + "\n密码不少于6位");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "pwd-check") {

			    //重复密码验证
			    var previ = i - 1;
			    var pwdvalue = fm[previ].value;
			    if (pwdvalue != value) {
			        alert("两次密码输入不一致");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "sfz") {
			    //验证身份证
			    var found = value.match(/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/);
			    if (found == null) {
			        alert(info + "\n请输入正确身份证号");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "int") {
			    //整数
			    var intVal = parseInt(value);
			    if (isNaN(intVal) || intVal != value) {
			        //alert(info+"\n"+name+"的格式不正确:\n"+value+"不是一个整数。");
			        alert(info + "\n其格式不正确:\n" + value + "不是一个整数。");
			        fm[i].focus();
			        return false;
			    }
			    //内容的值的大小判断
			    var colonP = format1.indexOf(":");
			    if (colonP > 0) {

			        var lengthLimit = format1.substring(0, colonP);
			        if (!isNaN(lengthLimit)) {//alert(value);
			            if (parseInt(value) > parseInt(lengthLimit)) {
			                //alert(info+"\n"+name+"的长度("+value.length+")超过限制"+lengthLimit);
			                alert(info + "\n其值(" + value + ")超过限制" + lengthLimit);
			                fm[i].focus();
			                return false;
			            }
			        }
			    }

			}
			else if (format == "float") {
			    //浮点数
			    var floatVal = parseFloat(value);
			    if (isNaN(floatVal) || floatVal != value) {
			        //alert(info+"\n"+name+"的格式不正确:\n"+value+"不是一个浮点数。");
			        alert(info + "\n其格式不正确:\n" + value + "不是一个浮点数。");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "date") {
			    //日期
			    var found = value.match(/(\d{1,5})-(\d{1,2})-(\d{1,2})/);
			    var found2 = value.match(/(\d{1,5})\/(\d{1,2})\/(\d{1,2})/);
			    if (found == null || found[0] != value || found[2] > 12 || found[3] > 31) {
			        if (found2 == null || found2[0] != value || found2[2] > 12 || found2[3] > 31) {
			            //alert(info+"\n"+name+"的格式不正确:\n\""+value+"\"不是一个日期\n提示：[2000-01-01]");
			            alert(info + "\n其格式不正确:\n\"" + value + "\"不是一个日期\n提示：[2000-01-01]");
			            fm[i].focus();
			            return false;
			        }
			    }
			    var year = trim0(found[1]);
			    var month = trim0(found[2]) - 1;
			    var date = trim0(found[3]);
			    var d = new Date(year, month, date);
			    if (d.getFullYear() != year || d.getMonth() != month || d.getDate() != date) {
			        //alert(info+"\n"+name+"的内容不正确:\n\""+value+"\"不是一个正确的日期\n提示：[2000-01-01]");
			        alert(info + "\n其内容不正确:\n\"" + value + "\"不是一个正确的日期\n提示：[2000-01-01]");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "datetime") {
			    //alert(isDateStr(value));
			    if (!isDateStr(value)) {
			        alert(info + "\n其内容不正确:\n\"" + value + "\"不是一个正确的日期时间\n提示：[2000-01-01 05:38:00]");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "time") {
			    //时间
			    var found = value.match(/(\d{2}):(\d{2}):(\d{2})/);
			    if (found == null || found[0] != value || found[1] > 23 || found[2] > 59 || found[3] > 59) {
			        //alert(info+"\n"+name+"的格式不正确:\n\""+value+"\"不是一个时间\n提示：[05:38:00]");
			        alert(info + "\n其格式不正确:\n\"" + value + "\"不是一个时间\n提示：[05:38:00]");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "hasChinese") {
			    var _hasChinese = false;
			    for (var j = 0; j < value.length; j++) {
			        if (value.charCodeAt(j) > 255) {
			            _hasChinese = true;
			            break;
			        }
			    }
			    if (!_hasChinese) {
			        //alert(info+"\n"+name+"的内容需要中文:\n\""+value+"\"不含有任何中文字符");
			        alert(info + "\n其内容需要中文:\n\"" + value + "\"不含有任何中文字符");
			        fm[i].focus();
			        return false;
			    }
			}
			else if (format == "allChinese") {
			    for (var j = 0; j < value.length; j++) {
			        if (value.charCodeAt(j) <= 255) {
			            //alert(info+"\n"+name+"的内容要求全中文:\n\""+value+"\"含有非中文字符");
			            alert(info + "\n其内容要求全中文:\n\"" + value + "\"含有非中文字符");
			            fm[i].focus();
			            return false;
			        }
			    }
			}
			else if (format == "noChinese") {
			    for (var j = 0; j < value.length; j++) {
			        if (value.charCodeAt(j) > 255) {
			            //alert(info+"\n"+name+"的内容要求非中文:\n\""+value+"\"含有中文字符");
			            alert(info + "\n其内容要求非中文:\n\"" + value + "\"含有中文字符");
			            fm[i].focus();
			            return false;
			        }
			    }
			}

			else if (format != "") {
			    //自定义
			    try {
			        var found = value.match(eval(format));
			        if (found == null || found[0] != value) {
			            //alert(info+"\n"+name+"的格式不不符合要求:\""+value+"\"\n提示：["+format+"]");
			            //alert(info+"\n其格式不不符合要求:\""+value+"\"\n提示：["+format+"]");
			            alert(info);
			            fm[i].focus();
			            return false;
			        }
			    }
			    catch (e) {
			        //alert(e.name+":\n["+fm[i].name+"]不合法的正则式\""+format+"\"");
			        alert(e.name + ":\n不合法的正则式\"" + format + "\"");
			        return false;
			    }
			}
		}
		return true;
	}
	function checkRadio(fm,opt)
	{
		var title=opt.title;
		if(title=="")return true;//忽略未定义title的元素
		var p=title.lastIndexOf("~");
		if(p<0)return true;//忽略title中未定义检查格式的元素
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=opt.name;
		if(name=="")return true;//忽略没有名字的元素
		if(format=="!")
		{
		    //console.log(name);
		    //return false;
			//必须选择一个选项
			if(typeof(fm[name].length)=="undefined")
			{
				//同名radio只有一个
				if(opt.checked)
				{
					return true;
				}
				else
				{
					//alert(info+"\n必须选择"+name);
					alert(info+"\n必须选择");
					opt.focus();
					return false;
				}
			}
			else
			{
				//是一个radio组
				var radios=fm[name];
				for(var j=0;j<radios.length;j++)
				{
					if(radios[j].checked==true)return true;
				}
				//alert(info+"\n必须选择"+name+"的一个选项");
				alert(info+"\n必须选择的一个选项");
				opt.focus();
				return false;
			}
		}
		else
		{
			//可以一个选项也不选
			return true;
		}
	}
	function checkCheckbox(fm,opt)
	{
		var title=opt.title;
		if(title=="")return true;//忽略未定义title的元素
		var p=title.lastIndexOf("~");
		if(p<0)return true;//忽略title中未定义检查格式的元素
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=opt.name;
		if(name=="")return true;//忽略没有名字的元素

		var min=format.match(/min:(\d+)\w*/);
		var max=format.match(/\w*max:(\d+)/);

		if(typeof(fm[name].length)=="undefined")
		{
			//只有一个同名checkbox
			if(min!=null)
			{
				if(min[1]==1&&!opt.checked)
				{
					//alert(info+"\n必须选上"+name+"选项");
					alert(info+"\n必须选上其中选项");
					opt.focus();
					return false;
				}
			}
		}
		else
		{
			//一个checkbox组
			var checkboxes=fm[name];
			var check_count=0;
			for(var j=0;j<checkboxes.length;j++)
			{
				if(checkboxes[j].checked)check_count++;
			}
			if(min!=null)
			{
				if(min[1]>check_count)
				{
					//alert(info+"\n"+name+"至少需要选择"+min[1]+"个选项");
					alert(info+"\n至少需要选择"+min[1]+"个选项");
					opt.focus();
					return false;
				}
			}
			if(max!=null)
			{
				if(max[1]<check_count)
				{
					//alert(info+"\n"+name+"至多可以选择"+max[1]+"个选项");
					alert(info+"\n至多可以选择"+max[1]+"个选项");
					opt.focus();
					return false;
				}
			}
		}
		return true;
	}
	function checkSelectOne(sel)
	{
		var title=sel.title;
		if(title=="")return true;//忽略未定义title的元素
		var p=title.lastIndexOf("~");
		if(p<0)return true;//忽略title中未定义检查格式的元素
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=sel.name;
		if(name=="")return true;//忽略没有名字的元素
		
		if(format=="!"&&sel.selectedIndex==0)
		{
			//alert(info+"\n"+name+"不可以选择第一个个选项");
		    alert(info + "\n请选择");
			sel.focus();
			return false;
		}
		return true;
	}
	function checkSelectMultiple(sel)
	{
		var title=sel.title;
		if(title=="")return true;//忽略未定义title的元素
		var p=title.lastIndexOf("~");
		if(p<0)return true;//忽略title中未定义检查格式的元素
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=sel.name;
		if(name=="")return true;//忽略没有名字的元素

		var min=format.match(/min:(\d+)\w*/);
		var max=format.match(/\w*max:(\d+)/);
		
		var select_count=0;
		for(var j=0;j<sel.length;j++)
		{
			if(sel[j].selected)select_count++;
		}
		if(min!=null)
		{
			if(min[1]>select_count)
			{
				//alert(info+"\n"+name+"至少需要选择"+min[1]+"个选项");
				alert(info+"\n至少需要选择"+min[1]+"个选项");
				sel.focus();
				return false;
			}
		}
		if(max!=null)
		{
			if(max[1]<select_count)
			{
				//alert(info+"\n"+name+"至多可以选择"+max[1]+"个选项");
				alert(info+"\n至多可以选择"+max[1]+"个选项");
				sel.focus();
				return false;
			}
		}
		return true;
	}
/**
 * 除去字符串变量s两端的空格。
 */
	function trim(s)
	{
		s=s.replace(/^ */,"");
		s=s.replace(/ *$/,"");
		return s;
	}
/**
 * 除去字符串表示的数值变量开头的所有的"0"。
 * 比如
 * 	trim0("01")将返回"1"
 * 	trim0("1")将返回"1"
 * 	trim0("10")将返回"10"
 * 	trim0("000")将返回"0"
 */
	function trim0(s)
	{
		if(s.length==0)return s;
		s=s.replace(/^0*/,"");
		if(s.length==0)s="0";
		return s;
	}
/**
 * 取得一个form对像所送出时内部送出参数的QueryString
 * 形如:
 * ?accountName=&userName=&email=&area=0&credit_low=&credit_high=&age_low=&age_high=&userLevel=0
 */
	function getQueryString(fm)
	{
		var qStr="";
		for(var i=0;i<fm.length;i++)
		{
			if(!fm[i].disabled)
			{
				var n=fm[i].name;
				if(n==null)continue;
				if(n.length==0)continue;
				if(fm[i].type=="select-multiple")
				{
					var _vs=fm[i].options;
					for(var _j=0;_j<_vs.length;_j++)
					{
						var _opt=_vs(_j);
						if(_opt.selected)
						{
							var v=_opt.value;
							qStr=qStr+"&"+n+"="+ec(v);
						}
					}
				}
				else
				{
					var v=fm[i].value;
					if(fm[i].type=="radio"||fm[i].type=="checkbox")
					{
						if(!fm[i].checked)continue;
					}
					qStr=qStr+"&"+n+"="+ec(v);
				}
			}
		}
		if(qStr.length>0)qStr="?"+qStr.substr(1);
		return qStr;
	}
	function ec(va)
	{
		return va.replace(/\n/g,"%0D%0A");
	}
	


/***********************************************************************
 * 判断一个字符串是否为合法的日期格式：YYYY-MM-DD HH:MM:SS
 * 或 YYYY-MM-DD 或 HH:MM:SS
 */
function isDateStr(ds){
  parts = ds.split(' ');
  //alert(parts.length);
  switch(parts.length){
    case 2:
      if(isDatePart( parts[0] ) == true && isTimePart( parts[1] )){
        return true;
      }else{
        return false;
      }
    case 1:
      return false;
    default:
      return false;
  }
}

/***********************************************************************
 * 判断一个字符串是否为合法的日期格式：YYYY-MM-DD
 */
function isDatePart(dateStr){
  var parts;

  if(dateStr.indexOf("-") > -1){
    parts = dateStr.split('-');
  }else if(dateStr.indexOf("/") > -1){
    parts = dateStr.split('/');
  }else{
    return false;
  }

  if(parts.length < 3){
  //日期部分不允许缺少年、月、日中的任何一项
    return false;
  }

  for(i = 0 ;i < 3; i ++){
  //如果构成日期的某个部分不是数字，则返回false
    if(isNaN(parts[i])){
      return false;
    }
  }

  y = parts[0];//年
  m = parts[1];//月
  d = parts[2];//日

  if(y > 3000){
    return false;
  }

  if(m < 1 || m > 12){
    return false;
  }

  switch(d){
    case 29:
      if(m == 2){
      //如果是2月份
        if( (y / 100) * 100 == y && (y / 400) * 400 != y){
          //如果年份能被100整除但不能被400整除 (即闰年)
        }else{
          return false;
        }
      }
      break;
    case 30:
      if(m == 2){
      //2月没有30日
        return false;
      }
      break;
    case 31:
      if(m == 2 || m == 4 || m == 6 || m == 9 || m == 11){
      //2、4、6、9、11月没有31日
        return false;
      }
      break;
    default:

  }

  return true;
}

/***********************************************************************
 * 判断一个字符串是否为合法的时间格式：HH:MM:SS
 */
function isTimePart(timeStr){
  var parts;

  parts = timeStr.split(':');

  if(parts.length < 2){
  //日期部分不允许缺少小时、分钟中的任何一项
    return false;
  }

  for(i = 0 ;i < parts.length; i ++){
  //如果构成时间的某个部分不是数字，则返回false
    if(isNaN(parts[i])){
      return false;
    }
  }

  h = parts[0];//年
  m = parts[1];//月

  if( h < 0 || h > 23){
  //限制小时的范围
    return false;
  }
  if( m < 0 || h > 59){
  //限制分钟的范围
    return false;
  }

  if(parts.length > 2){
    s = parts[2];//日

    if( s < 0 || s > 59){
    //限制秒的范围
      return false;
    }
  }

  return true;
}


<%@page import="org.springframework.ui.ModelMap"%>
<%@page import="net.jeeshop.services.manage.order.bean.Order"%>
<%@page import="net.jeeshop.services.front.area.bean.Area"%>
<%@page import="java.util.Map"%>
<%@page import="net.jeeshop.core.KeyValueHelper"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resource/common_html_meat.jsp"%>
<%@ include file="/manage/common.jsp"%>
<title>修改订单的配送地址信息</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resource/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
	<div class="container" style="margin-top: 0px;padding-top: 0px;">
		<div class="row">
			<div class="col-md-9" style="min-height: 200px;">
				<div class="row">
					
					<div class="alert alert-info">
						修改订单配送地址信息
					</div>
					<form action="<%=request.getContextPath() %>/manage/order/updateOrdership" method="post" name="form" role="form" id="form">
					<input type="hidden" name="id" value="${e.ordership.orderid }"/>
					<input type="hidden" name="ordership.id" value="${e.ordership.id }"/>
					<table class="table table-bordered">
						<tr>
							<td width="100px">收货人姓名</td>
							<td><input name="ordership.shipname" type="text" value="${e.ordership.shipname}"
						    class="form-control" id="name" data-rule="收货人姓名:required;length[2~8];name;" placeholder="请输入收货人姓名" /></td>
						</tr>
						<tr>
							<td>地址区域</td>
							<td>
							<input type="hidden"  name="ordership.province" value="${e.ordership.province }" id="provinceName"/>
						    	<select onchange="changeProvince()" name="ordership.provinceCode" id="province" class="form-control" >
							    	<c:if test="${e.ordership.provinceCode}">
								    		<option value="">--选择省份--</option>
							    	</c:if>
							    	<c:if test="${!e.ordership.provinceCode}">
									<c:forEach var="item" items="${provinces}">
							    		<option value="${item.code}" <c:if test='${item.code == e.ordership.provinceCode}'> selected='selected' </c:if>>${item.name}</option>
									</c:forEach>
							    	</c:if>
								</select>
								<input type="hidden"  name="ordership.city" value="${e.ordership.city }" id="cityName"/>
								<select onchange="changeCity()" id="citySelect" name="ordership.cityCode" class="form-control" >
									<c:forEach var="item" items="${cities}">
										<c:if test="${e.ordership.cityCode }">
								    		<option value="">--选择城市--</option>
							    		</c:if>
							    		<c:if test="${!e.ordership.cityCode }">
							    				<option value="${item.code}" <c:if test='${item.code == e.ordership.cityCode}'> selected='selected' </c:if>>${item.name}</option>
							    		</c:if>
									</c:forEach>
								</select>
								<input type="hidden" name="ordership.area" value="${e.ordership.area }" id="areaName"/>
									<select onchange="areaCity()" class="form-control" id="areaSelect" name="ordership.areaCode" >
									<c:forEach var="item" items="${areas}">
										<c:if test="${e.ordership.areaCode }">
								    		<option value="">--选择区域--</option>
							    		</c:if>
							    		<c:if test="${!e.ordership.areaCode }">
							    				<option value="${item.code}" <c:if test='${item.code == e.ordership.areaCode}'> selected='selected' </c:if>>${item.name}</option>
							    		</c:if>
									</c:forEach>
								</select>

					    	
							</td>
						</tr>
						<tr>
							<td>详细地址</td>
							<td>
								<textarea name="ordership.shipaddress" type="text" 
						    	class="form-control" id="address"  data-rule="地址:required;length[0~70];address;" placeholder="请输入收货人地址" >
						    	${e.ordership.shipaddress}
						    	</textarea>
							</td>
						</tr>
						<tr>
							<td>邮编</td>
							<td><input name="ordership.zip" type="text"  value="${e.ordership.zip}"
						    class="form-control" id="zip" data-rule="邮编:required;length[0~70];zip;" placeholder="请输入收货人邮编" /></td>
						</tr>
						<tr>
							<td>手机</td>
							<td><input name="ordership.phone" type="text" value="${e.ordership.phone}"
						    class="form-control" id="mobile" data-rule="手机:required;length[0~70];mobile;" placeholder="请输入收货人手机" /></td>
						</tr>
						<tr>
							<td>电话号码</td>
							<td><input name="ordership.tel" type="text" value="${e.ordership.tel}"
						    class="form-control" id="phone" data-rule="电话号码:required;length[0~70];phone;" placeholder="请输入收货人座机号码" /></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center;">
								<button type="submit" class="btn btn-success btn-sm" value="保存">
					      	 	<span class="glyphicon glyphicon-ok"></span>确认修改
					      		</button>
					      		<input type="button" value="返回" class="btn btn-default btn-sm" onclick="javascript:history.go(-1);"/>
					      	</td>
						</tr>
					</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$(function() {
	
});

function changeProvince(){
	var selectVal = $("#province").val();
	$("#provinceName").val($("#province").find("option:selected").text());
	if(!selectVal){
		console.log("return;");
		return;
	}
	var _url = "<%=request.getContextPath() %>/manage/order/selectCitysByProvinceCode?provinceCode="+selectVal;
	console.log("_url="+_url);
	$("#citySelect").empty().show().append("<option value=''>--选择城市--</option>");
	$("#areaSelect").empty().hide().append("<option value=''>--选择区域--</option>");
	$.ajax({
	  type: 'POST',
	  url: _url,
	  data: {},
	  dataType: "json",
	  success: function(data){
		  //console.log("changeProvince success!data = "+data);
		  $.each(data,function(index,value){
			  //console.log("index="+index+",value="+value.code+","+value.name);
			  $("#citySelect").append("<option value='"+value.code+"'>"+value.name+"</option>");
		  });
	  },
	  error:function(er){
		  console.log("changeProvince error!er = "+er);
	  }
	});
}

function changeCity(){
	var selectProvinceVal = $("#province").val();
	var selectCityVal = $("#citySelect").val();
	$("#cityName").val($("#citySelect").find("option:selected").text());
	if(!selectProvinceVal || !selectCityVal){
		console.log("return;");
		return;
	}
	var _url = "<%=request.getContextPath() %>/manage/order/selectAreaListByCityCode?provinceCode="+selectProvinceVal+"&cityCode="+selectCityVal;
	console.log("_url="+_url);
	$("#areaSelect").empty().show().append("<option value=''>--选择区域--</option>");
	$.ajax({
	  type: 'POST',
	  url: _url,
	  data: {},
	  dataType: "json",
	  success: function(data){
		  //console.log("changeProvince success!data = "+data);
		  $.each(data,function(index,value){
			  //console.log("index="+index+",value="+value.code+","+value.name);
			  $("#areaSelect").append("<option value='"+value.code+"'>"+value.name+"</option>");
		  });
	  },
	  error:function(er){
		  console.log("changeCity error!er = "+er);
	  }
	});
}
function areaCity(){
	$("#areaName").val($("#areaSelect").find("option:selected").text());
}
</script>
</body>
</html>

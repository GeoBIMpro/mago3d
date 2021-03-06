<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/font-awesome.min.css" />	
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXJ.min.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXButton.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXInput.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXSelect.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXTree.css" />
	<script src="/externlib/${lang}/jquery/jquery.js"></script>
	<script src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXJ.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXInput.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXModal.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXSelect.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXTree.js"></script>
	<script type="text/javascript" src="/js/${lang}/dataGroupTree.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="content-header row">
							<h3 class="content-title u-pull-left">데이터 그룹 (<a href="#" onclick="reloadDataGroupCache();">캐시갱신</a>)</h3>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<div class="row">
							<div class="one-third column">
								<div id="AXTreeTarget" class="tree"></div>
								<button type="button" class="btn btn-success btn-sm" onclick="addTree(); return false;">추가</button>
								<button type="button" class="btn btn-warning btn-sm" onclick="addChildTree(); return false;">하위메뉴추가</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="delTree(); return false;">선택삭제</button>
								<!-- <button type="button" class="btn btn-success btn-sm" onclick="updateTree(); return false;">수정</button> -->
								<button type="button" class="btn btn-warning btn-sm" onclick="moveUpTree(); return false;">위로</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="moveDownTree(); return false;">아래로</button>
							</div>
							<div class="two-third column">
								<div class="node">
									<div class="info">
										<form name="dataGroupForm" id="dataGroupForm" method="post" onsubmit="return false;">
											<input type="hidden" id="writeMode" name="writeMode" value="" />
											<input type="hidden" id="data_group_id" name="data_group_id" value="" />
											<input type="hidden" id="parent" name="parent" value="" />
											<input type="hidden" id="depth" name="depth" value="" /> 
											<input type="hidden" id="view_order" name="view_order" value="1" />
											<input type="hidden" id="update_type" name="update_type" value="" />
										<table class="input-table scope-row">
											<col class="col-label" />
											<col class="col-input" />
											<tr>
												<th class="col-label" scope="row">
													<label for="data_group_name">그룹명</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="data_group_name" name="data_group_name" value="" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="data_group_key">그룹명(영문)</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="data_group_key" name="data_group_key" value="" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<span>사용여부</span>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input radio-set">
													<input type="radio" id="use_y" name="use_yn" value="Y" />
													<label for="use_y">사용</label>
													<input type="radio" id="use_n" name="use_yn" value="N" />
													<label for="use_n">사용안함</label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="description">설명</label></th>
												<td class="col-input"><input type="text" id="description" name="description" value="" class="l"/></td>
											</tr>
											<tr>
												<td colspan="2">
													<div class="button-group u-pull-left">
														<input type="submit" value="저장" onclick="appendTree();"/>
														<input type="reset" value="취소" />
													</div>
													<div class="button-group u-pull-right">
														<a href="#" class="button" onclick="modifyDataGroupData();">데이터 관리</a>
													</div>
												</td>
											</tr>
										</table>
										</form>
									</div>
											
									<div class="tabs">
										<ul>
											<li><a href="#data_tab">데이터</a></li>
										</ul>
										<div id="data_tab">
											<table class="inner-table scope-col">
												<col class="col-numer" />
												<col class="col-id" />
												<col class="col-name" />
												<col class="col-email" />
												<col class="col-toggle" />
												<col class="col-date-time" />
												<thead>
													<tr>
														<th scope="col" class="col-number">번호</th>
														<th scope="col" class="col-id">아이디</th>
														<th scope="col" class="col-name">이름</th>
														<th scope="col" class="col-email">이메일</th>
														<th scope="col" class="col-toggle">데이터 상태</th>
														<th scope="col" class="col-date-time">등록일</th>
													</tr>
												</thead>
												<tbody id="data_list">
													<tr>
														<td colspan="6" class="col-none">등록된 데이터가 없습니다.</td>		
													</tr>
												</tbody>
											</table>
											<div id="data_pagination" class="pagination"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<!-- Data 관리 -->	
<div id="data_manager" class="data_dialog" title="데이터 관리">
	<div class="row">
		<!-- 전체 Data -->
		<div id="data_left" class="pool">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title">전체 데이터(선택 그룹 제외)</h4>
				</div>
				<div class="u-pull-right">
					<label for="search_except_data_name">아이디</label>
					<input type="search" id="search_except_data_name" name="search_except_data_name" class="m" value="" />
					<input type="button" value="조회" onclick="drawGroupPage('1', 'data_all');" />
				</div>
				<div id="data_all_list_count" class="list-desc u-pull-left">
				</div>
			</div>
		
			<form id="data_left_form"> 			
			<table class="list-table scope-col">
				<col class="col-checkbox" />
				<col class="col-name" />
				<col class="col-toggle" />
				<thead>
					<tr>
						<th scope="col" class="col-checkbox"><input type="checkbox" id="data_left_check_all" name="data_left_check_all" /></th>
						<th scope="col" class="col-name">아이디</th>
						<th scope="col" class="col-toggle">이름</th>
					</tr>
				</thead>
				<tbody id="data_all_list">
				</tbody>
			</table>
			<div id="data_all" class="pagination"></div>
			</form>
		</div>
		
		<!-- 그룹에 등록되어 있는 data -->
		<div id="data_right" class="chosen">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title">등록 데이터(선택 그룹)</h4>
				</div>
				<div class="u-pull-right">
					<label for="search_data_name">아이디</label>
					<input type="search" id="search_data_name" name="search_data_name" class="m" value="" />
					<input type="button" value="조회" onclick="drawGroupPage('1', 'data_select');" />
				</div>
				<div id="data_select_list_count" class="list-desc u-pull-left">
				</div>
			</div>
			
			<form id="data_right_form">
			<table class="list-table scope-col">
				<col class="col-checkbox" />
				<col class="col-name" />
				<col class="col-toggle" />
				<thead>
					<tr>
						<th scope="col" class="col-checkbox"><input type="checkbox" id="data_right_check_all" name="data_right_check_all" /></th>
						<th scope="col" class="col-name">아이디</th>
						<th scope="col" class="col-toggle">이름</th>
					</tr>
				</thead>
				<tbody id="data_select_list">
				</tbody>
			</table>
			<div id="data_select" class="pagination"></div>
			</form>
		</div>
		<div id="role_center" class="buttons">
			<a href="#" id="data_button_insert" class="button color-area-em">
				<span class="icon-glyph glyph-plus"></span>
				<span class="icon-text">등록</span>
			</a>
			<a href="#" id="data_button_delete" class="button color-area-em">
				<span class="icon-glyph glyph-ex"></span>
				<span class="icon-text">삭제</span>
			</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var DATA_GROUP_TREE_DATA = null;
    $(document).ready(function() {
    	getAjaxDataGroupList();
		$( ".tabs" ).tabs();
	});
    
    // 등록 가능한 data 전체 선택 
	$("#data_left_check_all").click(function() {
		$(':checkbox[name=data_all_id]').prop('checked', this.checked);
	});
    // 등록된 data 전체 선택 
	$("#data_right_check_all").click(function() {
		$(':checkbox[name=data_select_id]').prop('checked', this.checked);
	});
	
	var dataDialog = $( ".data_dialog" ).dialog({
		autoOpen: false,
		height: 700,
		width: 1000,
		modal: true,
		resizable: false
	});
	
	// 전체 data 검색, enter key 
	$("#search_except_data_name").keydown(function (key) {
	    if (key.keyCode == 13) {
			drawGroupPage('1', 'data_all');
	    }
	});
	// 등록 data 검색, enter key
	$("#search_data_name").keydown(function (key) {
	    if (key.keyCode == 13) {
			drawGroupPage('1', 'data_select');
	    }
	});
	
	// Data 관리
    function modifyDataGroupData() {
    	if ($("#data_group_id").val() == "") {
    		alert("데이터 그룹을 선택해 주세요.");
    		return;
    	}
    	if ($("#depth").val() == "" || parseInt($("#depth").val()) < 1) {
    		alert("최상위 그룹에는 데이터를 등록할 수 없습니다.");
    		return;
    	}
    	dataDialog.dialog( "open" );
    	// 선택한 Data 그룹에 등록된 Data 목록
    	ajaxListDataGroupDataByGroupId(1);
    	// Data 그룹 전체 Data 에서 선택한 Data 그룹에 등록된 Data 을 제외한 Data 목록
    	ajaxListExceptDataGroupDataByGroupId(1);
	}
	
	// data 등록
    $("#data_button_insert").click(function() {
    	$("#data_left_check_all").prop("checked",  false);
    	ajaxInsertDataGroupData();
    });
	// data 제거
    $("#data_button_delete").click(function() {
    	$("#data_right_check_all").prop("checked",  false);
    	ajaxDeleteDataGroupData();
    });
	
	// data 그룹 등록된 사용자 목록
    function ajaxListDataGroupData(pageNo) {
 		$.ajax({
    		url: "/data/ajax-list-data-group-data.do",
    		data: { data_group_id : $("#data_group_id").val(), pageNo : pageNo },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				drawListDataGroupData(msg.pagination, msg.dataList);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error) {
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	
	// data 그룹 전체 data 에서 선택한 data 그룹에 등록된 data 를 제외한 data 목록
	function ajaxListExceptDataGroupDataByGroupId(pageNo) {
 		var search_except_data_name = $("#search_except_data_name").val();
 		if(search_except_data_name != null && search_except_data_name != "") {
 			search_except_data_name = encodeURIComponent(search_except_data_name);
 		}
 		$("#data_all_list").empty();
    	$.ajax({
    		url: "/data/ajax-list-except-data-group-data-by-group-id.do",
    		data: { data_group_id : $("#data_group_id").val(), pageNo : pageNo, search_except_data_name : search_except_data_name },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == 'success') {
    				drawListDataGroupDataByGroupId(msg.pagination, msg.dataList, "data_all");
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	// 선택한 data 그룹에 등록된 data 목록
	function ajaxListDataGroupDataByGroupId(pageNo) {
 		var search_data_name = $("#search_data_name").val();
 		if(search_data_name != null && search_data_name != "") {
 			search_data_name = encodeURIComponent(search_data_name);
 		}
 		$("#data_select_list").empty();
    	$.ajax({
    		url: "/data/ajax-list-data-group-data-by-group-id.do",
    		data: { data_group_id : $("#data_group_id").val(), pageNo : pageNo, search_data_name : search_data_name },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == 'success') {
    				drawListDataGroupDataByGroupId(msg.pagination, msg.dataList, "data_select");
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
    
 	// 데이터 그룹내 데이터 추가
    function ajaxInsertDataGroupData() {
    	var data_group_id = $("#data_group_id").val()
    	if (data_group_id == "") {
    		alert("그룹 아이디가 없습니다.");
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=data_all_id]"));
    	if (!status) {
			alert("선택된 항목이 없습니다.");
			return;
		}
    	var param = $("#data_left_form").serialize() + "&data_group_id=" + data_group_id;
    	$.ajax({
    		url: "/data/ajax-insert-data-group-data.do",
    		type: "POST",
    		data: param,
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if(msg.result == "success") {
					alert(JS_MESSAGE["update"]);
					ajaxListDataGroupData(1);
					ajaxListDataGroupDataByGroupId(1);
			    	ajaxListExceptDataGroupDataByGroupId(1);
				}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
    
    // 데이터 그룹내 데이터 삭제
    function ajaxDeleteDataGroupData() {
    	var data_group_id = $("#data_group_id").val()
    	if (data_group_id == "") {
    		alert("그룹 아이디가 없습니다.");
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=data_select_id]"));
    	if (!status) {
			alert("선택된 항목이 없습니다.");
			return;
		}
    	var param = $("#data_right_form").serialize() + "&data_group_id=" + data_group_id;
    	$.ajax({
    		url: "/data/ajax-delete-data-group-data.do",
    		type: "POST",
    		data: param,
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if(msg.result == "success") {
    				alert(JS_MESSAGE["delete"]);
					ajaxListDataGroupData(1);
					ajaxListDataGroupDataByGroupId(1);
			    	ajaxListExceptDataGroupDataByGroupId(1);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
    
    // 체크박스 선택여부 
    function checkedStatus(element) {
		var returnVal = true;
		var checkStatusVal = 0;
		
		$.each(element, function(index) {			
			if (element[index].checked == true) {
				checkStatusVal++;
			}
		});
		
		if (checkStatusVal == 0) {
			returnVal = false;
		}		
		return returnVal; 
	}
    
 	// 캐시 갱신
    var cacheFlag = true;
	function reloadDataGroupCache() {
		if(cacheFlag) {
			cacheFlag = false;
			var info = "service_name=dataGroup";
			$.ajax({
				url: "/common/ajax-reload-config-cache.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					cacheFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
			        cacheFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 데이터 관리 팝업 목록
	function drawListDataGroupDataByGroupId(pagination, dataList, type) {
		var dataList = dataList;
		var content = "";
		if (dataList != null && dataList.length > 0) {
			for(i=0; i<dataList.length; i++ ) {
				var dataInfo = null;
				dataInfo = dataList[i];
				content			+= 	"<tr>"
								+		"<td class=\"col-checkbox\"><input type=\"checkbox\" id=\"data_id_" + dataInfo.data_id + "\" name=\"" + type + "_id\" value=\"" + dataInfo.data_id + "\" /></td>"
								+ 		"<td class=\"col-name\">" + dataInfo.data_id + "</td>"
								+ 		"<td class=\"col-toggle\">" + dataInfo.data_name + "</td>"
								+ 	"</tr>";
			}
		} else {
			content += 	"<tr>"
					+		"<td colspan=\"3\" class=\"col-none\">등록된 데이터가 없습니다.</td>"
					+	"</tr>";
		}
		
		$("#" + type + "_list").empty();
		$("#" + type + "_list").html(content);
		$("#" + type + "_list_count").empty();
		$("#" + type + "_list_count").html("총건수: <em>" + pagination.totalCount + "</em>건");
		
		drawPage(pagination, type, type);
	}
	
	// 선택 그룹 Data 목록
	function drawListDataGroupData(pagination, jsonData) {
		var dataList = jsonData;
		var content = "";
		if (dataList != null && dataList.length > 0) {
			for(i=0; i<dataList.length; i++ ) {
				var dataInfo = null;
				dataInfo = dataList[i];
				content += 	"<tr>"
						+		"<td class=\"col-number\">" + (i + 1) + "</td>"
						+ 		"<td class=\"col-id\">" + dataInfo.data_id + "</td>"
						+ 		"<td class=\"col-name\">" + dataInfo.data_name + "</td>"
						+ 		"<td class=\"col-toggle\">" + dataInfo.status + "</td>"
						+ 		"<td  class=\"col-date-time\">" + dataInfo.insert_date + "</td>"
						+ 	"</tr>";
			}
		} else {
			content += 	"<tr>"
					+		"<td colspan=\"5\" class=\"col-none\">등록된 데이터가 없습니다.</td>"
					+	"</tr>";
		}
		$("#data_list").empty();
		$("#data_list").html(content);
		$("#data_select_list_count").empty();
		$("#data_select_list_count").html("총건수: <em>" + pagination.totalCount + "</em>건");
		drawPage(pagination, "data_list", "data_pagination");
	}
	
 	function drawGroupPage(page, group) {
 		if(group == "data_all") {
 			ajaxListExceptDataGroupDataByGroupId(page);
 		} else if(group == "data_select") {
 			ajaxListDataGroupDataByGroupId(page);
		} else if(group == "data_list") {
 			ajaxListDataGroupData(page);
		}
 	}
 	
 	function drawParent(type) {
 		$("#" + type + "_list").empty();						
		$("#" + type + "_pagination").empty();
		
		var colspan = "5";
		var content = "";
		content += 	"<tr>"
				+		"<td colspan=\"" + colspan + "\" class=\"col-none\">최상위 그룹에는 등록할 수 없습니다.</td>"
				+	"</tr>";
		$("#" + type + "_list").html(content);
 	}
</script>
</body>
</html>
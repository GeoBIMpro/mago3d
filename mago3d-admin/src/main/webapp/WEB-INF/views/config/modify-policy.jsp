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
	
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jqplot/jquery.jqplot.min.js"></script>
	
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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						<div class="tabs">
							<ul>
								<li><a href="#user_tab">사용자</a></li>
								<li><a href="#password_tab">패스워드</a></li>
								<li><a href="#geo_tab">공간 정보</a></li>
								<li><a href="#geoserver_tab">GeoServer</a></li>
								<li><a href="#geocallback_tab">CallBack</a></li>
								<li><a href="#security_tab">보안</a></li>
								<li><a href="#content_tab">컨텐트</a></li>
								<li><a href="#os_tab">OS 설정</a></li>
								<li><a href="#backoffice_tab">Back Office 정보</a></li>
								<li><a href="#site_tab">사이트 정보</a></li>
								<li><a href="#solution_tab">제품 정보</a></li>
							</ul>
							
							<%@ include file="/WEB-INF/views/config/modify-policy-user.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-password.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-geo.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-geoserver.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-geocallback.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-security.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-content.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-os.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-backoffice.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-site.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-solution.jsp" %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		initJqueryCalendar();
		
		$("#user_delete_type").val("${policyUser.user_delete_type}");
		
		$("#security_session_timeout_yn").val("${policySecurity.security_session_timeout_yn}");
		$("#security_session_hijacking").val("${policySecurity.security_session_hijacking}");
		$("#security_sso").val("${policySecurity.security_sso}");
		$("#security_log_save_type").val("${policySecurity.security_log_save_type}");
		$("#security_log_save_term").val("${policySecurity.security_log_save_term}");
		$("#security_dynamic_block_yn").val("${policySecurity.security_dynamic_block_yn}");
		
		$("#content_statistics_interval").val("${policySecurity.content_statistics_interval}");

		$("[name=security_api_result_secure_yn]").filter("[value='${policySecurity.security_api_result_secure_yn}']").prop("checked",true);
		$("[name=security_masking_yn]").filter("[value='${policySecurity.security_masking_yn}']").prop("checked",true);
		$("[name=user_duplication_login_yn]").filter("[value='${policyUser.user_duplication_login_yn}']").prop("checked",true);
		
		$("#backoffice_user_db_driver").val("${policyBackoffice.backoffice_user_db_driver}");
		
		$( ".select" ).selectmenu();
		
		// 시간 설정에서 - 시간, 분값 세팅
		setTimeValue();
	});

	// 시간 설정에서 시 / 분 세팅
	function setTimeValue() {
		for (var i = 0; i < 24; i ++) {
			$("#os_ntp_hour").append("<option value='"+ i +"'>" + i + "</option>");
		}
		for (var i = 0; i < 60; i ++) {
			$("#os_ntp_minute").append("<option value='"+ i +"'>" + i + "</option>");
		}
	}
	
	$("#os_ntp").change(function() {
		var os_ntp = $("#os_ntp option:selected").val();		
		if (os_ntp != "") {
			$("#os_ntp_day").prop("disabled", true);
			$("#os_ntp_hour").prop("disabled", true);
			$("#os_ntp_minute").prop("disabled", true);
		} else {
			$("#os_ntp_day").prop("disabled", false);
			$("#os_ntp_hour").prop("disabled", false);
			$("#os_ntp_minute").prop("disabled", false);
		}
	});
	
	// OS 설정
	var updateOsFlag = true;
	function updatePolicyOs() {
		var os_ntp = $("#os_ntp option:selected").val();
		if (os_ntp== "" && ($("#os_ntp_hour").val() == "" || $("#os_ntp_minute").val() == "")) {
			alert("시간을 입력해 주세요");
			return;
		}
		
		if(updateOsFlag) {
			updateOsFlag = false;
			var info = $("#policyOs").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-os.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateOsFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateOsFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사용자 정책 저장
	var updateUserFlag = true;
	function updatePolicyUser() {
		if(updateUserFlag) {
			if($("#user_id_min_length").val() == "") {
				alert("사용자 아이디 최소 길이를 입력하여 주십시오.");
				$("#user_id_min_length").focus();
				return;
			}
			if(!isNumber($("#user_id_min_length").val())) {
				$("#user_id_min_length").focus();
				return;
			}
			if(parseInt($("#user_id_min_length").val()) < 4) {
				alert("사용자 아이디 최소 길이는 4 이상 입니다.");
				$("#user_id_min_length").focus();
				return;
			}
			if($("#user_fail_login_count").val() == "") {
				alert("로그인 실패 횟수를 입력하여 주십시오.");
				$("#user_fail_login_count").focus();
				return;
			}
			if(!isNumber($("#user_fail_login_count").val())) {
				$("#user_fail_login_count").focus();
				return;
			}
			/* if($("#user_fail_lock_release").val() == "") {
				alert("로그인 실패 잠금 해제 기간을 입력하여 주십시오.");
				$("#user_fail_lock_release").focus();
				return;
			}
			if(!isNumber($("#user_fail_lock_release").val())) {
				$("#user_fail_lock_release").focus();
				return;
			} */
			if($("#user_last_login_lock").val() == "") {
				alert("마지막 로그인으로 부터 잠금 기간을 입력하여 주십시오.");
				$("#user_last_login_lock").focus();
				return;
			}
			if(!isNumber($("#user_last_login_lock").val())) {
				$("#user_last_login_lock").focus();
				return;
			}
			
			updateUserFlag = false;
			var info = $("#policyUser").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-user.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.user.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 패스워드 정책 저장
	var updatePasswordFlag = true;
	function updatePolicyPassword() {
		if(updatePasswordFlag) {
			if($("#password_change_term").val() == "") {
				alert("변경 주기를 입력하여 주십시오.");
				$("#password_change_term").focus();
				return;
			}
			if(!isNumber($("#password_change_term").val())) {
				$("#password_change_term").focus();
				return;
			}
			if($("#password_min_length").val() == "") {
				alert("최소 길이를 입력하여 주십시오.");
				$("#password_min_length").focus();
				return;
			}
			if(!isNumber($("#password_min_length").val())) {
				$("#password_min_length").focus();
				return;
			}
			if($("#password_max_length").val() == "") {
				alert("최대 길이를 입력하여 주십시오.");
				$("#password_max_length").focus();
				return;
			}
			if(!isNumber($("#password_max_length").val())) {
				$("#password_max_length").focus();
				return;
			}
			if($("#password_eng_upper_count").val() == "") {
				alert("영문 대문자 개수를 입력하여 주십시오.");
				$("#password_eng_upper_count").focus();
				return;
			}
			if(!isNumber($("#password_eng_upper_count").val())) {
				$("#password_eng_upper_count").focus();
				return;
			}
			if($("#password_eng_lower_count").val() == "") {
				alert("영문 소문자 개수를 입력하여 주십시오.");
				$("#password_eng_lower_count").focus();
				return;
			}
			if(!isNumber($("#password_eng_lower_count").val())) {
				$("#password_eng_lower_count").focus();
				return;
			}
			if($("#password_number_count").val() == "") {
				alert("숫자 개수를 입력하여 주십시오.");
				$("#password_number_count").focus();
				return;
			}
			if(!isNumber($("#password_number_count").val())) {
				$("#password_number_count").focus();
				return;
			}
			if($("#password_special_char_count").val() == "") {
				alert("특수 문자 개수를 입력하여 주십시오.");
				$("#password_special_char_count").focus();
				return;
			}
			if(!isNumber($("#password_special_char_count").val())) {
				$("#password_special_char_count").focus();
				return;
			}
			if($("#password_continuous_char_count").val() == "") {
				alert("패스워드 연속문자 제한 개수를 입력하여 주십시오.");
				$("#password_continuous_char_count").focus();
				return;
			}
			if(!isNumber($("#password_continuous_char_count").val())) {
				$("#password_continuous_char_count").focus();
				return;
			}
/* 			if($("#password_create_char").val() == "") {
				alert("초기 패스워드 생성 문자열을 입력하여 주십시오.");
				$("#password_create_char").focus();
				return;
			} */
			
			updatePasswordFlag = false;
			var info = $("#policyPassword").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-password.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.password.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePasswordFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePasswordFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 공간 정보
	var updatePolicyGeoFlag = true;
	function updatePolicyGeo() {
		if(updatePolicyGeoFlag) {
			// validation 나중에
			updatePolicyGeoFlag = false;
			var info = $("#policyGeo").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-geo.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geo.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// GeoServer
	var updatePolicyGeoServerFlag = true;
	function updatePolicyGeoServer() {
		if(updatePolicyGeoServerFlag) {
			// validation 나중에
			updatePolicyGeoServerFlag = false;
			var info = $("#policyGeoServer").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-geoserver.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geoserver.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoServerFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoServerFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Geo CallBack Function
	var updatePolicyGeoCallBackFlag = true;
	function updatePolicyGeoCallBack() {
		if(updatePolicyGeoCallBackFlag) {
			// validation 나중에
			updatePolicyGeoCallBackFlag = false;
			var info = $("#policyGeoCallBack").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-geocallback.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geo.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoCallBackFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoCallBackFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 보안 정책 저장
	var updateSecurityFlag = true;
	function updatePolicySecurity() {
		if(updateSecurityFlag) {
			if(!isNumber($("#security_session_timeout").val())) {
				$("#security_session_timeout").focus();
				return;
			}
			var security_sso_token_verify_time = $("#security_sso_token_verify_time").val();
			if(security_sso_token_verify_time != null && security_sso_token_verify_time != "") {
				if(!isNumber(security_sso_token_verify_time)) {
					$("#security_sso_token_verify_time").focus();
					return;
				}
			}
			updateSecurityFlag = false;
			var info = $("#policySecurity").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-security.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.security.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSecurityFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSecurityFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 컨텐트 정책 저장
	var updateContentFlag = true;
	function updatePolicyContent() {
		if(updateContentFlag) {
			if($("#content_main_widget_count").val() == "") {
				alert("메인 화면 컨텐츠 표시 개수를 입력하여 주십시오.");
				$("#content_main_widget_count").focus();
				return;
			}
			if(!isNumber($("#content_main_widget_count").val())) {
				$("#content_main_widget_count").focus();
				return;
			}
			if($("#content_main_widget_interval").val() == "") {
				alert("메인 화면 위젯 Refresh 간격을 입력하여 주십시오.");
				$("#content_main_widget_interval").focus();
				return;
			}
			if(!isNumber($("#content_main_widget_interval").val())) {
				$("#content_main_widget_interval").focus();
				return;
			}
			if($("#content_monitoring_interval").val() == "") {
				alert("모니터링 감시 간격(분단위)을 입력하여 주십시오.");
				$("#content_monitoring_interval").focus();
				return;
			}
			
			if($("#content_statistics_interval").val() == "") {
				alert("통계 기본 검색 기간을 선택해 주십시오.");
				$("#content_statistics_interval").focus();
				return;
			}
			if($("#content_load_balancing_interval").val() == "") {
				alert("현재 서버가 Active, Standby 인지 상태를 표시하는 주기를 입력하여 주십시오.");
				$("#content_load_balancing_interval").focus();
				return;
			}
			if(!isNumber($("#content_load_balancing_interval").val())) {
				$("#content_load_balancing_interval").focus();
				return;
			}
			if($("#content_menu_group_root").val() == "") {
				alert("메뉴 그룹 최상위 그룹명을 입력하여 주십시오.");
				$("#content_menu_group_root").focus();
				return;
			}
			if($("#content_user_group_root").val() == "") {
				alert("사용자 그룹 최상위 그룹명을 입력하여 주십시오.");
				$("#content_user_group_root").focus();
				return;
			}
			
			updateContentFlag = false;
			var info = $("#policyContent").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-content.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.content.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateContentFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateContentFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Back Office 정보 저장
	var updateBackofficeFlag = true;
	function updatePolicyBackoffice() {
		if(updateBackofficeFlag) {
			updateBackofficeFlag = false;
			var info = $("#policyBackoffice").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-backoffice.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateBackofficeFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateBackofficeFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사이트 정보 저장
	var updateSiteFlag = true;
	function updatePolicySite() {
		if(updateSiteFlag) {
			if(!isIP($("#server_ip").val())) {
				alert("IP 형식에 맞게 입력해 주십시오.");
				$("#server_ip").focus();
				return false;
			}
			
			if($("#site_name").val() == "") {
				alert("서비스명을 입력해 주십시오.");
				$("#site_name").focus();
				return;
			}
			if($("#site_admin_mobile_phone").val() == "") {
				alert("관리자 핸드폰 번호를 입력해 주십시오.");
				$("#site_admin_mobile_phone").focus();
				return;
			}
			if($("#site_admin_email").val() == "") {
				alert("관리자 이메일을 입력해 주십시오.");
				$("#site_admin_email").focus();
				return;
			}
			
			updateSiteFlag = false;
			var info = $("#policySite").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-site.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.site.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSiteFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSiteFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// API KEY 찾기
	function findApiKey() {
		
	}
	
	// 제품 정보 저장
	var updateSolutionFlag = true;
	function updatePolicySolution() {
		if(updateSolutionFlag) {
			if($("#solution_name").val() == "") {
				alert("제품명을 입력해 주십시오.");
				$("#solution_name").focus();
				return;
			}
			if($("#solution_version").val() == "") {
				alert("제품 버전을 입력해 주십시오.");
				$("#solution_version").focus();
				return;
			}
			if($("#solution_manager").val() == "") {
				alert("제품 회사 담당자를 입력해 주십시오.");
				$("#solution_manager").focus();
				return;
			}
			
			updateSolutionFlag = false;
			var info = $("#policySolution").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-solution.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.solution.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSolutionFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSolutionFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	/* function checkChangLogo() {
		if($("#uploadfile_top").val() != null && $("#uploadfile_top").val() != "") {
			$("#uploadfile_top_value").val("logo");
		}
		if($("#uploadfile_bottom").val() != null && $("#uploadfile_bottom").val() != "") {
			$("#uploadfile_bottom_value").val("logo");
		}
	} */
</script>
</body>
</html>
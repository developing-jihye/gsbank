<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2.css">
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/proddtl.css">
<title>관리자시스템</title>
</head>

<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>밥먹자</strong></li>
			</ol>

			<h2>고객정보 목록</h2>
			<br />

			<div class="flex-column flex-gap-10" id="vueapp">
				<template>
					<div class="flex flex-100">
						<div class="flex-wrap flex-100 flex flex-gap-10 flex-padding-15"
							style="justify-content: center; flex-direction: column; align-items: center;">
							<div
								style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;">
								<div class="form-group flex-40">
									<label class="fix-width-33">고객명 :</label> <input
										class="form-control" v-model="cust_nm" value="">
								</div>
								<div class="form-group flex-40">
									<label class="fix-width-33">관리담당자:</label> <input
										class="form-control" v-model="pic_nm" value="">
								</div>
								<div class="form-group flex-40">
									<label class="fix-width-33">생년월일:</label> <input type="text"
										class="form-control" v-model="rrno">
								</div>
								<div class="form-group flex-40">
									<label class="fix-width-33">관리부서:</label> <input type="text"
										class="form-control" v-model="dept_nm">
								</div>
							</div>

							<!-- 검색 버튼들을 아래로 이동 -->
							<div
								style="display: flex; justify-content: center; width: 100%; margin-top: 0px;">
								<!-- 버튼들을 하나의 div로 묶고 중앙 정렬 -->
								<div style="display: flex; justify-content: center; gap: 20%;">
									<button type="button" class="btn btn-blue2 btn-icon icon-left"
										v-model="search_val" @click="getCustInfoList(true)">조건검색</button>
									<button type="button" class="btn btn-blue2 btn-icon icon-left"
										v-model="search_val" @click="getCustInfoListAll(true)">전체검색</button>
								</div>
							</div>
							<!-- <div style="display: flex; justify-content: center; align-items: center; margin-top: 15px; gap: 20%; height: 0px;">
            <div class="form-group" style=" margin-right: 5px;">
                <button type="button" class="btn btn-blue2 btn-icon icon-left form-control"
                    v-model="search_val" @click="getCustInfoList(true)">
                    조건검색
                </button>
            </div>
            <div class="form-group" style="">
                <button type="button" class="btn btn-blue2 btn-icon icon-left form-control"
                    v-model="search_val" @click="getCustInfoListAll(true)">
                    전체검색
                </button>
            </div>
        </div> -->
						</div>
					</div>
					<div style="display: flex; width: 100%; gap: 20px;">

						<!-- 고객조회 페이지 (비율 2) -->
						<div style="flex: 2; border: 1px solid #999999; padding: 15px;">
							<div>
								<div
									style="display: flex; gap: 161px; margin-top: 10px; justify-content: flex-end; margin-bottom: 15px;">
									<div style="display: flex; gap: 10px;">
										<button type="button" class="btn btn-blue3 btn-icon icon-left"
											@click="popCustmnglistPrint">관리대장출력</button>
										<button type="button" class="btn btn-blue3 btn-icon icon-left"
											@click="popCustmngCardPrint">관리카드출력</button>
										<button type="button" class="btn btn-blue3 btn-icon icon-left"
											@click="popDamdangSet">담당자설정</button>
									</div>


									<!-- <div style="margin-right: 20px;"></div> 간격 추가 -->



									<div style="display: flex; gap: 10px;">
										<button type="button"
											class="btn btn-orange2 btn-icon icon-left"
											@click="custInfoMng">고객관리</button>
										<button type="button"
											class="btn btn-orange2 btn-icon icon-left"
											@click="picInfoMng">담당자관리</button>
									</div>
								</div>


<div id="vueapp">
    <div style="overflow-x: auto;">
        <table class="table table-bordered" style="width: 100%; text-align: center; table-layout: fixed; margin-bottom: 0;">
            <thead>
                <tr>
                    <th style="text-align: center; width: 5%;">
                        <input type="checkbox" :checked="allSelected" @click="selectAll($event)">
                    </th>
                    <th style="text-align: center; width: 20%;">성명</th>
                    <th style="text-align: center; width: 20%;">생년월일</th>
                    <th style="text-align: center; width: 25%;">핸드폰번호</th>
                    <th style="text-align: center; width: 30%;">직업</th>
                </tr>
            </thead>
        </table>
    </div>

    <!-- 데이터가 있는 경우에만 표시 -->
    <div v-show="visibleDataList.length > 0" style="max-height: 368px; overflow-y: auto; border: 1px solid #ddd;">
        <table class="table table-bordered" style="width: 100%; text-align: center; table-layout: fixed;">
            <tbody>
                <tr v-for="(item, index) in visibleDataList" :key="index" @click="gotoDtl(item.cust_mbl_telno)">
                    <td style="width: 5%;">
                        <input type="checkbox" v-model="item.isChecked" name="'is_check_' + index" @click.stop="onItemCheck">
                    </td>
                    <td style="width: 20%;">{{ item.cust_nm }}</td>
                    <td style="width: 20%;">{{ item.rrno }}</td>
                    <td style="width: 25%;">{{ item.cust_mbl_telno }}</td>
                    <td style="width: 30%;">{{ item.occp_ty_cd_nm }}</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
							</div>
						</div>

						<!-- 고객 상세정보 (비율 1) -->
						<div style="flex: 1; border: 1px solid #999999; padding: 15px;">
							<div style="margin-top: 15px">
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">작성일자</label> <input
										type="text" class="form-control"
										v-model="selectedCustomer.wrt_dt"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">성명</label> <input
										type="text" class="form-control"
										v-model="selectedCustomer.cust_nm"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">주민번호</label> <input
										type="text" class="form-control"
										v-model="selectedCustomer.rrno"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">E-mail</label>
									<input type="text" class="form-control"
										v-model="selectedCustomer.cust_eml_addr"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">전화번호</label> <input
										type="text" class="form-control"
										v-model="selectedCustomer.co_telno"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center">핸드폰번호</label> <input
										type="text" class="form-control"
										v-model="selectedCustomer.cust_mbl_telno"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 30px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">직업</label> <input
										type="text" class="form-control"
										v-model="selectedCustomer.occp_ty_cd_nm"
										style="flex: 1; max-width: 300px;">
								</div>
								<div class="custdtlabel"
									style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px; margin-right: 10px">
									<label style="width: 100px; text-align: center;">주소</label>
									<textarea class="form-control"
										v-model="selectedCustomer.cust_addr" rows="3"
										style="flex: 1; max-width: 300px; padding: 5px 10px; resize: none; margin-left: 19px;"></textarea>
								</div>
							</div>
							<div
								style="display: flex; justify-content: center; gap: 10px; margin-top: 57px;">
								<button class="btn btn-blue2 btn-icon icon-left"
									@click="custUpdate">변경</button>
								<button class="btn btn-red btn-icon icon-left"
									@click="custDelete">삭제</button>
								<button class="btn btn-orange2 btn-icon icon-left"
									@click="clearSelectedCustomer">초기화</button>
							</div>
						</div>
						<!-- 고객 상세정보 (비율 1) -->
						<div style="flex: 1; border: 1px solid #999999; padding: 15px;">
							<!-- 상담내역 표시 -->
							<!-- <h3 style="margin-top: 0px; text-align: center;">고객 상담내용</h3> -->
							<textarea class="form-control"
								v-model="selectedCustomer.tsk_dtl_cn"
								style="height: 307px; resize: none; background-color: white; margin-top: 11px;"
								readonly></textarea>

							<!-- 상담내역 입력창 -->
							<textarea v-model="newTskDtl" class="form-control"
								style="height: 64px; resize: none; margin-top: 10px"></textarea>

							<!-- 수정 버튼 -->
							<div
								style="display: flex; justify-content: center; margin-top: 39px; gap: 10px">
								<button class="btn btn-green3 btn-icon icon-left"
									@click="updateTskDtl">수정</button>
							</div>
						</div>
					</div>
					<!-- <table class="table table-bordered datatable dataTable"
						id="grid_app" style="border: 1px solid #999999;">
						<thead>
							<tr class="replace-inputs">
								<th style="width: 5%;" class="center"><input
									type="checkbox" id="allCheck" @click="all_check(event.target)"
									style="cursor: pointer;"></th>
								<th style="width: 20%;" class="center">성명</th>
								<th style="width: 15%;" class="center">생년월일</th>
								<th style="width: 15%;" class="center">핸드폰번호</th>
								<th style="width: 15%;" class="center">직업</th>
								<th style="width: 30%;" class="center">주소</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList"
								@dblclick="gotoDtl(item.cust_mbl_telno)"
								style="cursor: pointer;">
								<td class="center" @dblclick.stop="return false;"><input
									type="checkbox" :data-idx="item.cust_nm" name="is_check"
									@click.stop="onCheck" style="cursor: pointer;"></td>
								<td class="center">{{item.cust_nm}}</td>
								<td class="center">{{item.rrno}}</td>
								<td class="center">{{item.cust_mbl_telno}}</td>
								<td class="center">{{item.occp_ty_cd_nm}}</td>
								<td class="center">{{item.cust_addr}}</td>
							</tr>
						</tbody>
					</table> -->
				</template>
			</div>


			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
				flush="false" />
		</div>
	</div>

	<!-- <!-- 고객기본정보조회 팝업
            <div class="modal fade" id="pop_cust_info">
                <template>
                    <div class="modal-dialog4">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                    id="btn_popClose">&times;</button>
                                <h4 class="modal-title" id="modify_nm">고객기본정보</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal form-groups-bordered">
                                    <div class="clearAfter">
                                        <div class="left">
                                            <div class="form-group">
                                                <label for="err_cd" class="col-sm-3 control-label">작성일자</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="wrt_dt" v-model="info.wrt_dt">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_kor_nm" class="col-sm-3 control-label">성명</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_nm" v-model="info.cust_nm">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">실명번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="rrno" v-model="info.rrno">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">E-mail</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_eml_addr" v-model="info.cust_eml_addr">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">전화번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="co_telno" v-model="info.co_telno">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">핸드폰번호</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="cust_mbl_telno"
                                                        v-model="info.cust_mbl_telno">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">직업</label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="occp_ty_cd_nm" v-model="info.occp_ty_cd_nm">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-3 control-label">주소</label>
                                                <div class="col-sm-9">
                                                    <textarea id="cust_addr" v-model="info.cust_addr"
                                                        style="width:100%;"></textarea>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="right">
                                            <div class="form-group">
                                                <label for="err_eng_nm" class="col-sm-2 control-label">상담내역</label>
                                            </div>
                                            <div class="col-sm-10">
                                                <tr>
                                                    <textarea id="tsk_dtl_cn" v-model="info.tsk_dtl_cn"
                                                        style="width:100%;"></textarea>
                                                </tr>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
            // 고객기본정보조회 팝업  -->
	-->

	<!-- 관리대장출력 팝업 -->
	<div class="modal fade" id="pop_cust_mnglist_print">
		<template>
			<div class="modal-dialog4">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true" id="btn_popClose">&times;</button>
						<h4 class="modal-title" id="modify_nm">고객정보출력관리</h4>
					</div>
					<div class="modal-body"
						style="overflow-y: auto; max-height: 400px;">
						<!-- max-height 설정으로 최대 높이 제한 -->
						<form class="form-horizontal form-groups-bordered">
							<div>
								[고객관리카드] 를(을) 출력하시겠습니까?<br> ※고객정보는 개인정보관리 대상이므로 유의하셔야 합니다.
							</div>
							<div class="form-group">
								<div class="col-sm-10">출력인원 : {{printInfo.custCount}}명</div>
							</div>
							<div class="form-group">
								<table class="table datatable dataTable">
									<thead>
										<tr class="replace-inputs">
											<th style="width: 20%;" class="center">성명</th>
											<th style="width: 20%;" class="center">생년월일</th>
											<th style="width: 30%;" class="center">핸드폰번호</th>
											<th style="width: 30%;" class="center">직업</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for="item in printInfo.custList">
											<td class="center">{{item.cust_nm}}</td>
											<td class="center">{{item.rrno}}</td>
											<td class="center">{{item.cust_mbl_telno}}</td>
											<td class="center">{{item.occp_ty_cd_nm}}</td>
										</tr>
									</tbody>
								</table>
							</div>

						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" @click="print">인쇄</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
			<!-- 관리대장 출력 영역 -->
			<div id="cust_mnglist_printArea" style="height: 0px; display: none;">
				<table class="table datatable dataTable">
					<thead>
						<tr class="replace-inputs">
							<th style="width: 20%;" class="center">성명</th>
							<th style="width: 20%;" class="center">생년월일</th>
							<th style="width: 30%;" class="center">핸드폰번호</th>
							<th style="width: 30%;" class="center">직업</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="item in printInfo.custList">
							<td class="center">{{item.cust_nm}}</td>
							<td class="center">{{item.rrno}}</td>
							<td class="center">{{item.cust_mbl_telno}}</td>
							<td class="center">{{item.occp_ty_cd_nm}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</template>
	</div>
	<!--// 관리대장출력 팝업  -->

	<!-- 고객관리카드 출력 팝업 -->
	<div class="modal fade" id="pop_cust_card_print">
		<template>
			<div class="modal-dialog4">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true" id="btn_popClose">&times;</button>
						<h4 class="modal-title" id="modify_nm">고객관리카드 출력</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form-groups-bordered">
							<div>
								[고객관리카드] 를(을) 출력하시겠습니까?<br> ※고객정보는 개인정보관리 대상이므로 유의하셔야 합니다.
							</div>
							<div class="clearAfter">
								<div class="left">
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">고객명</label>
										<div class="col-sm-9">
											<input type="text" id="cust_nm" v-model="info.cust_nm">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">실명번호</label>
										<div class="col-sm-9">
											<input type="text" id="rrno" v-model="info.rrno">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">E-mail</label>
										<div class="col-sm-9">
											<input type="text" id="cust_eml_addr"
												v-model="info.cust_eml_addr">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">전화번호</label>
										<div class="col-sm-9">
											<input type="text" id="co_telno" v-model="info.co_telno">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">핸드폰</label>
										<div class="col-sm-9">
											<input type="text" id="cust_mbl_telno"
												v-model="info.cust_mbl_telno">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">직업</label>
										<div class="col-sm-9">
											<input type="text" id="occp_ty_cd_nm"
												v-model="info.occp_ty_cd_nm">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">주소</label>
										<div class="col-sm-9">
											<textarea id="cust_addr" v-model="info.cust_addr"
												style="width: 100%;"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">담당자</label>
										<div class="col-sm-9">
											<input type="text" id="pic_nm" v-model="info.pic_nm">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">부서</label>
										<div class="col-sm-9">
											<input type="text" id="dept_nm" v-model="info.dept_nm">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">직위</label>
										<div class="col-sm-9">
											<input type="text" id="jbps_ty_cd_nm"
												v-model="info.jbps_ty_cd_nm">
										</div>
									</div>
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">연락처</label>
										<div class="col-sm-9">
											<input type="text" id="pic_mbl_telno"
												v-model="info.pic_mbl_telno">
										</div>
									</div>
									<div class="form-group">
										<label for="err_eng_nm" class="col-sm-2 control-label">상담내역</label>
									</div>
									<div class="col-sm-10">
										<tr>
											<textarea id="tsk_dtl_cn" v-model="info.tsk_dtl_cn"
												style="width: 100%;"></textarea>
										</tr>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" @click="print_card">인쇄</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
			<div id="cust_mngcard_printArea" style="height: 0px; display: none;">
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">고객명</label>
					<div class="col-sm-9">
						<input type="submit" id="cust_nm" v-model="info.cust_nm">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">실명번호</label>
					<div class="col-sm-9">
						<input type="submit" id="rrno" v-model="info.rrno">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">E-mail</label>
					<div class="col-sm-9">
						<input type="submit" id="cust_eml_addr"
							v-model="info.cust_eml_addr">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">전화번호</label>
					<div class="col-sm-9">
						<input type="submit" id="co_telno" v-model="info.co_telno">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">핸드폰</label>
					<div class="col-sm-9">
						<input type="submit" id="cust_mbl_telno"
							v-model="info.cust_mbl_telno">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">직업</label>
					<div class="col-sm-9">
						<input type="submit" id="occp_ty_cd_nm"
							v-model="info.occp_ty_cd_nm">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">주소</label>
					<div class="col-sm-9">
						<input type="submit" id="cust_addr" v-model="info.cust_addr">
						<!-- <textarea  type="submit" id="cust_addr" v-model="info.cust_addr" style="width:100%;" ></textarea> -->
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">담당자</label>
					<div class="col-sm-9">
						<input type="submit" id="pic_nm" v-model="info.pic_nm">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">부서</label>
					<div class="col-sm-9">
						<input type="submit" id="dept_nm" v-model="info.dept_nm">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">직위</label>
					<div class="col-sm-9">
						<input type="submit" id="jbps_ty_cd_nm"
							v-model="info.jbps_ty_cd_nm">
					</div>
				</div>
				<div class="form-group">
					<label for="err_cd" class="col-sm-3 control-label">연락처</label>
					<div class="col-sm-9">
						<input type="submit" id="pic_mbl_telno"
							v-model="info.pic_mbl_telno">
					</div>
				</div>
				<div class="form-group">
					<label for="err_eng_nm" class="col-sm-2 control-label">상담내역</label>
					<div class="col-sm-9">
						<input type="submit" id="tsk_dtl_cn" v-model="info.tsk_dtl_cn">
					</div>
				</div>
				<!-- <div class="col-sm-10">
						<tr>										
						   <textarea  type="submit" id="tsk_dtl_cn" v-model="info.tsk_dtl_cn" style="width:100%;" ></textarea>
						</tr> 
					</div>   -->
			</div>
		</template>
	</div>
	<!--// 고객관리카드 출력 팝업  -->

	<!-- 담당자설정 팝업 -->
	<div class="modal fade" id="pop_damdang_set">
		<template>
			<div class="modal-dialog4">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true" id="btn_popClose">&times;</button>
						<h4 class="modal-title" id="modify_nm">담당자 설정</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form-groups-bordered">
							<div class="clearAfter">
								<div class="left">
									<div class="form-group">
										<label for="err_cd" class="col-sm-3 control-label">담당자명
											: </label>
										<div class="col-sm-9">
											<input type="text" id="pic_nm" v-model="picInfo.pic_nm">
											<button type="button" class="btn" @click="popupPicInfo">
												<i class="fa fa-search"></i>
											</button>
											<button type="button" class="btn btn-blue2 btn-icon icon-left"
												style="margin-left: 5px;" @click="damdangSave">
												등록
											</button>
										</div>
									</div>
									<div class="form-group">
										<label for="err_kor_nm" class="col-sm-3 control-label">부서명
											: </label>
										<div class="col-sm-9">
											<input type="text" id="dept_nm" v-model="picInfo.dept_nm">
											<button type="button" class="btn btn-blue btn-icon icon-left"
												style="margin-left: 5px;" @click="damdangDelete">
												삭제 <i class="entypo-search"></i>
											</button>
										</div>
									</div>
									<div class="form-group">
										<label for="err_eng_nm" class="col-sm-3 control-label">직위
											: </label>
										<div class="col-sm-9">
											<input type="text" id="jbps_ty_cd_nm"
												v-model="picInfo.jbps_ty_cd_nm">
										</div>
									</div>
									<div class="form-group">
										<label for="err_eng_nm" class="col-sm-3 control-label">연락처
											: </label>
										<div class="col-sm-9">
											<input type="text" id="pic_mbl_telno"
												v-model="picInfo.pic_mbl_telno">
										</div>
									</div>
									<div class="form-group">
										<label for="err_eng_nm" class="col-sm-3 control-label">E-mail
											: </label>
										<div class="col-sm-9">
											<input type="text" id="pic_eml_addr"
												v-model="picInfo.pic_eml_addr">
										</div>
									</div>
									<div class="form-group">
										<label for="err_eng_nm" class="col-sm-3 control-label">입사일자
											: </label>
										<div class="col-sm-9">
											<input type="text" id="jncmp_ymd" v-model="picInfo.jncmp_ymd">
										</div>
									</div>
									<div class="form-group">
										<label for="err_eng_nm" class="col-sm-3 control-label">기타
											: </label>
										<div class="col-sm-9">
											<textarea id="etc_tsk_cn" v-model="picInfo.etc_tsk_cn"
												style="width: 100%;"></textarea>
										</div>
									</div>
									<div class="form-group" style="max-height: 200px; overflow-y: auto;">
										<table class="table datatable dataTable">
											<thead>
												<tr class="replace-inputs">
													<th style="width: 20%;" class="center">성명</th>
													<th style="width: 20%;" class="center">생년월일</th>
													<th style="width: 30%;" class="center">핸드폰번호</th>
													<th style="width: 30%;" class="center">직업</th>
												</tr>
											</thead>
											<tbody>
												<tr v-for="item in picInfo.custList"
													style="cursor: pointer;">
													<td class="center">{{item.cust_nm}}</td>
													<td class="center">{{item.rrno}}</td>
													<td class="center">{{item.cust_mbl_telno}}</td>
													<td class="center">{{item.occp_ty_cd_nm}}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" @click="popupPicClose">Close</button>
					</div>
				</div>
			</div>
		</template>
	</div>
	<!--// 담당자설정 팝업  -->
	<!-- 팝업 -->
<div class="modal fade" id="pop_pic_info" ref="modal">
		<template>
			<div class="modal-dialog" style="width: 500px;">
				<div class="modal-content">
					<div class="modal-body">
						<div style="height: 400px; overflow: auto;"
							class="dataTables_wrapper">
							<table class="table table-bordered datatable dataTable">
								<thead style="position: sticky; top: 0px;">
									<tr>
										<th class="center" style="width: 20%;">담당자명</th>
										<th class="center" style="width: 20%;">부서명</th>
										<th class="center" style="width: 20%;">직위</th>
										<th class="center" style="width: 50%;">연락처</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="item in dataList" @click="selItem(item.pic_nm)"
										style="cursor: pointer;">
										<td class="center">{{item.pic_nm}}</td>
										<td class="center">{{item.dept_nm}}</td>
										<td class="center">{{item.jbps_ty_cd_nm}}</td>
										<td class="center">{{item.pic_mbl_telno}}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</template>
	</div>
	<!-- 팝업 -->
</body>
<script>
            var vueapp = new Vue({
                el: "#vueapp",
                data() {
                    return {
                        dataList: [],  // 고객 목록 데이터
                        visibleDataList: [],   // 화면에 표시할 데이터
                        itemsToDisplay: 50,    // 한 번에 표시할 데이터 수
                        isLoading: false,      // 로딩 상태
                        search_nm: "",
                        cust_nm: "",
                        pic_nm: "",
                        rrno: "",
                        dept_nm: "",
                        search_val: "",
                        selectedCustomer: {
                            wrt_dt: "",
                            cust_nm: "",
                            rrno: "",
                            cust_eml_addr: "",
                            co_telno: "",
                            cust_mbl_telno: "",
                            occp_ty_cd_nm: "",
                            cust_addr: "",
                            tsk_dtl_cn: "",  // 상담내역 추가
                        },
                        newTskDtl: "",  // 새로운 상담내역 입력을 위한 변수
                        allSelected: false, // 전체 체크박스의 상태
                        autoSearch: true, // 고객 목록 자동 조회 여부 플래그
                        filteredDataList: [],  // 필터링된 데이터 리스트
                    }
                },
                
                mounted() {
                    var urlParams = new URLSearchParams(window.location.search);
                    this.autoSearch = urlParams.get('autoSearch') !== 'false';
                    
                },
                
                computed: {
                    isSearchEnabled() {
                        // 조건 검색을 활성화하기 위해 하나라도 값이 있어야 함
                        return this.cust_nm.trim() !== '' || 
                               this.pic_nm.trim() !== '' || 
                               this.rrno.trim() !== '' || 
                               this.dept_nm.trim() !== '';
                    }
                },
/*                 watch: {
                    cust_nm() {
                        this.filterData();
                    },
                    pic_nm() {
                        this.filterData();
                    },
                    rrno() {
                        this.filterData();
                    },
                    dept_nm() {
                        this.filterData();
                    }
                },
                 */
                methods: {
/*                     loadData() {
                        axios.get('/custMng/getCustInfoListAll').then(response => {
                            this.dataList = response.data.map(item => ({
                                ...item,
                                isChecked: false,
                            }));
                            this.filteredDataList = [...this.dataList];  // 초기 데이터 설정
                            this.addMoreItems(); // 초기 데이터 일부 표시
                        });
                    }, */
                    filterData() {
                        this.filteredDataList = this.dataList.filter(item => {
                            return (
                                (!this.cust_nm || item.cust_nm.includes(this.cust_nm)) &&
                                (!this.pic_nm || item.pic_nm.includes(this.pic_nm)) &&
                                (!this.rrno || item.rrno.includes(this.rrno)) &&
                                (!this.dept_nm || item.dept_nm.includes(this.dept_nm))
                            );
                        });
                        this.visibleDataList = [];
                        this.addMoreItems(); // 필터링된 데이터로 다시 일부만 표시
                    },
                    onItemCheck() {
                        this.allSelected = this.visibleDataList.every(item => item.isChecked);
                    },
                    addMoreItems() {
                        if (this.isLoading) return;

                        this.isLoading = true;

                        const start = this.visibleDataList.length;
                        const end = start + this.itemsToDisplay;

                        this.visibleDataList = this.visibleDataList.concat(this.filteredDataList.slice(start, end));

                        this.isLoading = false;
                    },
                    
                    onScroll(event) {
                        const container = event.target;
                        if (container.scrollTop + container.clientHeight >= container.scrollHeight) {
                            this.addMoreItems();
                        }
                    },
                	        
                    selectAll() {
                        this.visibleDataList.forEach(item => {
                            item.isChecked = this.allSelected;
                        });
                    },
                	
                     
                    
                     getCustInfoList: function (isInit) {
                         if (!this.cust_nm.trim() && !this.pic_nm.trim() && !this.rrno.trim() && !this.dept_nm.trim()) {
                             alert("검색 조건을 하나 이상 입력해 주세요.");
                             return; // 조건이 만족되지 않으면 함수 실행 중단
                         }
                         cv_pagingConfig.func = this.getCustInfoList;
                         if (isInit === true) {
                             cv_pagingConfig.pageNo = 1;
                             cv_pagingConfig.orders = [{ target: "cust_nm", isAsc: false }];
                         }

                         var params = {
                             search_nm: this.search_nm,
                             search_val: this.search_val,
                             pic_nm: this.pic_nm,
                             dept_nm: this.dept_nm,
                             cust_nm: this.cust_nm,
                             rrno: this.rrno,
                         }

                         cv_sessionStorage
                             .setItem('pagingConfig', cv_pagingConfig)
                             .setItem('params', params);

                         cf_ajax("/custMng/getCustInfoList", params, this.getListCB);
                     },
                    	        
                    getCustInfoListAll: function (isInit) {
                        cv_pagingConfig.func = this.getCustInfoListAll;
                        if (isInit === true) {
                            cv_pagingConfig.pageNo = 1;
                            cv_pagingConfig.orders = [{ target: "cust_nm", isAsc: false }];
                            cv_pagingConfig.limit = "100";  // 원하는 limit 값을 설정
                        }

                        var params = {
                            search_nm: this.search_nm,
                            search_val: this.search_val
                        };

                        cv_sessionStorage
                            .setItem('pagingConfig', cv_pagingConfig)
                            .setItem('params', params);

                        console.log("Fetching all customer info with params:", params);

                        cf_ajax("/custMng/getCustInfoListAll", params, this.getListCB);
                    },
                    
                    getListCB: function (data) {
                        console.log("Server data:", data);

                        this.dataList = data.list;  // 전체 데이터 저장
                        this.visibleDataList = this.dataList;  // 전체 데이터를 visibleDataList에 할당하여 모두 표시

                        cv_pagingConfig.renderPagenation("system");
                    },
                    
                    getFilteredDataList() {
                        // 수동으로 필터링된 데이터 리스트 업데이트
                        this.visibleDataList = this.dataList.filter(item => {
                            return (
                                (!this.cust_nm || item.cust_nm.includes(this.cust_nm)) &&
                                (!this.pic_nm || item.pic_nm.includes(this.pic_nm)) &&
                                (!this.rrno || item.rrno.includes(this.rrno)) &&
                                (!this.dept_nm || item.dept_nm.includes(this.dept_nm))
                            );
                        });
                    },
                    search() {
                        this.getFilteredDataList(); // 검색 조건에 맞게 필터링된 데이터 표시
                    },
                    updateData(newData) {
                        this.dataList = newData;
                        this.getFilteredDataList(); // 데이터 업데이트 후 필터링 수행
                    },
                  //고객변경
                    custUpdate() {
                        // 모든 필드가 비어 있는지 확인하는 조건 추가
                        if (!this.selectedCustomer.cust_nm.trim() ||
                            !this.selectedCustomer.wrt_dt.trim() ||
                            !this.selectedCustomer.rrno.trim() ||
                            !this.selectedCustomer.cust_eml_addr.trim() ||
                            !this.selectedCustomer.co_telno.trim() ||
                            !this.selectedCustomer.cust_mbl_telno.trim() ||
                            !this.selectedCustomer.occp_ty_cd_nm.trim() ||
                            !this.selectedCustomer.cust_addr.trim()) {
                            alert("모든 필드를 채워주세요.");  // 오류 메시지 표시
                            return; // 조건이 만족되지 않으면 함수 실행 중단
                        }
                        var params = {
                            cust_nm: this.selectedCustomer.cust_nm,
                            wrt_dt: this.selectedCustomer.wrt_dt,
                            rrno: this.selectedCustomer.rrno,
                            cust_eml_addr: this.selectedCustomer.cust_eml_addr,
                            co_telno: this.selectedCustomer.co_telno,
                            cust_mbl_telno: this.selectedCustomer.cust_mbl_telno,
                            occp_ty_cd_nm: this.selectedCustomer.occp_ty_cd_nm,
                            cust_addr: this.selectedCustomer.cust_addr,
                        };
                        cf_ajax("/custMng/updateCust", params, this.changeStsCB);
                    },
                          // 고객 정보 삭제 메서드
                             custDelete: function () {
                                 var params = {
                                     cust_mbl_telno: this.selectedCustomer.cust_mbl_telno,
                                 };
                                 cf_ajax("/custMng/updateCustStcd", params, this.deleteStsCB);
                             },

                             // 변경 성공 콜백 메서드
                             changeStsCB: function (data) {
                                 if (data.status == "OK") {
                                     alert("고객정보 변경 완료");
/*                                      this.getCustInfoList(true); // 변경 후 고객 목록을 다시 불러옵니다. */
                                 }
                             },

                             // 삭제 성공 콜백 메서드
                             deleteStsCB: function (data) {
                                 if (data.status == "OK") {
                                     alert("고객정보 삭제 완료");
                                     this.getCustInfoList(true); // 삭제 후 고객 목록을 다시 불러옵니다.
                                 }
                             },

                 // 상담내역 수정 로직 추가
                    updateTskDtl: function () {
                        if (this.newTskDtl.trim()) {
                            this.selectedCustomer.tsk_dtl_cn = this.newTskDtl;
                            var params = {
                                cust_mbl_telno: this.selectedCustomer.cust_mbl_telno,
                                tsk_dtl_cn: this.selectedCustomer.tsk_dtl_cn,
                            };
                            cf_ajax("/custMng/updateCust", params, this.updateTskDtlCB);
                            this.newTskDtl = "";  // 수정 후 입력창 초기화
                        } else {
                            alert("수정할 상담내역을 입력해주세요.");
                        }
                    },

                    // 상담내역 업데이트 콜백
                    updateTskDtlCB: function(data) {
                        if (data.status == "OK") {
                            alert("상담내역 수정 완료");
                            this.getCustInfoList(true);  // 수정 후 고객 목록을 다시 불러옵니다.
                        }
                    },
                    
                    selectAll(event) {
                        const isChecked = event.target.checked;
                        this.allSelected = isChecked;
                        this.visibleDataList.forEach(item => item.isChecked = isChecked);
                    },
                
                    handleCheck: function (cust_mbl_telno) {
                        const checkbox = event.target;
                        checkbox.checked = !checkbox.checked; // 체크박스 상태 토글
                    },
                    
                    gotoDtl: function (cust_mbl_telno) {
                        var params = { cust_mbl_telno: cust_mbl_telno };
                        cf_ajax("/custMng/getInfo", params, function(data) {
                            vueapp.selectedCustomer = data;
                            // 팝업에서 불러온 상담내역을 고객 상세정보에도 반영
                            if (data.tsk_dtl_cn) {
                                vueapp.selectedCustomer.tsk_dtl_cn = data.tsk_dtl_cn;
                            }
                            console.log("Selected customer data:", vueapp.selectedCustomer);
                        });
                    },
                    
                    
                    clearSelectedCustomer: function () {
                        // selectedCustomer 객체 초기화
                        this.selectedCustomer = {
                            wrt_dt: "",
                            cust_nm: "",
                            rrno: "",
                            cust_eml_addr: "",
                            co_telno: "",
                            cust_mbl_telno: "",
                            occp_ty_cd_nm: "",
                            cust_addr: ""
                  	      };
                    },
                    sortList: function (obj) {
                        cf_setSortConf(obj, "cust_nm");
                        this.getCustInfoList();
                    },
                    sortListAll: function (obj) {
                        cf_setSortConf(obj, "cust_nm");
                        this.getCustInfoListAll();
                    },
                    all_check: function (obj) {
                        $('[name=is_check]').prop('checked', obj.checked);
                    },
                    onCheck: function (item, event) {
                    	this.gotoDtl(customer);
                    },
                    
                    
                    
                    // 관리대장 출력 기능
                    popCustmnglistPrint() {
                        const selectedItems = this.visibleDataList.filter(item => item.isChecked);
                        
                        if (selectedItems.length === 0) {
                            alert("출력할 대상을 선택하여 주십시오.");
                            return;
                        }

                        const dateCopyList = selectedItems.map(item => ({
                            cust_nm: item.cust_nm,
                            rrno: item.rrno,
                            cust_mbl_telno: item.cust_mbl_telno,
                            occp_ty_cd_nm: item.occp_ty_cd_nm,
                        }));

                        pop_cust_mnglist_print.init(dateCopyList);
                        $('#pop_cust_mnglist_print').modal('show');
                    },
                    
                    
                    // 관리카드 출력 기능
popCustmngCardPrint() {
    const selectedItems = this.visibleDataList.filter(item => item.isChecked);

    if (selectedItems.length === 0) {
        alert("출력할 대상을 선택하여 주십시오.");
        return;
    } else if (selectedItems.length > 1) {
        alert("출력할 대상을 한 개만 선택하여 주십시오.");
        return;
    }

    const dateCopyList = selectedItems.map(item => ({
        cust_nm: item.cust_nm,
        rrno: item.rrno,
        cust_mbl_telno: item.cust_mbl_telno,
        occp_ty_cd_nm: item.occp_ty_cd_nm,
    }));

    pop_cust_card_print.init(dateCopyList); // 데이터 전달
    $('#pop_cust_card_print').modal('show');
},
                    popDamdangSet() {
                        const selectedItems = this.visibleDataList.filter(item => item.isChecked);
                        
                        if (selectedItems.length === 0) {
                            alert("담당자 설정 대상을 선택하여 주십시오.");
                            return;
                        }

                        const dateCopyList = selectedItems.map(item => ({
                            cust_nm: item.cust_nm,
                            rrno: item.rrno,
                            cust_mbl_telno: item.cust_mbl_telno,
                            occp_ty_cd_nm: item.occp_ty_cd_nm,
                            isChecked: item.isChecked
                        }));
                        console.log("선택된 고객 데이터:", dateCopyList);  // 디버깅용 출력

                        pop_damdang_set.init(dateCopyList);
                        $('#pop_damdang_set').modal('show');
                    },
                    
                    
                    custInfoMng: function () {
                        cf_movePage('/custMng/custInfoMng');
                    },
                    picInfoMng: function () {
                        cf_movePage('/custMng/picInfoMng');
                    },
                },
            });

            var pop_cust_info = new Vue({
                el: "#pop_cust_info",
                data: {
                    info: {
                        cust_mbl_telno: "${cust_mbl_telno}",
                        wrt_dt: "",
                        cust_nm: "",
                        rrno: "",
                        cust_eml_addr: "",
                        co_telno: "",
                        occp_ty_cd_nm: "",
                        cust_addr: "",
                        tsk_dtl_cn: "",
                    }
                },
                methods: {
                	init: function (dateCopyList) {
                	    if (dateCopyList && dateCopyList.length > 0) {
                	        this.info = { ...dateCopyList[0] };  // 첫 번째 항목의 데이터를 info에 할당
                	        console.log("Initialized info:", this.info);  // 초기화 후 데이터 출력

                	        this.info.cust_mbl_telno = dateCopyList[0].cust_mbl_telno;
                	        if (!cf_isEmpty(this.info.cust_mbl_telno)) {
                	            this.getCustCardInfo();
                	        }
                	    } else {
                	        console.log("데이터가 없습니다.");  // 데이터가 없을 경우 경고
                	    }
                	},
                    initInfo: function () {
                        this.info = {
                            cust_mbl_telno: "",
                            wrt_dt: "",
                            cust_nm: "",
                            rrno: "",
                            cust_eml_addr: "",
                            co_telno: "",
                            occp_ty_cd_nm: "",
                            cust_addr: "",
                            tsk_dtl_cn: "",
                        }
                    },
                    getInfo: function () {
                        var params = {
                            cust_mbl_telno: this.info.cust_mbl_telno,
                        }
                        cf_ajax("/custMng/getInfo", params, this.getInfoCB);
                    },
                    getInfoCB: function (data) {
                        this.info = data;
                        // 고객 상세정보의 상담내역을 업데이트
                        vueapp.selectedCustomer.tsk_dtl_cn = data.tsk_dtl_cn;
                    },
                },
            });

            var pop_cust_mnglist_print = new Vue({
                el: "#pop_cust_mnglist_print",
                data: {
                    printInfo: {
                        custCount: 0,
                        custList: [],
                    }
                },
                methods: {
                    init: function (dateCopyList) {
                        this.initInfo(dateCopyList);
                    },
                    initInfo: function (dateCopyList) {
                        this.printInfo = {
                            custCount: dateCopyList.length,
                            custList: dateCopyList,
                        }
                    },
                    print: function () {
                        const printArea = document.getElementById('cust_mnglist_printArea').innerHTML;
                        console.log(printArea);

                        win = window.open();
                        self.focus();
                        win.document.open();

                        /*
                        1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
                        2. window.open() 을 사용하여 새 팝업창을 띄운다.
                        3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
                        4. <body> 안에 매개변수로 받은 printArea를 추가한다.
                        5. window.print() 로 인쇄
                        6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
                        */
                        win.document.write('<html><head>');

                        /*
                        win.document.write('<link rel="icon" href="/static_resources/system/images/favicon.ico">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/font-icons/entypo/css/entypo.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/lib/fonts/font-awesome-4.7.0/css/font-awesome.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-core.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-theme.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-forms.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/custom.css">');
                        */

                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

                        win.document.write('<title></title><style>');
                        win.document.write('td.center {text-align: center;}');
                        win.document.write('th.center {text-align: center;}');
                        win.document.write('body {font-size: 14px;}');
                        //win.document.write('body, td {font-falmily: Verdana; font-size: 10pt;}');
                        win.document.write('</style></head><body>');
                        win.document.write(printArea);
                        win.document.write('</body></html>');
                        win.document.close();
                        win.print();
                        win.close();

                    },
                },
            });

            var pop_cust_card_print = new Vue({
                el: "#pop_cust_card_print",
                data: {
                    info: {
                        cust_mbl_telno: "",
                        cust_nm: "",
                        rrno: "",
                        cust_eml_addr: "",
                        co_telno: "",
                        occp_ty_cd_nm: "",
                        cust_addr: "",
                        pic_nm: "",
                        dept_nm: "",
                        jbps_ty_cd_nm: "",
                        pic_mbl_telno: "",
                        tsk_dtl_cn: "",
                    }
                },
                
                methods: {
                	init: function (dateCopyList) {
                	    if (dateCopyList && dateCopyList.length > 0) {
                	        this.info = { ...dateCopyList[0] };  // 첫 번째 항목의 데이터를 info에 할당
                	        console.log("Initialized info:", this.info);  // 초기화 후 데이터 출력

                	        this.info.cust_mbl_telno = dateCopyList[0].cust_mbl_telno;
                	        if (!cf_isEmpty(this.info.cust_mbl_telno)) {
                	            this.getCustCardInfo();
                	        }
                	    } else {
                	        console.log("데이터가 없습니다.");  // 데이터가 없을 경우 경고
                	    }
                	},
                    initInfo: function () {
                        this.info = {
                            cust_nm: "",
                            rrno: "",
                            cust_mbl_telno: "",
                            cust_eml_addr: "",
                            co_telno: "",
                            occp_ty_cd_nm: "",
                            cust_addr: "",
                            pic_nm: "",
                            dept_nm: "",
                            jbps_ty_cd_nm: "",
                            pic_mbl_telno: "",
                            tsk_dtl_cn: "",
                        }
                    },
                    getCustCardInfo: function () {
                        var params = {
                            cust_mbl_telno: this.info.cust_mbl_telno,
                        };

                        console.log("Requesting customer info with params:", params);  // API 호출 전 파라미터 확인

                        cf_ajax("/custMng/getCustCardInfo", params, this.getInfoCB);
                    },
                    getInfoCB: function (data) {
                        console.log("Received data from server:", data);  // 서버로부터 받은 데이터를 출력

                        this.info.cust_nm = data.cust_nm || '';  // 고객명
                        this.info.rrno = data.rrno || '';  // 실명번호
                        this.info.cust_eml_addr = data.cust_eml_addr || '';  // 이메일
                        this.info.co_telno = data.co_telno || '';  // 전화번호
                        this.info.cust_mbl_telno = data.cust_mbl_telno || '';  // 핸드폰
                        this.info.occp_ty_cd_nm = data.occp_ty_cd_nm || '';  // 직업
                        this.info.cust_addr = data.cust_addr || '';  // 주소
                        this.info.pic_nm = data.pic_nm || '';  // 담당자명
                        this.info.dept_nm = data.dept_nm || '';  // 부서명
                        this.info.jbps_ty_cd_nm = data.jbps_ty_cd_nm || '';  // 직위
                        this.info.pic_mbl_telno = data.pic_mbl_telno || '';  // 담당자 연락처
                        this.info.tsk_dtl_cn = data.tsk_dtl_cn || '';  // 상담내역
                    },
                    
                    print_card: function () {
                        const printArea = document.getElementById('cust_mngcard_printArea').innerHTML;
                        console.log(printArea);

                        win = window.open();
                        self.focus();
                        win.document.open();

                        /*
                        1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
                        2. window.open() 을 사용하여 새 팝업창을 띄운다.
                        3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
                        4. <body> 안에 매개변수로 받은 printArea를 추가한다.
                        5. window.print() 로 인쇄
                        6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
                        */
                        //win.document.write('<html><head>');

                        /*
                        win.document.write('<link rel="icon" href="/static_resources/system/images/favicon.ico">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/font-icons/entypo/css/entypo.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/lib/fonts/font-awesome-4.7.0/css/font-awesome.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-core.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-theme.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/neon-forms.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/css/custom.css">');
                        */

                        // 			 win.document.write('<html><head>');

                        // 			 win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
                        // 			 win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
                        // 			 win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

                        // 			 win.document.write('<title></title><style>');	
                        // 			 win.document.write('td.center {text-align: center;}');
                        // 			 win.document.write('th.center {text-align: center;}');
                        // 			 win.document.write('body {font-size: 14px;}');
                        // 			 win.document.write('</style></head><body>');
                        // 			 win.document.write(printArea);
                        // 			 win.document.write('</body></html>');
                        // 			 win.document.close();  
                        // 			 win.print();
                        // 			 win.close();

                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
                        win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

                        win.document.write('<title></title><style>');
                        
                        win.document.write('td.center {text-align: center;}');
                        win.document.write('th.center {text-align: center;}');
                        win.document.write('body {font-size: 14px;}');
                        //win.document.write('body, td {font-falmily: Verdana; font-size: 10pt;}');
                        win.document.write('</style></head><body>');
                        win.document.write(printArea);
                        win.document.write('</body></html>');
                        win.document.close();
                        win.print();
                        win.close();
                    },
                },
            });

            var pop_damdang_set = new Vue({
                el: "#pop_damdang_set",
                data: {
                	visibleDataList: [], 
                    picInfo: {
                        //custCount : 0,
                        pic_nm: "",
                        dept_nm: "",
                        jbps_ty_cd_nm: "",
                        pic_mbl_telno: "",
                        pic_eml_addr: "",
                        jncmp_ymd: "",
                        etc_tsk_cn: "",
                        custList: [],
                    }
                },
                methods: {
                    showModal: function () {
                        this.$refs.modal.show();
                    },
                    hideModal: function () {
                        this.$refs.modal.hide();
                    },
                    loadData() {
                        axios.get('/api/getCustomers')
                            .then(response => {
                                if (Array.isArray(response.data)) {
                                    // 응답 데이터가 배열인 경우, 각 항목에 `isChecked` 속성을 추가
                                    this.visibleDataList = response.data.map(item => ({
                                        ...item,
                                        isChecked: false // 초기화
                                    }));
                                    console.log("visibleDataList 설정 완료:", this.visibleDataList); // 디버깅용 로그
                                } else {
                                    console.error("서버에서 반환된 데이터가 배열이 아닙니다:", response.data);
                                    this.visibleDataList = [];
                                }
                            })
                            .catch(error => {
                                console.error("데이터 로드 중 오류 발생:", error);
                                this.visibleDataList = [];
                            });
                    },
                	init: function (dateCopyList) {
                	    console.log("init 메서드 호출됨, 전달된 dateCopyList:", dateCopyList); // 디버깅용 로그

                	    this.initInfo(dateCopyList);
                	    this.visibleDataList = dateCopyList;  // visibleDataList에 dateCopyList 할당
                	    console.log("init 메서드 이후 visibleDataList 상태:", this.visibleDataList);
                	    this.getInitInfo();
                	},
                    initInfo: function (dateCopyList) {
                        this.picInfo = {
                            pic_nm: pic_nm,
                            dept_nm: dept_nm,
                            jbps_ty_cd_nm: jbps_ty_cd_nm,
                            pic_mbl_telno: pic_mbl_telno,
                            pic_eml_addr: pic_eml_addr,
                            jncmp_ymd: jncmp_ymd,
                            etc_tsk_cn: etc_tsk_cn,
                            custList: dateCopyList,
                        };
                        this.visibleDataList = dateCopyList;
                    },
                    getInitInfo: function () {
                        var params = {
                            pic_nm: "admin001",
                        }
                        cf_ajax("/custMng/getInitInfo", params, this.getInfoCB);
                    },
                    getInfoCB: function (data) {
                        this.picInfo.pic_nm = data.pic_nm;
                        this.picInfo.dept_nm = data.dept_nm;
                        this.picInfo.jbps_ty_cd_nm = data.jbps_ty_cd_nm;
                        this.picInfo.pic_mbl_telno = data.pic_mbl_telno;
                        this.picInfo.pic_eml_addr = data.pic_eml_addr;
                        this.picInfo.jncmp_ymd = data.jncmp_ymd;
                        this.picInfo.etc_tsk_cn = data.etc_tsk_cn;
                    },
                    popupPicInfo: function () {
                        console.log('Opening popup...');
                        pop_pic_info.init();
                        $('#pop_pic_info').modal('show').on('shown.bs.modal', function () {
                            console.log('Popup shown!');
                        });
                    },
                    getPicSelInfo: function (pic_nm) {
                        var params = {
                            pic_nm: pic_nm,
                        }
                        cf_ajax("/custMng/getInitInfo", params, this.getInfoCB);
                    },
                    popupPicClose: function () {
                        pop_pic_info.init();
                        $('#pop_pic_info').modal('hide');
                    },
                    all_check: function (obj) {
                        $('[name=is_check]').prop('checked', obj.checked);
                    },
                    onCheck: function () {
                        $("#allCheck").prop('checked',
                            $("[name=is_check]:checked").length === $("[name=is_check]").length
                        );
                    },
                    damdangSave: function () {
                        console.log("damdangSave 메서드 호출됨");

                        // visibleDataList 상태 확인
                        console.log("현재 visibleDataList 상태:", this.visibleDataList);

                        // 선택된 고객 필터링
                        const checkedCustomers = this.visibleDataList.filter(item => item.isChecked);

                        console.log("선택된 고객 리스트 (필터링 후):", checkedCustomers);  // 선택된 고객 리스트 확인

                        if (checkedCustomers.length === 0) {
                            alert("변경할 고객대상을 선택하여 주십시오.");
                            return;
                        }

                        // 서버로 보낼 데이터 구성
                        var params = {
                            dateCopyList: checkedCustomers,
                            pic_mbl_telno: this.picInfo.pic_mbl_telno,
                        };

                        console.log("전송할 데이터:", params);  // 서버로 전송할 데이터 확인

                        // 서버로 AJAX 요청 보내기
                        cf_ajax("/custMng/updatePicRoof", params, this.changeStsCB);
                    },
                    changeStsCB: function (data) {
                        console.log("서버 응답:", data);  // 디버깅용: 서버 응답 확인

                        if (data.status === "OK") {
                            alert("담당자 변경 완료");
                            $('#pop_damdang_set').modal('show'); // 모달 닫기
/*                             $('.modal-backdrop').modal('hide'); // 백드롭 제거 */
                            
                        } else {
                            alert("담당자 변경 실패. 다시 시도해 주세요.");
                        }
                    },
                    damdangDelete: function () {

                        var chkedList = $("[name=is_check]:checked");
                        if (chkedList.length == 0) {
                            alert("삭제할 고객대상을 선택하여 주십시오.");
                            return;
                        }

                        //check list 가져오기..
                        var dateCopyList = [];
                        var idx;
                        chkedList.each(function (i) {
                            idx = $(this).attr("data-idx");
                            dateCopyList.push(pop_damdang_set.picInfo.custList.getElementFirst("cust_nm", idx));
                        });

                        var params = {
                            dateCopyList: dateCopyList,
                        }
                        cf_ajax("/custMng/updateStcdRoof", params, this.changeStsCB);
                    },
                },
            });

            var pop_pic_info = new Vue({
                el: "#pop_pic_info",
                data: {
                    dataList: [],
                },
                methods: {
                    init: function () {
                    	this.dataList = [];
                        this.getPicInfo();
                    },
                    getPicInfo: function () {
                        
                        var params = {
                            pic_nm: " ",
                        }

                        cf_ajax("/custMng/getPicInfo", params, function (data) {
                            pop_pic_info.dataList = data;
                            console.log("Data loaded for popup:", data);
                        });
                    },
                    selItem: function (pic_nm) {

                        //$('#pop_pic_info').modal('hide');
                        $('#pop_pic_info').hide();
  /*                       $('.modal-backdrop').remove(); // 백드롭 제거 */
                        pop_damdang_set.getPicSelInfo(pic_nm);
                    },
                    mounted() {
                        this.init();
                        var self = this;
                        $('#pop_pic_info').on('hidden.bs.modal', function () {
                            // 모달이 닫힐 때 데이터를 다시 초기화
                            self.init();
                        });

                        // 모달을 열 때 초기화 수행
                        $('#pop_pic_info').on('show.bs.modal', function () {
                            self.getPicInfo();
                        });
                    },
                },
            });
           
        </script>

</html>

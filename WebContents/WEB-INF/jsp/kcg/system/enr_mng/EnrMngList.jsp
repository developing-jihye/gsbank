<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/datatables/enrmnglist.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	<title>관리자시스템</title>
</head>
<body class="page-body">


<div class="page-container">


<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>


	
		
	    <div class="main-content">
		
		
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>상품 가입</strong></li>
		</ol>
		
		
		<h2>상품 가입</h2>
		<br />
		
		
		
		<div class="container" id="vueapp">
         <div class="left">
         
         
         <div class="form-group2">
                <label for="prodCode" class="form-control">고객:</label>
                <select
									v-model="sbstg_ty_cd" class="form-control">
									
									<!-- <option value="0">전체</option> -->
									
									<option value="1">일반개인</option>
									<option value="2">청년생활지원</option>
								</select>
            </div>
            
              <div class="form-group2">
                <label for="prodCode" class="form-control">상품:</label>
                <select
									v-model="sbstg_ty_cd" class="form-control">
									
									<!-- <option value="0">전체</option> -->
									
									<option value="1">일반개인</option>
									<option value="2">청년생활지원</option>
								</select>
								 </div>
								
								
		
		    <div class="Align_A">
            
            <button type="button"
							class="btn btn-blue"
							@click="getListCond(true)">
							가입하기
						</button>
						</div>
				        
          
   
         </div>
          <div class="right">
          
          
         
        <div class="table-container" style="max-height: 580px; overflow-y: auto; border: 1px solid #999999;">
    <table class="table table-bordered datatable dataTable custom-table"
        id="grid_app" style="width: 100%; border-collapse: collapse;">
        <thead>    
            <tr class="replace-inputs">
                <th style="width: 4%;" class="center hidden-xs nosort">
                    <input type="checkbox" id="allCheck">
                </th>
                <th style="width: 24%;" class="center">가입ID</th>
                <th style="width: 24%;" class="center">고객이름</th>
                <th style="width: 24%;" class="center">상품명</th>
                <th style="width: 24%;" class="center">가입날짜</th>
                </tr>
        </thead>
        <tbody>
        
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 A</td>
                <td class="center center-align">대상 A</td>
                <td class="center center-align">주기 A</td>
                <td class="center center-align">5%</td>
                         </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 B</td>
                <td class="center center-align">대상 B</td>
                <td class="center center-align">주기 B</td>
                <td class="center center-align">6%</td>
                           </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 C</td>
                <td class="center center-align">대상 C</td>
                <td class="center center-align">주기 C</td>
                <td class="center center-align">7%</td>
                          </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 D</td>
                <td class="center center-align">대상 D</td>
                <td class="center center-align">주기 D</td>
                <td class="center center-align">8%</td>
                         </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 E</td>
                <td class="center center-align">대상 E</td>
                <td class="center center-align">주기 E</td>
                <td class="center center-align">9%</td>
                           </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 F</td>
                <td class="center center-align">대상 F</td>
                <td class="center center-align">주기 F</td>
                <td class="center center-align">10%</td>
                           </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 G</td>
                <td class="center center-align">대상 G</td>
                <td class="center center-align">주기 G</td>
                <td class="center center-align">11%</td>
                          </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 H</td>
                <td class="center center-align">대상 H</td>
                <td class="center center-align">주기 H</td>
                <td class="center center-align">12%</td>
                           </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 I</td>
                <td class="center center-align">대상 I</td>
                <td class="center center-align">주기 I</td>
                <td class="center center-align">13%</td>
                            </tr>
            <tr>
                <td class="center">
                    <input type="checkbox" name="is_check">
                </td>
                <td class="center center-align">상품 J</td>
                <td class="center center-align">대상 J</td>
                <td class="center center-align">주기 J</td>
                <td class="center center-align">14%</td>
                         </tr>
        </tbody>
    </table>
</div>

	<div style="height: 15px;"></div>

 <div class="flex flex-100 flex-padding-10 flex-gap-10 white-background"
						style="justify-content: flex-end; border: 1px solid #999999;">
						
						
						
												<button type="button"
							class="btn btn-orange btn-small align11"
							@click="cf_movePage('/prod_mng/dtl')">
							삭제
						</button>
				
					</div>

         
          
          
		 </div>
		 
	

 </div>


</div>


</div>







</body>
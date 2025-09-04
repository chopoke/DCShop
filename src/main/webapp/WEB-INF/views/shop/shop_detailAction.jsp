<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><c:out value="${dto.pd_name}"/> 상세보기</title>

<!-- CSS -->
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/product/product_detail.css'/>?v=20250825">

<!-- JS -->
<script defer src="<c:url value='/resources/js/product/product_detail.js'/>"></script>
</head>

<body class="product-detail-page">
  <div class="wrap">
    <%@ include file="/WEB-INF/views/setting/header.jsp" %>

    <div id="container">
      <div id="contents">

        <div id="section2">
          <div id="right">
          	<div class="center">

              <%-- 이미지 URL : 절대경로/리소스경로/파일명만 저장된 경우 처리 --%>
              <c:set var="img" value="/resources/img/no-image.png"/>
              <c:if test="${not empty dto.pd_image_url}">
                <c:choose>
                  <c:when test="${fn:startsWith(dto.pd_image_url,'http://')
                                 or fn:startsWith(dto.pd_image_url,'https://')
                                 or fn:startsWith(dto.pd_image_url,'/resources/')}">
                    <c:set var="img" value="${dto.pd_image_url}"/>
                  </c:when>
                  <c:otherwise>
                    <c:set var="img" value="/resources/img_product/${dto.pd_image_url}"/>
                  </c:otherwise>
                </c:choose>
              </c:if>
              
              <%-- 할인 가격 계산 --%>
			 <c:set var="rate" value="${empty dto.pd_discount_rate ? 0 : dto.pd_discount_rate}" />
			 <c:set var="hasDiscount" value="${rate gt 0 and rate lt 100}" />
			 <c:set var="discPriceInt" value="${ (dto.pd_price * (100 - rate)) div 100 }" />
			 
			 <%-- ★ 평균 별점/리뷰수 계산 --%>
			 <c:set var="revCount" value="${empty reviews ? 0 : fn:length(reviews)}"/>  <!-- 리뷰가 0이면 0반환 / 리뷰가 있으면 reviews의 length반환 -->
			 <c:set var="sumScore" value="0"/>
			 <c:forEach var="r" items="${reviews}">
			   <c:set var="sumScore" value="${sumScore + r.r_score}"/> <!-- reviews를 돌면서 r.r_score(리뷰 점수)를 더해서 sumScore에 누적 -->
			 </c:forEach>
			 <%-- 0~5 반올림 정수: (평균*100 + 50) / 100  → 정수 별 개수 --%>
			 <!-- revCount(리뷰)가 1개이상이면 계산, 그렇지 않으면 0으로 설정 -->
			 <c:set var="avg" value="${revCount > 0 ? (sumScore / revCount) : 0}"/> 
			 <!-- avg * 100 => 소수점 둘째자리까지 처리 / + 50 => 반올림하기 위해 더해주는 값 / div 100 => 정수 나눗셈 -->
			 <c:set var="avgRounded" value="${(avg * 100 + 50) div 100}"/>
			 
              <table class="product-detail-2col">
				  <tr>
				    <!-- 왼쪽: 상품 이미지 -->
				    <td class="left image-cell">
				      <img src="<c:url value='${dto.pd_image_url}'/>" alt="<c:out value='${dto.pd_name}'/>" class="pd-photo">
				    </td>
				
				    <!-- 오른쪽: 상세 정보 + 버튼 -->
				    <td class="right">
				      <h2 class="pd-title"><c:out value="${dto.pd_name}"/></h2>
				      
				    <div class="pd-rating" aria-label="평균 별점 ${avgRounded} / 5">
					  <div class="stars">
					    <c:forEach var="i" begin="1" end="5">
					      <span class="star ${i <= avgRounded ? 'on' : ''}">★</span> <!-- avgRounded(평균 별점)이 1~5사이면 on클래스가 되서 채워진 별로 보이게 -->
					    </c:forEach>
					  </div>
					  <span class="reviews count">
						  (<c:out value="${revCount}"/>개 리뷰)
					  </span>
					</div>
				
				      <table class="kv">
				        <tr>
				          <th>상품번호</th>
				          <td><c:out value="${dto.pd_id}"/></td>
				        </tr>
				        
				        <tr>
				          <th>브랜드</th>
				          <td><c:out value="${dto.pd_brand}"/></td>
				        </tr>
				        
				        <tr>
				          <th>카테고리</th>
				          <td>
				            <c:choose>
				              <c:when test="${dto.pd_category == 1}">간식</c:when>
				              <c:when test="${dto.pd_category == 2}">위생</c:when>
				              <c:when test="${dto.pd_category == 3}">장난감</c:when>
				              <c:when test="${dto.pd_category == 4}">이동장</c:when>
				              <c:when test="${dto.pd_category == 5}">의류</c:when>
				              <c:otherwise>기타 (<c:out value="${dto.pd_category}"/>)</c:otherwise>
				            </c:choose>
				          </td>
				        </tr>
				        
						<tr>
						  <th>가격</th>
						  <td class="price-val">
						    <c:choose>
						      <c:when test="${hasDiscount}">
						        <span class="price-now money">
						          <fmt:formatNumber value="${discPriceInt}" type="number" maxFractionDigits="0"/> 원  <%-- maxFractionDigits="0" → 소수점 완전히 제거 --%>
						        </span>
						        <s class="price-old money">
						          <fmt:formatNumber value="${dto.pd_price}" type="number" maxFractionDigits="0"/> 원
						        </s>
						      </c:when>
						      <c:otherwise>
						        <span class="price-now money">
						          <fmt:formatNumber value="${dto.pd_price}" type="number" maxFractionDigits="0"/> 원
						        </span>
						      </c:otherwise>
						    </c:choose>
						  </td>
						</tr>
						
				        <tr>
				          <th>재고수량</th>
				          <td><c:out value="${dto.pd_stock}"/> 개</td>
				        </tr>
				        
				        <tr>
				          <th>배송비</th>
				          <td>
				            <c:choose>
				              <c:when test="${dto.pd_shipping_fee == 0}">무료배송</c:when>
				              <c:otherwise><fmt:formatNumber value="${dto.pd_shipping_fee}" type="number"/> 원</c:otherwise>
				            </c:choose>
				          </td>
				        </tr>
				        
				        <tr>
				          <th>할인율</th>
				          <td><c:out value="${dto.pd_discount_rate}"/>%</td>
				        </tr>
				        
				        <tr>
				          <th>상태</th>
				          <td><c:out value="${dto.pd_status}"/></td>
				        </tr>
				        
				        <tr>
				          <th>옵션</th>
				          <td><c:out value="${dto.pd_option}"/></td>
				        </tr>
				        
				        <tr>
				          <th>등록일</th>
				          <td><fmt:formatDate value="${dto.pd_created}" pattern="yyyy-MM-dd HH:mm"/></td>
				        </tr>
				        
				        <tr>
				          <th>수정일</th>
				          <td><fmt:formatDate value="${dto.pd_updated}" pattern="yyyy-MM-dd HH:mm"/></td>
				        </tr>
				      </table>
				
				      <div class="actions actions-main">
						  <button type="button"
						          class="btn-primary"
						          onclick="location.href='${path}/cart.do?pdId=${dto.pd_id}&qty=3'">장바구니 담기</button>
						
						  <button type="button"
						          class="btn-secondary"
						          onclick="location.href='${path}/order/now.do?pd_id=${dto.pd_id}&qty=1'">바로구매</button>
						</div>
					 </td>
					</tr>	
					
					<!-- 상품목록 -->
					<tr>
					  <td colspan="2">
					    <div class="actions-sub">
					      <button type="button"
					              class="btn-list"
					              onclick="location.href='${path}/ad_product_list.pd'">상품목록</button>
					    </div>
					  </td>
					</tr>
					
				</table>
				
				<div class="pd-bottom">
				  <nav class="pd-tabs" role="tablist" aria-label="상품 정보 탭">
				    <button class="tab is-active" role="tab"
				            aria-selected="true" aria-controls="panel-desc" id="tab-desc">상세설명</button>
				    <button class="tab" role="tab"
				            aria-selected="false" aria-controls="panel-rev" id="tab-rev">리뷰</button>
				    <button class="tab" role="tab"
				            aria-selected="false" aria-controls="panel-qa" id="tab-qa">Q&A</button>
				  </nav>
				
				  <!-- 상세설명 -->
				  <section id="panel-desc" class="pd-panel active" role="tabpanel" aria-labelledby="tab-desc">
					  <pre class="pd-desc-block"><c:out value="${dto.pd_description}"/></pre>
				  </section>
				
				  <!-- 리뷰 목록 -->
				  <section id="panel-rev" class="pd-panel" role="tabpanel" aria-labelledby="tab-rev">
				    <c:choose>
				      <c:when test="${empty reviews}">
				        <p class="empty">아직 등록된 리뷰가 없습니다.</p>
				        <a class="link" href="<c:url value='/review_insert.bc'/>?pd_id=${dto.pd_id}">리뷰 작성하기</a>
				      </c:when>
				      <c:otherwise>
				        <ul class="review-list">
				          <c:forEach var="r" items="${reviews}">
				            <li class="review">
				              <div class="pd-rating" aria-label="평균 별점 ${avg05} / 5">
                 <span class="rating-stars">
                   <!-- 꽉 별 -->
                   <c:forEach begin="1" end="${fullStars}">
                     <i class="fa-solid fa-star on"></i>
                   </c:forEach>
               
                   <!-- 반 별 -->
                   <c:if test="${halfStar == 1}">
                     <i class="fa-solid fa-star-half-stroke on"></i>
                   </c:if>
               
                   <!-- 빈 별 -->
                   <c:forEach begin="1" end="${emptyStars}">
                     <i class="fa-regular fa-star"></i>
                   </c:forEach>
                 </span>
               
                  <span class="reviews count">(${revCount}개 리뷰)</span>
               </div>
				            </li>
				          </c:forEach>
				        </ul>
				      </c:otherwise>
				    </c:choose>
				    
				    <c:set var="ctx" value="${pageContext.request.contextPath}" />
 				    <c:set var="pid" value="${dto.pd_id}" />
 				    
 				     <!-- 리뷰 목록 이동 -->
					  <a href="${ctx}/review/list.do?pd_id=${pid}">리뷰 목록</a>
					
					  <!-- 리뷰 작성 폼 -->
					  <form action="${ctx}/review/insert.do" method="post">
					    <input type="hidden" name="pd_id" value="${pid}">
					    
					  </form>
				  </section>
				
				  <!-- Q&A (자리만) -->
				  <section id="panel-qa" class="pd-panel" role="tabpanel" aria-labelledby="tab-qa">
				    <p class="empty">문의가 없습니다.</p>
				    <a class="link" href="${path}/qna/write.do?pd_id=${dto.pd_id}">문의 작성하기</a>
				  </section>
				</div>
				<!-- ▲▲▲ 여기까지 추가 ▲▲▲ -->

            </div>

          </div>
        </div>

      </div>
    </div>

    <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
  </div>
</body>
</html>
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
<link rel="stylesheet" href="<c:url value='/resources/css/product/product_detail.css'/>?v=20250825">

<!-- JS -->
<script defer src="<c:url value='/resources/js/product/product_detail.js'/>"></script>
<script src="https://kit.fontawesome.com/7e22bb38b7.js" crossorigin="anonymous"></script>

<!-- 선택 수량 읽어서 URL에 포함 -->
<script>
  /* 입력값을 읽고 min/max 범위로 보정 후 반환 */
  function getQty() {
    var el  = document.getElementById('qtyInput');
    if (!el) return 1;
    var v   = parseInt(el.value, 10);
    var min = parseInt(el.min || '1', 10);
    var max = parseInt(el.max || '9999', 10);

    if (isNaN(v) || v < min) v = min;
    if (!isNaN(max) && v > max) v = max;
    el.value = v;
    return v;
  }
  /* +/− 버튼이 호출. 현재 수량에 증감을 적용 */
  function chgQty(delta) {
    var el = document.getElementById('qtyInput');
    if (!el || el.disabled) return;
    var v = getQty() + delta;

    var min = parseInt(el.min || '1', 10);
    var max = parseInt(el.max || '9999', 10);
    if (v < min) v = min;
    if (v > max) v = max;
    el.value = v;
  }
  /* qty를 쿼리에 붙여 장바구니 URL로 이동 */
  function addToCart(pdId) {
    var qty = getQty();
    location.href = '${path}/cart.do?pdId=' + pdId + '&qty=' + qty;
  }
  /* “바로구매” URL 이동 */
  function orderNow(pdId) {
    var qty = getQty();
    location.href = '${path}/cartTOPay.do?pdId=' + pdId + '&qty=' + qty;
  }
</script>
</head>
<body class="product-detail-page">
  <div class="wrap">
    <%@ include file="/WEB-INF/views/setting/header.jsp" %>

	<section class="hero-section1">
	</section>
    <div id="container">
      <div id="contents">
        <div id="section2">
          <div id="right">
          	<div class="center">

              <%-- 이미지 URL : 절대경로/리소스경로/파일명만 저장된 경우 처리 --%>
              <%-- 저장된 값이 절대경로/리소스경로면 그대로, 파일명만 있으면 우리 폴더를 붙여 완성 --%>
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
			 
              <table class="product-detail-2col">
				  <tr>
				    <!-- 왼쪽: 상품 이미지 -->
				    <td class="left image-cell">
				      <img src="<c:url value='${dto.pd_image_url}'/>" alt="<c:out value='${dto.pd_name}'/>" class="pd-photo">
				    </td>
				
				    <!-- 오른쪽: 상세 정보 + 버튼 -->
				    <td class="right">
				      <h2 class="pd-title"><c:out value="${dto.pd_name}"/></h2>
				      
				    <fmt:formatNumber value="${avgScore}" maxFractionDigits="1" minFractionDigits="1" var="avgDisp"/>
					
					<div class="pd-rating" aria-label="평균 별점 ${avgDisp} / 5">
					  <div class="stars">
					    <!-- 꽉 별 -->
					    <c:forEach var="i" begin="1" end="${fullStars}">
					      <span class="star full">★</span>
					    </c:forEach>
					
					    <!-- 반 별 -->
					    <c:if test="${halfStar == 1}">
					      <span class="star half">★</span>
					    </c:if>
					
					    <!-- 빈 별 -->
						<c:forEach var="i" begin="1" end="${emptyStars}">
						  <span class="star empty">☆</span>
						</c:forEach>
					  </div>
					  <span class="reviews count">(${revCount}개 리뷰)</span>
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
						          <fmt:formatNumber value="${discPriceInt}" type="number" maxFractionDigits="0"/>원  <%-- maxFractionDigits="0" → 소수점 완전히 제거 --%>
						        </span>
						        <s class="price-old money">
						          <fmt:formatNumber value="${dto.pd_price}" type="number" maxFractionDigits="0"/>원
						        </s>
						      </c:when>
						      <c:otherwise>
						        <span class="price-now money">
						          <fmt:formatNumber value="${dto.pd_price}" type="number" maxFractionDigits="0"/>원
						        </span>
						      </c:otherwise>
						    </c:choose>
						  </td>
						</tr>
						
						<c:set var="hasStock" value="${dto.pd_stock gt 0}" />
						
				        <tr>
						  <th>수량</th>
						  <td>
						    <div class="qty">
						      <button type="button" class="qty-btn" onclick="chgQty(-1)" <c:if test="${!hasStock}">disabled</c:if>>−</button>
						
						      <input type="number" id="qtyInput" name="qty"
						             value="1" min="1" step="1"
						             <c:if test="${hasStock}">max="${dto.pd_stock}"</c:if>
						             <c:if test="${!hasStock}">disabled</c:if> />
						
						      <button type="button" class="qty-btn" onclick="chgQty(1)" <c:if test="${!hasStock}">disabled</c:if>>+</button>
						
						      <c:if test="${hasStock}">
						        <span class="qty-hint">(재고 <fmt:formatNumber value="${dto.pd_stock}" type="number"/>개)</span>
						      </c:if>
						      <c:if test="${!hasStock}">
						        <span class="qty-hint soldout">품절</span>
						      </c:if>
						    </div>
						  </td>
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
						 <button type="button" class="btn-primary" onclick="addToCart(${dto.pd_id})"
       						 <c:if test="${!hasStock}">disabled</c:if>>
						 	 장바구니 담기
						</button>

						<button type="button" class="btn-secondary" onclick="orderNow(${dto.pd_id})"
						        <c:if test="${!hasStock}">disabled</c:if>>
						  		바로구매
						</button>
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
				  <c:set var="ctx" value="${pageContext.request.contextPath}" />
				  <c:set var="pid" value="${dto.pd_id}" />
				  
				    <c:choose>
					  <c:when test="${empty recentReviews}">
					    <p class="empty">아직 등록된 리뷰가 없습니다.</p>
					    <a class="link" href="<c:url value='/review_insert.bc'/>?pd_id=${pid}">리뷰 작성하기</a>
					  </c:when>
				      <c:otherwise>
					    <%-- 최신 리뷰 5개 --%>
					    <ul class="recent-reviews">
					      <c:forEach var="r" items="${recentReviews}">
					        <li class="rv-item">
					          <c:if test="${not empty r.r_img}">
					            <a href="<c:url value='/review_detailAction.bc'/>?r_num=${r.r_num}">
					              <img class="rv-thumb"
					                   src="<c:url value='/resources/upload/review/${r.r_img}'/>"
					                   alt="리뷰 이미지">
					            </a>
					          </c:if>
					
					          <div class="rv-meta">
					            <div class="rv-stars" aria-label="별점 ${r.r_score}">
								  <c:forEach var="i" begin="1" end="5">
								    <i class="${i <= r.r_score ? 'fa-solid' : 'fa-regular'} fa-star"></i>
								  </c:forEach>
								</div>
					            <div class="rv-text"><c:out value="${r.r_content}"/></div>
					            <div class="rv-date">
					              <fmt:formatDate value="${r.r_regDate}" pattern="yyyy-MM-dd"/>
					            </div>
					           </div>
					        </li>
					      </c:forEach>
					    </ul>
					
					    <%-- 전체 보기 & 작성 --%>
					    <div class="review-actions text-right" style="margin-top:8px">
						  <a href="<c:url value='/review_list.bc'/>?pd_id=${pid}" class="btn-review-list">리뷰 전체보기</a>
						  <a href="<c:url value='/review_insert.bc'/>?pd_id=${pid}" class="btn-review-write">리뷰 작성</a>
						</div>
					  </c:otherwise>
					 </c:choose>
				    
					  <!-- 리뷰 작성 폼 -->
					  <form action="${ctx}/review/insert.do" method="post">
					    <input type="hidden" name="pd_id" value="${pid}">
					  </form>
				  </section>
				
				  <!-- Q&A -->
				  <section id="panel-qa" class="pd-panel" role="tabpanel" aria-labelledby="tab-qa">
				    
				    <!-- qna.jsp로 상품 번호(pd_id) 넘김. -->
				    <%-- qna.jsp는 ${path가 아닌} 상세경로로 지정해주기. --%>
				  	<jsp:include page="/WEB-INF/views/shop/qna.jsp">
					    <jsp:param name="pd_id" value="${dto.pd_id}"></jsp:param>
					</jsp:include>
					
				  </section>
				</div>

            </div>
          </div>
        </div>
      </div>
    </div>

    <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
  </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<script type="text/javascript">
	function openCheckout(el) {
		
		const d = el.dataset;
	
		const f = document.createElement('form');
		f.method = 'POST';
		f.action = CTX + '/ad_shop_detailAction.pd';
		
		addHidden(f, 'pdId', d.pdId);
	   
	    document.body.appendChild(f);
	    f.submit();
	}
	
	function addHidden(form, name, value){
  	  const i = document.createElement('input');
  	  i.type = 'hidden';
  	  i.name = name;
  	  i.value = value;
  	  form.appendChild(i);
  	  
	}
  	  ///////////////////////////////////////////
  	  // 장바구니 담기(product main에서)
  	async function addToCart(ev, pdId){
	    ev.preventDefault();			// <a>태그나 href로 연결된 동작을 막음
	    ev.stopPropagation();			// 상위 엘리먼트에 이벤트가 전달되는 것을 막음. (다음 이벤트 중단)

	    try {

	      // x-www-form-urlencoded (Spring @RequestParam로 값을 받기 위해
	      const params = new URLSearchParams();
	      params.append('pd_id', pdId);   // 컨트롤러가 pd_id 받는 경우
	      params.append('pdId', pdId);    // 컨트롤러가 pdId 받는 경우 대비 (둘 다 보냄)
	      params.append('qty', 1);		// 수량

	      let res = await fetch(CTX + '/cart.do', {		// 네트워크 요청이 끝날 때 까지 함수만 멈추고, 응답 오면 함수를 이어서 재개
	        method: 'POST',
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
	        body: params.toString(),
	        redirect: 'follow'			// fecth함수의 기본값이자 , 30x 에러가 떴을때 대응책 -> res.redirected, res.url로 설정한 곳으로 이동
	      });

	      // 로그인 필요(30x 에러시 대응책)
	      if (res.redirected && /login/i.test(res.url)) {		
	        showToast('로그인이 필요합니다.');
	        return false;
	      }

	      if (!res.ok) {		// res의 응답이 200~299명 true -> 앞에서 300~은 감지했으니 400~500에러가 잡히는 부분
	        const txt = await res.text().catch(()=> '');		// 서버의 응답을 문자열로 받기	(1회소모인 response body의 응답을 안전하게 받기 위해 추가로 catch사용)
	        console.error('addToCart failed:', res.status, txt);		// 로그확인용
	        showToast('장바구니 담기 실패 😥 (' + res.status + ')');			// 토스트로 띄워주기!
	        return false;		// anync 함수라 실제론 promise(false)리턴. (이미 프맆벤트디펄트로 기본 액션을 막아두었기 때무넹 큰 의미 없음)
	      }

	      // 성공! 토스트 출력
	      showToast('장바구니에 담겼습니다.');
	    } catch (e) {
	      console.error(e);
	      showToast('장바구니 담기 실패 😥 (네트워크)');		// fetch자체가 reject될때 네트워크 문제임을 알리기 위함
	    }
	    return false;
	  }

	  // 화면 중앙 하단 토스트
	  function showToast(msg){
	    let t = document.getElementById('toast');		// 토스트 만들어주기
	    if (!t) {							// 토스트가 없다면 생성	-> 싱클톤 사용하여 여러개 만들지 않도록 유지 (재사용시 텍스트 텊어쓰기)
	      t = document.createElement('div');
	      t.id = 'toast';
	      t.className = 'fixed left-1/2 -translate-x-1/2 bottom-24 bg-black/80 text-white px-4 py-3 rounded-lg shadow-lg z-[9999] transition-opacity';
	      t.style.opacity = '0';					// 처음엔 투명하게
	      document.body.appendChild(t);
	    }
	    t.textContent = msg;								// 메세지 덮어쓰기
	    requestAnimationFrame(() => { t.style.opacity = '1'; });			// 페이드인
	    clearTimeout(t._tid);												// 연속 호출시 겹칠 수 있으니 이전 함수 제거
	    t._tid = setTimeout(() => { t.style.opacity = '0'; }, 1800);		// 마지막 호출 기준으로 페이드아웃 1.8초
	}
</script>

	<!-- 이벤트 상품인지감지 -->
	<c:set var="eventMode" value="${param.event == '1'}" />
	<c:set var="shown" value="0" />	
	
	<c:choose>
		<c:when test="${empty list}">
			<div
				class="w-full flex flex-col items-center justify-center py-16 bg-white rounded-xl border border-gray-200 text-center">
				<i class="ri-search-line text-3xl text-gray-400 mb-3"></i>
				<p class="text-gray-800 font-medium mb-1">상품이 없습니다.</p>
				<c:if test="${not empty keyword}">
					<p class="text-sm text-gray-500">
						검색어 "<span class="font-semibold">${keyword}</span>"에 해당하는 상품이 없습니다.
					</p>
				</c:if>
			</div>
		</c:when>
	
		<c:otherwise>
			<div
				class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 md:gap-6">
				<c:forEach var="dto" items="${list}">
					<c:if test="${!eventMode or dto.pd_discount_rate gt 0}">
					<c:set var="shown" value="${shown + 1}"/>
					<div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition-shadow relative h-full">
						<a href="#" onclick="return openCheckout(this)" data-pd-id="${dto.pd_id}" style="text-decoration: none">
							<div class="aspect-square bg-gray-100 relative overflow-hidden">
								<img src="<c:url value='${dto.pd_image_url}'/>"
									alt="Rachael Ray Nutrish"
									class="w-full h-full object-cover object-top" />
							</div>
							<div class="p-3 pb-12 flex flex-col gap-2">
								<div class="text-sm text-gray-600 mb-1 p-4 flex flex-col flex-1"></div>
								<h4 class="font-medium text-gray-900 mb-2" id="pd_name">${dto.pd_name}</h4>
								
								<!-- 비교표현 gt a gt b = a > b -->
								<c:set var="hasDiscount" value="${dto.pd_discount_rate gt 0}" />	
								<!-- 하인율 계산 -->
								<c:set var="discountedPrice" value="${(dto.pd_price * (100 - dto.pd_discount_rate)) / 100}" />
								<div class="flex items-baseline gap-2 mb-2" id="pd_price">
									<c:choose>
										<c:when test="${hasDiscount}">
											<span class="text-sm text-gray-500 line-through">
											<!-- formatNumber태그는 자기닫힘이어야 함, 자기닫힘 아닐시 내부에 바디문자가있으면 오류       -->
		        							<fmt:formatNumber value="${dto.pd_price}" type="number"/> 원
		        							</span>
		        							<span class="text-lg font-bold text-red-600">
									        <fmt:formatNumber value="${discountedPrice}" type="number"/> 원
									      	</span>
									      	<span class="text-sm font-semibold text-red-600"> -
									        <fmt:formatNumber value="${dto.pd_discount_rate}" />%
									      	</span>
	       								</c:when>
	       								<c:otherwise>
	       									<span class="text-lg font-bold text-gray-900">
	       										<fmt:formatNumber value="${dto.pd_price}" type="number"/> 원
	       									</span>
	       								</c:otherwise>	
									</c:choose>
								</div>
								<div class="flex items-center">
									<div class="flex items-center text-blue-400 mr-2"
										aria-label="별점 ${dto.review_score}점">
										<c:forEach begin="1" end="${dto.review_score}">
											<i class="ri-star-fill text-sm"></i>
										</c:forEach>
										<c:forEach begin="1" end="${5 - dto.review_score}">
											<i class="ri-star-line text-sm"></i>
										</c:forEach>
									</div>
									<span class="text-sm text-gray-600">${dto.review_count}</span>
								</div> 
								<div class="mt-auto flex justify-end">  
							    <span 
							    class="absolute bottom-5 right-3 inline-flex items-center h-10 px-4 rounded-lg bg-blue-400 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 active:scale-[.99] transition"
							    data-pd-id="${dto.pd_id}" role="button" onclick="return addToCart(event, ${dto.pd_id})" tabindex="0">
							      담기
							    </span>
							  </div>
							</div>
						</a>
					</div>
					</c:if>
				</c:forEach>
				
				<c:if test="${eventMode and shown == 0 and paging.currentPage == paging.pageCount}">
				  <div class="w-full flex flex-col items-center justify-center py-16 bg-white rounded-xl border text-center">
				    <i class="ri-search-line text-3xl text-gray-400 mb-3"></i>
				    <p class="text-gray-800 font-medium mb-1">할인 중인 상품이 없습니다.</p>
				  </div>
				</c:if>
			</div>
		</c:otherwise>
	</c:choose>
	
			<div class="paging">
			  <div class="flex items-center justify-center gap-2 mt-8">
			    <ul class="flex items-center justify-center gap-2">
			
			      <!-- 이전 -->
			      <c:if test="${paging.startPage > 10}">
			        <c:url var="prevUrl" value="/shop_main.do">
			          <c:param name="pageNum" value="${paging.prev}"/>
			          <c:param name="sortOrder" value="${sortOrder}"/>
			          <c:param name="searchKeyword" value="${keyword}"/>
			          <c:param name="petType" value="${petType}"/>
			          <c:param name="cateList" value="${cateList}"/>
			          <c:if test="${not empty category}">
			            <c:param name="category" value="${category}"/>
			          </c:if>
			          <c:if test="${not empty subcategory}">
			            <c:param name="subcategory" value="${subcategory}"/>
			          </c:if>
			          <c:if test="${param.event==1}">
			            <c:param name="event" value="1"/>
			          </c:if>
			        </c:url>
			        <li><a href="${prevUrl}" class="page-btn">이전</a></li>
			      </c:if>
			
			      <!-- 번호 -->
			      <c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
			        <c:url var="numUrl" value="/shop_main.do">
			          <c:param name="pageNum" value="${num}"/>
			          <c:param name="sortOrder" value="${sortOrder}"/>
			          <c:param name="searchKeyword" value="${keyword}"/>
			          <c:param name="petType" value="${petType}"/>
			          <c:param name="cateList" value="${cateList}"/>
			          <c:if test="${not empty category}">
			            <c:param name="category" value="${category}"/>
			          </c:if>
			          <c:if test="${not empty subcategory}">
			            <c:param name="subcategory" value="${subcategory}"/>
			          </c:if>
			          <c:if test="${param.event==1}">
			            <c:param name="event" value="1"/>
			          </c:if>
			        </c:url>
			        <li>
			          <a href="${numUrl}" class="page-btn ${num == paging.currentPage ? 'active' : ''}">
			            ${num}
			          </a>
			        </li>
			      </c:forEach>
			
			      <!-- 다음 -->
			      <c:if test="${paging.endPage < paging.pageCount}">
			        <c:url var="nextUrl" value="/shop_main.do">
			          <c:param name="pageNum" value="${paging.next}"/>
			          <c:param name="sortOrder" value="${sortOrder}"/>
			          <c:param name="searchKeyword" value="${keyword}"/>
			          <c:param name="petType" value="${petType}"/>
			          <c:param name="cateList" value="${cateList}"/>
			          <c:if test="${not empty category}">
			            <c:param name="category" value="${category}"/>
			          </c:if>
			          <c:if test="${not empty subcategory}">
			            <c:param name="subcategory" value="${subcategory}"/>
			          </c:if>
			          <c:if test="${param.event==1}">
			            <c:param name="event" value="1"/>
			          </c:if>
			        </c:url>
			        <li><a href="${nextUrl}" class="page-btn">다음</a></li>
			      </c:if>
			
			    </ul>
			  </div>
			</div>

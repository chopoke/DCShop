<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>




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
	
	/////////////////////////////////////////////////////////

	  // 장바구니 담기 (이동 없음)
	async function addToCart(ev, pdId){
	    ev.preventDefault();		// form 드으이 기본 이벤트 방지
	    ev.stopPropagation();		// 바깥(<a>태그)로 이동되는 것 방지

		try {
		      // 1) x-www-form-urlencoded (Spring @RequestParam에  호환)
		      const params = new URLSearchParams();
		      params.append('pd_id', pdId);   // 컨트롤러가 pd_id 받는 경우
		      params.append('pdId', pdId);    // 컨트롤러가 pdId 받는 경우 대비 (둘 다 보냄)
		      params.append('qty', 1);		  // 갯수?
	
		    
	
		      let res = await fetch(CTX + '/cart.do', {		// fetch 비동기 형식으로 전송(페이지 리로드X)
			        method: 'POST',				//  POST방식
			        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },	//body: params.toString() 을 폼파라미터로 인식해서 pd_id, qty를 @RequestParams에 매핑
			        body: params.toString(),
			        redirect: 'follow'
		      });

		      	// 로그인 필요(302→로그인 페이지) 감지  
		      	if (res.redirected && /login/i.test(res.url)) {
		        	showToast('로그인이 필요합니다.');
		        	return false;
		      	}
				// 에러시
		      	if (!res.ok) {
			        const txt = await res.text().catch(()=> '');
			        console.error('addToCart failed:', res.status, txt);
			        showToast('장바구니 담기 실패 😥 (' + res.status + ')');
			        return false;
		      	}

	      		// 성공! --> 토스트 띄우기
		      	showToast('장바구니에 담겼습니다.');
	    	} catch (e) {
		      console.error(e);
		      showToast('장바구니 담기 실패 😥 (네트워크 error )');
	    	}
    	return false;
	  }

	  // 화면 중앙 하단 토스트
	  function showToast(msg){		// 토스트 띄우기(아래서 생성)
	    let t = document.getElementById('toast');
	    if (!t) {		// 없다면 생서
	      t = document.createElement('div');
	      t.id = 'toast';
	      t.className = 'fixed left-1/2 -translate-x-1/2 bottom-24 bg-black/80 text-white px-4 py-3 rounded-lg shadow-lg z-[9999] transition-opacity';
	      t.style.opacity = '0';
	      document.body.appendChild(t);
	    }
	    t.textContent = msg;
	    requestAnimationFrame(() => { t.style.opacity = '1'; });		// 페이드인
	    clearTimeout(t._tid);
	    t._tid = setTimeout(() => { t.style.opacity = '0'; }, 2600);		// 2.6초 뒤에 페이드아웃
	  }
	</script>





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
			class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 md:gap-2">
			<c:forEach var="dto" items="${list}">
				<div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition-shadow">
					<a href="#" 
						onclick="return openCheckout(event, this)" 
						data-pd-id="${dto.pd_id}" 
						style="text-decoration: none">
						<div class="aspect-square bg-gray-100 relative overflow-hidden">
							<img src="<c:url value='${dto.pd_image_url}'/>"
								alt="상품 이미지"
								class="w-full h-full object-cover object-top" />
						</div>
						<div class="p-3">
							<div class="text-sm text-gray-600 mb-1 p-4 flex flex-col flex-1"></div>
							<h3 class="font-medium text-gray-900 mb-2" id="pd_name">${dto.pd_name}</h3>
							<div class="text-lg font-bold text-gray-900 mb-2" id="pd_price">${dto.pd_price} 원</div>
							<div class="flex items-center">
								<div class="flex items-center text-yellow-400 mr-2"
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
						    class="inline-flex items-center h-10 px-4 rounded-lg bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 active:scale-[.99] transition"
						    data-pd-id="${dto.pd_id}" role="button" onclick="return addToCart(event, ${dto.pd_id})" tabindex="0">
						      장바구니담기
						    </span>
						  </div>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</c:otherwise>
</c:choose>
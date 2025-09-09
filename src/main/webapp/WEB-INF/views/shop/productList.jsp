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
			class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 md:gap-6">
			<c:forEach var="dto" items="${list}">
				<div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition-shadow">
					<a href="#" onclick="return openCheckout(this)" data-pd-id="${dto.pd_id}" style="text-decoration: none">
						<div class="aspect-square bg-gray-100 relative overflow-hidden">
							<img src="<c:url value='${dto.pd_image_url}'/>"
								alt="Rachael Ray Nutrish"
								class="w-full h-full object-cover object-top" />
						</div>
						<div class="p-4">
							<div class="text-sm text-gray-600 mb-1"></div>
							<h3 class="font-medium text-gray-900 mb-2" id="pd_name">${dto.pd_name}</h3>
							<div class="text-lg font-bold text-gray-900 mb-2" id="pd_price">${dto.pd_price}</div>
							<div class="flex items-center">
								<div class="flex items-center text-skyblue-400 mr-2"
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
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</c:otherwise>
</c:choose>
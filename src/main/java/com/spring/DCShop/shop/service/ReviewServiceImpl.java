package com.spring.DCShop.shop.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.shop.dao.ProductDAO;
import com.spring.DCShop.shop.dao.ReviewDAO;
import com.spring.DCShop.shop.dto.ProductDTO;
import com.spring.DCShop.shop.dto.ReviewDTO;
import com.spring.DCShop.shop.page.Paging;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDAO dao;
    
    @Autowired
    private ProductDAO pdao;

    // 리뷰 목록
    @Override
    public String reviewListAction(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {
        System.out.println("ReviewServiceImpl - reviewListAction()");
        // 어떤 상품의 리뷰인지 pd_id 파라미터로 받음
        String pdIdParam = request.getParameter("pd_id");
        String pageNum   = request.getParameter("pageNum");

        // pd_id= null => 1번 상품으로 리다이렉트
        if (pdIdParam == null || pdIdParam.isEmpty()) {
            return "redirect:/review_list.bc?pd_id=1"; 
        }

        int pdId = Integer.parseInt(pdIdParam);

        // 페이징
        int pageSize = 10;
        int currentPage = 1;
        try { if (pageNum != null) currentPage = Integer.parseInt(pageNum); } catch (Exception ignore) {}
        if (currentPage < 1) currentPage = 1;
        
        // 해당 상품 리뷰 총 개수 DB에서 조회
        int total = dao.reviewCnt(pdId);
        
        // 현재 페이지에 보여줄 범위를 구함(1부터 시작)
        int startRow = (currentPage - 1) * pageSize + 1;
        int endRow = currentPage * pageSize;
        if (endRow > total) endRow = total;
        
        // map에 pd_id, startRow, endRow 담기
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pd_id", pdId);
        map.put("startRow", startRow);
        map.put("endRow", endRow);
        
        List<ReviewDTO> list = dao.reviewList(map);
        
        Paging paging = new Paging(String.valueOf(currentPage));
        paging.setTotalCount(total);
        paging.setPageSize(pageSize);

        // 모델에 담아서 review_list(목록)jsp로 이동
        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
        model.addAttribute("pd_id", pdId);

        return "/shop/review_list";
    }

    // 리뷰 상세
    @Override
    public void reviewDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {
        System.out.println("ReviewServiceImpl - reviewDetailAction()");
        
        // 어떤 리뷰를 볼 건지 r_num(리뷰번호) 받기
        String p = request.getParameter("r_num");
        
        // 리뷰번호(r_num) 없으면 목록으로 리다이렉트
        if (p == null || p.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/review_list.bc");
            return;
        }
        int r_num = Integer.parseInt(p);
        
        // DB에서 리뷰 한 건 조회
        ReviewDTO dto = dao.getReviewDetail(r_num);
        model.addAttribute("dto", dto);
        
        // 리뷰가 가진 pd_id로 상품 기본정보 올리기
        ProductDTO pd = pdao.productDetail(dto.getPd_id()); // pd_name, pd_image_url
        if (pd != null) {
            request.setAttribute("pd_name", pd.getPd_name());
            request.setAttribute("pd_image_url", pd.getPd_image_url());
        }
    }
    
    // 수정/삭제 체크
    @Override
    public int review_chkAction(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {
        System.out.println("ReviewServiceImpl - review_chkAction()");
        
        // 폼에서 넘어온 리뷰번호를 먼저 hidden_r_num에서 찾고, 없으면 r_num에서 찾음
        String p = request.getParameter("hidden_r_num");
        if (p == null || p.isBlank()) p = request.getParameter("r_num");
        
        // 값이 비었거나 숫자가 아니면 실패(0) 반환
        if (p == null || !p.matches("\\d+")) return 0;
        
        int r_num = Integer.parseInt(p);

        // 기존 세션만 꺼냄 (없으면 새로 만들지 않음)
        HttpSession session = request.getSession(false);
        
        // 로그인 여부 확인. 세션에 u_id가 없으면 로그인 안 된 것이므로 실패(0)
        String u_id = (session == null) ? null : (String) session.getAttribute("u_id");
        if (u_id == null || u_id.isEmpty()) return 0;

        // 그 리뷰가 실제 DB에 있는지 확인. 없으면 실패(0)
        ReviewDTO dto = dao.getReviewDetail(r_num);
        if (dto == null) return 0;

        // 모델에 리뷰 정보 싣고, 성공(1) 반환
        model.addAttribute("dto", dto);
        return 1;
    }
    
    // 리뷰 수정화면
    @Override
    public void reviewEditForm(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {
    	
        String p = request.getParameter("r_num");
        
        // r_num 없거나 숫자 아니면 목록으로 리다이렉트
        if (p == null || p.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/review_list.bc");
            return;
        }

        // 숫자로 변환 실패하면 목록으로
        int r_num;
        try { r_num = Integer.parseInt(p); }
        catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/review_list.bc");
            return;
        }

        // 해당 리뷰가 DB에 없으면 목록으로
        ReviewDTO dto = dao.getReviewDetail(r_num);
        if (dto == null) {
            response.sendRedirect(request.getContextPath() + "/review_list.bc");
            return;
        }

        // 세션에서 로그인한 회원번호와 권한 가져오기
        HttpSession session = request.getSession(false);
        Integer loginMemberId = (session == null) ? null : (Integer) session.getAttribute("session_u_member_id");
        String role = (session == null) ? null : (String) session.getAttribute("role");
        
        // 관리자이거나, 글쓴이 본인이면 수정 가능
        boolean allowed = ("ADMIN".equals(role)) ||
                          (loginMemberId != null && loginMemberId.intValue() == dto.getU_member_id());

        // 권한 없으면 상세페이지로 돌려보냄
        if (!allowed) {
            response.sendRedirect(request.getContextPath() + "/review_detailAction.bc?r_num=" + r_num);
            return;
        }

        // 수정폼에서 사용할 데이터 올리기
        model.addAttribute("dto", dto);
    }


    // 리뷰 수정
    @Override
    public void reviewUpdateAction(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {

        int rNum   = Integer.parseInt(request.getParameter("r_num"));
        int score  = Integer.parseInt(request.getParameter("r_score"));
        String content = request.getParameter("r_content");

        String newPath = null; // 새 이미지가 있을 때 DB에 저장할 전체경로

        if (request instanceof MultipartHttpServletRequest) {
            MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;
            MultipartFile file = mreq.getFile("r_imgFile");

            if (file != null && !file.isEmpty()) {
                // 1) 배포 경로(서버 런타임 경로)
                String saveDir = request.getServletContext()
                        .getRealPath("/resources/upload/review/");
                new java.io.File(saveDir).mkdirs();

                // 2) 소스 폴더(프로젝트 경로) - 본인 환경에 맞게 유지
                String realDir = "D:\\DEV05\\workspace_DCshop\\DCShop\\src\\main\\webapp\\resources\\upload\\review\\";
                new java.io.File(realDir).mkdirs();

                // 파일명: UUID + 원본 확장자
                String origin = file.getOriginalFilename();
                String ext = (origin != null && origin.lastIndexOf('.') > -1)
                        ? origin.substring(origin.lastIndexOf('.')) : "";
                String fname = java.util.UUID.randomUUID().toString().replace("-", "") + ext;

                // 배포 경로 저장
                java.io.File deployFile = new java.io.File(saveDir, fname);
                file.transferTo(deployFile);

                // 배포 → 소스 폴더 복사
                try (java.io.FileInputStream fis = new java.io.FileInputStream(deployFile);
                     java.io.FileOutputStream fos = new java.io.FileOutputStream(new java.io.File(realDir, fname))) {
                    byte[] buf = new byte[8192];
                    int len;
                    while ((len = fis.read(buf)) != -1) {
                        fos.write(buf, 0, len);
                    }
                }

                // DB에는 항상 전체경로
                newPath = "/resources/upload/review/" + fname;
            }
        }

        ReviewDTO dto = new ReviewDTO();
        dto.setR_num(rNum);
        dto.setR_score(score);
        dto.setR_content(content);
        if (newPath != null) {
            dto.setR_img(newPath); // 새 파일이 있을 때만 교체
        }

        dao.updateReview(dto);
    }



    // 리뷰 삭제
    @Override
    public void reviewDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {
        System.out.println("ReviewServiceImpl - reviewDeleteAction()");
        
        String p = request.getParameter("r_num");
        int num = Integer.parseInt(p);
        
        dao.deleteReview(num);
    }
    
    // 리뷰 작성 화면
    @Override
	public String reviewInsertForm(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
    	// 1) pd_id 필수
        String pdIdParam = request.getParameter("pd_id");
        if (pdIdParam == null || !pdIdParam.matches("\\d+")) {
            // 적절한 곳으로 보냄 (원하면 상품목록/상세로)
            return "redirect:/ad_product_list.pd";
        }
        int pdId = Integer.parseInt(pdIdParam);

        // 2) 상품 기본정보 조회 (이미 있는 DAO 메서드 재사용)
        ProductDTO pd = pdao.productDetail(pdId);
        if (pd == null) {
            return "redirect:/ad_product_list.pd";
        }

        // 3) JSP에서 바로 쓰도록 올려주기
        request.setAttribute("pd_id",        pd.getPd_id());
        request.setAttribute("pd_name",      pd.getPd_name());
        request.setAttribute("pd_image_url", pd.getPd_image_url());

        // 4) 작성 폼 JSP로 forward
        return "/shop/review_insert"; 
	}

    // 리뷰 작성 
    @Override
    public String reviewInsertAction(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {
        System.out.println("ReviewServiceImpl - reviewInsertAction()");

        // 멀티파트 캐스팅
        MultipartHttpServletRequest mreq = (request instanceof MultipartHttpServletRequest)
                ? (MultipartHttpServletRequest) request : null;

        // 필수 파라미터
        String pdIdParam    = request.getParameter("pd_id");
        String scoreParam   = request.getParameter("r_score");
        String contentParam = request.getParameter("r_content");

        if (pdIdParam == null || pdIdParam.isEmpty()
         || scoreParam == null || scoreParam.isEmpty()
         || contentParam == null || contentParam.trim().isEmpty()) {
            return "redirect:/review_list.bc";
        }

        int pdId, score;
        try {
            pdId  = Integer.parseInt(pdIdParam);
            score = Integer.parseInt(scoreParam);
        } catch (NumberFormatException e) {
            return "redirect:/review_list.bc?pd_id=" + pdIdParam;
        }

        // 로그인 회원 번호
        HttpSession sess = request.getSession(false);
        Integer uMemberId = null;
        if (sess != null) {
            Object v = sess.getAttribute("session_u_member_id");
            if (v == null) v = sess.getAttribute("sessionid");
            if (v instanceof Integer) uMemberId = (Integer) v;
            else if (v instanceof String) {
                try { uMemberId = Integer.parseInt((String) v); } catch (Exception ignore) {}
            }
        }
        if (uMemberId == null) return "redirect:/login.do";

        // ===== 파일 저장 (배포 경로 + 소스 폴더 모두 저장) =====
        String rImgPath = null; // DB에 저장할 전체경로(/resources/...)
        if (mreq != null) {
            MultipartFile file = mreq.getFile("r_imgFile");
            if (file != null && !file.isEmpty()) {

                // 1) 배포 경로
                String saveDir = request.getServletContext()
                        .getRealPath("/resources/upload/review/");
                new java.io.File(saveDir).mkdirs();

                // 2) 소스 폴더 (당신의 로컬 경로로 수정)
                String realDir = "D:\\DEV05\\workspace_DCshop\\DCShop\\src\\main\\webapp\\resources\\upload\\review\\";
                new java.io.File(realDir).mkdirs();

                // 파일명: UUID + 원본 확장자
                String origin = file.getOriginalFilename();
                String ext = (origin != null && origin.lastIndexOf('.') > -1)
                        ? origin.substring(origin.lastIndexOf('.')) : "";
                String fname = java.util.UUID.randomUUID().toString().replace("-", "") + ext;

                // 배포 경로 저장
                file.transferTo(new java.io.File(saveDir, fname));

                // 배포 → 소스 폴더 복사
                try (java.io.FileInputStream fis = new java.io.FileInputStream(saveDir + fname);
                     java.io.FileOutputStream fos = new java.io.FileOutputStream(realDir + fname)) {
                    byte[] buf = new byte[8192];
                    int len;
                    while ((len = fis.read(buf)) != -1) {
                        fos.write(buf, 0, len);
                    }
                }

                // DB에는 항상 전체경로
                rImgPath = "/resources/upload/review/" + fname;
            }
        }

        // DB 저장
        ReviewDTO dto = new ReviewDTO();
        dto.setPd_id(pdId);
        dto.setU_member_id(uMemberId);
        dto.setR_score(score);
        dto.setR_content(contentParam.trim());
        dto.setR_img(rImgPath); // 업로드 없으면 null

        dao.insertReview(dto);

        // 등록 후 상품 상세로
        return "redirect:/ad_shop_detailAction.pd?pdId=" + pdId;
    }

	



}

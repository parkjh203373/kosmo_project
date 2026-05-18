<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document"> <div class="modal-content border-0 shadow-lg" style="border-radius: 15px;"> <div class="modal-header border-0 pt-4 px-4">
                <h5 class="modal-title font-weight-bold" id="exampleModalLabel" style="color: #2a5c43;">
                    <i class="fas fa-sign-out-alt mr-2"></i>로그아웃 하시겠습니까?
                </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            
            <div class="modal-body px-4 text-gray-600">
                정말로 로그아웃 하시겠습니까? <br>
                다음에 또 방문해 주세요! FOREST LIBRARY는 언제나 열려 있습니다.
            </div>
            
            <div class="modal-footer border-0 pb-4 px-4">
                <button class="btn btn-light px-4 py-2 mr-2" type="button" data-dismiss="modal" style="border-radius: 8px; font-weight: 500;">취소</button>
                
                <a class="btn px-4 py-2" href="/member/logout" 
                   style="background-color: #2a5c43; color: white; border-radius: 8px; font-weight: 500;">
                   로그아웃
                </a>
            </div>
            
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>
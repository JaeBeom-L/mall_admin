<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>insertManagerForm</title>

 	<link href="<%=request.getContextPath()%>/Bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body>

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            <!-- 매니저 등록 폼 -->
                            <form class="user" action = "<%=request.getContextPath()%>/Manager/insertManagerAction.jsp" method="post">
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" name="managerId"
                                        placeholder="Id">
                                </div>
                                
                                <div class="form-group">
                                    <input type="password" class="form-control form-control-user" name="managerPw"
                                        placeholder="PassWord">
                                </div>
                                
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" name="managerName"
                                        placeholder="Name">
                                </div>
                               
                                <button type="submit" class="btn btn-primary btn-user btn-block">
                                    Register Account
                                </button>                             
                            </form>
                            <hr>
                           	<div class="text-center">
                           		<a class="small" href="<%=request.getContextPath()%>/adminIndex.jsp">Go to Login</a>
                           	</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>
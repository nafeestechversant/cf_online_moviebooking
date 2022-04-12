<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - SB Admin</title>
    <link href="../css/styles.css" rel="stylesheet" />
    <link href="../css/jquery.dataTables.min.css" rel="stylesheet" />
</head>
<body class="sb-nav-fixed">
    <cfinclude template="header.cfm">
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <cfinclude template="sidenav.cfm">
        </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Update Password</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item">Home</li>
                        <li class="breadcrumb-item active">Update Password</li>
                    </ol>
                    <div class="row">
                        <div class="col-xl-12 col-md-12">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form class="">
                                        <div class="col-md-6 mb-3">
                                            <label for="inputEmail4" class="form-label">Old Password</label>
                                            <input type="text" class="form-control" id="inputEmail4">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="inputPassword4" class="form-label">New Password</label>
                                            <input class="form-control" type="text" id="formFile">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="inputCity" class="form-label">Confirm Password</label>
                                            <input type="text" class="form-control" id="inputCity">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update Password</button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <cfinclude template="footer.cfm">
        </div>
    </div>
    <script src="../js/jquery.min.js"></script>     
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script src="../js/jquery.dataTables.min.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/scripts.js"></script>
</body>
</html>
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
</head>
<body class="sb-nav-fixed">
    <cfoutput>    
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
                                        <cfif isDefined('session.ErrmsgForm') AND NOT arrayIsEmpty(session.ErrmsgForm)>
                                            <cfloop array="#session.ErrmsgForm#" index="message">
                                                <p  class="red">#message#</p>
                                            </cfloop>                                          
                                        </cfif>
                                        <cfif structKeyExists(URL,'status')>
                                            <cfif URL.status IS "success">
                                                <p  class="green">Updated Successfully</p>
                                            </cfif>
                                        </cfif> 
                                        <form class="" id="form_updatePwd" method="post" action="cfc/admin.cfc?method=updateAdminPwd">
                                            <div class="col-md-6 mb-3">
                                                <label for="inputEmail4" class="form-label">Old Password</label>
                                                <input type="password" name="admin_oldpwd"  class="form-control" id="inputEmail4">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="inputPassword4" class="form-label">New Password</label>
                                                <input class="form-control" name="admin_newpwd" id="admin_newpwd" type="password" id="formFile">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="inputCity" class="form-label">Confirm Password</label>
                                                <input type="password" name="admin_cnfpwd" id="admin_cnfpwd" class="form-control" id="inputCity">
                                            </div>
                                            <input type="submit" class="btn btn-primary" value="Update Password">
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
    </cfoutput>
    <script src="../js/jquery.min.js"></script>   
    <script src="../js/bootstrap.bundle.min.js"></script>     
    <script src="../js/jquery.dataTables.min.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/scripts.js"></script>
</body>
</html>
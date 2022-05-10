<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Login - SB Admin</title>
    <link href="../css/styles.css" rel="stylesheet" />
</head>
<body class="bg-primary">
    <cfoutput>    
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header">
                                        <h3 class="text-center font-weight-light my-4">Login</h3>
                                    </div>
                                    <div class="card-body">                                   
                                        <cfif isDefined('session.Errmsg') AND session.Errmsg NEQ "">
                                            <p  class="red">#session.Errmsg#</p>                                         
                                        </cfif>                                       
                                        <cfparam name="form.admin_loginEmail"  default=""  type="string">
                                        <cfparam name="form.admin_loginPwd"  default=""  type="string">
                                        <form id="adminlogin_form" method="post" action="cfc/admin.cfc">
                                            <input type="Hidden" name="method" value="checkAdminLogin">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="admin_loginEmail" name="admin_loginEmail" type="email" placeholder="name@example.com" value="#form.admin_loginEmail#"/>
                                                <label for="admin_loginEmail">Email address</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="admin_loginPwd" name="admin_loginPwd" type="password" placeholder="Password" value="#form.admin_loginPwd#"/>
                                                <label for="admin_loginPwd">Password</label>
                                            </div>
                                            <div class="dataTables-empty align-items-center justify-content-between mt-4 mb-0">
                                                <input type="submit" class="btn btn-primary" value="Login">
                                            </div>
                                        </form>
                                    </div>                                
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </cfoutput>
    <script src="../js/jquery.min.js"></script>              
    <script src="../js/jquery.validate.js"></script>    
    <script src="../js/scripts.js"></script>
</body>
</html>
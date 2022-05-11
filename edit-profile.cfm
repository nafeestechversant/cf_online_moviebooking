<cfobject name="Users" component="cfc/user">
<cfinvoke component="#Users#" method="getUsrById" returnvariable="UsersById"></cfinvoke>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Movie Booking - Dashboard</title>
    <meta content="" name="description">
    <meta content="" name="keywords">  
    <link href="css/frontend/bootstrap.min.css" rel="stylesheet">  
    <link href="css/frontend/bootstrap-icons.css" rel="stylesheet">
    <link href="css/frontend/style.css" rel="stylesheet">
</head>
<body>
    <cfoutput>
        <cfinclude template="header.cfm"> 
        <main id="main">
            <div class="header-bg page-area">           
            </div>        
            <div class="blog-page area-padding pb-160">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-3">
                            <div class="page-head-blog">                              
                                <div class="single-blog-page">
                                    <div class="left-blog">                                       
                                        <ul>
                                            <li>
                                                <a  href="dashboard.cfm">Booking History</a>
                                            </li>
                                            <li>
                                                <a class="active-link" href="edit-profile.cfm">Edit Profile</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                          
                                <h4>Edit Profile</h4>
                                <cfif isDefined('session.ProErrmsg') AND session.ProErrmsg NEQ "">                                    
                                    <p  class="red">#session.ProErrmsg#</p>                                    
                                </cfif> 
                                <cfparam name="form.fld_userName"  default=""  type="string">
                                <cfparam name="form.fld_userEmail"  default=""  type="string"> 
                                <cfparam name="form.fld_userMobile"  default=""  type="string">
                                <cfparam name="form.fld_userAddr"  default=""  type="string">
                                <cfparam name="form.fld_userPwd"  default=""  type="string">
                                <cfparam name="form.fld_userCnfPwd"  default=""  type="string">  
                                <form method="post" id="form_editUser" action="cfc/user.cfc?method=editUser">
                                    <div class="row mr-bot">
                                        <div class="col">
                                            <label for="inputEmail4">Full Name</label>
                                            <input type="text" name="fld_userName" class="form-control" placeholder="Full Name" value="#UsersById.user_fullname#">
                                        </div>
                                        <div class="col">
                                            <label for="inputEmail4">Email</label>
                                            <input type="text" name="fld_userEmail" class="form-control" placeholder="Email" value="#UsersById.user_email#" readonly>
                                        </div>
                                    </div>
                                    <div class="row mr-bot">
                                        <div class="col">
                                            <label for="inputEmail4">Mobile</label>
                                            <input type="text" name="fld_userMobile" class="form-control" placeholder="Mobile" value="#UsersById.user_phone#">
                                        </div>
                                        <div class="col">
                                            <label for="inputEmail4">Address</label>
                                            <input type="text" name="fld_userAddr" class="form-control" placeholder="Address" value="#UsersById.user_address#">
                                        </div>
                                    </div>
                                    <div class="row mr-bot">
                                        <div class="col">
                                            <label for="inputEmail4">Password</label>
                                            <input type="password" name="fld_userPwd" class="form-control" placeholder="Password" >
                                        </div>
                                        <div class="col">
                                            <label for="inputEmail4">Confirm Password</label>
                                            <input type="password" name="fld_userCnfPwd" class="form-control" placeholder="Confirm Password">
                                        </div>
                                    </div>
                                    <input type="submit" class="btn-get-started" value="Update">
                                </form>                              
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <cfinclude template="footer.cfm">
    </cfoutput>
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.validate.js"></script>       
    <script src="js/main.js"></script>
</body>
</html>
<!--- <cfdump  var="#session.Errmsg#"> --->
<cfoutput>
    <footer>
        <div class="footer-area-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="copyright text-center">
                            <p>
                                &copy; Copyright <strong>Movie Booking</strong>. All Rights Reserved
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End  Footer -->
    <!-- SignUp Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header cus-modal-header">
                    <h5 class="modal-title cus-modal-title" id="exampleModalLabel">Create an Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <cfparam name="form.fld_userName"  default=""  type="string">
                <cfparam name="form.fld_userEmail"  default=""  type="string"> 
                <cfparam name="form.fld_userMobile"  default=""  type="string">
                <cfparam name="form.fld_userPwd"  default=""  type="string">
                <cfparam name="form.fld_userCnfPwd"  default=""  type="string">            
                <form class="row g-3" id="form_addUser" method="post">              
                    <div class="modal-body">
                        <div id="valid-err"></div>
                        <div class="col-md-12">
                            <label for="inputEmail4" class="form-label">Full Name</label>
                            <input type="text" name="fld_userName" id="fld_userName" class="form-control" id="inputEmail4">
                        </div>
                        <div class="col-md-12">
                            <label for="inputPassword4" class="form-label">Email Address</label>
                            <input class="form-control" name="fld_userEmail" id="fld_userEmail" type="email" id="formFile">
                        </div>
                        <div class="col-md-12">
                            <label for="inputPassword4" class="form-label">Mobile</label>
                            <input class="form-control" name="fld_userMobile" id="fld_userMobile" type="text" id="formFile">
                        </div>
                        <div class="col-md-12">
                            <label for="inputPassword4" class="form-label">Password</label>
                            <input class="form-control" name="fld_userPwd" id="fld_userPwd" type="password" id="formFile">
                        </div>
                        <div class="col-md-12">
                            <label for="inputPassword4" class="form-label">Confirm Password</label>
                            <input class="form-control" name="fld_userCnfPwd" id="fld_userCnfPwd" type="password" id="formFile">
                        </div>                                           
                    </div>
                    <div class="modal-footer cus-modal-footer register-btn">                    
                        <input type="submit" class="btn-get-started" value ="Create Account">
                        <a class="" data-bs-toggle="modal" data-bs-target="##loginModal">                                
                            <span class="login-span">Login</span>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header cus-modal-header">
                    <h5 class="modal-title cus-modal-login" id="exampleModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <cfparam name="form.fld_userEmail"  default=""  type="string">
                <cfparam name="form.fld_userPwd"  default=""  type="string">  
                <cfparam name="form.remember_me" type="string" default="0" />          
                <form class="row g-3" id="form_login" method="post" >              
                    <div class="modal-body">
                        <cfif isDefined('session.Errmsg') AND session.Errmsg NEQ "">
                            <p  class="red">#session.Errmsg#</p>                                         
                        </cfif>
                        <div id="valid-loginerr"></div>                 
                        <div class="col-md-12">
                            <label for="inputPassword4" class="form-label">Email Address</label>
                            <input class="form-control" name="fld_userEmail" id="fld_userEmail" type="email" id="formFile">
                        </div>             
                        <div class="col-md-12">
                            <label for="inputPassword4" class="form-label">Password</label>
                            <input class="form-control" name="fld_userPwd" id="fld_userPwd" type="password" id="formFile">
                        </div> 
                        <label>
                            <input type="checkbox" name="remember_me" id="remember_me" value="1" />
                            Remember Me
                        </label>                                                           
                    </div>
                    <div class="modal-footer cus-modal-footer">                    
                        <input type="submit" class="btn-get-started" value ="Login"> 
                        <a class="" data-bs-toggle="modal" data-bs-target="##exampleModal">                               
                            <span class="login-span">Create Account</span>
                        </a>                 
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</cfoutput>
<div id="preloader"></div>
<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

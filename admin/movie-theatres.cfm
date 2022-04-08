<cfobject name="MovieTheatresList" component="cfc/admin">
<cfinvoke component="#MovieTheatresList#" method="getMovieTheatres" returnvariable="TheatresLists"></cfinvoke>
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
                        <h1 class="mt-4">Movie Theatres</h1>
                        <div class="fl-r">
                            <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="##exampleModal">
                                Add Movie Theatre
                            </a>
                        </div>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Home</li>
                            <li class="breadcrumb-item active">Movie Theatres</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-12 col-md-12">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <table id="datatablesSimple">
                                            <thead>
                                                <tr>
                                                    <th>S.No</th>
                                                    <th>Theatre Name</th>
                                                    <th>Theatre Image</th>
                                                    <th colspan="2">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <cfloop query="#TheatresLists#"> 
                                                    <tr>
                                                        <td>1</td>
                                                        <td>#TheatresLists.theatre_name#</td>
                                                        <td><img class="" id="" src="uploads/MovieTheatres/#TheatresLists.theatre_image#" width="50%"></td>
                                                        <td><a class="btn btn-primary btn-edit-theatre" data-id="#TheatresLists.theatre_id#" data-bs-toggle="modal" data-bs-target="##exampleModal">Edit</a></td>
                                                        <td><a class="btn btn-primary btn-delete-theatre" href="1" data-record-id="#TheatresLists.theatre_id#" data-id="#TheatresLists.theatre_id#" data-bs-toggle="modal" data-bs-target="##DeleteModal">Delete</a></td>
                                                    </tr>
                                                </cfloop>                                                
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <cfinclude template="footer.cfm">
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Movie Theatre</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <cfparam name="form.theatre_id"  default=""  type="string">
                    <cfparam name="form.theatre_name"  default=""  type="string">
                    <cfparam name="form.theatre_img"  default=""  type="string">
                    <form class="row g-3" id="form_addTheatre" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="theatre_id" id="theatre_id" value="">
                        <input type="hidden" name="theatre_img" id="theatre_img" value="">
                        <div class="modal-body">                        
                            <div class="col-md-12">
                                <label for="inputEmail4" class="form-label">Theatre Name</label>
                                <input type="text" name="theatre_name" id="theatre_name" class="form-control" id="inputEmail4">
                            </div>
                            <div class="col-md-12">
                                <label for="inputPassword4" class="form-label">Theatre Image</label>
                                <input class="form-control" name="theatre_img" id="theatre_img" type="file" id="formFile">
                            </div>
                            <div class="col-md-6">
                                <img class="" id="show-thr-img" src="">
                            </div>                       
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value ="Add Theatre">
                        </div>
                    </form>
                </div>
            </div>
        </div>
         <!-- Delete Contact Modal-->
        <div class="modal fade" id="DeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">                                              
                        <h5 class="modal-title" id="exampleModalLabel">Confirm Delete?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>                    
                    </div>
                    <div class="modal-body">Are you sure want to delete.</div>
                    <div class="modal-footer">
                        <input type="hidden" name="cntId" id="cntId" value=""/>
                        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">No</button>
                        <a class="btn btn-primary btn-yes" >Yes</a>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script src="../js/scripts.js"></script>
    <script src="../js/simple-datatables.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/validation.js"></script>  
</body>
</html>
<cfobject name="compAdmin" component="cfc/admin"> 
<cfinvoke component="cfc/admin" method="getShows" returnvariable="ShowLists"></cfinvoke>
<cfinvoke component="#compAdmin#" method="getMovieTheatres" returnvariable="Theatres"></cfinvoke>
<cfinvoke component="#compAdmin#" method="getMovies" returnvariable="Movies"></cfinvoke>
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
    <cfoutput>
        <cfinclude template="header.cfm"> 
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <cfinclude template="sidenav.cfm">
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Show Timings</h1>
                        <div class="fl-r">
                            <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="##exampleModal">
                                Add Show
                            </a>
                        </div>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Home</li>
                            <li class="breadcrumb-item active">Show Timings</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-12 col-md-12">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <table id="datatablesShows">
                                            <thead>
                                                <tr>
                                                    <th>S.No</th>
                                                    <th>Theatre</th>
                                                    <th>Movie</th>
                                                    <th>Start/End Date</th>
                                                    <th>Start/End Time</th>
                                                    <th>Gold Full</th>
                                                    <th>Gold Half</th>
                                                    <th>ODC Full</th>
                                                    <th>ODC Half</th>
                                                    <th>Box</th>
                                                    <th>Action</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <cfset variables.sno = 1 >
                                                <cfloop query="#ShowLists#">
                                                    <tr>
                                                        <td>#sno#</td>
                                                        <td>#ShowLists.theatre_id#</td>
                                                        <td>#ShowLists.movie_id#</td>
                                                        <td>#ShowLists.start_date#/#ShowLists.end_date#</td>
                                                        <td>#ShowLists.start_time#/#ShowLists.end_time#</td>
                                                        <td>Rs:#ShowLists.price_gold_full#</td>
                                                        <td>Rs:#ShowLists.price_gold_half#</td>
                                                        <td>Rs:#ShowLists.price_odc_full#</td>
                                                        <td>Rs:#ShowLists.price_odc_half#</td>
                                                        <td>Rs:#ShowLists.price_box#</td>
                                                        <td><a class="btn btn-primary btn-edit-show" data-id="#ShowLists.show_id#" data-bs-toggle="modal" data-bs-target="##exampleModal">Edit</a></td>
                                                        <td><a class="btn btn-primary btn-delete-show" href="" data-href="cfc/admin.cfc?method=delShow&DelId=#ShowLists.show_id#" data-bs-toggle="modal" data-bs-target="##ShowDeleteModal">Delete</a></td>
                                                    </tr>
                                                    <cfset variables.sno ++ >
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
                        <h5 class="modal-title" id="exampleModalLabel">Add Show Time</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form class="" id="form_addShowTime" method="post">
                        <div class="modal-body">
                            <div  class="red" id="valid-err"></div> 
                            <div class="row">                                 
                                <input type="hidden" name="show_id" id="show_id" value="">
                                <div class="col-md-6">
                                    <label for="inputEmail4" class="form-label">Select Theatre</label>
                                    <select class="form-select" name="theatre_id" id="theatre_id" aria-label="Default select example">
                                        <option value="">Open this select menu</option>
                                        <cfloop query="#Theatres#">
                                            <option value="#Theatres.theatre_id#">#Theatres.theatre_name#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="inputPassword4" class="form-label">Select Movie</label>
                                    <select class="form-select" name="movie_id" id="movie_id" aria-label="Default select example">
                                        <option value="">Open this select menu</option>
                                        <cfloop query="#Movies#">
                                            <option value="#Movies.movie_id#">#Movies.movie_name#</option>
                                        </cfloop>                                      
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="inputCity" class="form-label">Show Start Date</label>
                                    <input type="date" name="start_date" id="start_date" class="form-control" id="inputCity">
                                </div>
                                <div class="col-md-6">
                                    <label for="inputCity" class="form-label">Show End Date</label>
                                    <input type="date" name="end_date" id="end_date" class="form-control" id="inputCity">
                                </div>
                                <div class="col-md-6">
                                    <label for="inputPassword4" class="form-label">Show Start Time</label>
                                    <input type="time" name="start_time" id="start_time" class="form-control" id="inputCity">
                                </div>
                                <div class="col-md-6">
                                    <label for="inputPassword4" class="form-label">Show Start Time</label>
                                    <input type="time" name="end_time" id="end_time" class="form-control" id="inputCity">
                                </div>
                                <div class="col-md-6">
                                    <label for="inputPassword4" class="form-label">Online Booking Seat</label>
                                    <input type="number" name="online_booking" id="online_booking" class="form-control" id="inputCity">
                                </div>

                                <div class="col-md-12">
                                    <label for="inputPassword4" class="form-label">Set Price</label>
                                </div>
                                <div class="row ">
                                    <div class="col-md-2 adj-wdth">
                                        <label for="inputPassword4" class="form-label">Gold Full:</label>
                                        <input type="text" name="price_gold_full" id="price_gold_full" class="form-control" id="inputCity">
                                    </div>
                                    <div class="col-md-2 adj-wdth">
                                        <label for="inputPassword4" class="form-label">Gold Half:</label>
                                        <input type="text" name="price_gold_half" id="price_gold_half" class="form-control" id="inputCity">
                                    </div>
                                    <div class="col-md-2 adj-wdth">
                                        <label for="inputPassword4" class="form-label">ODC Full:</label>
                                        <input type="text" name="price_odc_full" id="price_odc_full" class="form-control" id="inputCity">
                                    </div>
                                    <div class="col-md-2 adj-wdth">
                                        <label for="inputPassword4" class="form-label">ODC Half:</label>
                                        <input type="text" name="price_odc_half" id="price_odc_half" class="form-control" id="inputCity">
                                    </div>
                                    <div class="col-md-2 adj-wdth">
                                        <label for="inputPassword4" class="form-label">Box:</label>
                                        <input type="text" name="price_box" id="price_box" class="form-control" id="inputCity">
                                    </div>
                                </div>
                            </div>                        
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value ="Add Show">                            
                        </div>
                    </form>
                </div>
            </div>
        </div>
          <!-- Delete  Modal-->
        <div class="modal fade" id="ShowDeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
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
    <script src="../js/jquery.dataTables.min.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/scripts.js"></script>   
</body>
</html>
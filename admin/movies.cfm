<cfobject name="MovieList" component="cfc/admin">
<cfinvoke component="#MovieList#" method="getMovies" returnvariable="MoviesLists"></cfinvoke>
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
                        <h1 class="mt-4">Movies</h1>
                        <div class="fl-r">
                            <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="##exampleModal">
                                Add Movie
                            </a>
                        </div>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Home</li>
                            <li class="breadcrumb-item active">Movies</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-12 col-md-12">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <table id="datatablesSimple">
                                            <thead>
                                                <tr>
                                                    <th>S.No</th>
                                                    <th>Movie Name</th>
                                                    <th>Poster</th>
                                                    <th>Trailer</th>
                                                    <th colspan="2">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <cfloop query="#MoviesLists#"> 
                                                    <tr>
                                                        <td>1</td>
                                                        <td>#MoviesLists.movie_name#</td>
                                                        <td><img class="" id="" src="uploads/Movie/#MoviesLists.movie_poster#" width="50%"></td>                                                        
                                                        <td><iframe width="300" height="250" src="#MoviesLists.movie_youtubelink#"></iframe></td>
                                                        <td><a class="btn btn-primary btn-edit-movie" data-id="#MoviesLists.movie_id#" data-bs-toggle="modal" data-bs-target="##exampleModal">Edit</a></td>
                                                        <td><a class="btn btn-primary btn-delete-movie" data-id="#MoviesLists.movie_id#" data-bs-toggle="modal" data-bs-target="##">Delete</a></td>
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
                        <h5 class="modal-title" id="exampleModalLabel">Add Movie</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <cfparam name="form.movie_id"  default=""  type="string">
                    <cfparam name="form.movie_poster"  default=""  type="string">
                    <cfparam name="form.movie_name"  default=""  type="string">
                    <cfparam name="form.movie_youtubelink"  default=""  type="string">
                    <cfparam name="form.movie_rating"  default=""  type="string">
                    <cfparam name="form.movie_details"  default=""  type="string">   
                    <form class="row g-3" id="form_addmovie" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="movie_id" id="movie_id" value="">
                        <input type="hidden" name="movie_poster" id="movie_poster" value="">
                        <div class="modal-body" >                                                                           
                            <div class="col-md-12">
                                <label for="inputEmail4" class="form-label">Movie Name</label>
                                <input type="text" class="form-control" name="movie_name" id="movie_name">
                            </div>
                            <div class="col-md-12">
                                <label for="inputPassword4" class="form-label">Poster</label>
                                <input class="form-control" type="file" name="movie_poster" id="movie_poster">
                            </div>
                            <div class="col-md-6">
                                <label for="inputCity" class="form-label">Youtube Link</label>
                                <input type="text" class="form-control" name="movie_youtubelink" id="movie_youtubelink">
                            </div>
                            <div class="col-md-6">
                                <label for="inputCity" class="form-label">Movie Ratings</label>
                                <select class="form-select" name="movie_rating" id="movie_rating" aria-label="Default select example">
                                    <option selected>Open this select menu</option>
                                    <option value="1">One</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                                    <option value="4">Four</option>
                                    <option value="5">Five</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="inputPassword4" class="form-label">Movie Details</label>
                                <textarea class="form-control" name="movie_details" id="movie_details" rows="3"></textarea>
                            </div> 
                            <div class="col-md-6">
                                <img class="" id="show-mov-img" src="">
                            </div>                           
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value ="Add Movie">                        
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="../js/jquery.min.js"></script>
        <script src="../js/bootstrap.bundle.min.js"></script>
        <script src="../js/scripts.js"></script>
        <script src="../js/simple-datatables.js"></script>
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/validation.js"></script> 
    </cfoutput>
</body>
</html>
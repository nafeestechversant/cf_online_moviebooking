<cfinvoke component="cfc/admin" method="getMovies" returnvariable="MoviesLists"></cfinvoke>
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
                                <h1 class="mt-4">Home Page</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item">Home</li>
                                    <li class="breadcrumb-item active">Home Page</li>
                                </ol>
                                <div class="row">
                                    <div class="col-xl-12 col-md-12">
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <table id="datatablesSimple">
                                                    <thead>
                                                        <tr>
                                                            <th>S.No</th>
                                                            <th>Movie Image</th>
                                                            <th>Movie Name</th>
                                                            <th>Movie Details</th>
                                                            <th>Rating</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <cfset variables.sno = 1 >
                                                        <cfloop query="#MoviesLists#"> 
                                                            <tr>
                                                                <td>#sno#</td>
                                                                <td>
                                                                    <cfif MoviesLists.movie_poster NEQ ''>
                                                                        <img class="" id="" src="uploads/Movie/#MoviesLists.movie_poster#" width="50%">
                                                                    </cfif>
                                                                </td>
                                                                <td>#MoviesLists.movie_name#</td>
                                                                <td>#MoviesLists.movie_name#</td>
                                                                <td>#MoviesLists.movie_name#</td>
                                                                <td>
                                                                    <a class="btn btn-primary btn-activate-home" id="movie-actID-#MoviesLists.movie_id#" data-id="#MoviesLists.movie_id#" data-actid="#IIF(MoviesLists.active_homepage eq 1, de("0"), de("1"))#">#IIF(MoviesLists.active_homepage eq 1, de("Deactivate"), de("Activate"))#</a>                                                    
                                                                </td>
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
        </cfoutput>
        <script src="../js/jquery.min.js"></script>    
        <script src="../js/bootstrap.bundle.min.js"></script>
        <script src="../js/jquery.dataTables.min.js"></script>
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/scripts.js"></script>    
    </body>
</html>
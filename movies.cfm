<cfobject name="MovieList" component="cfc/user">
<cfinvoke component="#MovieList#" method="getMovies" returnvariable="MoviesLists"></cfinvoke>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Movie Booking - Movie List</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <link href="css/frontend/animate.min.css" rel="stylesheet">
    <link href="css/frontend/bootstrap.min.css" rel="stylesheet">
    <link href="css/frontend/bootstrap-icons.css" rel="stylesheet">
    <link href="css/frontend/boxicons.min.css" rel="stylesheet">
    <link href="css/frontend/style.css" rel="stylesheet">
</head>
<body>
    <cfoutput> 
        <cfinclude template="header.cfm">     
        <cfinclude template="banner.cfm"> 
        <main id="main">       
            <div class="blog-page area-padding">
                <div class="container">
                    <div class="row">                                                                  
                        <cfloop query="#MoviesLists#">                               
                            <div class="col-md-3 col-sm-3 col-xs-12">
                                <div class="single-blog">
                                    <div class="single-blog-img">
                                        <a href="movie-details.cfm?movie=#MoviesLists.movie_id#">
                                            <cfif MoviesLists.movie_poster NEQ ''>
                                                <img src="admin/uploads/Movie/#MoviesLists.movie_poster#" width="100%" alt="">
                                            <cfelse>
                                                <img src="img/no-poster-available.jpg" width="" alt="">                                            
                                            </cfif>
                                        </a>
                                    </div>
                                    <div class="blog-meta">
                                        <span class="comments-type">
                                            <i class="bi bi-chat"></i>
                                            <a href="##">11 comments</a>
                                        </span>
                                        <span class="date-type">
                                            <i class="bi bi-calendar"></i>2016-03-05 / 09:10:16
                                        </span>
                                    </div>
                                    <div class="blog-text">
                                        <h4>
                                            <a href="movie-details.cfm?movie=#MoviesLists.movie_id#">#MoviesLists.movie_name#</a>
                                        </h4>
                                        <p>
                                            #MoviesLists.movie_lang#
                                        </p>
                                    </div>
                                    <div class="all-center">
                                        <a href="##about" class="btn-get-started">Book Tickets</a>
                                    </div>
                                </div>
                            </div> 
                        </cfloop>                                                                                                              
                    </div>
                </div>
            </div>            
        </main>
        <cfinclude template="footer.cfm">
    </cfoutput> 
    <script src="js/bootstrap.bundle.min.js"></script>   
    <script src="js/main.js"></script>
</body>
</html>
<cfobject name="MovieList" component="cfc/user">
<cfinvoke component="#MovieList#" method="getHomeMovies" returnvariable="MoviesLists"></cfinvoke>
<cfinvoke component="#MovieList#" method="getComingSoonMovies" returnvariable="ComingSoonMovies"></cfinvoke>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Movie Booking - Index</title>
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
            <section id="hero">
                <div class="hero-container">
                    <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">
                        <ol id="hero-carousel-indicators" class="carousel-indicators"></ol>
                        <cfset variables.sno = 1 >
                        <cfloop query="#MoviesLists#"> 
                                <div class="carousel-item #IIF(variables.sno eq 1, de('active'), de(''))#" style="background-image: url(img/hero-carousel/1.jpg)">
                                    <div class="carousel-container">
                                        <div class="container">
                                            <h2 class="animate__animated animate__fadeInDown">#MoviesLists.movie_name# </h2>
                                            <p class="animate__animated animate__fadeInUp">#MoviesLists.movie_details#</p>
                                            <a href="movie-details.cfm?movie=#MoviesLists.movie_id#" class="btn-get-started scrollto animate__animated animate__fadeInUp">Book Tickets</a>
                                        </div>
                                    </div>
                                </div> 
                                <cfset variables.sno ++ >                      
                        </cfloop> 
                        <a class="carousel-control-prev" href="##heroCarousel" role="button" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
                        </a>
                        <a class="carousel-control-next" href="##heroCarousel" role="button" data-bs-slide="next">
                            <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
            </section>
            <main id="main">
                <div id="team" class="our-team-area area-padding">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="section-headline text-center">
                                    <h2>Now Showing</h2>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <cfloop query="#MoviesLists#"> 
                                <div class="col-md-3 col-sm-3 col-xs-12">
                                    <div class="single-team-member">
                                        <div class="team-img">
                                            <a href="movie-details.cfm?movie=#MoviesLists.movie_id#">
                                                <img class="img-fluid" src="admin/uploads/Movie/#MoviesLists.movie_poster#" alt="" width= "100%">
                                            </a>
                                        </div>
                                        <div class="team-content text-center">
                                            <h4><a href="movie-details.cfm?movie=#MoviesLists.movie_id#">#MoviesLists.movie_name#</a></h4>
                                            <p>#MoviesLists.movie_lang#</p>
                                            <a href="movie-details.cfm?movie=#MoviesLists.movie_id#" class="btn-get-started">Book Tickets</a>
                                        </div>
                                    </div>
                                </div>
                            </cfloop>                                                    
                        </div>
                    </div>
                </div>

                <div id="blog" class="blog-area">
                    <div class="blog-inner area-padding padding-2">
                        <div class="blog-overly"></div>
                        <div class="container ">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="section-headline text-center">
                                        <h2>Coming Soon</h2>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <cfloop query="#ComingSoonMovies#">
                                    <div class="col-md-4 col-sm-4 col-xs-12">
                                        <div class="single-blog">
                                            <div class="single-blog-img">
                                                <a href="movie-details.cfm?movie=#ComingSoonMovies.movie_id#">
                                                    <img src="admin/uploads/Movie/#ComingSoonMovies.movie_poster#" alt="">
                                                </a>
                                            </div>
                                            <div class="blog-meta">                                        
                                                <span class="date-type">
                                                    <i class="fa fa-calendar"></i>2016-03-05 / 09:10:16
                                                </span>
                                            </div>
                                            <div class="blog-text">
                                                <h4>
                                                    <a href="movie-details.cfm?movie=#ComingSoonMovies.movie_id#">#ComingSoonMovies.movie_name#</a>
                                                </h4>
                                            </div>
                                            <div class="blog-morebtn">
                                                <a href="movie-details.cfm?movie=#ComingSoonMovies.movie_id#" class="ready-btn">More Info</a>
                                            </div>
                                        </div>
                                    </div> 
                                </cfloop>                                                
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <cfinclude template="footer.cfm">
        </cfoutput>
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.validate.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/main.js"></script>   
    </body>
</html>
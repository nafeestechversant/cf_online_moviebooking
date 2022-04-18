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
                    <div class="carousel-inner" role="listbox">
                        <div class="carousel-item active" style="background-image: url(img/hero-carousel/1.jpg)">
                            <div class="carousel-container">
                                <div class="container">
                                    <h2 class="animate__animated animate__fadeInDown">The Best Business Information </h2>
                                    <p class="animate__animated animate__fadeInUp">We're In The Business Of Helping You Start Your Business</p>
                                    <a href="##about" class="btn-get-started scrollto animate__animated animate__fadeInUp">Book Tickets</a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item" style="background-image: url(img/hero-carousel/2.jpg)">
                            <div class="carousel-container">
                                <div class="container">
                                    <h2 class="animate__animated animate__fadeInDown">At vero eos et accusamus</h2>
                                    <p class="animate__animated animate__fadeInUp">Helping Business Security & Peace of Mind for Your Family</p>
                                    <a href="##about" class="btn-get-started scrollto animate__animated animate__fadeInUp">Book Tickets</a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item" style="background-image: url(img/hero-carousel/3.jpg)">
                            <div class="carousel-container">
                                <div class="container">
                                    <h2 class="animate__animated animate__fadeInDown">Temporibus autem quibusdam</h2>
                                    <p class="animate__animated animate__fadeInUp">Beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem</p>
                                    <a href="##about" class="btn-get-started scrollto animate__animated animate__fadeInUp">Book Tickets</a>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                        <a href="##">
                                            <img class="img-fluid" src="admin/uploads/Movie/#MoviesLists.movie_poster#" alt="" width= "100%">
                                        </a>
                                    </div>
                                    <div class="team-content text-center">
                                        <h4>#MoviesLists.movie_name#</h4>
                                        <p>#MoviesLists.movie_lang#</p>
                                        <a href="##about" class="btn-get-started">Book Tickets</a>
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
                                        <a href="blog.html">
                                            <img src="admin/uploads/Movie/#ComingSoonMovies.movie_poster#" alt="">
                                        </a>
                                    </div>
                                    <div class="blog-meta">
                                        <span class="comments-type">
                                            <i class="fa fa-comment-o"></i>
                                            <a href="##">13 comments</a>
                                        </span>
                                        <span class="date-type">
                                            <i class="fa fa-calendar"></i>2016-03-05 / 09:10:16
                                        </span>
                                    </div>
                                    <div class="blog-text">
                                        <h4>
                                            <a href="blog.html">#ComingSoonMovies.movie_name#</a>
                                        </h4>
                                    </div>
                                    <span>
                                        <a href="blog.html" class="ready-btn">More Info</a>
                                    </span>
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
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
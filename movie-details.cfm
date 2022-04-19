<cfobject name="MovieList" component="cfc/user">
<cfif structKeyExists(URL,'movie')>
    <cfif URL.movie NEQ "">
        <cfset variables.movie_id = URL.movie/>
        <cfinvoke component="#MovieList#" method="getMoviesById" returnvariable="MoviesById">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
        </cfinvoke>
        <cfdump  var="#MoviesById#">
    </cfif>
</cfif> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Movie Booking - Movie Details</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <link href="css/frontend/bootstrap.min.css" rel="stylesheet">
    <link href="css/frontend/boxicons.min.css" rel="stylesheet">
    <link href="css/frontend/style.css" rel="stylesheet">
</head>
<body>
    <cfoutput>
        <cfinclude template="header.cfm"> 
        <main id="main">
            <div class="header-bg page-area">
                <div class="container position-relative">
                    <div class="row">
                        <div class="col-lg-5 col-md-5">
                            <div class="post-thumbnail">
                                <img src="assets/img/blog/6.jpg" alt="" />
                            </div>
                        </div>
                        <div class="col-md-7 col-sm-7 col-xs-12">                        
                            <article class="blog-post-wrapper">
                                <div class="post-information">
                                    <h2>Blog image post layout</h2>
                                    <div class="entry-meta">
                                        <span class="author-meta"><i class="bi bi-person"></i> <a href="##">admin</a></span>
                                        <span><i class="bi bi-clock"></i> march 28, 2016</span>
                                        <span class="tag-meta">
                                            <i class="bi bi-folder"></i>
                                            <a href="##">painting</a>,
                                            <a href="##">work</a>
                                        </span>
                                        <span>
                                            <i class="bi bi-tags"></i>
                                            <a href="##">tools</a>,
                                            <a href="##"> Humer</a>,
                                            <a href="##">House</a>
                                        </span>
                                        <span><i class="bi bi-chat"></i> <a href="##">6 comments</a></span>
                                    </div>
                                    <div class="entry-content">
                                        <p>Aliquam et metus pharetra, bibendum massa nec, fermentum odio. Nunc id leo ultrices, mollis ligula in, finibus tortor. Mauris eu dui ut lectus fermentum eleifend. Pellentesque faucibus sem ante, non malesuada odio varius
                                            nec. Suspendisse potenti. Proin consectetur aliquam odio nec fringilla. Sed interdum at justo in efficitur. Vivamus gravida volutpat sodales. Fusce ornare sit amet ligula condimentum sagittis.</p>
                                    </div>
                                </div>
                            </article>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
            </div>       
            <div class="blog-page">
                <div class="container">
                    <div class="row">                   
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">                             
                                    <div class="single-blog-page">                                    
                                        <div class="left-blog">
                                            <h4>Theatre</h4>
                                            <div class="recent-post">                                           
                                                <div class="recent-single-post">
                                                    <div class="post-img">
                                                        <a href="##">
                                                            <img src="assets/img/blog/1.jpg" alt="">
                                                        </a>
                                                    </div>
                                                    <div class="pst-content">
                                                        <p><a href="##"> Redug Lerse dolor sit amet consect adipis elit.</a></p>
                                                    </div>
                                                </div>                                                                                                                               
                                            </div>
                                        </div>                                    
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>        
            <div class="holder">
                <iframe width="560" height="315" src="https://www.youtube.com/embed/SMVjfP8rGQk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                <div class="overlay trigger" src="https://www.youtube.com/embed/SMVjfP8rGQk" data-target="##videoModal" data-toggle="modal"></div>
            </div>

            <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <button type="button" class="close btn-round btn-primary" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="" allowfullscreen></iframe>
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
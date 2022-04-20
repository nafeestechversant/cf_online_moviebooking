<cfobject name="MovieList" component="cfc/user">
<cfif structKeyExists(URL,'movie')>
    <cfif URL.movie NEQ "">
        <cfset variables.movie_id = URL.movie/>
        <cfinvoke component="#MovieList#" method="getMoviesById" returnvariable="MoviesById">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
        </cfinvoke> 
        <cfinvoke component="#MovieList#" method="getTheatreShow" returnvariable="TheatreShow">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
        </cfinvoke>         
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
    <link href="css/frontend/bootstrap-icons.css" rel="stylesheet">    
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
                                <img src="admin/uploads/Movie/#MoviesById.movie_poster#" alt="" />
                            </div>
                        </div>
                        <div class="col-md-7 col-sm-7 col-xs-12">                        
                            <article class="blog-post-wrapper">
                                <div class="post-information">
                                    <h2>#MoviesById.movie_name#</h2>
                                    <p>#MoviesById.movie_lang#</p>
                                    <div class="entry-meta">
                                        <cfif MoviesById.movie_rating EQ 1>
                                            <span><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i></span>
                                        <cfelseif MoviesById.movie_rating EQ 2> 
                                            <span><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i></span>
                                        <cfelseif MoviesById.movie_rating EQ 3> 
                                            <span><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i></span>                                                                                                                        
                                        <cfelseif MoviesById.movie_rating EQ 4> 
                                            <span><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i></span>                                                                                                                        
                                        <cfelseif MoviesById.movie_rating EQ 5> 
                                            <span><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></span>                                                                                                                        
                                        </cfif>                                                                                                                                                   
                                    </div>
                                    <div class="entry-content">
                                        <p>#MoviesById.movie_details#</p>
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
                                            <cfif TheatreShow.recordcount NEQ 0>
                                                <cfloop query="#TheatreShow#">
                                                    <div class="recent-post">                                           
                                                        <div class="recent-single-post">
                                                            <div class="post-img">
                                                                <a href="##">
                                                                    <img src="admin/uploads/MovieTheatres/#TheatreShow.theatre_image#" alt="">
                                                                </a>
                                                            </div>
                                                            <div class="pst-content">
                                                                <p><a href="##"> #TheatreShow.theatre_name#</a></p>
                                                            </div>
                                                        </div>                                                                                                                               
                                                    </div>
                                                </cfloop>
                                            <cfelse>
                                                This Movie not showing any theatre
                                            </cfif>                                            
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
                <iframe width="560" height="315" src="#MoviesById.movie_youtubelink#" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                <div class="overlay trigger" src="#MoviesById.movie_youtubelink#" data-target="##videoModal" data-toggle="modal"></div>
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
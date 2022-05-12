<cfobject name="MovieList" component="cfc/user">
<cfif structKeyExists(URL,'movie')>
    <cfif URL.movie NEQ "">
        <cfset variables.movie_id = URL.movie/>
        <cfinvoke component="#MovieList#" method="getMoviesById" returnvariable="MoviesById">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
        </cfinvoke> 
        <cfinvoke component="#MovieList#" method="getTheatresByDate" returnvariable="TheatreShow">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
            <cfinvokeargument  name="curr_date" value="#DateFormat(Now(),"yyyy-mm-dd")#" />
            <cfinvokeargument  name="curr_time" value="#DateFormat(Now(),"HH:mm:ss")#" />
        </cfinvoke>
        <cfinvoke component="#MovieList#" method="getDateofShow" returnvariable="DateofShow">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
            <cfinvokeargument  name="curr_date" value="#DateFormat(Now(),"yyyy-mm-dd")#" />            
        </cfinvoke>           
    </cfif>
<cfelse>
    <cflocation url = "index.cfm" addtoken="false" />
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
    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/popper.min.js" ></script>
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
                                <span class="tn-play-icon"><img src="img/movie-video-play-icon.png"></span>
                                <div class="overlay trigger" src="#MoviesById.movie_youtubelink#" data-bs-target="##videoModal" data-bs-toggle="modal"></div>
                            </div>
                        </div>
                        <div class="col-md-7 col-sm-7 col-xs-12">                        
                            <article class="blog-post-wrapper">
                                <div class="post-information">
                                    <h2>#MoviesById.movie_name#</h2>
                                    <p>#MoviesById.movie_lang#</p>
                                    <div class="entry-meta">
                                        <span><i class="bi bi-clock"></i> march 28, 2016 |  2 hrs 35 mins</span>
                                    </div>
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
            <div class="blog-page detial-padd">
                <div class="container">
                    <div class="row">                   
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">                             
                                    <div class="single-blog-page">                                    
                                        <div class="left-blog">
                                            <h4>Theatre</h4>
                                            <ul class="nav nav-tabs">
                                                <cfloop query="#DateofShow#">
                                                    <li class="nav-item">
                                                        <a class="nav-link filterbyDate #IIF(DateofShow.start_date eq DateFormat(Now(),"yyyy-mm-dd"), de('active'), de(''))#" aria-current="page" data-currDate="#DateofShow.start_date#" data-movieId="#variables.movie_id#">#DateFormat(DateofShow.start_date,"dd")#<br>#DateFormat(DateofShow.start_date,"ddd")#</a>
                                                    </li>
                                                </cfloop>                                                                                             
                                            </ul>
                                            <div id="results">
                                                <cfif TheatreShow.recordcount NEQ 0>
                                                    <cfloop query="#TheatreShow#">
                                                        <cfinvoke component="#MovieList#" method="getTheatreById" returnvariable="TheatreById">
                                                            <cfinvokeargument  name="theatre_id" value="#TheatreShow.theatre_id#" />
                                                        </cfinvoke>
                                                        <cfinvoke component="#MovieList#" method="getTheatreShowTime" returnvariable="TheatreShowTime">
                                                            <cfinvokeargument  name="theatre_id" value="#TheatreShow.theatre_id#" />
                                                            <cfinvokeargument  name="curr_date" value="#DateFormat(Now(),"yyyy-mm-dd")#" />
                                                            <cfinvokeargument  name="curr_time" value="#DateFormat(Now(),"HH:mm:ss")#" />
                                                        </cfinvoke>  
                                                        <div class="recent-post">                                           
                                                            <div class="recent-single-post">
                                                                <div class="post-img">
                                                                    <a href="##">
                                                                        <img src="admin/uploads/MovieTheatres/#TheatreById.theatre_image#" alt="">                                                                        
                                                                    </a>
                                                                </div>
                                                                <div class="pst-content">
                                                                    <p><a href="##"> #TheatreById.theatre_name#</a></p>
                                                                    <span>Location</span>
                                                                </div>
                                                                <div class="pst-shwtime">
                                                                    <ul>
                                                                        <cfloop query="#TheatreShowTime#">
                                                                            <li><a href="movieticket_booking.cfm?Req_date=#URLEncodedFormat(Encrypt(DateFormat(Now(),"yyyy-mm-dd"), "abc!@"))#&shw_id=#URLEncodedFormat(Encrypt(TheatreShowTime.show_id, "abc!@"))#&mov_id=#URLEncodedFormat(Encrypt(variables.movie_id, "abc!@"))#">#TheatreShowTime.start_time#</a></li> 
                                                                        </cfloop>                                                                  
                                                                    </ul>                                                                
                                                                </div>
                                                            </div>                                                                                                                               
                                                        </div>
                                                    </cfloop>
                                                <cfelse>
                                                    This Movie not showing any theatre
                                                </cfif> 
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
            <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content adj_trailer">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" width="900" height="500" src="#MoviesById.movie_youtubelink#" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <cfinclude template="footer.cfm">
    </cfoutput>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
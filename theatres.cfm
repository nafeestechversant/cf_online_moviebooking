<cfobject name="TheatreList" component="cfc/user">
<cfinvoke component="#TheatreList#" method="getHomeMovies" returnvariable="MoviesLists"></cfinvoke>
<cfinvoke component="#TheatreList#" method="getTheatres" returnvariable="TheatreLists"></cfinvoke>
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
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">                             
                                    <div class="single-blog-page">                                    
                                        <div class="left-blog">
                                            <h4>Theatre</h4>
                                            <cfif TheatreLists.recordcount NEQ 0>
                                                <cfloop query="#TheatreLists#">
                                                    <div class="recent-post">                                           
                                                        <div class="recent-single-post">
                                                            <div class="post-img">
                                                                <a href="##">
                                                                    <img src="admin/uploads/MovieTheatres/#TheatreLists.theatre_image#" alt="">
                                                                </a>
                                                            </div>
                                                            <div class="pst-content">
                                                                <p><a href="##">#TheatreLists.theatre_name#</a></p>
                                                                <span>Location</span>
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
        </main>
        <cfinclude template="footer.cfm">
    </cfoutput> 
    <script src="js/bootstrap.bundle.min.js"></script>   
    <script src="js/main.js"></script>
</body>
</html>
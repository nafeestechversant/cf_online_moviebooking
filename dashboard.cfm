<cfobject name="MovieList" component="cfc/user">
<cfinvoke component="#MovieList#" method="getUsrBookHis" returnvariable="BookingHistory"></cfinvoke>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Movie Booking - Dashboard</title>
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
            </div>        
            <div class="blog-page area-padding pb-160">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-3">
                            <div class="page-head-blog">                                
                                <div class="single-blog-page">
                                    <div class="left-blog">                                       
                                        <ul>
                                            <li>
                                                <a class="active-link" href="dashboard.cfm">Booking History</a>
                                            </li>
                                            <li>
                                                <a href="edit-profile.cfm">Edit Profile</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <h4>Booking History</h4>                                   
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">BookingId</th>
                                                <th scope="col">Movie</th>
                                                <th scope="col">Theatre</th>
                                                <th scope="col">Booked On</th>
                                                <th scope="col">Show Time</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfset variables.sno = 1 >
                                            <cfloop query="#BookingHistory#">
                                                <cfinvoke component="#MovieList#" method="getMoviesById" returnvariable="MoviesById">
                                                    <cfinvokeargument  name="movie_id" value="#BookingHistory.movie_id#" />
                                                </cfinvoke> 
                                                 <cfinvoke component="#MovieList#" method="getTheatreById" returnvariable="TheatreById">
                                                    <cfinvokeargument  name="theatre_id" value="#BookingHistory.theatre_id#" />
                                                </cfinvoke> 
                                                <tr>
                                                    <th scope="row">#sno#</th>
                                                    <td>#MoviesById.movie_name#</td>
                                                    <td>#TheatreById.theatre_name#</td>
                                                    <td>#BookingHistory.booked_on#</td>
                                                    <td>#BookingHistory.start_time#</td>
                                                    <td><a href="ticket_pdf.cfm?tic_id=#URLEncodedFormat(Encrypt(BookingHistory.booking_id, "abc!@"))#">Download Ticket</a></td>
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
            </div>
        </main>
        <cfinclude template="footer.cfm">
    </cfoutput>    
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
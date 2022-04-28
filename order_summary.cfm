<cfobject name="OrderSummary" component="cfc/user">
<cfif structKeyExists(session,'BookingDetails')>
    <cfif session.BookingDetails.mov_id NEQ "">      
        <cfinvoke component="#OrderSummary#" method="getMoviesById" returnvariable="MoviesById">
            <cfinvokeargument  name="movie_id" value="#session.BookingDetails.mov_id#" />
        </cfinvoke>
    </cfif> 
    <cfif session.BookingDetails.shw_id NEQ "">      
        <cfinvoke component="#OrderSummary#" method="getShowById" returnvariable="ShowById">
            <cfinvokeargument  name="shw_id" value="#session.BookingDetails.shw_id#" />
        </cfinvoke>
        <cfinvoke component="#OrderSummary#" method="getTheatreById" returnvariable="TheatreName">
            <cfinvokeargument  name="theatre_id" value="#ShowById.theatre_id#" />
        </cfinvoke>
    </cfif> 
</cfif>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Movie Booking - Order Summary</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <link href="css/frontend/seat-style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="css/frontend/bootstrap.min.css" rel="stylesheet">     
    <link href="css/frontend/style.css" rel="stylesheet">
</head>
<body>
    <cfoutput>
        <cfinclude template="header.cfm"> 
        <main id="main">            
            <div class="order_sum">               
                <div class="container">
                    <h3 class="order_title">Order Summary</h3>
                    <div class="row">
                        <div class="col-7">
                        <div class="movie-title">
                            <h3>#MoviesById.movie_name#</h3>
                            <p>#MoviesById.movie_lang#</p>
                        </div>
                            <table class="table">
                                
                                <tbody>
                                    <tr>
                                    <th scope="row" class="border-right ">Date</th>
                                        <td class="border-right ">#session.BookingDetails.req_date#</td>                                  
                                    </tr>
                                     <tr>
                                    <th scope="row" class="border-right ">Time</th>
                                        <td class="border-right ">#ShowById.start_time#</td>                                  
                                    </tr>  
                                    <tr>
                                    <th scope="row">Theatre</th>
                                        <td class="border-right ">#TheatreName.theatre_name#</td>                                  
                                    </tr> 
                                    <tr>
                                    <th scope="row">Seat</th>
                                        <td class="border-right ">#session.BookingDetails.booked_seats#</td>                                  
                                    </tr>                                                                       
                                </tbody>
                            </table>
                        </div>
                        <div class="col-5">  
                        <div class="summary">
                            <h3>Order Summary</h3>
                        </div>                          
                            <ul class="book-left">
                        
                                <li>Tickets</li>
                                <li>Total</li>                                
                            </ul>
                            <ul class="book-right">
                           
                                <li>: <span id="counter">#session.BookingDetails.tick_count#</span></li>
                                <li>: <b><i>Rs </i><span id="total">#session.BookingDetails.total_price#</span></b></li>
                            </ul>
                            <div class="clear"></div>  
                            <div class="">
                                <input type="submit" value="Confirm Book" id="confirm_book" class="checkout-button" /> 
                                <input type="button" value="Cancel" class="checkout-button cnce-btn" />    
                            </div>                                                   
                            
                                                                                                                                       
                        </div>
                    </div>
                </div>                                                                                                                                                           
            </div>
        </main>
    </cfoutput>   
    <script src="js/jquery.min.js"></script>    
    <script src="js/main.js"></script>
</body>
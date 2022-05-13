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
    <cfset variables.convert_rupees = session.BookingDetails.total_price * 100>
   
</cfif>
<cfif structKeyExists(session,'stLoggedInUser')>
    <cfif session.stLoggedInUser.userID NEQ "">
          <cfinvoke component="#OrderSummary#" method="getUsrById" returnvariable="UsrById"></cfinvoke>    
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
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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
                                <div class="summary">
                                    <h3>User Details</h3>
                                    <table class="">                                
                                        <tbody>
                                            <tr>
                                                <td>Name</td>
                                                <td>:</td>
                                                <td class="">#UsrById.user_fullname#</td>                                  
                                            </tr>
                                            <tr>
                                                <td>Email</td>
                                                <td>:</td>
                                                <td class="">#UsrById.user_email#</td>                                  
                                            </tr>
                                            <tr>
                                                <td>Mobile</td>
                                                <td>:</td>
                                                <td class="">#UsrById.user_phone#</td>                                  
                                            </tr>                                                                                                                                                        
                                        </tbody>
                                    </table>
                                </div>
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
                                    <button id="rzp-button1" class="checkout-button">Make Payment</button>
                                <!---  <input type="submit" value="Confirm Book" id="confirm_book" class="checkout-button" />  --->
                                    <input type="button" value="Cancel" class="checkout-button cnce-btn" />    
                                    
                                </div>                            
                            </div>
                        </div>
                    </div>                                                                                                                                                           
                </div>
            </main>
            <script>
                var options = {
                    "key": "rzp_test_dKHSAwIaRKIBft", 
                    "amount": "#variables.convert_rupees#", 
                    "currency": "INR",
                    "name": "Movie Ticket Booking",
                    "description": "Test Transaction",
                    "image": "https://example.com/your_logo",  
                    "callback_url": "http://127.0.0.1:8500/cf_online_moviebooking/cfc/user.cfc?method=addBooking&returnformat=json",                
                    "prefill": {
                        "name": "#UsrById.user_fullname#",
                        "email": "#UsrById.user_email#",
                        "contact": "#UsrById.user_phone#"
                    },
                    "notes": {
                        "address": "Razorpay Corporate Office"
                    },
                    "theme": {
                        "color": "##3399cc"
                    }
                };
                var rzp1 = new Razorpay(options);
                rzp1.on('payment.failed', function (response){
                
                });
                document.getElementById('rzp-button1').onclick = function(e){
                    rzp1.open();
                    e.preventDefault();
                }
            </script>
        </cfoutput>   
        <script src="js/jquery.min.js"></script>    
        <script src="js/main.js"></script>            
    </body>
</html>
<cfobject name="MovieBooking" component="cfc/user">
<cfif structKeyExists(URL,'mov_id')>
    <cfif URL.mov_id NEQ "">
        <cfset variables.movie_id = Decrypt(URL.mov_id, "abc!@") />
        <cfinvoke component="#MovieBooking#" method="getMoviesById" returnvariable="MoviesById">
            <cfinvokeargument  name="movie_id" value="#variables.movie_id#" />
        </cfinvoke>
    </cfif> 
</cfif>
<cfif structKeyExists(URL,'shw_id')>
    <cfif URL.shw_id NEQ "">
        <cfset variables.shw_id = Decrypt(URL.shw_id, "abc!@") />
        <cfinvoke component="#MovieBooking#" method="getShowById" returnvariable="ShowById">
            <cfinvokeargument  name="shw_id" value="#variables.shw_id#" />
        </cfinvoke>
        <cfinvoke component="#MovieBooking#" method="getBookedShowById" returnvariable="BookedShowById">
            <cfinvokeargument  name="shw_id" value="#variables.shw_id#" />
        </cfinvoke>       
    </cfif> 
</cfif>
<cfif structKeyExists(URL,'Req_date')>
    <cfif URL.Req_date NEQ "">
        <cfset variables.Req_date = Decrypt(URL.Req_date, "abc!@") />
    </cfif>
</cfif>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Movie Booking - Movie Ticket Booking</title>
    <meta content="" name="description">
    <meta content="" name="keywords"> 
    <link href="css/frontend/bootstrap.min.css" rel="stylesheet">
    <link href="css/frontend/style.css" rel="stylesheet">   
    <link href="css/frontend/seat-style.css" rel="stylesheet" type="text/css" media="all" />
    <script src="js/jquery-1.11.0.min.js"></script>
  
</head>
<body>
    <cfoutput>
        <cfinclude template="header.cfm"> 
            <main id="main">               
                <div class="main">
                    <h2>Multiplex Theatre Showing Screen 1</h2>
                    <div class="demo">
                        <div id="seat-map">
                            <div class="front">SCREEN</div>
                        </div>
                        <div class="booking-details">
                            <ul class="book-left">
                                <li>Movie </li>
                                <li>Time </li>
                                <li>Tickets</li>
                                <li>Total</li>
                                <li>Seats :</li>
                            </ul>
                            <ul class="book-right">
                                <li>: #MoviesById.movie_name#</li>
                                <li>: #DateFormat(variables.Req_date,"mmmm dd")#, #ShowById.start_time#</li>
                                <li>: <span id="counter">0</span></li>
                                <li>: <b><i>Rs </i><span id="total">0</span></b></li>
                            </ul>
                            <div class="clear"></div>
                            <ul id="selected-seats" class="scrollbar scrollbar1"></ul>
                            <input type="hidden"  id="req_date" value="#variables.Req_date#">
                            <input type="hidden"  id="shw_id" value="#variables.shw_id#">
                            <input type="hidden"  id="mov_id" value="#variables.movie_id#">
                            <input type="button" value="Book Now" class="checkout-button" />                            
                            <div id="legend"></div>
                        </div>
                        <div style="clear:both"></div>
                    </div>

                    <script type="text/javascript">
                        
                        $(document).ready(function() {
                            var $cart = $('##selected-seats'), //Sitting Area
                                $counter = $('##counter'), //Votes
                                $total = $('##total'); //Total money

                            var sc = $('##seat-map').seatCharts({
                                map: [ //Seating chart
                                    'oooooooooo',
                                    'oooooooooo',
                                    '__________',
                                    'gggggggg__',
                                    'gggggggggg',
                                    'gggggggggg',
                                    'gggggggggg',
                                    'bbbbbbbbbb',
                                    'bbbbbbbbbb',
                                    '__bbbbbb__'
                                ],
                               seats: {
                                        o: {
                                            price   : #ShowById.price_odc_full#,
                                            classes : 'odc-seat' //your custom CSS class
                                        },
                                        g: {
                                            price   : #ShowById.price_gold_full#,
                                            classes : 'gold-seat' //your custom CSS class
                                        },
                                        b: {
                                            price   : #ShowById.price_box#,
                                            classes : 'box-seat' //your custom CSS class
                                        }
                                    
                                },
                                naming: {
                                    top: false,
                                    getLabel: function(character, row, column) {
                                        return column;
                                    }
                                },
                                legend: { //Definition legend
                                    node: $('##legend'),
                                    items: [
                                        ['o', 'odc_available', 'Odc'], 
                                        ['g', 'gold_available', 'Gold'],
                                        ['b', 'box_available', 'Box'],                                           
                                        ['a', 'unavailable', 'Sold'],
                                        ['a', 'selected', 'Selected']
                                    ]
                                },
                                click: function() { //Click event
                                    if (this.status() == 'available') { //optional seat
                                        $('<li>Row' + (this.settings.row + 1) + ' Seat' + this.settings.label + '<b> Rs : '+this.data().price+'</b> <a href="##" class="cancel-cart-item">[cancel]</a></li>')
                                            .attr('id', 'cart-item-' + this.settings.id)
                                            .data('seatId', this.settings.id)
                                            .appendTo($cart);

                                        $counter.text(sc.find('selected').length + 1);
                                        $total.text(recalculateTotal(sc) + this.data().price);

                                        return 'selected';
                                    } else if (this.status() == 'selected') { //Checked
                                        //Update Number
                                        $counter.text(sc.find('selected').length - 1);
                                        //update totalnum
                                        $total.text(recalculateTotal(sc) - this.data().price);

                                        //Delete reservation
                                        $('##cart-item-' + this.settings.id).remove();
                                        //optional
                                        return 'available';
                                    } else if (this.status() == 'unavailable') { //sold
                                        return 'unavailable';
                                    } else {
                                        return this.style();
                                    }
                                }
                            });

                            

                            $('##selected-seats').on('click','.cancel-cart-item',function () {     
                            sc.get($(this).parents('li:first').data('seatId')).click();
                            });


                            //sold seat
                            //sc.get(['1_2', '4_4', '4_5', '6_6', '6_7', '8_5', '8_6', '8_7', '8_8', '10_1', '10_2']).status('unavailable');
                             sc.get([#BookedShowById#]).status('unavailable');

                        });

                        
                        //sum total money
                        function recalculateTotal(sc) {
                            var total = 0;
                            sc.find('selected').each(function() {
                                total += this.data().price;
                            });

                            return total;
                        }
                    </script>
                </div>       
            </main>
      <cfinclude template="footer.cfm">
    </cfoutput>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/jquery.seat-charts.js"></script>
<!---     <script src="js/jquery.nicescroll.js"></script> --->
    <script src="js/seat-scripts.js"></script>
</body>
</html>
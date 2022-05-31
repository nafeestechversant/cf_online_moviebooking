<cfobject component="cfc/user" name="ticketPdf">
<cfif structKeyExists(URL,'tic_id')>
    <cfif URL.tic_id NEQ "">
        <cfset variables.ticket_id = Decrypt(URL.tic_id, "abc!@") />
        <cfinvoke component="#ticketPdf#" method="getTicket" returnvariable="getTicketLists">
             <cfinvokeargument  name="tic_id" value="#variables.ticket_id#" />        
        </cfinvoke>
        <cfinvoke component="#ticketPdf#" method="getMoviesById" returnvariable="MoviesById">
            <cfinvokeargument  name="movie_id" value="#getTicketLists.movie_id#" />
        </cfinvoke>
        <cfinvoke component="#ticketPdf#" method="getShowById" returnvariable="ShowById">
            <cfinvokeargument  name="shw_id" value="#getTicketLists.show_id#" />
        </cfinvoke>
        <cfinvoke component="#ticketPdf#" method="getTheatreById" returnvariable="TheatreName">
            <cfinvokeargument  name="theatre_id" value="#ShowById.theatre_id#" />
        </cfinvoke>
   </cfif> 
</cfif>

<cfheader name="Content-Disposition" value="attachment; filename=myDoc.pdf">
    <cfcontent type="application/pdf">    
    <cfdocument format="PDF">
        <cfoutput>  
            <link href="css/frontend/pdf.css" rel="stylesheet">      
           <div class="ticket">
                <div class="title">
                    <p class="cinema">#MoviesById.movie_name#</p>
                </div>
                <div class="info">
                    <table border="2">
                        <tr>
                            <th>Theatre</th>
                            <th>Row</th>
                            <th>Seat</th>
                        </tr>
                        <tr>
                            <td class="bigger">#TheatreName.theatre_name#</td>
                            <td class="bigger" colspan="2">#getTicketLists.booked_seat#</td>
<!---                             <td class="bigger">24</td> --->
                        </tr>
                    </table>
                    <table border="2">
                        <tr>
                            <th>PRICE</th>
                            <th>DATE</th>
                            <th>TIME</th>
                        </tr>
                        <tr>
                            <td>#getTicketLists.total_price#</td>
                            <td>#DateFormat(getTicketLists.booked_on,"dd/mm/yyyy")#</td>
                            <td>#ShowById.start_time#</td>
                        </tr>
                    </table>
                </div>
                <div class="holes-lower"></div>               
            </div>
        </cfoutput>
    </cfdocument>
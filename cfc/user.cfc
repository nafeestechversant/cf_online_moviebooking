<cfcomponent>
    <cffunction name="getHomeMovies" access="public" output="false" returntype="query">		
		<cfquery name="qry.rs_getHomeMovies">
			SELECT movie_id,movie_name,movie_poster,movie_lang FROM mv_movies WHERE active_homepage = <cfqueryparam value="1" cfsqltype="cf_sql_integer" /> ORDER BY updated_time DESC
		</cfquery>		
		<cfreturn qry.rs_getHomeMovies />
	</cffunction>

    <cffunction name="getComingSoonMovies" access="public" output="false" returntype="query">		
		<cfquery name="qry.rs_getHomeMovies">
			SELECT movie_id,movie_name,movie_poster,movie_lang FROM mv_movies WHERE coming_soon = <cfqueryparam value="1" cfsqltype="cf_sql_integer" /> ORDER BY updated_time DESC
		</cfquery>		
		<cfreturn qry.rs_getHomeMovies />
	</cffunction>

	<cffunction name="getMovies" access="public" output="false" returntype="query">		
		<cfquery name="qry.rs_getMovies">
			SELECT movie_id,movie_name,movie_poster,movie_lang,movie_rating FROM mv_movies ORDER BY movie_id DESC
		</cfquery>		
		<cfreturn qry.rs_getMovies />
	</cffunction>

	<cffunction name="getMoviesById" access="public" output="false" returntype="query">	
		<cfargument name="movie_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getMoviesById">
			SELECT movie_id,movie_name,movie_poster,movie_lang,movie_details,movie_youtubelink,movie_rating FROM mv_movies WHERE movie_id = <cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getMoviesById />
	</cffunction>

	<cffunction name="getTheatres" access="public" output="false" returntype="query">		
		<cfquery name="qry.rs_getTheatres">
			SELECT theatre_id,theatre_name,theatre_image FROM mv_movie_theatres ORDER BY theatre_id DESC
		</cfquery>		
		<cfreturn qry.rs_getTheatres />
	</cffunction>

	<cffunction name="getTheatreById" access="public" output="false" returntype="query">	
		<cfargument name="theatre_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getTheatreById">
			SELECT theatre_name,theatre_image FROM mv_movie_theatres WHERE theatre_id = <cfqueryparam value="#arguments.theatre_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getTheatreById />
	</cffunction>

	<cffunction name="getTheatreShow" access="public" output="false" returntype="query">	
		<cfargument name="movie_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getTheatreShow">
			SELECT tr.theatre_id,tr.theatre_name,tr.theatre_image,st.show_id FROM mv_show_timing st JOIN mv_movie_theatres tr ON st.theatre_id=tr.theatre_id WHERE  st.movie_id= <cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getTheatreShow />
	</cffunction>

	<cffunction name="getTheatresByDate" access="public" output="false" returntype="query">	
		<cfargument name="movie_id" type="integer" required="true" />
		<cfargument name="curr_date" type="string" required="true" />	
		<cfquery name="qry.rs_getTheatresByDate">
			SELECT DISTINCT `theatre_id` FROM `mv_show_timing` WHERE movie_id=<cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" /> AND start_date=<cfqueryparam value="#arguments.curr_date#" cfsqltype="cf_sql_date" />;
		</cfquery>		
		<cfreturn qry.rs_getTheatresByDate />
	</cffunction>

	<cffunction name="getTheatreShowTime" access="public" output="false" returntype="query">	
		<cfargument name="theatre_id" type="integer" required="true" />	
		<cfargument name="curr_date" type="string" required="true" />	
		<cfquery name="qry.rs_getTheatresShowTime">
			SELECT show_id,start_time,movie_id FROM mv_show_timing WHERE theatre_id=<cfqueryparam value="#arguments.theatre_id#" cfsqltype="cf_sql_integer" /> AND start_date=<cfqueryparam value="#arguments.curr_date#" cfsqltype="cf_sql_date" /> ORDER BY start_time DESC;
		</cfquery>		
		<cfreturn qry.rs_getTheatresShowTime />
	</cffunction>

	<cffunction name="getDateofShow" access="public" output="false" returntype="query">	
		<cfargument name="movie_id" type="integer" required="true" />
		<cfargument name="curr_date" type="string" required="true" />			
		<cfquery name="qry.rs_getDateofShow">
			SELECT DISTINCT `start_date` FROM `mv_show_timing` WHERE movie_id=<cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" /> AND start_date >= <cfqueryparam value="#arguments.curr_date#" cfsqltype="cf_sql_date" /> ORDER BY start_date ASC;
		</cfquery>		
		<cfreturn qry.rs_getDateofShow />
	</cffunction>

	<cffunction name="addUser" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.fld_userName = form.fld_userName/>
		<cfset variables.fld_userEmail = form.fld_userEmail/>
		<cfset variables.fld_userMobile = form.fld_userMobile/>	
		<cfset variables.fld_userPwd = form.fld_userPwd/>
		<cfset variables.fld_userCnfPwd = form.fld_userCnfPwd/>	
		<cfif trim(variables.fld_userName) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Full Name')>
		</cfif>	
		<cfif trim(variables.fld_userEmail) EQ '' OR NOT isValid("eMail", variables.fld_userEmail)>
			<cfset arrayAppend(errorMessage, 'Please Enter valid Email')>
		</cfif>	
		<cfif trim(variables.fld_userMobile) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Mobile')>
		</cfif>	
		<cfif trim(variables.fld_userPwd) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Password')>
		</cfif>	
		<cfif trim(variables.fld_userCnfPwd) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Confirm Password')>
		</cfif>	
		<cfif  variables.fld_userCnfPwd NOT EQUAL '' AND variables.fld_userPwd NOT EQUAL variables.fld_userCnfPwd>
			<cfset arrayAppend(errorMessage, 'Confirm Password Mismatch')>
		</cfif>	
		<cfquery name="qry.checkEmail">
			SELECT user_email FROM mv_users WHERE user_email = <cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfif qry.checkEmail.recordcount EQ 1>
			<cfset arrayAppend(errorMessage, 'Email Already exists')>
		</cfif>			
		<cfif NOT arrayIsEmpty(errorMessage)>
			
		</cfif>
				
		<cfif arrayIsEmpty(errorMessage)>			
			<cfquery name="tableElements" result="result">
				INSERT INTO mv_users (user_fullname,user_phone,user_email,user_pwd)
				VALUES (
						<cfqueryparam value="#variables.fld_userName#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.fld_userMobile#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />,						
						<cfqueryparam value="#hash(variables.fld_userPwd,'SHA')#" cfsqltype="cf_sql_varchar" />																					
					)
			</cfquery>
			<cfset variables.lastInsertId = result.generatedkey>
			<cfset session.stLoggedInUser = {'userFullName' = variables.fld_userName, 'userID' = variables.lastInsertId} > 													
		</cfif>		
 		<cfreturn variables.errorMessage />
	</cffunction>

	<cffunction name="checkUserLogin" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.fld_userEmail = form.fld_userEmail/>
		<cfset variables.fld_userPwd = form.fld_userPwd/>		
		<cfif variables.fld_userEmail EQ ''>
			<cfset session.Errmsg = 'Please Enter Email' />
			<cflocation url = "../index.cfm" addtoken="false" />			
		</cfif>
		<cfif variables.fld_userPwd EQ ''>
			<cfset session.Errmsg = 'Please Enter Password' />
			<cflocation url = "../index.cfm" addtoken="false" />				
		</cfif>
		<cfif arrayIsEmpty(errorMessage)>
			<cfquery name="qry.checkLogin">
				SELECT * FROM mv_users 
					WHERE user_email = <cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" /> AND user_pwd = <cfqueryparam value="#hash(variables.fld_userPwd,'SHA')#" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfif qry.checkLogin.recordcount EQ 1>
				<cfset session.stLoggedInUser = {'userFullName' = qry.checkLogin.user_fullname, 'userID' = qry.checkLogin.user_id} > 
				<cfset structdelete(session,'Errmsg')>				
			<cfelse>				
				<cfset session.Errmsg = 'Invalid User Login' />			
				<cflocation url = "../index.cfm" addtoken="false" />
			</cfif>
		</cfif>	
		<cfreturn qry.checkLogin.recordcount />		
	</cffunction>

	<cffunction name="getUsrBookHis" access="public" output="false" returntype="query">			
		<cfquery name="qry.rs_getUsrBookHis">
			SELECT mb.booked_on,mb.booking_id,ms.theatre_id,ms.movie_id,mb.show_id,ms.start_time FROM mv_booking mb JOIN mv_show_timing ms ON mb.show_id=ms.show_id WHERE  mb.user_id= <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" /> ORDER BY mb.created_time DESC
		</cfquery>		
		<cfreturn qry.rs_getUsrBookHis />
	</cffunction>

	<cffunction name="getUsrById" access="public" output="false" returntype="query">				
		<cfquery name="qry.rs_getUsrById">
			SELECT user_fullname,user_phone,user_email,user_address FROM mv_users WHERE user_id = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getUsrById />
	</cffunction>

	<cffunction name="editUser" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.fld_userName = form.fld_userName/>
		<cfset variables.fld_userEmail = form.fld_userEmail/>
		<cfset variables.fld_userMobile = form.fld_userMobile/>	
		<cfset variables.fld_userPwd = form.fld_userPwd/>
		<cfset variables.fld_userAddr = form.fld_userAddr/>
		<cfset variables.fld_userCnfPwd = form.fld_userCnfPwd/>	
		<cfif trim(variables.fld_userName) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Full Name')>
		</cfif>	
		<cfif trim(variables.fld_userEmail) EQ '' OR NOT isValid("eMail", variables.fld_userEmail)>
			<cfset arrayAppend(errorMessage, 'Please Enter valid Email')>
		</cfif>	
		<cfif trim(variables.fld_userMobile) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Mobile')>
		</cfif>		
		<cfif  variables.fld_userCnfPwd NOT EQUAL '' AND variables.fld_userPwd NOT EQUAL variables.fld_userCnfPwd>
			<cfset arrayAppend(errorMessage, 'Confirm Password Mismatch')>
		</cfif>	
		<cfquery name="qry.checkEmail">
			SELECT user_email FROM mv_users WHERE user_email = <cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />
		</cfquery>
				
		<cfif NOT arrayIsEmpty(errorMessage)>
			
		</cfif>
				
		<cfif arrayIsEmpty(errorMessage)>			
			<cfquery name="tableElements" result="result">
				UPDATE mv_users SET 			
				user_fullname = <cfqueryparam value="#variables.fld_userName#" cfsqltype="cf_sql_varchar" />,				
				user_phone = <cfqueryparam value="#variables.fld_userMobile#" cfsqltype="cf_sql_varchar" />,
				user_email = <cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />,				
				user_address = <cfqueryparam value="#variables.fld_userAddr#" cfsqltype="cf_sql_varchar" />				
				WHERE user_id = #session.stLoggedInUser.userID#
			</cfquery>	
			<cflocation url = "../edit-profile.cfm" addtoken="false" />		
		</cfif>		
 		<cfreturn variables.errorMessage />
	</cffunction>

	<cffunction name="filterTheatre" access="remote" output="false" returnFormat = "plain" returntype="string">	
		<cfargument name="movieId" type="integer" required="true" />
		<cfargument name="currDate" type="string" required="true" />	
		<cfquery name="qry.rs_getTheatresByDate" result="result">
			SELECT DISTINCT `theatre_id` FROM `mv_show_timing` WHERE movie_id=<cfqueryparam value="#arguments.movieId#" cfsqltype="cf_sql_integer" /> AND start_date=<cfqueryparam value="#arguments.currDate#" cfsqltype="cf_sql_date" />;
		</cfquery>	

		<cfset variables.html = "">		
		<cfsavecontent variable="variables.html">
			<cfoutput>				
				<cfloop query="qry.rs_getTheatresByDate">
				 <cfset variables.TheatreById = this.getTheatreById(qry.rs_getTheatresByDate.theatre_id) />
				 <cfset variables.TheatreShowTime = this.getTheatreShowTime(qry.rs_getTheatresByDate.theatre_id,arguments.currDate) />
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
										<li><a href="movieticket_booking.cfm?Req_date=#URLEncodedFormat(Encrypt(arguments.currDate, "abc!@"))#&shw_id=#URLEncodedFormat(Encrypt(TheatreShowTime.show_id, "abc!@"))#&mov_id=#URLEncodedFormat(Encrypt(TheatreShowTime.movie_id, "abc!@"))#">#TheatreShowTime.start_time#</a></li>									
									</cfloop>
								</ul>                                                                
							</div>
						</div>                                                                                                                               
					</div>
				</cfloop>
			</cfoutput>
		</cfsavecontent>
		<cfreturn variables.html>		
	</cffunction>

	<cffunction name="getShowById" access="public" output="false" returntype="query">	
		<cfargument name="shw_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getShowById">
			SELECT start_time,online_booking,price_gold_full,price_gold_half,price_odc_full,price_odc_half,price_box,theatre_id FROM mv_show_timing WHERE show_id = <cfqueryparam value="#arguments.shw_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getShowById />
	</cffunction>

	<cffunction name="getBookedShowById" access="public" returntype="any">	
		<cfargument name="shw_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getBookedShowById">
			SELECT booked_seat FROM mv_booking WHERE show_id = <cfqueryparam value="#arguments.shw_id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset variables.rec_cont = qry.rs_getBookedShowById.recordcount />			
		<cfset variables.bked_seat = '' />
		<cfloop query = "qry.rs_getBookedShowById"> 		
			<cfset bked_seat = listAppend(bked_seat, booked_seat) />						
		</cfloop>
		<cfreturn variables.bked_seat />	
	</cffunction>

	<cffunction name="addBooking" access="remote" output="false">
		<cfif structKeyExists(session,'BookingDetails')> 	
			<cfquery name="qry.rs_addBooking" result="result">
					INSERT INTO mv_booking (user_id,movie_id,show_id,booked_on,booked_seat,total_price,category_name)
					VALUES (
							<cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />,
							<cfqueryparam value="#session.BookingDetails.mov_id#" cfsqltype="cf_sql_integer" />,
							<cfqueryparam value="#session.BookingDetails.shw_id#" cfsqltype="cf_sql_integer" />,
							<cfqueryparam value="#session.BookingDetails.req_date#" cfsqltype="cf_sql_date" />,																		
							<cfqueryparam value="#session.BookingDetails.booked_seats#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#session.BookingDetails.total_price#" cfsqltype="cf_sql_decimal" />,
							<cfqueryparam value="Gold" cfsqltype="cf_sql_varchar" />																		
						)
			</cfquery>			
			<cfset structdelete(session,'BookingDetails') />									
		</cfif>	
<!--- 		<cflocation url = "../dashboard.cfm" addtoken="false" /> --->
		<cfreturn result.RECORDCOUNT />						
	</cffunction>

	<cffunction name="checkLoginOrNot" access="remote" returntype="boolean">				
		<cfif structKeyExists(session,'stLoggedInUser')> 
			<cfset variables.return_value = true /> 
		<cfelse>
			<cfset variables.return_value = false />
		</cfif>	
		<cfreturn variables.return_value />
	</cffunction>

	<cffunction name="addBookingSession" access="remote" returntype="boolean">
		<cfargument name="req_date" type="date" required="true" />	
		<cfargument name="shw_id" type="integer" required="true" />
		<cfargument name="mov_id" type="integer" required="true" />
		<cfargument name="booked_seats" type="string" required="true" />
		<cfargument name="total_price" type="any" required="true" />
		<cfargument name="tick_count" type="any" required="true" />	
		<cfset session.BookingDetails = {'req_date' = arguments.req_date, 'shw_id' = arguments.shw_id, 'mov_id' = arguments.mov_id, 'booked_seats' = arguments.booked_seats, 'total_price' = arguments.total_price, 'tick_count' = arguments.tick_count} > 			
		<cfset variables.return_value = true /> 
		<cfreturn variables.return_value />
	</cffunction>

	<cffunction name="cancelBooking" access="remote" >				
		<cfif structKeyExists(session,'BookingDetails')> 
			<cfset variables.mov_id = session.BookingDetails.mov_id /> 
			<cfset structdelete(session,'BookingDetails') /> 		
		</cfif>	
		<cfreturn variables.mov_id />
	</cffunction>

	<cffunction name="getTicket" access="public" returntype="any">	
		<cfargument name="tic_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getTicketById">
			SELECT movie_id,show_id,booked_on,booked_seat,total_price FROM mv_booking WHERE booking_id = <cfqueryparam value="#arguments.tic_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getTicketById />	
	</cffunction>

</cfcomponent>
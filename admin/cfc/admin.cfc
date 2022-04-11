<cfcomponent>   	
   <cffunction name="checkAdminLogin" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.admin_loginEmail = form.admin_loginEmail/>
		<cfset variables.admin_loginPwd = form.admin_loginPwd/>		
		<cfif variables.admin_loginEmail EQ ''>
			<cfset session.Errmsg = 'Please Enter Email' />
			<cflocation url = "../login.cfm" addtoken="false" />			
		</cfif>
		<cfif variables.admin_loginPwd EQ ''>
			<cfset session.Errmsg = 'Please Enter Password' />
			<cflocation url = "../login.cfm" addtoken="false" />				
		</cfif>
		<cfif arrayIsEmpty(errorMessage)>
			<cfquery name="qry.checkLogin">
				SELECT * FROM admin 
					WHERE admin_email = <cfqueryparam value="#variables.admin_loginEmail#" cfsqltype="cf_sql_varchar" /> AND admin_pwd = <cfqueryparam value="#hash(variables.admin_loginPwd)#" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfif qry.checkLogin.recordcount EQ 1>
				<cfset session.stLoggedInAdmin = {'userFullName' = qry.checkLogin.admin_name, 'adminID' = qry.checkLogin.admin_id} > 
				<cfset structdelete(session,'Errmsg')>
				<cflocation url = "../index.cfm" addtoken="false" />
			<cfelse>				
				<cfset session.Errmsg = 'Invalid User Login' />			
				<cflocation url = "../login.cfm" addtoken="false" />
			</cfif>
		</cfif>				
	</cffunction>

	<cffunction name="addTheatre" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.theatre_name = form.theatre_name/>
		<cfset variables.theatre_img = form.theatre_img/>
		<cfset variables.theatre_id = form.theatre_id/>	
		<cfset variables.hid_theatre_img = form.hid_theatre_img/>	
		<cfif trim(variables.theatre_name) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Theatre Name')>
		</cfif>					
		<cfif NOT arrayIsEmpty(errorMessage)>
			<cfset arrayAppend(errorMessage, 'error')>
		</cfif>
		<cfset variables.theatre_image = variables.hid_theatre_img>
		<cfif structKeyExists(form,"theatre_img") and len(trim(form.theatre_img))>
			<cfset variables.thisDir = expandPath(".")>
			<cffile action="upload" fileField="form.theatre_img" destination="#variables.thisDir#/../uploads/MovieTheatres" result="fileUpload" nameconflict="overwrite">
			<cfset variables.theatre_image = fileUpload.serverFile>
		</cfif>
		<cfset variables.curr_time = Now()>
		<cfif arrayIsEmpty(errorMessage) AND variables.theatre_id EQ ''>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery name="tableElements" result="r">
				INSERT INTO mv_movie_theatres (theatre_name,theatre_image,created_by)
				VALUES (
						<cfqueryparam value="#variables.theatre_name#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.theatre_image#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />																					
					)
			</cfquery>												
		</cfif>
		<cfif arrayIsEmpty(errorMessage) AND variables.theatre_id NEQ ''>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery>
				UPDATE mv_movie_theatres SET 			
				theatre_name = <cfqueryparam value="#variables.theatre_name#" cfsqltype="cf_sql_varchar" />,				
				theatre_image = <cfqueryparam value="#variables.theatre_image#" cfsqltype="cf_sql_varchar" />
				WHERE theatre_id = #variables.theatre_id# AND created_by = #session.stLoggedInAdmin.adminID#			
			</cfquery>						
		</cfif>
 		<cfreturn variables.errorMessage />
	</cffunction>

	<cffunction name="getMovieTheatres" access="public" output="false" returntype="query">		
		<cfquery name="qry.rs_getMovieTheatres">
			SELECT * FROM mv_movie_theatres  WHERE created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" /> ORDER BY theatre_id DESC
		</cfquery>		
		<cfreturn qry.rs_getMovieTheatres />
	</cffunction>

	<cffunction name="getTheatreById" access="remote" output="false" returntype="any" returnformat="JSON">
		<cfargument name="theatre_id" required="yes">		
		<cfquery name="qry.rs_getTheatreById">
			SELECT theatre_name,theatre_image FROM mv_movie_theatres  WHERE theatre_id = <cfqueryparam value="#arguments.theatre_id#" cfsqltype="cf_sql_integer" /> AND created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
		</cfquery>			
		<cfreturn serializeJSON(qry.rs_getTheatreById,"struct") />
	</cffunction>

	<cffunction name="addMovie" access="remote" output="false" >
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.movie_name = form.movie_name/>
		<cfset variables.movie_poster = form.movie_poster/>
		<cfset variables.movie_youtubelink = form.movie_youtubelink/>
		<cfset variables.movie_rating = form.movie_rating/>
		<cfset variables.movie_details = form.movie_details/>
		<cfset variables.movie_id = form.movie_id/>
		<cfset variables.hid_movie_poster = form.hid_movie_poster/>

		<cfif trim(variables.movie_name) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Movie Name')>
		</cfif>						
		<cfif NOT arrayIsEmpty(errorMessage)>
			<cfset arrayAppend(errorMessage, 'error')>
		</cfif>
		<cfset variables.movie_poster = variables.hid_movie_poster>
		<cfif structKeyExists(form,"movie_poster") and len(trim(form.movie_poster))>
			<cfset variables.thisDir = expandPath(".")>
			<cffile action="upload" fileField="form.movie_poster" destination="#variables.thisDir#/../uploads/Movie" result="fileUpload" nameconflict="overwrite">
			<cfset variables.movie_poster = fileUpload.serverFile>
		</cfif>
		<cfset variables.curr_time = Now()>
		<cfif arrayIsEmpty(errorMessage) AND variables.movie_id EQ ''>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery name="tableElements" result="r">
				INSERT INTO mv_movies (movie_name,movie_poster,movie_youtubelink,movie_rating,movie_details,created_by)
				VALUES (
						<cfqueryparam value="#variables.movie_name#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_poster#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_youtubelink#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_rating#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_details#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
					)
			</cfquery>												
		</cfif>
		<cfif arrayIsEmpty(errorMessage) AND variables.movie_id NEQ ''>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery>
				UPDATE mv_movies SET 			
				movie_name = <cfqueryparam value="#variables.movie_name#" cfsqltype="cf_sql_varchar" />,				
				movie_poster = <cfqueryparam value="#variables.movie_poster#" cfsqltype="cf_sql_varchar" />,
				movie_youtubelink = <cfqueryparam value="#variables.movie_youtubelink#" cfsqltype="cf_sql_varchar" />,
				movie_rating = <cfqueryparam value="#variables.movie_rating#" cfsqltype="cf_sql_integer" />,
				movie_details = <cfqueryparam value="#variables.movie_details#" cfsqltype="cf_sql_varchar" />
				WHERE movie_id = #variables.movie_id# AND created_by = #session.stLoggedInAdmin.adminID#			
			</cfquery>						
		</cfif>
		<cfreturn variables.errorMessage />						
	</cffunction>

	<cffunction name="getMovies" access="public" output="false" returntype="query">		
		<cfquery name="qry.rs_getMovies">
			SELECT * FROM mv_movies  WHERE created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getMovies />
	</cffunction>

	<cffunction name="getMovieById" access="remote" output="false" returntype="any" returnformat="JSON">
		<cfargument name="movie_id" required="yes">		
		<cfquery name="qry.rs_getMovieById">
			SELECT movie_id,movie_name,movie_poster,movie_youtubelink,movie_rating,movie_details FROM mv_movies  WHERE movie_id = <cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" /> AND created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
		</cfquery>			
		<cfreturn serializeJSON(qry.rs_getMovieById,"struct") />
	</cffunction>

	<cffunction name="delTheatre" access="remote" returntype="void" >		
		<cfquery name="qry.rs_getFileById">
			SELECT theatre_image FROM mv_movie_theatres  WHERE theatre_id  = <cfqueryparam value="#URL.DelId#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset variables.thisDir = expandPath(".")>
		<cfset variables.DeleteFileName = qry.rs_getFileById.theatre_image>
		<cffile action = "delete" file = "#variables.thisDir#\..\uploads\MovieTheatres\#Variables.DeleteFileName#">			
		<cfquery>
			DELETE FROM mv_movie_theatres WHERE theatre_id = <cfqueryparam value="#URL.DelId#" cfsqltype="cf_sql_integer" /> AND created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cflocation url = "../movie-theatres.cfm" addtoken="false" />
	</cffunction>

	<cffunction name="delMovie" access="remote" returntype="void" >
		<cfquery name="qry.rs_getFileById">
			SELECT movie_poster FROM mv_movies  WHERE movie_id  = <cfqueryparam value="#URL.DelId#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset variables.thisDir = expandPath(".")>
		<cfset variables.DeleteFileName = qry.rs_getFileById.movie_poster>
		<cffile action = "delete" file = "#variables.thisDir#\..\uploads\Movie\#Variables.DeleteFileName#">			
		<cfquery>
			DELETE FROM mv_movies WHERE movie_id = <cfqueryparam value="#URL.DelId#" cfsqltype="cf_sql_integer" /> AND created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cflocation url = "../movies.cfm" addtoken="false" />
	</cffunction>

	<cffunction name="addShowTime" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.theatre_id = form.theatre_id/>
		<cfset variables.movie_id = form.movie_id/>
		<cfset variables.start_date = form.start_date/>	
		<cfset variables.end_date = form.end_date/>	
		<cfset variables.start_time = form.start_time/>	
		<cfset variables.end_time = form.end_time/>	
		<cfset variables.online_booking = form.online_booking/>	
		<cfset variables.price_gold_full = form.price_gold_full/>
		<cfset variables.price_gold_half = form.price_gold_half/>	
		<cfset variables.price_odc_full = form.price_odc_full/>	
		<cfset variables.price_odc_half = form.price_odc_half/>	
		<cfset variables.price_box = form.price_box/>
		<cfset variables.show_id = form.show_id/>	
		<cfif trim(variables.theatre_id) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Theatre')>
		</cfif>	
		<cfif trim(variables.movie_id) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Movie')>
		</cfif>	
		<cfif trim(variables.start_date) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Start Date')>
		</cfif>	
		<cfif trim(variables.end_date) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select End Date')>
		</cfif>
		<cfif trim(variables.start_time) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Start Time')>
		</cfif>	
		<cfif trim(variables.end_time) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select End Time')>
		</cfif>
		<cfif trim(variables.online_booking) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Online Booking Seat')>
		</cfif>	
		<cfif trim(variables.price_gold_full) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Price of  Gold Full')>
		</cfif>	
		<cfif trim(variables.price_gold_half) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Price of Gold Half')>
		</cfif>	
		<cfif trim(variables.price_odc_full) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Price of odc Full')>
		</cfif>	
		<cfif trim(variables.price_odc_half) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Price of odc Half')>
		</cfif>	
		<cfif trim(variables.price_box) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Price of Price Box')>
		</cfif>						
		<cfif NOT arrayIsEmpty(errorMessage)>
			<cfset arrayAppend(errorMessage, 'error')>
		</cfif>
		<cfset variables.theatre_image = variables.hid_theatre_img>
		
		<cfset variables.curr_time = Now()>
		<cfif arrayIsEmpty(errorMessage) AND variables.show_id EQ ''>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery name="tableElements" result="r">
				INSERT INTO mv_show_timing (theatre_id,movie_id,start_date,end_date,start_time,end_time,online_booking,price_gold_full,price_gold_half,price_odc_full,price_odc_half,price_box,created_by)
				VALUES (
						<cfqueryparam value="#variables.theatre_id#" cfsqltype="cf_sql_integer" />,
						<cfqueryparam value="#variables.movie_id#" cfsqltype="cf_sql_integer" />,
						<cfqueryparam value="#variables.start_date#" cfsqltype="cf_sql_date" />,
						<cfqueryparam value="#variables.end_date#" cfsqltype="cf_sql_date" />,
						<cfqueryparam value="#variables.start_time#" cfsqltype="cf_sql_time" />,
						<cfqueryparam value="#variables.end_time#" cfsqltype="cf_sql_time" />,
						<cfqueryparam value="#variables.online_booking#" cfsqltype="cf_sql_integer" />,
						<cfqueryparam value="#variables.price_gold_full#" cfsqltype="cf_sql_decimal" />,
						<cfqueryparam value="#variables.price_gold_half#" cfsqltype="cf_sql_decimal" />,
						<cfqueryparam value="#variables.price_odc_full#" cfsqltype="cf_sql_decimal" />,
						<cfqueryparam value="#variables.price_odc_half#" cfsqltype="cf_sql_decimal" />,
						<cfqueryparam value="#variables.price_box#" cfsqltype="cf_sql_decimal" />,
						<cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />																					
					)
			</cfquery>												
		</cfif>
		<cfif arrayIsEmpty(errorMessage) AND variables.show_id NEQ ''>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery>
				UPDATE mv_movie_theatres SET 			
				theatre_name = <cfqueryparam value="#variables.theatre_name#" cfsqltype="cf_sql_varchar" />,				
				theatre_image = <cfqueryparam value="#variables.theatre_image#" cfsqltype="cf_sql_varchar" />
				WHERE theatre_id = #variables.theatre_id# AND created_by = #session.stLoggedInAdmin.adminID#			
			</cfquery>						
		</cfif>
 		<cfreturn variables.errorMessage />
	</cffunction>			 
</cfcomponent>


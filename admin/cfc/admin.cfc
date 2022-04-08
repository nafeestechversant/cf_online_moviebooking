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

		<cfif trim(variables.theatre_name) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Theatre Name')>
		</cfif>
		<cfif trim(variables.theatre_img) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Theatre Image')>
		</cfif>				
		<cfif NOT arrayIsEmpty(errorMessage)>
			
		</cfif>
		<cfset variables.theatre_image = variables.theatre_img>
		<cfif structKeyExists(form,"theatre_img") and len(trim(form.theatre_img))>
			<cfset variables.thisDir = expandPath(".")>
			<cffile action="upload" fileField="form.theatre_img" destination="#variables.thisDir#/../uploads/MovieTheatres" result="fileUpload" nameconflict="overwrite">
			<cfset variables.theatre_image = fileUpload.serverFile>
		</cfif>
		<cfset variables.curr_time = Now()>
		<cfif arrayIsEmpty(errorMessage) AND variables.theatre_id EQ ''>
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
			SELECT * FROM mv_movie_theatres  WHERE created_by = <cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_integer" />
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

	<cffunction name="addMovie" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.movie_name = form.movie_name/>
		<cfset variables.movie_poster = form.movie_poster/>
		<cfset variables.movie_youtubelink = form.movie_youtubelink/>
		<cfset variables.movie_rating = form.movie_rating/>
		<cfset variables.movie_details = form.movie_details/>
		<cfset variables.movie_id = form.movie_id/>

		<cfif trim(variables.movie_name) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Movie Name')>
		</cfif>
		<cfif trim(variables.movie_poster) EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Select Movie Poster')>
		</cfif>				
		<cfif NOT arrayIsEmpty(errorMessage)>
			
		</cfif>
		<cfset variables.movie_poster = variables.movie_poster>
		<cfif structKeyExists(form,"movie_poster") and len(trim(form.movie_poster))>
			<cfset variables.thisDir = expandPath(".")>
			<cffile action="upload" fileField="form.movie_poster" destination="#variables.thisDir#/../uploads/Movie" result="fileUpload" nameconflict="overwrite">
			<cfset variables.movie_poster = fileUpload.serverFile>
		</cfif>
		<cfset variables.curr_time = Now()>
		<cfif arrayIsEmpty(errorMessage) AND variables.movie_id EQ ''>
			<cfquery name="tableElements" result="r">
				INSERT INTO mv_movies (movie_name,movie_poster,movie_youtubelink,movie_rating,movie_details,created_by)
				VALUES (
						<cfqueryparam value="#variables.movie_name#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_poster#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_youtubelink#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_rating#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.movie_details#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#session.stLoggedInAdmin.adminID#" cfsqltype="cf_sql_varchar" />
					)
			</cfquery>												
		</cfif>
		<cfif arrayIsEmpty(errorMessage) AND variables.movie_id NEQ ''>
			<cfquery>
				UPDATE mv_movies SET 			
				movie_name = <cfqueryparam value="#variables.movie_name#" cfsqltype="cf_sql_varchar" />,				
				movie_poster = <cfqueryparam value="#variables.movie_poster#" cfsqltype="cf_sql_varchar" />,
				movie_youtubelink = <cfqueryparam value="#variables.movie_youtubelink#" cfsqltype="cf_sql_varchar" />,
				movie_rating = <cfqueryparam value="#variables.movie_rating#" cfsqltype="cf_sql_varchar" />,
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
</cfcomponent>


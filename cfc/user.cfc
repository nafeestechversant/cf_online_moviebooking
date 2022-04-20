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
			SELECT movie_id,movie_name,movie_poster,movie_lang FROM mv_movies ORDER BY movie_id DESC
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

	<cffunction name="getTheatreShow" access="public" output="false" returntype="query">	
		<cfargument name="movie_id" type="integer" required="true" />	
		<cfquery name="qry.rs_getTheatreShow">
			SELECT tr.theatre_id,tr.theatre_name,tr.theatre_image,st.show_id FROM mv_show_timing st JOIN mv_movie_theatres tr ON st.theatre_id=tr.theatre_id WHERE  st.movie_id= <cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getTheatreShow />
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
			<cfset arrayAppend(errorMessage, 'error')>
		</cfif>
				
		<cfif arrayIsEmpty(errorMessage)>
			<cfset arrayAppend(errorMessage, 'success')>
			<cfquery name="tableElements" result="r">
				INSERT INTO mv_users (user_fullname,user_phone,user_email,user_pwd)
				VALUES (
						<cfqueryparam value="#variables.fld_userName#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.fld_userMobile#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#hash(variables.fld_userPwd,'SHA')#" cfsqltype="cf_sql_varchar" />																					
					)
			</cfquery>													
		</cfif>		
 		<cfreturn variables.errorMessage />
	</cffunction>

	<cffunction name="checkUserLogin" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.fld_userEmail = form.fld_userEmail/>
		<cfset variables.fld_userPwd = form.fld_userPwd/>		
		<cfif variables.fld_userEmail EQ ''>
			<cfset session.Errmsg = 'Please Enter Email' />
			<cflocation url = "../login.cfm" addtoken="false" />			
		</cfif>
		<cfif variables.fld_userPwd EQ ''>
			<cfset session.Errmsg = 'Please Enter Password' />
			<cflocation url = "../login.cfm" addtoken="false" />				
		</cfif>
		<cfif arrayIsEmpty(errorMessage)>
			<cfquery name="qry.checkLogin">
				SELECT * FROM mv_users 
					WHERE user_email = <cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" /> AND user_pwd = <cfqueryparam value="#hash(variables.fld_userPwd)#" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfif qry.checkLogin.recordcount EQ 1>
				<cfset session.stLoggedInUser = {'userFullName' = qry.checkLogin.user_fullname, 'userID' = qry.checkLogin.user_id} > 
				<cfset structdelete(session,'Errmsg')>
				<cflocation url = "../index.cfm" addtoken="false" />
			<cfelse>				
				<cfset session.Errmsg = 'Invalid User Login' />			
				<cflocation url = "../index.cfm" addtoken="false" />
			</cfif>
		</cfif>				
	</cffunction>
</cfcomponent>
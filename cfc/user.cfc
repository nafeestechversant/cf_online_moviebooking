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
			SELECT movie_id,movie_name,movie_poster,movie_lang,movie_details FROM mv_movies WHERE movie_id = <cfqueryparam value="#arguments.movie_id#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn qry.rs_getMoviesById />
	</cffunction>
</cfcomponent>
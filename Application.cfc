<!-- Set the value of MyDatabase to be the name you published the database under -->
<cfcomponent output="false">
    <cfset this.name = 'Movie Booking System' />
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />    
	<cfset this.ormenabled = "true">
	<cfset this.ormsettings = {datasource="cf_moviebooking"}> 
    <cfset this.datasource = 'cf_moviebooking' /> 
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />  
	

    <!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >			
		<cfreturn true />
	</cffunction>

    <!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean">		
		<cfargument name="targetPage" type="string" required="true" />			
		<cfset variables.files = "index1.cfm">
		<cfif ListContains(variables.files, GetFileFromPath(CGI.CF_TEMPLATE_PATH)) AND NOT structKeyExists(session,'stLoggedInAdmin')>
			<cflocation url = "login.cfm" addtoken="false" />
		</cfif>
		<cfif structKeyExists(URL,'logout')>
			<cfset structdelete(session,'stLoggedInAdmin') />			
		</cfif>			
		<cfreturn true />
	</cffunction>	 	
</cfcomponent>

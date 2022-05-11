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
		<cfif structKeyExists(URL,'Usrlogout')>
			<cfset structdelete(session,'stLoggedInUser') />
			<cflocation url = "index.cfm" addtoken="false" />			
		</cfif>
		<cfset variables.fefiles = "edit-profile.cfm,dashboard.cfm,ticket_pdf.cfm,order_summary.cfm">
		<cfif ListContains(variables.fefiles, GetFileFromPath(CGI.CF_TEMPLATE_PATH)) AND NOT structKeyExists(session,'stLoggedInUser')>
			<cflocation url = "index.cfm" addtoken="false" />
		</cfif>
		<cfif ListContains("movieticket_booking.cfm", GetFileFromPath(CGI.CF_TEMPLATE_PATH)) >
<!--- 			<cflocation url = "index.cfm" addtoken="false" /> --->
		</cfif>
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionStart" access="public" output="false" returntype="void">     	    
			 	
	</cffunction>

		 	
</cfcomponent>

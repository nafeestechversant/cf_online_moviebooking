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
	<cffunction name="onRequestStart" returntype="boolean" >
		<cfargument name="targetPage" type="string" required="true" />
		<cfset variables.files = "index.cfm,contact_pdf.cfm,contact_excel.cfm,contact_print.cfm">
		<cfif ListContains(variables.files, GetFileFromPath(CGI.CF_TEMPLATE_PATH)) AND NOT structKeyExists(session,'stLoggedInUser')>
			<cflocation url = "login.cfm" addtoken="false" />
		</cfif>
		<cfif structKeyExists(URL,'logout')>
			<cfset structdelete(session,'stLoggedInUser') />
			<cfset structdelete(session,'errMsg') />
		</cfif>
		<!---handle some special URL parameters--->
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart() />
		</cfif>		
		<cfreturn true />
	</cffunction>

	<cffunction name="onError"> 
		<cfargument name="Exception" required=true/> 
		<cfargument type="String" name="EventName" required=true/> 				 		
		<cfif NOT (Arguments.EventName IS "onSessionEnd") OR  
				(Arguments.EventName IS "onApplicationEnd")> 
			<cfoutput> 
				<h2>An unexpected error occurred.</h2> 
				<p>Please provide the following information to technical support:</p> 
				<p>Error Event: #Arguments.EventName#</p> 
				<p>Error details:<br> 
				<cfdump var=#Arguments.Exception#></p> 
			</cfoutput> 
		</cfif>  
	</cffunction> 	
</cfcomponent>

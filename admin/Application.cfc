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
		<cfif structKeyExists(URL,'logout')>
			<cfset structdelete(session,'stLoggedInAdmin') />			
		</cfif>	
			
		<cfif NOT structKeyExists(session,'stLoggedInAdmin') >					
			<cfinclude template="login.cfm"> 				
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

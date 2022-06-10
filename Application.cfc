<!-- Set the value of MyDatabase to be the name you published the database under -->
<cfcomponent output="false">
    <cfset this.name = 'Movie Booking System' />
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />    
	<cfset this.ormenabled = "true">
	<cfset this.ormsettings = {datasource="cf_moviebooking"}> 
    <cfset this.datasource = 'cf_moviebooking' /> 
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />  
	<cfset this.SetClientCookies = true />
	<cfset application.EncrptKey = "abc!@" />
	 
    <!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >
		<cfset application.paymentKey = "rzp_test_dKHSAwIaRKIBft" /> 
		<cfset application.EncrptKey = "abc!@" /> 
		<cfset application.EncryptionKey = "S3xy8run3tt3s" />				
		<cfreturn true />
	</cffunction>
    <!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean">		
		<cfargument name="targetPage" type="string" required="true" />						
		<cfif structKeyExists(URL,'Usrlogout')>
			<cfset structdelete(session,'stLoggedInUser') />
			<cfset structdelete(session,'BookingDetails') />
			<cfcookie name="RememberMe" value="" expires="now" />
			<cflocation url = "index.cfm" addtoken="false" />			
		</cfif>
		<cfset variables.fefiles = "edit-profile.cfm,dashboard.cfm,ticket_pdf.cfm,order_summary.cfm">
		<cfif ListContains(variables.fefiles, GetFileFromPath(CGI.CF_TEMPLATE_PATH)) AND NOT structKeyExists(session,'stLoggedInUser')>
<!--- 			<cflocation url = "index.cfm" addtoken="false" /> --->
		</cfif>	
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionStart" access="public" output="false" returntype="void">     	    
			 	<cftry>			
					<cfset local.RememberMe = Decrypt(cookie.RememberMe,application.EncryptionKey,"cfmx_compat","hex") />					
					<cfset local.RememberMe = ListGetAt(local.RememberMe,2,":") />					
					<cfif IsNumeric( local.RememberMe )>
					
						<cfset session.stLoggedInUser.userID = local.RememberMe />

					</cfif>
					
					<cfcatch>
					
					</cfcatch>
				</cftry>
		<cfreturn />
	</cffunction>

	<cffunction name="onMissingTemplate">
        <cfargument name="targetPage" type="string" required=true/>
        <cftry>            
            <cflog type="error" text="Missing template: #Arguments.targetPage#">
            
<!---             <cfoutput> --->
<!---                 <h3>#Arguments.targetPage# could not be found.</h2> --->
<!---                 <p>You requested a non-existent ColdFusion page.<br /> --->
<!---                 Please check the URL.</p> --->
<!---             </cfoutput> --->
					 <cfinclude template="missing-template.cfm">

            <cfreturn true />         
            <cfcatch>
                <cfreturn false />
            </cfcatch>
        </cftry>

    </cffunction>

<!--- 	<cferror type="exception" template="error-page.cfm"/> --->

	<cffunction name="onError"> 
		<cfargument name="Exception" required=true/> 
		<cfargument type="String" name="EventName" required=true/> 				 		
		<cfif NOT (Arguments.EventName IS "onSessionEnd") OR  
				(Arguments.EventName IS "onApplicationEnd")> 
<!--- 				<cfoutput> --->
<!--- 					<h2>An unexpected error occurred.</h2> --->
<!--- 					<p>Please provide the following information to technical support:</p> --->
<!--- 					<p>Error Event: #Arguments.EventName#</p> --->
<!--- 					<p>Error details:<br> --->
<!--- 					<cfdump var=#Arguments.Exception#></p> --->
<!--- 				</cfoutput> --->
 				<cfinclude template="error-page.cfm">			 
		</cfif>  
	</cffunction>

		 	
</cfcomponent>

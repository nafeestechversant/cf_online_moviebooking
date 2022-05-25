<cffunction name="sendMessageWithTwilio" output="false" access="public" returnType="string">
    <cfargument name="aMessage" type="string" required="true" />
    <cfargument name="destinationNumber" type="string" required="true" />

    <cfset var twilioAccountSid = "AC56b12986ec4463d8feb27b8a0e5d3c31" />
    <cfset var twilioAuthToken = "f4201bc3c1a9a21790b7753c101a5f0b" />
    <cfset var twilioPhoneNumber = "+13192642947" />

    <cfhttp 
        result="result" 
        method="POST" 
        charset="utf-8" 
        url="https://api.twilio.com/2010-04-01/Accounts/#twilioAccountSid#/Messages.json"
        username="#twilioAccountSid#"
        password="#twilioAuthToken#" >

        <cfhttpparam name="From" type="formfield" value="#twilioPhoneNumber#" />
        <cfhttpparam name="Body" type="formfield" value="#arguments.aMessage#" />
        <cfhttpparam name="To" type="formfield" value="#arguments.destinationNumber#" />

    </cfhttp>

    <cfif result.Statuscode IS "201 CREATED">
        <cfreturn deserializeJSON(result.Filecontent.toString()).sid />
    <cfelse>
        <cfreturn result.Statuscode />
    </cfif>

</cffunction>

<cfdump var='#sendMessageWithTwilio(
    "This is a test message.",
    "+917200631317"
)#' />
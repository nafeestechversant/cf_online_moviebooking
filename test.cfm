<cfset myVar=false>
<cfloop condition="myVar eq false">
  <cfoutput>
  myVar = #myVar#  (still in loop)
 </cfoutput>
  <cfif RandRange(1,10) eq 10>
    <cfset myVar="true">
  </cfif>
</cfloop>
<cfoutput>
myVar = #myVar# (loop has finished)
</cfoutput>


<cfclient>
<cfscript>
function launchCamera()
{
// Capture the image from the device comera
var opt = cfclient.camera.getOptions();
var resp = cfclient.camera.getPicture(opt);
var fileContent = cfclient.file.readFileURIAsBase64(resp);
// Process the image
return;
}
</cfscript>
</cfclient>
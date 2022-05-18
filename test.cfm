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
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



<html>
<head>
   <title>Vertical Sorting</title>
</head>
<cfquery name = "qMyQuery" datasource = "dsn">
   SELECT fields
   FROM   table
   ORDER BY myField
</cfquery>
<body>
<!--- set the number of colums you wish to have --->
<cfset cols = 5>
<!--- get the number of rows so you know what record to display at the top of the next row. for example if our query contains "a,b,c,d,e,f,g,h,i,j,k,l,m" (13 elements) it will produce 3 totalrows--->
<cfset totalRows = ceiling(qMyQuery.RecordCount / cols)>
<!--- set inital record to 1 "output" is the actual cell of the query --->
<cfset output = 1>
<!--- Create table --->
<table width = "100%" border="0" align="center" cellpadding="2" cellspacing = "2">            
    <!--- loop through the rows.  This loop will run 3 times in this example --->
    <cfloop from = "1" to = "#totalRows#" index = "thisRow">
    <tr>
        <!--- this loop will run 5 times in times in this example --->
        <cfloop from = "1" to = "#cols#" index = "thisCol">
        <!--- the width in the table cell will dynamicaly calculated to evenly distribute the cells. in this example if cols = 5 100/5 will make the cells 20% of the table --->
        <td width = "<cfoutput>#numberformat((100/cols), 99)#</cfoutput>%" align="center" nowrap style = "border: 1px solid #ccc;">
            <!--- Check current record with the record count, this will be used to display data or an empty cell --->
            <cfif output lte qMyQuery.recordCount>
                <cfoutput>#qMyQuery.Mon[output]#</cfoutput>
            <cfelse>
            <!--- use <br> to display an empty cell --->
                <br>
            </cfif>
            <!--- increment counter to the next record in this example if we started on the first cell of the first row it would be 1(a), then 4(d), then 7(g) and so on if this was the firs cell on the second row it would be 2(b), 5(e), 8(h), continue... --->
            <cfset output = output + totalRows>
        </td>
        </cfloop>
        <!--- this little bit tells where to start the next row. if we just finished the first row output would be 2(b) --->
        <cfset output = thisRow + 1>
    </tr>
    </cfloop>
</table>
</body>
</html>


4 column
5 row

<cfscript>
local.col = form.numcol;
                                    local.max=ArrayLen(arr);
                                    local.row= ceiling(max/col);
                                    local.cells=row*col;
                                    local.miss=cells-max;
                                    // writeoutput( row);
                                    // writeoutput( "row<br/>");
                                    // writeoutput( cells);
                                    // writeoutput( "cells<br/>");
                                    // writeoutput( miss);
                                    writeoutput( "<br/><br/>");
                                    local.x=0;
                                    local.y=0;
                                    local.myarray = ArrayNew(1);
                                    for(i=1;i<=row;i++)
                                    {
                                        for(j=1;j<=col;j++)
                                        {
                                            y++;
                                            if(y<=max)
                                            {
                                                if(i==1)
                                                {
                                                    x=x+1;
                                                    if(j==1)
                                                    {
                                                        if(x<=max)
                                                        {
                                                            myarray[i][j] = arr[x] ;
                                                        }else
                                                        {
                                                            myarray[i][j]=null;
                                                        }
                                                    }
                                                    else if(j==2)
                                                    {
                                                        x=myarray[i][j-1]+row;
                                                        if(x<=max)
                                                        {
                                                            myarray[i][j] = arr[x];
                                                        }else
                                                        {
                                                            myarray[i][j]=null;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if(max<=20)
                                                        {
                                                            x=myarray[i][j-1]+col;
                                                        }
                                                        else{
                                                            x=myarray[i][j-1]+col+1;
                                                        }
                                                        if(x<=max)
                                                        {
                                                            myarray[i][j] = arr[x];
                                                        }else
                                                        {
                                                            myarray[i][j]=null;
                                                        }
                                                    }
                                                }
                                                else
                                                {
                                                    if(j==1)
                                                    {
                                                        x=myarray[i-1][j]+1;
                                                        if(x<=max)
                                                        {
                                                            myarray[i][j] = arr[x];
                                                        }else
                                                        {
                                                            myarray[i][j]=null;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        x=myarray[i-1][j]+1;
                                                        if(x<=max)
                                                        {
                                                            myarray[i][j] = arr[x];  
                                                        } 
                                                        else
                                                        {
                                                            myarray[i][j]=null;
                                                        }
                                                    }
                                                }   
                                            }
                                        }
                                    }
                                    writeOutput("<table border='1'>");
                                    for (d in myarray)  // for-in loop for array
                                    {
                                        writeOutput("<tr>");
                                        for (key in d)  // for-in loop for struct
                                        {
                                            writeOutput("<td>");
                                            writeOutput( d[key] &"&nbsp;&nbsp;");
                                            writeOutput("</td>");
                                        }
                                        writeOutput("</tr>");
                                    }
                                    writeOutput("</table>");


                                    </cfscript>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Movie Booking - Not Found</title>
        <meta content="" name="description">
        <meta content="" name="keywords">        
        <link href="css/frontend/bootstrap.min.css" rel="stylesheet">
        <link href="css/frontend/bootstrap-icons.css" rel="stylesheet">       
        <link href="css/frontend/style.css" rel="stylesheet">
    </head>
    <body>
        <cfoutput> 
            <cfinclude template="header.cfm"> 
            <main id="main">       
                <div class="blog-page area-padding cus-tag">
                    <div class="container">
                        <div class="row cus-tag2">                             
                            <cfdump var=#Arguments.Exception#></p>                        
                        </div>
                    </div>
                </div>
            </main>
            <cfinclude template="footer.cfm">
        </cfoutput>
        <script src="js/bootstrap.bundle.min.js"></script>   
        <script src="js/main.js"></script>
    </body>
</html> 
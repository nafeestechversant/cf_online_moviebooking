<cfinvoke component="cfc/admin" method="getBookings" returnvariable="BookingLists"></cfinvoke>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - SB Admin</title>
    <link href="../css/styles.css" rel="stylesheet" />
    <link href="../css/jquery.dataTables.min.css" rel="stylesheet" />
</head>
<body class="sb-nav-fixed">
    <cfoutput>    
        <cfinclude template="header.cfm">
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <cfinclude template="sidenav.cfm">
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Booking</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Home</li>
                            <li class="breadcrumb-item active">Booking</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-12 col-md-12">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <table id="datatablesSimple">
                                            <thead>
                                                <tr>
                                                    <th>S.No</th>
                                                    <th>User</th>
                                                    <th>Show</th>
                                                    <th>Show Date</th>
                                                    <th>Status</th>
                                                    <th>Category</th>
                                                    <th>Booked On</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <cfset variables.sno = 1 >
                                                <cfloop query="#BookingLists#">
                                                    <tr>
                                                        <td>#sno#</td>
                                                        <td>#BookingLists.user_fullname#</td>
                                                        <td>#BookingLists.show_id#</td>
                                                        <td>#BookingLists.booked_on#</td>
                                                        <td>#IIF(BookingLists.booking_status eq 1, de("Booked"), de("Pending"))#</td>
                                                        <td>#BookingLists.category_name#</td>                                                        
                                                        <td>#BookingLists.booked_on#</td>
                                                    </tr>
                                                    <cfset variables.sno ++ >
                                                </cfloop>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <cfinclude template="footer.cfm">
            </div>
        </div>
    </cfoutput>
    <script src="../js/jquery.min.js"></script> 
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script src="../js/jquery.dataTables.min.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/scripts.js"></script>
</body>
</html>
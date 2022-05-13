<cfobject name="UserList" component="cfc/admin">
<cfinvoke component="#UserList#" method="getUsers" returnvariable="UsersLists"></cfinvoke>
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
                            <h1 class="mt-4">Users</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item">Home</li>
                                <li class="breadcrumb-item active">Users</li>
                            </ol>
                            <div class="row">
                                <div class="col-xl-12 col-md-12">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <table id="datatablesSimple">
                                                <thead>
                                                    <tr>
                                                        <th>S.No</th>
                                                        <th>Name</th>
                                                        <th>Phone</th>
                                                        <th>Email</th>
                                                        <th>Address</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <cfset variables.sno = 1 >
                                                    <cfloop query="#UsersLists#">
                                                        <tr>
                                                            <td>#sno#</td>
                                                            <td>#UsersLists.user_fullname#</td>
                                                            <td>#UsersLists.user_phone#</td>
                                                            <td>#UsersLists.user_email#</td>
                                                            <td>#UsersLists.user_address#</td>
                                                            <td>#IIF(UsersLists.user_status eq 1, de("Active"), de("Inactive"))#</td>
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
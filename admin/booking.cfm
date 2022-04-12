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
                                            <tr>
                                                <td>1</td>
                                                <td>Tiger Nixon</td>
                                                <td>1</td>
                                                <td>2022/04/2</td>
                                                <td>Booked</td>
                                                <td>ODC</td>
                                                <td>2022/03/2</td>
                                            </tr>
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
    <script src="../js/jquery.min.js"></script> 
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script src="../js/jquery.dataTables.min.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/scripts.js"></script>
    

</body>

</html>
<cfoutput>
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <a class="nav-link" href="index.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Dashboard
                </a>
                <a class="nav-link collapsed" href="movie-theatres.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                    Movie Theatres
                </a>
                <a class="nav-link collapsed" href="movies.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                    Movies
                </a>
                <a class="nav-link" href="show-timings.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                    Show Timings
                </a>
                <a class="nav-link" href="homepage.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Home Page
                </a>
                <a class="nav-link" href="users.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Users
                </a>
                <a class="nav-link" href="booking.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Booking
                </a>
                <a class="nav-link" href="update-password.cfm">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Update Password
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">Logged in as:</div>
            <cfif structKeyExists(session,'stLoggedInAdmin')>
                #session.stLoggedInAdmin.userFullName#
            </cfif>
        </div>
    </nav>
</cfoutput>
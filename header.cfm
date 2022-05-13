<cfinvoke component="cfc/user" method="getMovies" returnvariable="MoviesMenu"></cfinvoke>
<cfoutput>
    <header id="header" class="fixed-top d-flex align-items-center">
        <div class="container d-flex justify-content-between">
            <div class="logo">
                <h1><a href="index.cfm">Movie Booking</a></h1>
            </div>           
            <nav id="navbar" class="navbar">
                <ul class="adj-menubar">
                    <li><a class="nav-link scrollto" href="index.cfm">Home</a></li>
                    <li class="dropdown"><a href="movies.cfm"><span>Movies</span> <i class="bi bi-chevron-down"></i></a>
                        <ul>
                            <cfloop query="#MoviesMenu#"> 
                                <li><a href="movie-details.cfm?movie=#MoviesMenu.movie_id#">#MoviesMenu.movie_name#</a></li>
                            </cfloop>
                        </ul>
                    </li>
                    <li class="dropdown"><a href="theatres.cfm"><span>Theatres</span></a></li>                                       
                </ul>
                <i class="bi bi-list mobile-nav-toggle"></i>                
                <div class="dropdown">
                <button class="button search-icon" onclick="myFunction()" type="submit"><i class="bi bi-search"></i></button>
                    <form action="movies.cfm">
                        <div id="myDropdown" class="dropdown-content">
                            <input type="text" name="search_term" placeholder="Search Movie" id="myInput" autocomplete="off"> 
                            <button class="button" type="submit">
                                <i class="bi bi-search"></i>
                            </button>                   
                        </div>
                    </form>
                </div>
                <cfif structKeyExists(session,'stLoggedInUser')>               
                    <ul class="login-menu">                   
                        <li class="dropdown"><a href="##"><span>#session.stLoggedInUser.userFullName#</span> <i class="bi bi-chevron-down"></i></a>
                            <ul class="user-menu">
                                <li><a href="dashboard.cfm">Dashboard</a></li>
                                <li><a href="index.cfm?Usrlogout">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                <cfelse>
                    <ul class="login-menu">               
                        <li class="">                 
                            <a class="" data-bs-toggle="modal" data-bs-target="##exampleModal">
                                <i class="bi bi-person"></i>
                                <span class="login-span">Sign Up</span>
                            </a>
                        </li>               
                        <li class="nav-item dropdown no-arrow">
                            <a class="" data-bs-toggle="modal" data-bs-target="##loginModal">
                                <i class="bi bi-box-arrow-in-right"></i>
                                <span class="login-span">Login</span>
                            </a>
                        </li>
                    </ul>
                </cfif>
            </nav>
        </div>
    </header>
</cfoutput>
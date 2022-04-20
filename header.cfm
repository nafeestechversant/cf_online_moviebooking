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
                        <li><a href="#">Drop Down 1</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a href="theatres.cfm"><span>Theatres</span> <i class="bi bi-chevron-down"></i></a>
                    <ul>
                        <li><a href="#">Drop Down 1</a></li>
                    </ul>
                </li>
            </ul>
            <i class="bi bi-list mobile-nav-toggle"></i>
            <ul class="login-menu">               
                <li class="">                 
                    <a class="" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        <i class="bi bi-person"></i>
                        <span class="login-span">Sign Up</span>
                    </a>
                </li>               
                <li class="nav-item dropdown no-arrow">
                    <a class="" data-bs-toggle="modal" data-bs-target="#loginModal">
                        <i class="bi bi-box-arrow-in-right"></i>
                        <span class="login-span">Login</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</header>
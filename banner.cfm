<cfoutput>
    <section id="hero" class="movie-listbanner">
        <div class="hero-container">
            <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">
                <ol id="hero-carousel-indicators" class="carousel-indicators"></ol>
                <div class="carousel-inner" role="listbox">
                    <cfset variables.sno = 1 >
                    <cfloop query="#MoviesLists#"> 
                        <div class="carousel-item #IIF(variables.sno eq 1, de('active'), de(''))#" style="background-image: url(img/hero-carousel/1.jpg)">
                            <div class="carousel-container">
                                <div class="container">
                                    <h2 class="animate__animated animate__fadeInDown">#MoviesLists.movie_name# </h2>
                                    <p class="animate__animated animate__fadeInUp">#MoviesLists.movie_details#</p>
                                    <a href="movie-details.cfm?movie=#MoviesLists.movie_id#" class="btn-get-started scrollto animate__animated animate__fadeInUp">Book Tickets</a>
                                </div>
                            </div>
                        </div> 
                        <cfset variables.sno ++ >                      
                    </cfloop>              
                </div>
                <a class="carousel-control-prev" href="##heroCarousel" role="button" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
                </a>
                <a class="carousel-control-next" href="##heroCarousel" role="button" data-bs-slide="next">
                    <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
                </a>
            </div>
        </div>
    </section>
</cfoutput>
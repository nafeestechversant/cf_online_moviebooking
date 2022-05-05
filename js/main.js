(function() {
    "use strict";

    /**
     * Easy selector helper function
     */
    const select = (el, all = false) => {
        el = el.trim()
        if (all) {
            return [...document.querySelectorAll(el)]
        } else {
            return document.querySelector(el)
        }
    }

    /**
     * Easy event listener function
     */
    const on = (type, el, listener, all = false) => {
        let selectEl = select(el, all)
        if (selectEl) {
            if (all) {
                selectEl.forEach(e => e.addEventListener(type, listener))
            } else {
                selectEl.addEventListener(type, listener)
            }
        }
    }

    /**
     * Easy on scroll event listener 
     */
    const onscroll = (el, listener) => {
        el.addEventListener('scroll', listener)
    }

    /**
     * Navbar links active state on scroll
     */
    let navbarlinks = select('#navbar .scrollto', true)
    const navbarlinksActive = () => {
        let position = window.scrollY + 200
        navbarlinks.forEach(navbarlink => {
            if (!navbarlink.hash) return
            let section = select(navbarlink.hash)
            if (!section) return
            if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
                navbarlink.classList.add('active')
            } else {
                navbarlink.classList.remove('active')
            }
        })
    }
    window.addEventListener('load', navbarlinksActive)
    onscroll(document, navbarlinksActive)

    /**
     * Scrolls to an element with header offset
     */
    const scrollto = (el) => {
        let header = select('#header')
        let offset = header.offsetHeight

        if (!header.classList.contains('header-scrolled')) {
            offset -= 16
        }

        let elementPos = select(el).offsetTop
        window.scrollTo({
            top: elementPos - offset,
            behavior: 'smooth'
        })
    }

    /**
     * Toggle .header-scrolled class to #header when page is scrolled
     */
    let selectHeader = select('#header')
    if (selectHeader) {
        const headerScrolled = () => {
            if (window.scrollY > 100) {
                selectHeader.classList.add('header-scrolled')
            } else {
                selectHeader.classList.remove('header-scrolled')
            }
        }
        window.addEventListener('load', headerScrolled)
        onscroll(document, headerScrolled)
    }

    /**
     * Back to top button
     */
    let backtotop = select('.back-to-top')
    if (backtotop) {
        const toggleBacktotop = () => {
            if (window.scrollY > 100) {
                backtotop.classList.add('active')
            } else {
                backtotop.classList.remove('active')
            }
        }
        window.addEventListener('load', toggleBacktotop)
        onscroll(document, toggleBacktotop)
    }

    /**
     * Mobile nav toggle
     */
    on('click', '.mobile-nav-toggle', function(e) {
        select('#navbar').classList.toggle('navbar-mobile')
        this.classList.toggle('bi-list')
        this.classList.toggle('bi-x')
    })

    /**
     * Mobile nav dropdowns activate
     */
    on('click', '.navbar .dropdown > a', function(e) {
        if (select('#navbar').classList.contains('navbar-mobile')) {
            e.preventDefault()
            this.nextElementSibling.classList.toggle('dropdown-active')
        }
    }, true)

    /**
     * Scrool with ofset on links with a class name .scrollto
     */
    on('click', '.scrollto', function(e) {
        if (select(this.hash)) {
            e.preventDefault()

            let navbar = select('#navbar')
            if (navbar.classList.contains('navbar-mobile')) {
                navbar.classList.remove('navbar-mobile')
                let navbarToggle = select('.mobile-nav-toggle')
                navbarToggle.classList.toggle('bi-list')
                navbarToggle.classList.toggle('bi-x')
            }
            scrollto(this.hash)
        }
    }, true)

    /**
     * Scroll with ofset on page load with hash links in the url
     */
    window.addEventListener('load', () => {
        if (window.location.hash) {
            if (select(window.location.hash)) {
                scrollto(window.location.hash)
            }
        }
    });

    /**
     * Preloader
     */
    let preloader = select('#preloader');
    if (preloader) {
        window.addEventListener('load', () => {
            preloader.remove()
        });
    }

    /**
     * Hero carousel indicators
     */
    let heroCarouselIndicators = select("#hero-carousel-indicators")
    let heroCarouselItems = select('#heroCarousel .carousel-item', true)

    heroCarouselItems.forEach((item, index) => {
        (index === 0) ?
        heroCarouselIndicators.innerHTML += "<li data-bs-target='#heroCarousel' data-bs-slide-to='" + index + "' class='active'></li>":
            heroCarouselIndicators.innerHTML += "<li data-bs-target='#heroCarousel' data-bs-slide-to='" + index + "'></li>"
    });


    let showCarouselIndicators = select("#show-carousel-indicators")
    let showCarouselItems = select('#ShownowCarousel .carousel-item', true)

    showCarouselItems.forEach((item, index) => {
        (index === 0) ?
        showCarouselIndicators.innerHTML += "<li data-bs-target='#ShownowCarousel' data-bs-slide-to='" + index + "' class='active'></li>":
            showCarouselIndicators.innerHTML += "<li data-bs-target='#ShownowCarousel' data-bs-slide-to='" + index + "'></li>"
    });
})()

$(document).on("submit", "#form_addUser", function(event) {
    event.preventDefault();
    $.ajax({
        url: "cfc/user.cfc?method=addUser&returnformat=json",
        type: "POST",
        dataType: 'json',
        data: new FormData(this),
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.length != 0) {
                $("#valid-err").empty();
                for (i = 0; i < response.length; ++i) {
                    $("#valid-err").append("<p class='red'>" + response[i] + "</p>");
                }
            } else {
                $('#exampleModal').modal('hide');
                location.reload();
            }

        },
        error: function(xhr, desc, err) {

        }
    });

});

$(document).on("submit", "#form_login", function(event) {
    event.preventDefault();
    $.ajax({
        url: "cfc/user.cfc?method=checkUserLogin&returnformat=json",
        type: "POST",
        dataType: 'json',
        data: new FormData(this),
        processData: false,
        contentType: false,
        success: function(response) {
            if (response == 1) {
                location.reload();
            }

        },
        error: function(xhr, desc, err) {

        }
    });

});

$(".filterbyDate").click(function() {
    var currDate = $(this).attr('data-currdate');
    var movieId = $(this).attr('data-movieId');

    $.ajax({
        url: "cfc/user.cfc?method=filterTheatre",
        type: "POST",
        data: { currDate: currDate, movieId: movieId },
        cache: false,
        success: function(html) {
            $("#results").empty();
            $("#results").append(html);
        }
    });
});

$(':button[value="Book Now"]').on('click', function(e) {
    e.preventDefault();
    checkUserLoginOrNot();
});

$('#confirm_book').on('click', function(e) {
    e.preventDefault();
    $.ajax({
        type: "POST",
        url: "cfc/user.cfc?method=addBooking&returnformat=json",
        cache: false,
        success: function(data) {
            if (data > 0) {
                window.location.href = "dashboard.cfm";
            }
        }
    });
});

$('.cnce-btn').on('click', function(e) {
    e.preventDefault();
    $.ajax({
        type: "POST",
        url: "cfc/user.cfc?method=cancelBooking&returnformat=json",
        cache: false,
        success: function(data) {
            if (data > 0) {
                window.location.href = "movie-details.cfm?movie=" + data;
            }
        }
    });
});

$("document").ready(function() {
    autoPlayYouTubeModal();
    $(".filterbyDate").trigger('click');

    $("#form_login").validate({
        rules: {
            fld_userEmail: {
                required: true
            },
            fld_userPwd: {
                required: true,
            }
        }
    });
    $("#form_editUser").validate({
        rules: {
            fld_userName: {
                required: true
            },
            fld_userEmail: {
                required: true,
            },
            fld_userMobile: {
                required: true,
            }
        }
    });
    $("#form_addUser").validate({
        rules: {
            fld_userName: {
                required: true
            },
            fld_userMobile: {
                required: true
            },
            fld_userPwd: {
                required: true,
                minlength: 5
            },
            fld_userCnfPwd: {
                required: true,
                minlength: 5,
                equalTo: "#fld_userPwd"
            },
            fld_userEmail: {
                required: true,
                email: true
            }
        }
    });

});

function checkUserLoginOrNot() {
    $.ajax({
        type: "POST",
        url: "cfc/user.cfc?method=checkLoginOrNot&returnformat=json",
        cache: false,
        success: function(response) {
            if (response == "false") {
                $('#loginModal').modal('show');
            } else {
                addBookingSession();
            }
        }
    });
}

function addBookingSession() {

    if ($('#selected-seats li').length > 0) {
        var sc = $('#seat-map').seatCharts({});
        var total = 0;
        var ids = '';
        sc.find('selected').each(function() {
            total += this.data().price;
            ids += '"' + this.settings.id + '"' + ', ';

        });

        var req_date = $('#req_date').val();
        var shw_id = $('#shw_id').val();
        var mov_id = $('#mov_id').val();
        var tick_count = $('#counter').text();

        var index = ids.lastIndexOf(",");
        ids = ids.substring(0, index) + ids.substring(index + 1);


        $.ajax({
            type: "POST",
            url: "cfc/user.cfc?method=addBookingSession&returnformat=json",
            data: { req_date: req_date, shw_id: shw_id, mov_id: mov_id, booked_seats: ids, total_price: total, tick_count: tick_count },
            dataType: "json",
            cache: false,
            success: function(response) {
                console.log(response);
                if (response == true) {
                    window.location.href = "order_summary.cfm";
                }
            }
        });

    } else {
        alert('No selected seat to Book Ticket!')
    }

}

function autoPlayYouTubeModal() {
    var trigger = $('.trigger');
    trigger.click(function(e) {
        e.preventDefault();
        var theModal = $(this).data("target");
        var videoSRC = $(this).attr("src");
        var videoSRCauto = videoSRC + "?autoplay=1";
        $(theModal + ' iframe').attr('src', videoSRCauto);
        $(theModal).on('hidden.bs.modal', function(e) {
            $(theModal + ' iframe').attr('src', '');
        });
    });
}
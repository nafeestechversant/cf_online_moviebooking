window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});

$(document).ready(function() {

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }


    today = yyyy + '-' + mm + '-' + dd;
    // document.getElementById("start_date").setAttribute("min", today);
    // document.getElementById("end_date").setAttribute("min", today);

    console.log(today);

    $('#datatablesSimple,#datatablesMovies,#datatablesShows').DataTable({
        "sDom": "ltipr"
    });

    $("#adminlogin_form").validate({
        rules: {
            admin_loginEmail: {
                required: true
            },
            admin_loginPwd: {
                required: true,
            }
        }
    });
    $("#form_addTheatre").validate({
        rules: {
            theatre_name: {
                required: true
            }
        }
    });

    $("#form_addmovie").validate({
        rules: {
            movie_name: {
                required: true
            }
        }
    });

    $("#form_addShowTime").validate({
        rules: {
            theatre_id: {
                required: true
            },
            movie_id: {
                required: true
            },
            start_date: {
                required: true
            },
            end_date: {
                required: true
            },
            start_time: {
                required: true
            },
            end_time: {
                required: true
            },
            online_booking: {
                required: true
            },
            price_gold_full: {
                required: true
            },
            price_gold_half: {
                required: true
            },
            price_odc_full: {
                required: true
            },
            price_odc_half: {
                required: true
            },
            price_box: {
                required: true
            }
        }
    });

    $("#form_updatePwd").validate({
        rules: {
            admin_oldpwd: {
                required: true
            },
            admin_newpwd: {
                required: true,
                minlength: 5
            },
            admin_cnfpwd: {
                required: true,
                minlength: 5,
                equalTo: "#admin_newpwd"
            },
        }
    });

    $(document).on("submit", "#form_addTheatre", function(event) {
        event.preventDefault();
        $.ajax({
            url: "cfc/admin.cfc?method=addTheatre&returnformat=json",
            type: "POST",
            dataType: 'json',
            data: new FormData(this),
            processData: false,
            contentType: false,
            success: function(response) {
                if (response[1] == "error") {
                    $("#valid-err").append("<p>" + response[0] + "</p>");
                    //$("#valid-err").append("<p>" + response[1] + "</p>");
                } else {
                    $('#exampleModal').modal('hide');
                    location.reload();
                }

            },
            error: function(xhr, desc, err) {

            }
        });

    });
    $(document).on("click", ".btn-edit-theatre", function(event) {
        var theatre_id = $(this).data('id');
        $.ajax({
            type: "POST",
            url: "cfc/admin.cfc?method=getTheatreById",
            data: "theatre_id=" + theatre_id,
            dataType: "json",
            cache: false,
            success: function(data) {
                $('#theatre_name').val(data[0].THEATRE_NAME);
                $('#hid_theatre_img').val(data[0].THEATRE_IMAGE);
                $('#theatre_id').val(theatre_id);
                if (data[0].THEATRE_IMAGE != '') {
                    $('#show-thr-img').attr('src', 'uploads/MovieTheatres/' + data[0].THEATRE_IMAGE);
                }
            }
        });
    });

    $(document).on("submit", "#form_addmovie", function(event) {
        event.preventDefault();
        $.ajax({
            url: "cfc/admin.cfc?method=addMovie&returnformat=json",
            type: "POST",
            dataType: "json",
            data: new FormData(this),
            processData: false,
            contentType: false,
            success: function(response) {
                if (response[1] == "error") {
                    $("#valid-err").append("<p>" + response[0] + "</p>");

                } else {
                    $('#exampleModal').modal('hide');
                    location.reload();
                }
            },
            error: function(xhr, desc, err) {

            }
        });

    });

    $(document).on("click", ".btn-edit-movie", function(event) {
        var movie_id = $(this).data('id');
        $.ajax({
            type: "POST",
            url: "cfc/admin.cfc?method=getMovieById",
            data: "movie_id=" + movie_id,
            dataType: "json",
            cache: false,
            success: function(data) {
                console.log(data[0]);
                $('#movie_name').val(data[0].MOVIE_NAME);
                $('#hid_movie_poster').val(data[0].MOVIE_POSTER);
                $('#movie_youtubelink').val(data[0].MOVIE_YOUTUBELINK);
                $('#movie_rating').val(data[0].MOVIE_RATING);
                $('#movie_language').val(data[0].MOVIE_LANG);
                $('#movie_details').val(data[0].MOVIE_DETAILS);
                $('#movie_id').val(movie_id);
                if (data[0].COMING_SOON == '1') {
                    $('#movie_cmngsoonckb').prop('checked', true);
                    $('#movie_cmngsoon').val(1);
                } else {
                    $('#movie_cmngsoonckb').prop('checked', false);
                    $('#movie_cmngsoon').val(0);
                }
                if (data[0].MOVIE_POSTER != '') {
                    $('#show-mov-img').attr('src', 'uploads/Movie/' + data[0].MOVIE_POSTER);
                }
            }
        });
    });

    $('#TheatreDeleteModal').on('show.bs.modal', function(e) {
        $(this).find('.btn-yes').attr('href', $(e.relatedTarget).data('href'));
        $(this).find('.btn-yes').attr('href');
    });

    $('#MovieDeleteModal').on('show.bs.modal', function(e) {
        $(this).find('.btn-yes').attr('href', $(e.relatedTarget).data('href'));
        $(this).find('.btn-yes').attr('href');
    });

    $(document).on('hide.bs.modal', '#exampleModal', function() {
        var form_id = $(this).closest("form").attr('id');
        //alert(form_id);
        // var validator = $("#form_addTheatre").validate();
        // validator.resetForm();
    });

    $(document).on("submit", "#form_addShowTime", function(event) {
        event.preventDefault();
        $.ajax({
            url: "cfc/admin.cfc?method=addShowTime&returnformat=json",
            type: "POST",
            dataType: "json",
            data: new FormData(this),
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.length != 0) {
                    $("#valid-err").empty();
                    for (i = 0; i < response.length - 1; ++i) {
                        $("#valid-err").append("<p>" + response[i] + "</p>");
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

    $(document).on("click", ".btn-edit-show", function(event) {
        var show_id = $(this).data('id');
        $.ajax({
            type: "POST",
            url: "cfc/admin.cfc?method=getShowById",
            data: "show_id=" + show_id,
            dataType: "json",
            cache: false,
            success: function(data) {
                $('#theatre_id').val(data[0].THEATRE_ID);
                $('#movie_id').val(data[0].MOVIE_ID);
                $('#online_booking').val(data[0].ONLINE_BOOKING);
                $('#price_gold_full').val(data[0].PRICE_GOLD_FULL);
                $('#price_gold_half').val(data[0].PRICE_GOLD_HALF);
                $('#price_odc_full').val(data[0].PRICE_ODC_FULL);
                $('#price_odc_half').val(data[0].PRICE_ODC_HALF);
                $('#price_box').val(data[0].PRICE_BOX);
                $('#show_id').val(show_id);

            }
        });
    });

    $('#ShowDeleteModal').on('show.bs.modal', function(e) {
        $(this).find('.btn-yes').attr('href', $(e.relatedTarget).data('href'));
        $(this).find('.btn-yes').attr('href');
    });

    $(document).on("click", ".btn-activate-home", function(event) {
        var movie_id = $(this).data('id');
        var actid_status = $(this).data('actid');
        $.ajax({
            type: "POST",
            url: "cfc/admin.cfc?method=updateHomePageMovie&returnformat=json",
            data: "movie_id=" + movie_id + "&actid_status=" + actid_status,
            dataType: "json",
            cache: false,
            success: function(response) {
                location.reload();
            }
        });
    });

});
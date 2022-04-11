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
                $('#movie_details').val(data[0].MOVIE_DETAILS);

                $('#movie_id').val(movie_id);
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
        // event.preventDefault();
        $.ajax({
            url: "cfc/admin.cfc?method=addShowTime&returnformat=json",
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

});
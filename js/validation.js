$(document).ready(function() {
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
            },
            theatre_img: {
                required: true,
            }
        }
    });

    $("#form_addmovie").validate({
        rules: {
            movie_name: {
                required: true
            },
            movie_poster: {
                required: true,
            }
        }
    });

    $(document).on("submit", "#form_addTheatre", function(event) {
        // event.preventDefault();
        $.ajax({
            url: "cfc/admin.cfc?method=addTheatre",
            type: "POST",
            dataType: "JSON",
            data: new FormData(this),
            processData: false,
            contentType: false,
            success: function(data, status) {

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
                console.log(data[0]);
                $('#theatre_name').val(data[0].THEATRE_NAME);
                $('#theatre_img').val(data[0].THEATRE_IMAGE);

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
            url: "cfc/admin.cfc?method=addMovie",
            type: "POST",
            dataType: "JSON",
            data: new FormData(this),
            processData: false,
            contentType: false,
            success: function(data, status) {

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
                $('#movie_poster').val(data[0].MOVIE_POSTER);
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

    // $('#DeleteModal').on('click', '.btn-yes', function(e) {

    //     var $modalDiv = $(e.delegateTarget);
    //     var id = $(this).data('recordId');
    //     alert(id);

    //     // $modalDiv.addClass('loading');
    //     // $.post('/api/record/' + id).then(function() {
    //     //     $modalDiv.modal('hide').removeClass('loading');
    //     // });
    // });

    $('.btn-yes').click(function(e) {
        $('#DeleteModal').modal('hide');
        alert($('#DeleteModal').attr('href'));
        $.ajax({
            url: $('#DeleteModal').attr('href'),
            success: function(result) {
                // $(anchor).closest('tr').addClass("error");
                // $(anchor).closest('tr').delay(2000).fadeOut();
            }
        });
    });

    $(document).on('hide.bs.modal', '#exampleModal', function() {
        var form_id = $(this).closest("form").attr('id');
        //alert(form_id);
        // var validator = $("#form_addTheatre").validate();
        // validator.resetForm();
    });

});
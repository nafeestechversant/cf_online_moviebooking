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

    $(document).on("submit", "#form_addTheatre", function(event) {
        // event.preventDefault();
        $.ajax({
            url: $(this).attr("action"),
            type: $(this).attr("method"),
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

    $(document).on('hide.bs.modal', '#exampleModal', function() {
        var validator = $("#form_addTheatre").validate();
        validator.resetForm();
    });

});
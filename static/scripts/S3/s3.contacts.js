$('.contact').each(function () {
    var contact = $(this);
    var id = contact.attr('id').match(/\d+/);
    contact.find('a.editBtn').click(function (e) {
        var span = contact.find('span');
        var current = span.html();

        var formHolder = $('<div>').addClass('form-container');

        var form = $('<form>');
        formHolder.append(form);

        var input = $('<input>');
        input.val(current);
        form.append(input);

        var save = $('<input type="submit">');
        save.val('Save');
        form.append(save);

        span.replaceWith(formHolder);
        contact.addClass('edit');

        form.submit(function (e) {
            e.preventDefault();
            contact.removeClass('edit').addClass('saving');
            form.append($('<img src="' + S3.Ap.concat('/static/img/jquery-ui/ui-anim_basic_16x16.gif') + '">').addClass('fright'));
            form.find('input[type=submit]').addClass('hidden');
            $.post(S3.Ap.concat('/hrm/contact/' + id[0] + '.s3json'),
                   '{"$_pr_contact":' + JSON.stringify({'value': input.val()}) + '}',
                   function () {
                      contact.removeClass('saving');
                      // @ToDo: Use returned value instead of submitted one
                      var value = input.val();
                      formHolder.replaceWith($('<span>').html(value));
                   }, 'json');
        });
    });
});

$('.address').each(function () {
    var address = $(this);
    var id = address.attr('id').match(/\d+/);
    address.find('a.editBtn').click(function () {
        // Download the form
        var url = S3.Ap.concat('/hrm/address/' + id + '.iframe/update')
        $.get(url, function(data) {
            // Hide the Read row
            address.hide();
            // Add a DIV to show the iframe in
            address.after('<div id="edit' + id + '"></div>');
            // Load the Form into the iframe
            address.next().html(data);
            // Modify the submission URL
            var url2 = S3.Ap.concat('/hrm/address/' + id + '/update?person=' + personId);
            $('#popup').find('form').attr('action', url2);
        });
    });
});
/*
 * jQuery File Upload Plugin JS Example
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * https://opensource.org/licenses/MIT
 */

/* global $, window */

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: 'http://pcrc.library.sh.cn/files/FileTransferHandler.ashx',
		acceptFileTypes: /(\.|\/)(rar|zip)$/i,
		maxNumberOfFiles: 1,
		maxFileSize: 1024*1024*50
    })
	.on('fileuploaddone', function (e, data) {
        $.each(data.result.files, function (index, file) {
            if (file.url) {
                var link = $('<a>')
                    .attr('target', '_blank')
                    .prop('href', file.url);
                $(data.context.children()[index])
                    .wrap(link);
            } else if (file.error) {
                var error = $('<span class="text-danger"/>').text(file.error);
                $(data.context.children()[index])
                    .append('<br>')
                    .append(error);
            }
        });
    })
	.on('fileuploaddrop', function (e, data) {
		e.preventDefault(); 
        $.each(data.files, function (index, file) {
			console.log('Dropped file: ' + file.name);
		});
    });



    if (window.location.hostname === 'blueimp.github.io') {

    } else {
        // Load existing files:
        $('#fileupload').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload').fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
            $(this).fileupload('option', 'done')
                .call(this, $.Event('done'), {result: result});
        });
    }

});
$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload1').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: 'http://pcrc.library.sh.cn/files/FileTransferHandler.ashx',
		acceptFileTypes: /(\.|\/)(ppt|pptx|pdf)$/i,
		maxNumberOfFiles: 2,
		maxFileSize: 1024*1024*50
    })
	.on('fileuploaddone', function (e, data) {
        $.each(data.result.files, function (index, file) {
            if (file.url) {
                var link = $('<a>')
                    .attr('target', '_blank')
                    .prop('href', file.url);
                $(data.context.children()[index])
                    .wrap(link);
            } else if (file.error) {
                var error = $('<span class="text-danger"/>').text(file.error);
                $(data.context.children()[index])
                    .append('<br>')
                    .append(error);
            }
        });
    })
	.on('fileuploaddrop', function (e, data) {
		 e.preventDefault(); 
        $.each(data.files, function (index, file) {
			console.log('Dropped file: ' + file.name);
		});
    });



    if (window.location.hostname === 'blueimp.github.io') {

    } else {
        // Load existing files:
        $('#fileupload1').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload1').fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload1')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
            $(this).fileupload('option', 'done')
                .call(this, $.Event('done'), {result: result});
        });
    }

});
$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload2').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: 'http://pcrc.library.sh.cn/files/FileTransferHandler.ashx',
		acceptFileTypes: /(\.|\/)(mp4)$/i,
		maxNumberOfFiles: 1,
		maxFileSize: 1024*1024*50
    })
	.on('fileuploaddone', function (e, data) {
        $.each(data.result.files, function (index, file) {
            if (file.url) {
                var link = $('<a>')
                    .attr('target', '_blank')
                    .prop('href', file.url);
                $(data.context.children()[index])
                    .wrap(link);
            } else if (file.error) {
                var error = $('<span class="text-danger"/>').text(file.error);
                $(data.context.children()[index])
                    .append('<br>')
                    .append(error);
            }
        });
    })
	.on('fileuploaddrop', function (e, data) {
		e.preventDefault(); 
        $.each(data.files, function (index, file) {
			console.log('Dropped file: ' + file.name);
		});
    });



    if (window.location.hostname === 'blueimp.github.io') {

    } else {
        // Load existing files:
        $('#fileupload2').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload2').fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload2')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
            $(this).fileupload('option', 'done')
                .call(this, $.Event('done'), {result: result});
        });
    }

});
$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload3').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: 'http://pcrc.library.sh.cn/files/FileTransferHandler.ashx',
		acceptFileTypes: /(\.|\/)(jpg|jpeg|png)$/i,
		maxNumberOfFiles: 1,
		maxFileSize: 1024*1024*50
    })
	.on('fileuploaddone', function (e, data) {
        $.each(data.result.files, function (index, file) {
            if (file.url) {
                var link = $('<a>')
                    .attr('target', '_blank')
                    .prop('href', file.url);
                $(data.context.children()[index])
                    .wrap(link);
            } else if (file.error) {
                var error = $('<span class="text-danger"/>').text(file.error);
                $(data.context.children()[index])
                    .append('<br>')
                    .append(error);
            }
        });
    })
	.on('fileuploaddrop', function (e, data) {
		e.preventDefault(); 
        $.each(data.files, function (index, file) {
			console.log('Dropped file: ' + file.name);
		});
    });



    if (window.location.hostname === 'blueimp.github.io') {

    } else {
        // Load existing files:
        $('#fileupload3').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload3').fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload3')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
            $(this).fileupload('option', 'done')
                .call(this, $.Event('done'), {result: result});
        });
    }

});

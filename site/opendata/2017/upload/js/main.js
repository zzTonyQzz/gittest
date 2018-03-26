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
        url: 'http://pcrc.library.sh.cn/files/FileTransferHandler.ashx?hqxu=hqxu',
		acceptFileTypes: /(\.|\/)(gif|jpe?g|png|rar|zip|pdf|ppt|pptx|doc|docs|txt|xls|xlsx|py|mp4|mkv|rmb|avi)$/i,
		maxNumberOfFiles: 99,
		maxFileSize: 1024*1024*50
    })
	.on('fileuploaddone', function (e, data) {
		console.log(data)
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
		console.log(data);
		 e.preventDefault(); 
        $.each(data.files, function (index, file) {
			console.log('Dropped file: ' + file.name);
		});
    });



    if (window.location.hostname === 'blueimp.github.io') {

    } else {
        // Load existing files:
        $('#fileupload').addClass('fileupload-processing');
		//console.log($('#fileupload').fileupload('option', 'url'));
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload').fileupload('option', 'url'),			
            dataType: 'json',
            context: $('#fileupload')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
			console.log(result);
            $(this).fileupload('option', 'done')
                .call(this, $.Event('done'), {result: result});
        });
    }

});


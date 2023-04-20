$(function() {
    if ($('textarea[data-ckeditor]').length) {
      CKEDITOR.config.customConfig = '/assets/ckeditor/config.js';
      CKEDITOR.replace($('textarea[data-ckeditor]').attr('id'));
    }
  });
  
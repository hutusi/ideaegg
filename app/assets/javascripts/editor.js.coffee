//= require summernote

$ ->

  # to set summernote object
  # You should change '#post_content' to your textarea input id
  summer_note = $('#idea_content')

  # to call summernote editor
  summer_note.summernote
    # to set options
    height:350
    toolbar: [
      ['style', ['style']],
      ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
      ['fontsize', ['fontsize']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert', ['link', 'picture', 'hr']],
      ['misc', ['undo', 'redo']]
      ['view', ['fullscreen']]
    ]
    codemirror:
      lineNumbers: true
      tabSize: 2
      theme: 'solarized light'
    onImageUpload: (files, editor, welEditable) ->
      for file in files
        Qiniu.sendFile file, (url) ->
          editor.insertImage(welEditable, url)

  # to set code for summernote
  summer_note.code summer_note.val()

  # to get code for summernote
  summer_note.closest('form').submit ->
    # alert $('#post_content').code()
    summer_note.val summer_note.code()
    true

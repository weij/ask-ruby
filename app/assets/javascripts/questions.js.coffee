# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Questions =
  preview: (body, preview_box) ->
    preview_box.text "Loading..."

    $.post "/questions/preview",
      "body": body,
      (data) ->
        preview_box.html data.body
      "json"
      
  hookPreview: (switcher, textarea) ->
    preview_box = $(document.createElement("div")).addClass "preview_box"
    $(textarea).after preview_box

    $(".edit a", $(switcher)).click ->
      form = $(this).closest("form")
      $(".preview", form.find(switcher)).removeClass("active")
      $(this).parent().addClass("active")
      $(".preview_box", form).hide()
      $(textarea, form).show()
      false
    $(".preview a", $(switcher)).click ->
      form = $(this).closest("form")
      $(".edit", form.find(switcher)).removeClass("active")
      $(this).parent().addClass("active")
      preview_box = $(".preview_box", form)
      preview_box.show()
      $(textarea, form).hide()
      Questions.preview($(textarea, form).val(), preview_box)
      false
    preview_box.hide()

  answerCallback: (success, msg) ->
    if success
      Questions.bindAnswersCallback() 
      Util.notice(msg, '#new_answer')
    else
      Util.alert(msg, '#new_answer')
      
  bindAnswersCallback: () ->
    $(".answer a.btn-danger").on "ajax:complete", (e, xhr, status)->
      if status == 'nocontent'
        $(this).closest('.answer').remove()
        

$(document).ready ->
  $("#question_add_image").on "click", () ->
    $("#question_upload_images").click()
    return false
  $(".comment label").on "click", () ->
    $(this).hide().next(".comment-form").show()
  $(".comment-form a").on "click", () ->
    $(this).closest(".comment-form").hide().closest(".comment").find("label").show()
    
  $(".edit-answer-form .cancel-link").on "click", () ->
    $(this).closest(".edit-answer-form").hide()
    return false
  $(".edit-answer-button").on "click", () ->
    $(this).parent("div").find(".edit-answer-form").show()
    
  $(".edit-answer-form form").on "ajax:success", () ->
    $(this).closest(".edit-answer-form").hide()
    
  Questions.bindAnswersCallback()  
  Questions.hookPreview(".editor_toolbar", ".questions_editor,.answers_editor")
  return

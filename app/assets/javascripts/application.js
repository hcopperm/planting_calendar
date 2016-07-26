// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require_tree .
//= require bootstrap


$(document).on('ready page:load', function () {
  $(".datepicker").datepicker({format: 'mm/dd/yyyy'});

  $(".scope").on("click", function() {
    $(".scope-name").text($(this).data("name"));
  });

  $(".task-table .date").on("click", function() {
    $(this).find("span").removeClass("hide").find("input").datepicker();
  });

  $(".task-table .update").on("click", function() {
    var span = $(this).parent();
    var input = span.find("input");
    $.ajax({
      url: "/planting_tasks/" + input.attr("id")+ "/update_from_index",
      type: "PUT",
      data: {
        type: input.data("type"),
        value: input.val()
      },
      success: function() {
        span.addClass("hide");
        var successEl = span.parent();
        successEl.removeClass("date").addClass("text-success");
        successEl.text(input.val());
      }

    });
  })
});

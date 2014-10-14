//Use Datejs and jQuery to validate and create smart, auto-correcting date/time input fields.

$(function(){
  $('input.autoDate').change(function() {
    var d = $(this).val();
    if (Date.parse(d) !== null) {
      $(this).val(Date.parse(d).toString('M/d/yyyy'));
    }
  });

  $('input.autoDateTime').change(function() {
    var d = $(this).val();
    if (Date.parse(d) !== null) {
      $(this).val(Date.parse(d).toString('M/d/yyyy h:mm tt'));
    }
  });
});
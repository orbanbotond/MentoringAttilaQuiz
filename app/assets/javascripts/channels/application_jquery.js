function remove_fields(link) {
  if ($("#answers table:visible").length > 2) {
    $(link).closest('table').find(':checkbox').attr('checked', false);
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest("table").hide();
  }
  else {
    alert("Minimum 2 answers");
  }
}

function add_fields(link, association, content) {
  if ($("#answers table:visible").length < 5) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));
  }
  else {
    alert("Maximum 5 answers");
  }
}
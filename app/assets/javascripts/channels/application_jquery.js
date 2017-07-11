function remove_fields(link) {
  $(link).closest('table').find(':checkbox').attr('checked', false);
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("table").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}
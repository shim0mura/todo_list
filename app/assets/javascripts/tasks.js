$(function(){
  $(document).on("page:change", ensortable_tasks);
  $(document).on("page:change", enfinish_tasks);
  $(document).on("page:change", set_default_sort);
  $(document).on("page:change", set_datetime_picker);
  $(document).on("page:change", set_time_picker);

  ensortable_tasks();
  enfinish_tasks();
  set_default_sort();
  set_datetime_picker();
  set_time_picker();

  function enfinish_tasks(){
    console.log("ddd");
    $(".finish_task").on("click", function(elm){
      var self = this;
      // TODO: idはdata属性にいれておきたい
      var task_id = this.id.slice(12);
      $.post(
        "tasks/finish",
        "task_id="+task_id,
        function(data){
          $("#task-"+task_id).remove();
        }
      )
    
    });
  }

  function set_time_picker(){
    console.log("eee");
    $("#task_estimate").timepicker({
      hourGrid: 2,
      hourMax: 6,
      minuteGrid: 10,
      stepMinute: 10
    });
  }

  function set_datetime_picker(){
    console.log("ccc");
    $('#task_limit').datetimepicker({dateFormat: "yy-mm-dd"});
  }

  function set_default_sort(){
    console.log("bbb");
    $("#position_array").val($("#tasks").sortable("serialize"))
  }

  function ensortable_tasks(){
    console.log("aaa")
    $("#tasks").sortable({
      update: function(event, ui){
        var sorted_array = $("#tasks").sortable("serialize");
        $("#position_array").val(sorted_array);
        $.post(
          "sort/change",
          $("#tasks").sortable("serialize"),
          function(data){
            console.log(data);
            console.log(data.result);
          }
        )
      }
    })
    .disableSelection();
  }
});


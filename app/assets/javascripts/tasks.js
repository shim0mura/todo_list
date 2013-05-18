$(function(){
  $(document).on("page:change", ensortable_tasks);
  $(document).on("page:change", enfinish_tasks);
  $(document).on("page:change", set_default_sort);
  $(document).on("page:change", set_datetime_picker);
  $(document).on("page:change", set_time_picker);
  $(document).on("page:change", add_child_task_field);

  ensortable_tasks();
  enfinish_tasks();
  set_default_sort();
  set_datetime_picker();
  set_time_picker();
  add_child_task_field();

  function add_child_task_field(){
    console.log("fff");
    var temp = $("#temp");
    var form = $("#new_task");
    var num = 0;

    $('#nested_tasks').nestedSortable({
      listType: "ul",
      forcePlaceholderSize: true,
      handle: 'div',
      helper: 'clone',
      items: 'li',
      opacity: .6,
      placeholder: 'placeholder',
      revert: 250,
      tabSize: 25,
      tolerance: 'pointer',
      toleranceElement: '> div',
      maxLevels: 0,
      isTree: true,
      expandOnHover: 700,
      startCollapsed: true,
      protectRoot: true,
      isAllowed: function(item, parent){
        var parent_id = $(parent).find(".tmp_id").val();
        console.log("ppp"+parent_id);
        $(item).find(".parent_task").val(parent_id);
        return true;
      }

    });

    $(".task_template").on("click", ".add_child", function(){
      num++;
      var self = this;
      var $wrapper = $(self).parent().parent();
      var $temp = $(self).parent();
      var parent_id = $temp.find(".tmp_id").val();
      console.log(parent_id);
      $temp.find(".date_picker").removeClass("hasDatepicker").removeData("datepicker");
      $temp.find(".time_picker").removeClass("hasDatepicker").removeData("datepicker");

      $temp = $temp.clone(true);
      $temp.find(".date_picker")[0].id = "date_" + num;
      $temp.find(".time_picker")[0].id = "time_" + num;
      $temp.find(".parent_task")[0].id = "parent_task_" + num;
      $temp.find(".parent_task")[0].value = parent_id;
      $temp.find(".tmp_id")[0].value = num;
      var a = $("<li>").attr("id", "task_" + num).append($temp);
      var b = $("<ul>").append(a);
      $wrapper.append(b);

      var positioned_task = $("<li>")
        .attr("id", "task-xxx" + num)
        .text(
          $temp.find(".task_name").val()
        );
      $("#arranged_tasks").append(positioned_task);
      var sorted_array = $("#arranged_tasks").sortable("serialize");
      $("#position_array").val(sorted_array);
    });
  }

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
    //$(".time").on("focusin", ".time_picker", function(e){
    $(document).on("focusin", ".time_picker", function(e){
      $(this).timepicker({
        hourGrid: 2,
        hourMax: 6,
        minuteGrid: 10,
        stepMinute: 10
      });
    });
  }

  function set_datetime_picker(){
    console.log("ccc");
    $(document).on("focusin", ".date_picker", function(e){
      //$(".hasDatapicker").each(function(){
        //$(this).removeClass("
      console.log("sss");
      $(this).datetimepicker({dateFormat: "yy-mm-dd"});
    })
  }

  function set_default_sort(){
    console.log("bbb");
    $("#position_array").val($("#arranged_tasks").sortable("serialize"))
  }

  function ensortable_tasks(){
    console.log("aaa")
    $("#arranged_tasks").sortable({
      update: function(event, ui){
        var sorted_array = $("#arranged_tasks").sortable("serialize");
        $("#position_array").val(sorted_array);
        $.post(
          "sort/change",
          $("#arranged_tasks").sortable("serialize"),
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


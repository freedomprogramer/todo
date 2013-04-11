$(function(){
  $('input[type=text]').keypress(function(e){
    var code = e.keyCode;  //判断按键是否为enter

    if(code == 13){
      var entervalue = $(this).val();

      $.ajax({
        type: 'post',
        url: '/todo_lists',
        data: {todo_list: {todo_name: entervalue}},
        success: function(data){
            $('#todo-list').append("<li class='todo-item' id='"+data.id+"'><input class='unchecked' type='checkbox' title='done thing'><span class='item-name'>"+entervalue+"</span></li>");
        }
      });

      $(this).val('');  //清除输入框内容
    }
  })

  // 删除todo-item
  $(document).on('click', ':checkbox', function(){
    if($(this).hasClass('unchecked')){
      var $done_todo = $(this).parent();

      $.ajax({
        type: 'delete',
        url: '/todo_lists/' + $done_todo.attr('id'),
        success: function(data){
          $done_todo.clone()
              .attr('class', 'done-item')
              .attr('id', data.id)
              .find('input').remove().end()
              .prependTo('#done-things').css('display', 'none');
          $('.done-item:first').fadeIn(1000).slideDown(500);
          $done_todo.fadeOut(500).remove();
        }
      })
    }
  })
})

$(function(){
  // 创建未办事项
  $('input[type=text]').keypress(function(e){
    var code = e.keyCode;  //判断按键是否为enter

    if(code == 13){
      var entervalue = $(this).val();

      $.ajax({
        type: 'post',
        url: '/todo_lists',
        data: {task: {task_name: entervalue, status: 'undo'} },
        success: function(data){
          $('#undo-things').append("<li class='undo-item' id='" + data.id + "'>"
                                   + "<input class='unchecked' type='checkbox' title='done thing'>"
                                   + "<span class='item-name'>" + entervalue + "</span>"
                                   + "<span class='item-delete'>X</span></li>");
        }
      });

      $(this).val('');  //清除输入框内容
    }
  })

  // 改变未办事项为已办
  $(document).on('click', ':checkbox', function(){
    if($(this).hasClass('unchecked')){
      var $done_todo = $(this).parent();

      $.ajax({
        type: 'put',
        url: '/todo_lists/' + $done_todo.attr('id'),
        success: function(data){
          $done_todo.clone()
              .attr('class', 'done-item')
              .attr('id', data.id)
              .find('input').remove().end()
              .find('.item-delete').remove().end()
              .prependTo('#done-things').css('display', 'none');
          $('.done-item:first').fadeIn(1000).slideDown(500);
          $done_todo.fadeOut(500).remove();
        }
      })
    }
  })

  // 删除待办todo
  $('#undo-things').on('click', '.item-delete', function(){
    var $this = $(this),
        task_id = $this.parent().attr('id'),
        choose_what = confirm('Are you sure?');

    if(choose_what){
      $.ajax({
        type: 'delete',
        url: '/todo_lists/' + task_id,
        success: function(){
          $this.parent().fadeOut(500).end().remove();
        }
      })
    }
  })

  // 选择历史记录
  $('#start-date').datepicker({ dateFormat: 'yy-mm-dd' });
  $('#end-date').datepicker({ dateFormat: 'yy-mm-dd' });

  // 查询历史记录
  $('#start-date').change(function(){
    var start_date = $(this).val();

    $('#end-date').change(function(){
      var end_date = $(this).val();
      var range_date = {
          "start_date": start_date,
          "end_date": end_date
      }

      $.ajax({
        type: 'get',
        url: '/todo_lists/tracks',
        data: range_date,
        success: function(data){
          $('#content').children().remove();

          for(i in data){
            var length = data[i].length;
            $('#content').append('<h2>'+ i.substring(0, 10) +'</h2><ul></ul>');

            for(j=0; j < length; j++){
              $('#content ul').append("<li>"
                                      +"<span>"+data[i][j].updated_at.substring(11, 19)+"</span>"
                                      +data[i][j].task_name+"</li>");
            }
          }
        }
      })

    });
  })

  // 在历史记录中单击标题来显隐子项
  $('#content').on('click', 'h2', function(){
    $(this).next().slideToggle();
  })

  // 单击用户名显示用户操作
  $('#user-login').click(function(){
    $('#user-operation').slideToggle(1000);
  })

  // 给user-operation的li增加动画
  $('#user-operation ul li').mouseover(function(){
      $(this).children('a').animate({
          marginLeft: '70px'
      }, 500)
  })

  $('#user-operation ul li').mouseleave(function(){
      $(this).children('a').animate({
          marginLeft: '50px'
      })
  })


  // 单击显示
  $('#history-record a').click(function(){
    $('#pop-history-bg').fadeIn(600);
  })

  // 单击隐藏
  $('span.close').click(function(){
    $('#pop-history-bg').fadeOut(600);
  })
})

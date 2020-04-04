layui.define(['form', 'jquery'], function (exports) {
  var form = layui.form,
    $ = layui.jquery;
  var common = {
    initSelector: function (config) {
      var selectors = config.selectors,
        editItem = (config.editItem) ? JSON.parse(config.editItem) : null;
      selectors.forEach(function (selector) {
        $.get(selector.url, function (res) {
          var options = res.data,
            html = '',
            selected = false;
          for (var i = 0; i < options.length; i++) {
            if (editItem && selected == false) {
              if (editItem[selector.key] == options[i][selector.text]) {
                html = $("<option value='" + options[i][selector.value] + "' selected>" + options[i][selector.text] + "</option>");
                selected = true;
              }else{
                html = $("<option value='" + options[i][selector.value] + "'>" + options[i][selector.text] + "</option>");
              }
            }else {
              html = $("<option value='" + options[i][selector.value] + "'>" + options[i][selector.text] + "</option>");
            }
            $(selector.target).append(html);
          }
          selected = false;
          form.render();
        });
      })
    }
  };
  //输出common接口
  exports('common', common);
});
// turbolinksの無効化
$(document).on('turbolinks:load', function() {
  /* global $*/
  $(function(){
    // tab1以外を非表示
    $('#tab2').hide();
      // .tabがクリックされたとき処理を実行
    $('#tab-menu a').on('click', function(event) {
      // 全てのタグ内を一旦非表示
      $(".tab").hide();
      // activeクラスの削除
      $("#tab-menu .active").removeClass("active");
      // クリックしたタグにactiveクラスを追加
      $(this).addClass("active");
      // クリックしたタグの中身を表示
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  });
});
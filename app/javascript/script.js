// ユーザー詳細画面、投稿/ブックマークの切り替え
//turbolinksの無効化
$(document).on('turbolinks:load', function() {
  /* global $*/
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


// トップスクロール
$(function() {
  // クリック時に動作
  $('#top-scroll a').on('click',function(event){
    // 画面トップへ時間指定し動作
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
  // ボタン表示タイミング指定
  $(window).scroll(function() {
    if ($(this).scrollTop() > 1000) {
      $('#top-scroll').fadeIn();
    } else {
      $('#top-scroll').fadeOut();
    }
  });
});

// let nav_item1_btn = document.querySelector(".nav_item1");
// // ファンクション指定
// const sidebar_nav_item1 = () => {
//   console.log('ボタンがクリックされました');
// }


// nav_item1_btn.addEventListener('click',sidebar_nav_item1)

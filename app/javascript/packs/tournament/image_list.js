$(document).on("turbolinks:load", function () {

  // 魚種選択でtext_areaの切り替え
  document.getElementById("tournament_fish_name_other").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "block";
    }
  }

  // targetクラスの選択時にテキストエリアを非表示
  let targets = document.getElementsByClassName('target');
  for (let i = 0; i < targets.length; i++){
    targets[i].addEventListener("click", () => {
      document.getElementById("othertext").style.display = "none";
    }, false);
  }

// メインルールの内容で釣果上限説明表示の切り替え
  document.getElementById("tournament_main_rule_デカイもん勝ち").onclick = function () {
    if (this.checked) {
      document.getElementById("judging_limit").style.display = "none";
      document.getElementById("swap_limit").style.display = "block";
      document.getElementById("limit_content").style.display = "block";
    }
  }
  document.getElementById("tournament_main_rule_合計長さで勝負").onclick = function () {
    if (this.checked) {
      document.getElementById("judging_limit").style.display = "block";
      document.getElementById("swap_limit").style.display = "block";
      document.getElementById("limit_content").style.display = "block";
    }
  }
  document.getElementById("tournament_main_rule_とにかく数を釣れ").onclick = function () {
    if (this.checked) {
      document.getElementById("judging_limit").style.display = "none";
      document.getElementById("swap_limit").style.display = "none";
      document.getElementById("limit_content").style.display = "none";
    }
  }
});

$(function () {
  $('.search-text').keyup(function () {
    // テキストボックスの内容を取得＆変数に入れる
    search_text = $('.search-text').val().toLowerCase();
    // texts-content 内の h3をすべて取得する
    $('ul.image-list .image-box p').each(function () {
      val = $(this).text().toLowerCase();
      if (val.match(search_text)) {
        // (this)の元要素になるtexts-contentクラスを表示にする
        $(this).parents('.image-list li').show();
      } else {
        // (this)の元要素になるtexts-contentクラスを非表示にする
        $(this).parents('.image-list li').hide();
      }
    });
  });
});
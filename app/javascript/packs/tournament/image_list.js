$(document).on("turbolinks:load", function () {
  $(function () {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
    $("#tournament_img").change(function () {
      readURL(this);
    });
  });

  
  // 魚種選択でtext_areaの切り替え
  document.getElementById("tournament_fish_name_other").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "block";
    }
  }
  document.getElementById("tournament_fish_name_ラージマウスバス").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_スモールマウスバス").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_ナマズ").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_ライギョ").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_鯉").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_フナ").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_シーバス").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_シイラ").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_青物").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_鯛").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_ロックフィシュ").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }
  }
  document.getElementById("tournament_fish_name_イカ").onclick = function () {
    if (this.checked) {
      document.getElementById("othertext").style.display = "none";
    }

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
  // テキストボックスでキーアップされた時に実行
  $('.search-text').keyup(function () {
    // テキストボックスの内容を取得し変数に入れる
    search_text = $(".search-text").val().toLowerCase();
    // texts-content 内の h3をすべて取得する
    $('ul.image-list .image-box p').each(function () {
      // 大文字小文字を区別させず取得して変数に入れる
      val = $(this).text().toLowerCase();
      if (val.match(search_text)) {
        // (this)の先祖要素になるtexts-contentクラスを表示にする
        $(this).parents('.image-list li').show();
      } else {
        // (this)の先祖要素になるtexts-contentクラスを非表示にする
        $(this).parents('.image-list li').hide();
      }
    });
  });
});
window.onload = function () {
  document.getElementById("tournament_fish_name_ture").onclick = function () {
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
  window.onload = (function () {
    // チェックボックスのクリックを無効化します。
    $('.image_box .radio-box').click(function () {
      return false;
    });

    // 画像がクリックされた時の処理です。
    $('img.image').click(function () {
      var $imageList = $('.image_list');

      // 現在の選択を解除します。
      $imageList.find('img.image.checked').removeClass('checked');

      // チェックを入れた状態にします。
      $(this).addClass('checked');
    });
  });
}
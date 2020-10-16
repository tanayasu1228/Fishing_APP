window.onload = function () {
  // 魚種選択でtext_areaの切り替え
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

// メインルールの内容で釣果上限の切り替え
  document.getElementById("tournament_main_rule_１匹の最大長さ").onclick = function () {
    if (this.checked) {
      document.getElementById("judging_limit").style.display = "none";
      document.getElementById("swap_limit").style.display = "block";
      document.getElementById("limit_content").style.display = "block";
    }
  }
  document.getElementById("tournament_main_rule_合計長さ").onclick = function () {
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
}
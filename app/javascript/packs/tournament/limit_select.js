window.onload = function () {
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
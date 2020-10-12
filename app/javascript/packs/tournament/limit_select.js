window.onload = function () {
  document.getElementById("tournament_condition_１匹の最大長さ").onclick = function () {
    if (this.checked) {
      document.getElementById("wayin_limit").style.display = "none";

      document.getElementById("swap_limit").style.display = "block";
    }
  }

  document.getElementById("tournament_condition_合計長さ").onclick = function () {
    if (this.checked) {
      document.getElementById("wayin_limit").style.display = "block";

      document.getElementById("swap_limit").style.display = "block";
    }

  }

  document.getElementById("tournament_condition_とにかく数を釣れ").onclick = function () {
    if (this.checked) {
      document.getElementById("wayin_limit").style.display = "none";

      document.getElementById("swap_limit").style.display = "none";
    }

  }

}
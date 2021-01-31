$(function () {
  // 元のURLを取得＆"/"で分解
  var referrer = document.referrer.split('/');
  var targetWord = 'confirm';
  // referrer内に"confirm"が含まれていれば、インデックス番号を格納
  var inValue = referrer.indexOf(targetWord);

  if (inValue >= 0) {
    history.pushState(null, null, null);
    window.addEventListener("popstate", function () {
      var result = window.confirm('確認画面には戻れません。トップページにリダイレクトしますか？');
      if (result) {
        location.href = "http://localhost:3000/";
      }
      else {
        history.pushState(null, null, null);
      }
    })
  }
});
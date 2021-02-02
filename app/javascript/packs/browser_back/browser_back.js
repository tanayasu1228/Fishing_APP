// 投稿後にブラウザバックするとトップページへリダイレクトさせる
$(function () {
  // 元のURLを取得＆"/"で分解
  var referrer = document.referrer.split('/');
  var targetWord = 'confirm';
  // referrer内に"confirm"が含まれていれば、インデックス番号を格納
  var inValue = referrer.indexOf(targetWord);

  if (inValue >= 0) {
    history.pushState(null, null, null);
    window.addEventListener("popstate", function () {
      this.window.alert("投稿後に確認画面へは戻れません。トップページへリダイレクトします")
      location.href = "https://angler-app.herokuapp.com/";
    })
  }
});
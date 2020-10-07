$(function () {
  var radio = $('div.image-list');
  $('input', radio).css({ 'opacity': '0' })
    //checkedだったら最初からチェックする
    .each(function () {
      if ($(this).attr('checked') == 'checked') {
        $(this).next().addClass('checked');
      }
    });
  //クリックした要素にクラス割り当てる
  $('label', radio).click(function () {
    $(this).parent().parent().each(function () {
      $('label', this).removeClass('checked');
    });
    $(this).addClass('checked');
  });
});


// $(function () {
//   // チェックボックスのクリックを無効化します。
//   $('.image_box .disabled_checkbox').click(function () {
//     return false;
//   });

//   // 画像がクリックされた時の処理です。
//   $('img.image').on('click', function () {
//     if (!$(this).is('.checked')) {
//       // チェックが入っていない画像をクリックした場合、チェックを入れます。
//       $(this).addClass('checked');
//     } else {
//       // チェックが入っている画像をクリックした場合、チェックを外します。
//       $(this).removeClass('checked')
//     }
//   });
// });

// $(function () {
//   // チェックボックスのクリックを無効化します。
//   $('.image_box .disabled_checkbox').click(function () {
//     return false;
//   });

//   // 画像がクリックされた時の処理です。
//   $('img.image').click(function () {
//     var $imageList = $('.image_list');

//     // 現在の選択を解除します。
//     $imageList.find('img.image.checked').removeClass('checked');

//     // チェックを入れた状態にします。
//     $(this).addClass('checked');
//   });
// });
// window.onload = function () {
//   document.getElementById("tournament_fish_name_ture").onclick = function () {
//     if (this.checked) {
//       document.getElementById("othertext").style.display = "block";
//     } 
//     else {
//       document.getElementById("othertext").style.display = "none";
//     }
//   }
// }



var selecterBox = document.getElementById('sample');

function formSwitch() {
  check = document.getElementsByClassName('js-check')
  if (check[0].checked) {
    selecterBox.style.display = "none";

  } else if (check[1].checked) {
    selecterBox.style.display = "block";

  } else {
    selecterBox.style.display = "none";
  }
}
window.addEventListener('load', formSwitch());

function entryChange2() {
  if (document.getElementById('changeSelect')) {
    id = document.getElementById('changeSelect').value;
  }
}






















// function formSwitch(textid, ischecked ) {
//   check = document.getElementsByClassName('radio-box')
//   if (ischecked == true) {
//       // チェックが入っていたら有効化
//     // document.getElementById("othertext").style.display = "block";
//       document.getElementById(textid).disabled = false;
//    }
//    else {
//       // チェックが入っていなかったら無効化
//     // document.getElementById("othertext").style.display = "none";
//       document.getElementById(textid).disabled = true;
//    }
   
//   // if (check[0].checked) {
//   //   selecterBox.style.display = "none";

//   // } else if (check[1].checked) {
//   //   selecterBox.style.display = "block";

//   // } else {
//   //   selecterBox.style.display = "none";
//   // }
// }
// // ページ全体が完全に読み込まれたら動作を開始
// window.addEventListener('load', formSwitch());

// function entryChange2() {
//   if (document.getElementById('changeSelect')) {
//     id = document.getElementById('changeSelect').value;
//   }
// }


// function connecttext( textid, ischecked ) {
//    if( ischecked == true ) {
//       // チェックが入っていたら有効化
//       document.getElementById(textid).disabled = false;
//    }
//    else {
//       // チェックが入っていなかったら無効化
//       document.getElementById(textid).disabled = true;
//    }
// }



// $(function () {
//   var radio = $('div.image-list');
//   $('input', radio).css({ 'opacity': '0' })
//     //checkedだったら最初からチェックする
//     .each(function () {
//       if ($(this).attr('checked') == 'checked') {
//         $(this).next().addClass('checked');
//       }
//     });
//   //クリックした要素にクラス割り当てる
//   $('label', radio).click(function () {
//     $(this).parent().parent().each(function () {
//       $('label', this).removeClass('checked');
//     });
//     $(this).addClass('checked');
//   });
// });


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
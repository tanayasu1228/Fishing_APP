window.addEventListener('load', function () {
  viewSlide('.slide img');
});
function viewSlide(className, slideNo = -1) {
  let imgArray = document.querySelectorAll(className);
  if (slideNo >= 0) {
    //初回以外は現在のスライドを消す
    imgArray[slideNo].style.opacity = 0;
  }
  slideNo++;
  if (slideNo >= imgArray.length) {
    slideNo = 0; //次のスライドがなければ最初のスライドへ戻る
  }
  imgArray[slideNo].style.opacity = 1;
  //スライドの切り替え時間
  setTimeout(function () { viewSlide(className, slideNo); }, 3500);
}



// document.addEventListener("turbolinks:load", function () {
//   function slideSwitch() {
//     var $active = $('#slideshow img.active');
//     if ($active.length == 0) $active = $('#slideshow img:last');
//     var $next = $active.next().length ? $active.next()
//       : $('#slideshow img:first');
//     $active.addClass('last-active');
//     $next.css({ opacity: 0.0 })
//       .addClass('active')
//       .animate({ opacity: 1.0 }, 1000, function () {
//         $active.removeClass('active last-active');
//       });
//   }
//   setInterval("slideSwitch()", 3000);
// })






// window.onload = function slideSwitch() {
//   var $active = $('#slideshow img.active');
//   if ($active.length == 0) $active = $('#slideshow img:last');
//   var $next = $active.next().length ? $active.next()
//     : $('#slideshow img:first');
//   $active.addClass('last-active');
//   $next.css({ opacity: 0.0 })
//     .addClass('active')
//     .animate({ opacity: 1.0 }, 1000, function () {
//       $active.removeClass('active last-active');
//     });
// }
// $(function () {
//   setInterval("slideSwitch()", 3000);
// });
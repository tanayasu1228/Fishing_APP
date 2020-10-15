function change() {

  var element;
  if (document.getElementById("checkBox1").checked) {
    element = document.getElementById("mailAdress");
    element.disabled = false;
  } else {
    element = document.getElementById("mailAdress");
    element.disabled = true;
  }

}
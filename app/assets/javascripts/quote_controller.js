 function showMoreOrLess( elem ) {

    var link=elem;

    do {
        elem = elem.previousSibling;
    } while ( elem && elem.nodeType !== 1);


    if(link.innerHTML == "Show More"){
        elem.style.maxHeight="none";
        link.innerHTML="Show Less";
        elem.classList.remove("fade-overflow");
    } else {
        elem.style.maxHeight="58px";
        link.innerHTML="Show More";
        elem.classList.add("fade-overflow");
    }

}


var checkOverflow;
checkOverflow = function() {

  var elems = document.getElementsByClassName("pls");
  for(var i =0; i < elems.length; i++){
    /*
    console.log("scrollH " + elems[i].scrollHeight);
    console.log("clientH " + elems[i].clientHeight);
    console.log("scrollW " + elems[i].scrollWidth);
    console.log("clientW " + elems[i].clientWidth);
    */
    if (elems[i].scrollHeight > elems[i].clientHeight || elems[i].scrollWidth > elems[i].clientWidth) {
        $("<a class='see-more' onclick='showMoreOrLess(this);'>Show More</a>").insertAfter(elems[i]);
        elems[i].classList.add("fade-overflow");
    }
  }

};

$(document).ready(checkOverflow);
$(document).on('page:load', checkOverflow);
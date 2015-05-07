 function isOverflowed(elem) {
    return elem.scrollHeight > elem.clientHeight || elem.scrollWidth > elem.clientWidth;
}

function showMoreOrLess( elem ) {

    var link=elem;

    do {
        elem = elem.previousSibling;
    } while ( elem && elem.nodeType !== 1);


    if(link.innerHTML == "Show More"){
        elem.style.maxHeight="none";
        link.innerHTML="Show Less";
    } else {
        elem.style.maxHeight="58px";
        link.innerHTML="Show More";
    }

}
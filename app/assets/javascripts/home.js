function showMoreOrLess( elem ) {
    var link=elem;

    do {
        elem = elem.previousSibling;
    } while ( elem && elem.nodeType !== 1);

    if(link.innerHTML == "Show More"){
        elem.style.maxHeight="none";
        link.innerHTML="See Less";
    } else {
        elem.style.maxHeight="58px";
        link.innerHTML="Show More";
    }
}
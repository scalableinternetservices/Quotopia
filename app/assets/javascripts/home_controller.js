/**
 * Created by christinayang on 4/22/15.
 */
function validate()
{
    var x = document.forms["search-form"]["search"].value;
    if (x == null || x == "") {
        return false;
    }
}
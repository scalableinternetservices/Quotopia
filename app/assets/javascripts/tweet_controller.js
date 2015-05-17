function validate_form()
{
    var x = document.forms["tweet-form"]["tweet"].value;
    if (x == null || x == "") {
        return false;
    }
}
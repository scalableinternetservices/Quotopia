var init_typeahead = function(){ 

  var suggestions = new Bloodhound({
        datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.value);},
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '/typeahead?q=%QUERY' ,
            filter: function (results) {

                return $.map(results, function (result) {
                    return { value: result.value };
                });
            }
        }
  });

  suggestions.initialize(); 

  $('#q').typeahead(
    {
        hint: true,
        highlight: true,
        minLength: 1
    }, 
    {
        name: 'suggestions',
        displayKey: 'value',
        source: suggestions.ttAdapter()
    }); 
};

$(document).on('page:load', init_typeahead);
$(document).ready(init_typeahead);

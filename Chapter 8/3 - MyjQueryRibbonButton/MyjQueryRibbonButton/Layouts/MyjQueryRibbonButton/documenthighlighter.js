function highlightSelected() {
    // Select items based on if they're checked
    var citems = $('#onetidDoclibViewTbl0>tbody>.ms-itmhover>.ms-vb-itmcbx>input:checked');

    // Iterate through each checked item
    citems.each(function (index, element) {
        // Find the Table Row
        var tr = $(element).closest('tr');

        // Toggle the highlight class
        tr.toggleClass('ms-rteStyle-Highlight');
    });
}
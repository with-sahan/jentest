$(document).ready(function() {
	

	if ($('#status').hasClass('open')) {
 		 $('span#resolveBtn').show();
    } else if ($('#status').hasClass('resolved')){
        $('span#resolveBtn').hide();
    } 
	

	$("#resolveBtn a").click(function(){
   			$('#status').removeClass('open');
   			$('#status').addClass('resolved').text("RESOLVED");
			
	   if ($('#status').hasClass('resolved')){
 		 $('span#resolveBtn').fadeOut("slow");
       }
	});

	/* Formatting function for row details - modify as you need */
function format () {
    // `d` is the original data object for the row
    return '<table cellspacing="0" class="dashboard long">'+
        '<tr>'+
            '<th>Polling Station</th>'+
            '<th>Ballot Papers Issued</th>'+
			'<th>Postal Packs</th>'+
			'<th>Station Open</th>'+
			'<th>Status</th>'+
        '</tr>'+
        '<tr>'+
            '<td>1/AA Arbourthorne Cent and Forum Ltd</td>'+
            ' <td>100</td>'+
			' <td>5</td>'+
			' <td>YES</td>'+
			' <td class="green"></td>'+
        '</tr>'+
        '<tr>'+
            '<td>2/AB Catholic Church of The Holy Family</td>'+
            ' <td>500</td>'+
			' <td>13</td>'+
			' <td>YES</td>'+
			' <td class="amber"></td>'+
        '</tr>'+
		'<tr>'+
            '<td>3/AC Gleadless Utd Ref Church</td>'+
            ' <td>200</td>'+
			' <td>29</td>'+
			' <td>YES</td>'+
			' <td class="red"></td>'+
        '</tr>'+
		'<tr>'+
            '<td>4/AD Arbourthorne Social Centre</td>'+
            ' <td>200</td>'+
			' <td>3</td>'+
			' <td>NO</td>'+
			' <td class="green"></td>'+
        '</tr>'+
    '</table>';
}

    var table = $('#electoralArea').DataTable( {
        bFilter: false,
		bInfo: false,
		bPaginate: false,
    } );
     
    // Add event listener for opening and closing details
    $('#electoralArea tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );
 
        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child(format() ).show();
            tr.addClass('shown');
        }
    } );
    
    $('#boxProgress').DataTable({
        bFilter: false,
		bInfo: false,
		bPaginate: false,
    });
	
});


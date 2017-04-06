angular.module('newApp').factory('chartService', function () {
	
	var dashboardchart = {};
    function getRandom(maximum,minimum){    	   
 	   return  Math.floor(Math.random() * (maximum - minimum + 1)) + minimum;
    } 	
    
    function rgb2hex(rgb){
    	 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
    	 return (rgb && rgb.length === 4) ? "#" +
    	  ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
    	  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
    	  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) : '';
    }    
    
	dashboardchart.dashboardPieCharts = function (dataset) {
        var g_datasets = []; // Data of all charts  
        var tot_issue  = 0;
    	dashboardchart.cat_summary = [];
    	if(typeof dataset !== "undefined"){
            if (typeof dataset.reason !== 'undefined'){//Only one object is passed and it's not in obj array
            	temp_arr = dataset;
            	dataset = [];//reset array;
            	dataset.push(temp_arr);
            }
            $.each(dataset, function(key_t, item_t) {
            	tot_issue = tot_issue + eval(item_t.issuecount);
            });
            $.each(dataset, function(key1, item1) {//Go through result obj and get data for x axis and info indexed by hour 
            	colour_red = getRandom(254,1);
            	colour_green = getRandom(254,1);
            	colour_blue = getRandom(254,1);
            	
            	var chart_color_val = "rgba("+ colour_red +", "+ colour_green +", "+ colour_blue +",0.9)";
            	var legend_color_val = rgb2hex(chart_color_val);
            	
                g_datasets.push({ value: eval(item1.issuecount), color: chart_color_val, highlight: "rgba("+ getRandom(254,1) +", "+ getRandom(254,1) +", "+ getRandom(254,1) +",1)", label: item1.reason });
                issue_percent = (eval(item1.issuecount)/tot_issue)*100;
                dashboardchart.cat_summary.push({name: item1.reason, val: issue_percent.toFixed(2), colour: legend_color_val, act_val:eval(item1.issuecount) });
            });  
            var ctx = document.getElementById("pie-chart").getContext("2d");
            ctx.canvas.width = 250;
            ctx.canvas.height = 250;
            window.myPie = new Chart(ctx).Pie(g_datasets, {
                tooltipCornerRadius: 0
            });		            
    	}
       /* var g_datasets = [
                       { value: 300, color: "rgba(54, 173, 199,0.9)", highlight: "rgba(54, 173, 199,1)", label: "Blue" },
                       { value: 40, color: "rgba(201, 98, 95,0.9)", highlight: "rgba(201, 98, 95,1)", label: "Red" },
                       { value: 100, color: "rgba(255, 200, 112,0.9)", highlight: "rgba(255, 200, 112,1)", label: "Yellow" },
                       { value: 50, color: "rgba(27, 184, 152,0.9)", highlight: "rgba(27, 184, 152,1)", label: "Green" },
                       { value: 120, color: "rgba(97, 103, 116,0.9)", highlight: "rgba(97, 103, 116,1)", label: "Dark Grey" }
                   ];*/
	};	

    return dashboardchart;
});
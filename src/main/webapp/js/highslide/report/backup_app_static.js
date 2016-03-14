var backup_line_sta_container = {
    chart: {
        type: 'line',
        renderTo: 'backup_line_sta'
    },
    title: {
        text: 'Cloud Service Usage Statistic'
    },
    subtitle: {
        text: ''
    },
    xAxis: {
        categories: []
    },
    yAxis: {
        max : 0,
        min : 0,
        minTickInterval : 5,
        title: {
            text: 'Times'
        },
        stackLabels: {
            enabled:true
        }
    },
    tooltip: {
        enabled: false,
        formatter: function() {
            return '<b>'+ this.series.name +'</b><br>'+this.x +': '+ this.y +' times';
        }
    },
    plotOptions: {
        line: {
            dataLabels: {
                enabled: true
            },
            enableMouseTracking: false
        }
    },
    series: [{
        name: 'App Backup Action',
        data: []
    }, {
        name: 'App Online Operate Action',
        data: []
    }]
};
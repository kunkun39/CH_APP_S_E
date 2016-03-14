var app_column_sta_container = {
    chart: {
        type: 'column',
        renderTo: 'app_column_sta'
    },
    title: {
        text: 'End User Download App Statistic'
    },
    subtitle: {
        text: ''
    },
    xAxis: {
        categories: []
    },
    yAxis: {
        title: {
            text: 'Times'
        },
        min:0
    },
    tooltip: {
        formatter: function() {
            return '<b>' + this.series.name + this.y + ' times';
        }
    },
    legend: {
        enabled: true
    },
    plotOptions: {
        series: {
            colorByPoint: true
        },
        column: {
            dataLabels: {
                enabled: true
            },
            pointPadding:0.2,
            borderWidth:0,
            enableMouseTracking: true
        }
    }, series: [
        {
            name: 'End User Download App Statistic ',
            data: []
        }
    ]
};

var app_pie_sta_container = {
    chart: {
        renderTo: 'app_pie_sta',
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false
    },
    title: {
        text: 'End User Download App Statistic'
    },
    tooltip: {
        pointFormat: '<b>{series.name} {point.percentage:.1f} %</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                color: '#ffffff',
                connectorColor: '#bbbbbb',
                format: '{point.name} {point.percentage:.1f} %'
            }
        }
    },
    legend: {
        enabled: true
    },
    series: [{
        type: 'pie',
        name: 'App download percentage by category',
        data: []
    }]
};

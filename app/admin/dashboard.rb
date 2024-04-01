# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div id: "container" do
      # This div will be used by Highcharts to render the chart.
    end

    script src: "https://code.highcharts.com/highcharts.js"
    script src: "https://code.highcharts.com/highcharts-3d.js"
    script src: "https://code.highcharts.com/modules/exporting.js"
    script src: "https://code.highcharts.com/modules/export-data.js"
    script src: "https://code.highcharts.com/modules/accessibility.js"

    script type: "text/javascript" do
      raw <<~JS
        Highcharts.chart('container', {
          chart: {
              type: 'pie',
              options3d: {
                  enabled: true,
                  alpha: 45
              }
          },
          title: {
              text: 'Service Management Information',
              align: 'left'
          },
          subtitle: {
              text: 'Service + Booking Status + Status + Location',
              align: 'left'
          },
          plotOptions: {
              pie: {
                  innerSize: 100,
                  depth: 45
              }
          },
          series: [{
              name: 'Booking',
              data: [
                  ['Indore', 25],
                  ['Bhopal', 10],
                  ['Khandwa', 10],
                  ['Ujjain', 10],
                  ['Ayodhya', 20],
                  ['Dewas', 10],
                  ['Delhi', 15],
                  ['Mumbai', 10],
                  ['Kolkata', 10]
              ]
          }]
        });
      JS
    end
  end
end

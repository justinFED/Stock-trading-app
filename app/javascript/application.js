// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery3
//= require popper
//= require bootstrap


document.addEventListener("turbo:load", () => {
  
  const generateRandomData = () => {
    const data = [];
    for (let i = 0; i < 50; i++) {
      data.push(Math.random() * 40 + 60); 
    }
    return data;
  };

  const stockData = {
    labels: Array.from({ length: 50 }, (_, i) => i.toString()), 
    datasets: [{
      label: "Fluctuating Pattern",
      data: generateRandomData(),
      fill: false,
      borderColor: "#21ce99", 
      borderWidth: 2,
      lineTension: 0.1, 
      pointRadius: 0, 
    }]
  };

  const ctx = document.getElementById("stockChart").getContext("2d");

  const stockChart = new Chart(ctx, {
    type: "line",
    data: stockData,
    options: {
      scales: {
        x: [{
          type: 'linear',
          position: 'bottom'
        }],
        y: [{
          ticks: {
            beginAtZero: true,
            max: 100, 
          }
        }]
      },
      responsive: true,
      maintainAspectRatio: false,
      animation: {
        duration: 0
      },
    }
  });
});






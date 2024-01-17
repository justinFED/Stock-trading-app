// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery3
//= require popper
//= require bootstrap

// Stock Graph
document.addEventListener('DOMContentLoaded', async function () {
  // Fetch historical stock data
  const apiKey = 'pk_4c3cbdbb723f480aaebb788ffa0d198f';
  const symbol = 'AAPL';

  try {
    const response = await fetch(`https://cloud.iexapis.com/stable/stock/${symbol}/chart/1m?token=${apiKey}`);
    if (!response.ok) {
      throw new Error(`Failed to fetch data: ${response.status} - ${response.statusText}`);
    }

    const data = await response.json();

    console.log(data);

    clearGraph();

    renderGraph(data);
  } catch (error) {
    console.error('Error fetching or rendering stock data:', error);
  }
});


function clearGraph() {
  const svg = d3.select("#stockGraph");
  svg.selectAll("*").remove();
}

function renderGraph(data) {
  const margin = { top: 20, right: 20, bottom: 30, left: 50 };
  const height = 400 - margin.top - margin.bottom;

  const svg = d3.select("#stockGraph");

  const chart = svg.append("svg")
    .attr("width", "100%") 
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  const x = d3.scaleTime().range([0, svg.node().getBoundingClientRect().width - margin.left - margin.right]);
  const y = d3.scaleLinear().range([height, 0]);

  const line = d3.line()
    .x(d => x(new Date(d.priceDate)))
    .y(d => y(d.close))
    .curve(d3.curveMonotoneX);

  x.domain(d3.extent(data, d => new Date(d.priceDate)));
  y.domain([d3.min(data, d => d.low), d3.max(data, d => d.high)]);

  chart.append("path")
    .data([data])
    .attr("class", "line")
    .attr("d", line)
    .style("stroke", "#4285F4")
    .style("stroke-width", 2)
    .style("fill", "none");

  chart.selectAll(".dot")
    .data(data)
    .enter().append("circle")
    .attr("class", "dot")
    .attr("cx", d => x(new Date(d.priceDate)))
    .attr("cy", d => y(d.close))
    .attr("r", 4)
    .style("fill", "#4285F4");

  chart.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));

  chart.append("g")
    .call(d3.axisLeft(y));
}
// Stock Graph

// Invested Chart

document.addEventListener('DOMContentLoaded', function () {
  // Fetch data for invested value over weeks
  const investedValueData = [
    { week: 'Week 1', value: 1000 },
    { week: 'Week 2', value: 1500 },
    // Add more data points as needed
  ];

  const margin = { top: 20, right: 20, bottom: 30, left: 50 };
  const width = 600 - margin.left - margin.right;
  const height = 400 - margin.top - margin.bottom;

  const svg = d3.select("#investedValueChart")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom);

  const x = d3.scaleBand().range([0, width]).padding(0.1);
  const y = d3.scaleLinear().range([height, 0]);

  x.domain(investedValueData.map(d => d.week));
  y.domain([0, d3.max(investedValueData, d => d.value)]);

  svg.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));

  svg.append("g")
    .call(d3.axisLeft(y));

  svg.selectAll(".bar")
    .data(investedValueData)
    .enter().append("rect")
    .attr("class", "bar")
    .attr("x", d => x(d.week))
    .attr("width", x.bandwidth())
    .attr("y", d => y(d.value))
    .attr("height", d => height - y(d.value));
});

// Invested Chart
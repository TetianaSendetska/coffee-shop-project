import React, { useRef, useEffect } from 'react';
import { Bar } from 'react-chartjs-2';
import "chart.js/auto";
import { Chart as ChartJS } from 'chart.js/auto'
import { Chart as chart }            from 'react-chartjs-2'

const Chart = ({ salesData  }) => {
  
  const data = {
    labels: salesData.map(entry => entry.datetime),
    datasets: [
      {
        label: 'Sales',
        data: salesData.map(entry => entry.amountOfSales),
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgba(54, 162, 235, 1)',
        borderWidth: 1,
      },
    ],
  };
  const options = {
    responsive: true, // Робить чарт адаптивним до розміру батьківського контейнера
    maintainAspectRatio: true, // Забороняє збереження співвідношення сторін чарту
    width: 500, // Ширина чарту в пікселях
    height: 100, // Висота чарту в пікселях
    
  };
  
  
  return <Bar data={data} options={options} />;
  
  

  // return <Bar data={data}/>;
};

export default Chart;

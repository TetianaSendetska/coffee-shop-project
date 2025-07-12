import React, {useState, useEffect, Fragment, useRef} from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './Styles.css';
import { Bar } from 'react-chartjs-2';
// import ChartJSImage from 'chartjs-to-image';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import axios from 'axios';
import Chart from "./Chart";
import { jsPDF } from 'jspdf';
import 'jspdf-autotable';

const Statistic = () => {
    const [selectedDate, setSelectedDate] = useState(new Date());
    const [amountOfSales, setAmountOfSales] = useState(null);
    const [amountOfOrders, setAmountOfOrders] = useState(null);
    const [amountOfDrinks, setAmountOfDrinks] = useState(null);
    const [amountOfFood, setAmountOfFood] = useState(null);
    const [amountOfClient, setAmountOfClient] = useState(null);
    const [amountOfEmployee, setAmountOfEmployee] = useState(null);


  //   useEffect(()=>{
  //     getNumbers();

  // },[])

  const [salesData, setSalesData] = useState([]);

  useEffect(() => {
    getNumbers();
    const fetchData = async () => {
      try {
        const data = await getSales();
        // setSalesData(data);
      } catch (error) {
        console.error('Failed to fetch sales data:', error);
      }
    };

    fetchData();
  }, []);
    const getNumbers = () =>{
      axios.get(`https://localhost:44342/api/SalesReport/client_count`)
          .then((response) => {
            setAmountOfClient(response.data);
            
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
            setAmountOfClient(null);
          });
          axios.get(`https://localhost:44342/api/SalesReport/employee_count`)
          .then((response) => {
            setAmountOfEmployee(response.data);
            
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
            setAmountOfEmployee(null);
          });
    }

    const chartRef = useRef(null);
    function downloadPDF() {
      const doc = new jsPDF();
      doc.setFontSize(12);
      
      
      doc.text('Sales report for', 70, 10);
      doc.text(selectedDate.toDateString(), 100, 10)
      doc.text('Amounnt of sales:', 20, 20);
      doc.text(amountOfSales.toString(), 180, 20);
      doc.text('Amount of orders', 20, 30);
      doc.text(amountOfOrders.toString(), 180, 30);
      doc.text('Amount of food', 20, 40);
      doc.text(amountOfFood.toString(), 180, 40);
      doc.text('Amount of drinks', 20, 50);
      doc.text(amountOfDrinks.toString(), 180, 50);
      doc.text('Amount of clients', 20, 60);
      doc.text(amountOfClient.toString(), 180, 60);
      doc.text('Amount of employees', 20, 70);
      doc.text(amountOfEmployee.toString(), 180, 70);
      
      const fileName = `report for ${selectedDate.toDateString()}.pdf`;
      doc.save(fileName);
    }
  
    function handleChartMount(ref) {
      chartRef.current = ref;
    }
    // let data =[];
    const getSales = () =>{
      axios.get(`https://localhost:44342/api/SalesReport`)
          .then((response) => {
            
            console.log(response.data)
            setSalesData(response.data)
            
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
          });
          
    }
    const handleDateChange = (date) => {
        setSelectedDate(date);
        // Виконуємо запит на сервер при зміні дати
        fetchData(date);
      };

      
      const fetchData = (date) => {
        const formattedDate = formatDate(date); 
        console.log(formattedDate)
        axios.get(`https://localhost:44342/api/SalesReport/datetime?dateTime=${formattedDate}`)
          .then((response) => {
            setAmountOfSales(response.data[0].amountOfSales);
            
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
            setAmountOfSales(null);
          });
          axios.get(`https://localhost:44342/api/SalesReport/order_count?dateTime=${formattedDate}`)
          .then((response) => {
            setAmountOfOrders(response.data[0].orderCount);
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
            setAmountOfOrders(null);
          });

          axios.get(`https://localhost:44342/api/SalesReport/drink_count?dateTime=${formattedDate}`)
          .then((response) => {
            setAmountOfDrinks(response.data);
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
            setAmountOfOrders(null);
          });

          axios.get(`https://localhost:44342/api/SalesReport/food_count?dateTime=${formattedDate}`)
          .then((response) => {
            setAmountOfFood(response.data);
          })
          .catch((error) => {
            console.error('Error fetching data:', error);
            setAmountOfFood(null);
          });
      };

      const formatDate = (date) => {
        return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
      };
    return(
       <Fragment>
        <div className="statistic-numbers">
        <div style={{paddingLeft: "50px", display: "flex", flexDirection: "column", justifyContent: "flex-end", alignContent: "flex-end", flexWrap: "nowrap", alignItems: "stretch"}}>
          <h2>Sales by Date</h2>
          <DatePicker selected={selectedDate} onChange={handleDateChange} />
          <button className="buttons" onClick={()=>downloadPDF()}>Завантажити</button>
      </div>
      </div>
      <div className="statistic-numbers-inside">
      <div className="statictic-numbers-child">{amountOfSales !== null ? (
        <p>Amount of Sales for {selectedDate.toDateString()}: {amountOfSales}</p>
      ) : (
        <p>No sales data available for the selected date.</p>
      )}
      </div>
      <div className="statictic-numbers-child">
      {amountOfOrders !== null ? (
        <p>Amount of Orders for {selectedDate.toDateString()}: {amountOfOrders}</p>
      ) : (
        <p>No order data available for the selected date.</p>
      )}
      </div>
      <div className="statictic-numbers-child">
      {amountOfDrinks !== null ? (
        <p>Amount of drinks for {selectedDate.toDateString()}: {amountOfDrinks}</p>
      ) : (
        <p>No drink data available for the selected date.</p>
      )}
      </div>
      <div className="statictic-numbers-child">
      {amountOfFood !== null ? (
        <p>Amount of food for {selectedDate.toDateString()}: {amountOfFood}</p>
      ) : (
        <p>No food data available for the selected date.</p>
      )}
      
      </div>


    </div>
    <div className="statistic-count-parent">
    <div className="statictic-numbers-child">
      {amountOfClient!== null ? (
        <p>Amount of clients  {amountOfClient}</p>
      ) : (
        <p>No clients data available.</p>
      )}
      </div>
      <br></br>
      <div className="statictic-numbers-child">
      {amountOfEmployee!== null ? (
        <p>Amount of employee  {amountOfEmployee}</p>
      ) : (
        <p>No employee data available.</p>
      )}
      </div>

    
      </div>
      <div style={{marginLeft:"100px"}}>
      <Chart salesData={salesData} />;
      </div>


     
       </Fragment>
    )
}

export default Statistic;


import React, {useState, useEffect, Fragment} from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from "axios";
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './Styles.css';
import { useUserId } from './UserIdContext';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { jsPDF } from 'jspdf';
import 'jspdf-autotable';
import { saveAs } from 'file-saver';

const Order = () => {
   
    
    const { userId } = useUserId();

    const [orderData, setOrderData] = useState([]);
    const [selectedDate, setSelectedDate] = useState(new Date());

     useEffect(()=>{
        getCombinedData(userId);
    },[])

    const getData= (userId) =>{
        axios.get(`https://localhost:44342/api/Order/userId?userId=${userId}`)
        .then((result)=>{
          setOrderData(result.data)
         
        })
        .catch((error)=>{
            console.log(error)
        })
    }

    const handleDateChange = (date) => {
        setSelectedDate(date);
        getCombinedDateData(date, userId);
      };

      const formatDate = (date) => {
        return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
      };

    const getDeliveryAddress=  (orderId) => {
        let deliveryAddress = '-';
           axios.get(`https://localhost:44342/api/Delivery/orderId?orderId=${orderId}`)
           .then((result) => {
            const deliveryData = result.data;
           
            if (deliveryData) {
                deliveryAddress = deliveryData.deliveryAddress;
            }
           }) 
            .catch((error)=> {
                console.error('Error getting delivery address:', error);
                
            })
            .finally(() => {
                return deliveryAddress;
            });
    }

    const getCombinedData = async (userId) => {
        try {
            const data = [];
            const orderResponse = await axios.get(`https://localhost:44342/api/Order/userId?userId=${userId}`);
            const orders = orderResponse.data;
            for (const order of orders) {
               
                const combinedOrder = [ order ];
                const deliveryResponse = await axios.get(`https://localhost:44342/api/Delivery/orderId?orderId=${order.id}`);
                const delivery = deliveryResponse.data[0];
                combinedOrder.Adress = delivery ? delivery.adress : '-';

                const orderedDrinkResponse = await axios.get(`https://localhost:44342/api/OrderedDrinks/orderId?orderId=${order.id}`);
                const orderedDrinks = orderedDrinkResponse.data;
               
               
                for(const orderedDrink of orderedDrinks){
                    const DrinkMenuResponse = await axios.get(`https://localhost:44342/api/DrinkMenu/id?id=${orderedDrink.drinkId}`);
                    const order = DrinkMenuResponse.data;
                    
                    const combinedData = { order, amount: orderedDrink.amount };
                    combinedOrder.push(combinedData)
                }
               
                const orderedFoodResponse = await axios.get(`https://localhost:44342/api/OrderedFood/orderId?orderId=${order.id}`);
                const orderedFoods = orderedFoodResponse.data;
               
               
                for(const orderedFood of orderedFoods){
                    const FoodMenuResponse = await axios.get(`https://localhost:44342/api/FoodMenu/id?id=${orderedFood.foodId}`);
                    const order = FoodMenuResponse.data;
                    
                    const combinedData = { order, amount: orderedFood.amount };
                    combinedOrder.push(combinedData)
                }
                data.push(combinedOrder )

            
            }
            setOrderData(data);
        } catch (error) {
            console.log(error);
            return [];
        }
    }

    const getCombinedDateData = async (datetime, userId) => {
        try {
            const data = [];
            const formattedDate = formatDate(datetime);
            const orderResponse = await axios.get(`https://localhost:44342/api/Order/datetime?dateTime=${formattedDate}&userId=${userId}`);
            const orders = orderResponse.data;
            for (const order of orders) {
               
                const combinedOrder = [ order ];
                const deliveryResponse = await axios.get(`https://localhost:44342/api/Delivery/orderId?orderId=${order.id}`);
                const delivery = deliveryResponse.data[0];
                combinedOrder.Adress = delivery ? delivery.adress : '-';

                const orderedDrinkResponse = await axios.get(`https://localhost:44342/api/OrderedDrinks/orderId?orderId=${order.id}`);
                const orderedDrinks = orderedDrinkResponse.data;
               
               
                for(const orderedDrink of orderedDrinks){
                    const DrinkMenuResponse = await axios.get(`https://localhost:44342/api/DrinkMenu/id?id=${orderedDrink.drinkId}`);
                    const order = DrinkMenuResponse.data;
                    
                    const combinedData = { order, amount: orderedDrink.amount };
                    combinedOrder.push(combinedData)
                }
               
                const orderedFoodResponse = await axios.get(`https://localhost:44342/api/OrderedFood/orderId?orderId=${order.id}`);
                const orderedFoods = orderedFoodResponse.data;
               
               
                for(const orderedFood of orderedFoods){
                    const FoodMenuResponse = await axios.get(`https://localhost:44342/api/FoodMenu/id?id=${orderedFood.foodId}`);
                    const order = FoodMenuResponse.data;
                    
                    const combinedData = { order, amount: orderedFood.amount };
                    combinedOrder.push(combinedData)
                }
                data.push(combinedOrder )

            
            }
            setOrderData(data);
        } catch (error) {
            console.log(error);
            return [];
        }
    }

    function downloadPDF(item) {
        const doc = new jsPDF();
        if (item.length === 0) {
            console.error("Item array is empty.");
            return;
        }

        doc.setFontSize(12);
        console.log(item.length)
        const tableData = [];
        const time = item[0].acceptanceTime;
       const delivery = item[0].takeout ? item[0].takeout : "-";
       
        for (let i = 1; i < item.length; i++) {
            
            console.log(delivery)
            const orderid = item[i].order.id;
            console.log(orderid)
            const name = item[i].order.name;
            const amount = item[i].amount;
            const ml = item[i].order.ml;
            const price = item[i].order.price;
        tableData.push([orderid,name, time, amount, price, ml]);
        }
        doc.text('Order Details', 20, 10);
        const bottomMargin = 20; // Margin from the bottom
        const pageHeight = doc.internal.pageSize.height;
        const textBottomY = pageHeight - bottomMargin;
        doc.text('Доставка', 20, 16); // Adjust the -10 to position the text higher or lower
        doc.text(delivery, 60, 16);

        doc.autoTable({
          startY: 25,
          head:[['Order ID', 'Name', 'Time', 'Amount', 'Price', 'Ml']], // Header row
          body: tableData
        });
      
        const fileName = `order_${item[1].order.id}.pdf`;
        doc.save(fileName);
      }
    

    function formatDateTime(dateTime) {
        const options = {
          year: 'numeric', month: '2-digit', day: '2-digit',
          hour: '2-digit', minute: '2-digit', second: '2-digit',
          hour12: false
        };
        return new Date(dateTime).toLocaleString('en-US', options).replace(/,/g, '');
      }
      

    
    return(
       <Fragment>
        <h3>Замовлення</h3>
        <DatePicker selected={selectedDate} onChange={handleDateChange} />
       

                {orderData && orderData.length > 0 ?
                orderData.map((item, index) =>{
                    

                    let totalSum = 0; // Обчислюємо totalSum для кожного item
                // Переміщуємо це обчислення поза JSX
                item.forEach((row) => {
                    totalSum += (row.order && row.order.price ? 
                        row.order.price * row.amount : 0);
                });
                
                    return (
                       
                        <div key={index}>
                             {/* <button className="buttons" onClick={()=>downloadPDF(item)}>Завантажити</button> */}
                            <div style={{display:"flex", flexDirection:"row", justifyContent: "space-evenly"}}>
                                <label>Замовлення {formatDateTime(item[0].acceptanceTime)}</label><br></br>
                                <label>Доставка {item.Adress}</label><br></br>
                                <label>Статус: {item[0].status}</label>
                            </div> 
                            <table className="responsive-table">
                            <thead className="table-header">
                                <tr>
                                    <th className="col col-4">Назва</th>
                                    <th className="col col-4">Ціна</th>
                                    <th className="col col-4">Кількість</th>
                                    
                                </tr>
                            </thead>
                        
                            <tbody className="table-row"> 
                                {item.map((row, rowIndex) => (
                                
                                <tr key={rowIndex}>
                                    <td className="col col-4">{row.order && row.order.name}</td> 
                                    <td className="col col-4">{row.order && row.order.price}</td>
                                    <td className="col col-4">{row.amount}</td>
                                    
                                </tr>

                            ))}
                        </tbody>
                    </table>
                    
                    <strong>Загальна сума: {totalSum}</strong> {/* Відображаємо загальну суму */}
                        <br /><br /><br></br>
                        </div>
                 ) })
                : (
                    <div>Немає замовлень</div>
                )}
                   
 
               
       </Fragment>
    )
}

export default Order;


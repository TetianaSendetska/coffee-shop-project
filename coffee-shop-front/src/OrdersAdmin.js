import React, {useState, useEffect, Fragment} from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from "axios";
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './Styles.css';

const OrderAdmin = () => { 
   
    const [orderData, setOrderData] = useState([]);
    const [activeButton, setActiveButton] = useState("Прийнято");
    const [selectedStatus, setSelectedStatus] = useState();
    //видимість рядка зміни статусу
    const [activeRow, setActiveRow] = useState(null);
     // фільтр по імені
     const [searchName, setSearchName] = useState('');

    const handleButtonClick = (status) => {
        setActiveButton(status);
        getCombinedData(status);
    };

     useEffect(()=>{
        getCombinedData("Прийнято");
        

    },[])

    const handleChangeStatus = async (id,newStatus) => {
       
        const orderId = id;
        try {
           
            const response = await axios.put(`https://localhost:44342/api/Order/${orderId}?newStatus=${newStatus}` );
            orderData[0].status = newStatus;
            getCombinedData(activeButton)
        } catch (error) {
            console.error(error);
        }
    };

    const getCombinedData = async (status) => {
        try {
            const data = [];
            const orderResponse = await axios.get(`https://localhost:44342/api/Order/status?status=${status}`);
            let orders = orderResponse.data;
          
            if (typeof orders === 'object' && !Array.isArray(orders)) {
        
                orders = [orders];
            }
         
            for (const order of orders) {
                const clientResponse = await axios.get(`https://localhost:44342/api/Client/id?id=${order.userId}`);
                const client = clientResponse.data;
          
                const combinedOrder = [ order ];
                combinedOrder.push(client)
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
        {/* <td colSpan={2}> */}
                    
                <button onClick={() => handleButtonClick("Прийнято")} className={"buttons"+(activeButton === "Прийнято" ? "active" : "")}>Нові</button>
                <button onClick={() => handleButtonClick("В процесі")} className={"buttons" + (activeButton === "В процесі" ? "active" : "")}>В процесі</button>
                <button onClick={() => handleButtonClick("Завершено")} className={"buttons"+(activeButton === "Завершено" ? "active" : "")}>Завершені</button>
                <button onClick={() => handleButtonClick("Скасовано")} className={"buttons"+(activeButton === "Скасовано" ? "active" : "")}>Скасовані</button>
    
            {/* </td> */}
            
            <input type="text" value={searchName} onChange={(e) => setSearchName(e.target.value)} placeholder="Введіть ім'я користувача" />
                {orderData && orderData.length > 0 ?
                orderData.filter(item => {
                    return item[1].name.toLowerCase().startsWith(searchName.toLowerCase());
                }).map((item, index) =>{

                  
                    return (
                        <div key={index}>
                       
                       <div style={{display:"flex", flexDirection:"column", justifyContent: "space-evenly", alignItems: "flex-start"}}>

                        <label>Замовлення {formatDateTime(item[0].acceptanceTime)}</label><br></br>
                        <label>Користувач ID = {item[1].id} {item[1].name}  </label><br></br>
                        <label>Доставка {item.Adress}</label><br></br>
                        <div>
                        <label>Статус {item[0].status}</label> 
                         
                        
                            {activeRow === index ? (
                                <>
                            <select value={selectedStatus} onChange={(e) => setSelectedStatus(e.target.value)   }>
                                <option value="Прийнято">Прийнято</option>
                                <option value="В процесі">В процесі</option>
                                <option value="Завершено">Завершено</option>
                                <option value="Скасовано">Скасовано</option>
                            </select>
                            <button onClick={() => {
                                handleChangeStatus(item[0].id, selectedStatus);
                                setActiveRow(null)
                            }}>Зберегти</button>
                            </>
                        ) : (
                            activeButton !== "Завершено" && (
                                <button className="buttons" onClick={() => setActiveRow(index)}>Змінити статус</button>
                            )
                        )}
                        </div>
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
                            {item.slice(2).map((row, rowIndex) => (
                               
                                <tr key={rowIndex}>
                                    <td className="col col-4">{row.order && row.order.name}</td> 
                                    <td className="col col-4">{row.order && row.order.price}</td>
                                    <td className="col col-4">{row.amount}</td>
                                </tr>

                            ))}
                        </tbody>
                    </table>
                    
                
                        <br /><br /><br></br>
                        </div>
                 ) })
                : (
                    <div>Немає замовлень</div>
                )}
                   
 
            <td colSpan={2}>
            
                   
            </td>
        
       </Fragment>
    )
}

export default OrderAdmin;


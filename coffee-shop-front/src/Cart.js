import React, {useState, useEffect, Fragment} from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/Container';
import axios from "axios";
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './Styles.css';
import { useQuery } from 'react-query';
import { useCartContext } from './CartContext';
import { useUserId } from './UserIdContext';


const Cart = () => {
    const { cartData, setCartData } = useCartContext();
    const [isDelChecked, setIsDelChecked] = useState(false);
    const [isResChecked, setIsResChecked] = useState(false);
    

    const { userId } = useUserId();


   const exportToCsv = () => {
        const csv = cartData.map(row => Object.values(row).join(',')).join('\n');
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = URL.createObjectURL(blob);
    
        const a = document.createElement('a');
        a.href = url;
        a.download = 'data.csv';
        document.body.appendChild(a);
        a.click();
        URL.revokeObjectURL(url);
        document.body.removeChild(a);
      }

      const handleDelChange = () => {
        setIsDelChecked((prevState) => !prevState);
        setIsResChecked(false);
    };

    const handleResChange = () => {
        setIsResChecked((prevState) => !prevState);
        setIsDelChecked(false);
    };

     useEffect(()=>{
        getData();

    },[cartData])
    const getData= () =>{
        axios.get('https://localhost:44342/api/Cart')
        .then((result)=>{
          setCartData(result.data)
        })
        .catch((error)=>{
            console.log(error)
        })
    }

    let totalSum = 0;
    const changeQuantity = (Id, isIncrising) =>{
        
        if(isIncrising == 1){
            const existingCart = cartData.find(item => item.id == Id);
    
            const newQuantity = existingCart.quantity + 1;
            axios.put(`https://localhost:44342/api/Cart/${existingCart.id}`, {
                ...existingCart,
                quantity: newQuantity,
            })
            .then((response) => {
            
            })
            .catch((error) => {
                console.error('Error updating item quantity in cart:', error);
            });     
        }
        else {
            const existingCart = cartData.find(item => item.id == Id);
            if(existingCart.quantity != 1){
                const newQuantity = existingCart.quantity - 1;
            axios.put(`https://localhost:44342/api/Cart/${existingCart.id}`, {
                ...existingCart,
                quantity: newQuantity,
            })
            .then((response) => {
            
            
            })
            .catch((error) => {
                console.error('Error updating item quantity in cart:', error);
            });  
            }

            
        }
    }

    const deleteFromCart = (Id) =>{
            axios.delete(`https://localhost:44342/api/Cart/item/${Id}`)
            .then((result)=>{
                if(result.status===204)
                {
                    toast.success('Item deleted successfully!');
                    getData();
                }
            })
            .catch((error)=>{
                toast.error(error);
            })
        
    }

    const deleteCart = async () => {
        try {
            console.log(cartData)
           // exportToCsv();
            await axios.delete(`https://localhost:44342/api/Cart/${userId}`);
            alert('Order added succesfully');

            
        } catch (error) {
            console.error('Error deleting item:', error);
        }
    }

    const handleOrder = async (tableId, isTakeout, userId, currentTime) => {
        try {
            // Виконуємо пост-запит для створення нового ордера
            const orderResponse = await axios.post(`https://localhost:44342/api/Order`, {
                acceptanceTime: currentTime,
                userId: userId,
                tableId: tableId,
                takeout: isTakeout,
                clientId: userId,
                status: "Прийнято"
            });
            
            console.log(orderResponse.data.acceptanceTime)
            const acceptanceTimeResponse = await axios.get(`https://localhost:44342/api/Order/acceptanceTime?acceptanceTime=${orderResponse.data.acceptanceTime}`);
            console.log(acceptanceTimeResponse.data);
    
            // Отримуємо ID нового ордера
            const newOrderId = acceptanceTimeResponse.data[0].id;
            // Додаємо елементи кошика до ордера
            const cartItems = cartData.map(item => item.drinkId);  
            for (let i = 0; i < cartItems.length; ++i) {
                let response;
                if (cartItems[i]) {
                    response = await axios.post(`https://localhost:44342/api/OrderedDrinks`, {
                        orderId: newOrderId,
                        drinkId: cartData[i].drinkId,
                        amount: cartData[i].quantity
                    });
                } else {
                    response = await axios.post(`https://localhost:44342/api/OrderedFood`, {
                        orderId: newOrderId,
                        foodId: cartData[i].foodId,
                        amount: cartData[i].quantity
                    });
                }
                console.log(`Ordered item accepted:`, response.data);
            }
    
            console.log('Order accepted:', orderResponse.data);
            return newOrderId;
        } catch (error) {
            console.error('Error:', error.response.data);
            return null;
        }
    };
    

    const createOrder = async() => {
        const allTables = Array.from({ length: 50 }, (_, i) => i + 1);
        
        const currentTime = new Date().toISOString(); 
        var formattedDateTime = new Date(currentTime).toISOString().slice(0, 19);

        console.log(formattedDateTime) 
         if(isResChecked) {
            axios.get(`https://localhost:44342/api/Reservation`)
            .then((result) => {
            var reservationList = result.data;
            var tableIdList = reservationList.map(item => item.tableId);
            
            const freeTables = allTables.filter(tableId => !tableIdList.includes(tableId));
            if(freeTables){
                    axios.post(`https://localhost:44342/api/Reservation`, {
                        tableId: freeTables[0],
                        reservationTime: currentTime,
                        clientId: userId
                    })
                    .then((response) => {
                        handleOrder(freeTables[0], 0, userId, formattedDateTime);
                    })
                    .catch((error) => {
                        console.error('Error reserving:', error);
                    });
                   }
                   else{
                    alert("Всі столи зайняті")
                   }
          })
          .catch((error) => {
            console.log(error);
          });
                
        }
        else if(isDelChecked){
            const adress = document.getElementById('adress');
            const newOrderId = await handleOrder(0, 1, userId, formattedDateTime);
            axios.post(`https://localhost:44342/api/Delivery`, {
                        adress: adress.value,
                        acceptanceTime: currentTime,
                        orderId: newOrderId,
                        clientId: userId
                    })
                    .then((response) => {
                         
                        
                    })
                    .catch((error) => {
                        console.error('Error registration:', error.response.data);
                    });
                
        }
        else {
            handleOrder(0, 0, userId, formattedDateTime);
        }
        alert('Order added succesfully');
        // deleteCart();
       
    }
    
    return(
       <Fragment >
            <table   className="responsive-table">
            <thead className="table-header" >
                <tr>
                {/* <th>Id</th> */}
                <th className="col col-1">Ім'я</th>
                <th className="col col-1">Ціна</th>
                <th className="col col-1">Кількість</th>
                <th className="col col-1">Дії</th>
                </tr>
            </thead>
            <tbody className="table-row">
                {
                    cartData && cartData.length > 0 ?
                    cartData.map((item, index) =>{
                        totalSum += item.price ? 
                        item.price * item.quantity :
                        0;
                        return (
                            <tr key={index}>
                            <td className="col col-1">{item.name}</td>
                            <td className="col col-1">{item.price}</td>
                            <td style={{display:"flex"}} className="col col-1">{item.quantity}&nbsp;&nbsp;
                            <span style={{fontSize:"large" ,cursor:"pointer"}} onClick={()=>changeQuantity(item.id, 1)}>+</span> &nbsp;
                            <span style={{fontSize:"large" ,cursor:"pointer"}} onClick={()=>changeQuantity(item.id, 0)}>-</span> &nbsp;
                            </td>
                            <td className="col col-1" style={{display:"flex"}}>
                                       <button className="btn btn-danger" onClick={()=>deleteFromCart(item.id)}>Видалити</button>
                            </td>

                            </tr>
                            
                        )
                    })
                    :
                    'No data yet...'
                }
               
                
            </tbody>
            </table >
                <strong>Загальна сума: {totalSum.toFixed(2)}</strong>
                <td className="">
                <label htmlFor="delivery">Доставка</label>
                <input type="checkbox"checked={isDelChecked}
                    onChange={() => {handleDelChange();}} id="delivery" name="delivery" />&nbsp;<br/><br/>
                <div style={{ display: isDelChecked ? 'block' : 'none' }}>
                <label htmlFor="adress">Введіть адресу</label>
                <input type="text" id="adress" name="adress"></input>
                <br/><br/>  
                </div>
                <label htmlFor="reservation">Зарезервувати стіл</label>
                <input type="checkbox" checked={isResChecked}
                    onChange={() => {handleResChange();}}/>&nbsp;<br/><br/>
                <div style={{ display: isResChecked ? 'block' : 'none' }}>
                    
                </div>
                <br/><br/> 

                
                <button className="buttons" onClick={()=>createOrder()}>Замовити</button> &nbsp;
                    
            </td>
        
       </Fragment>
    )
}

export default Cart;


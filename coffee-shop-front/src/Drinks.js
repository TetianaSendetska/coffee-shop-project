import React, {useState, useEffect, Fragment} from "react";
//import Table from 'react-bootstrap/Table';
import 'bootstrap/dist/css/bootstrap.min.css';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/Container';
import axios from "axios";
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
//import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
//import { useNavigate } from 'react-router-dom';
import './Styles.css';
import { useUserId } from './UserIdContext';
import { useCartContext } from './CartContext';

// import { getNewData } from './Cart';
const Drinks = () => {

    const [data, setData] = useState([]);
    const { userId } = useUserId();
    useEffect(()=>{
        getData();

    },[])

    const getData= () =>{
        axios.get('https://localhost:44342/api/DrinkMenu')
        .then((result)=>{
            setData(result.data)
        })
        .catch((error)=>{
            console.log(error)
        })
    }

    const getSortedData = () => {
        axios.get('https://localhost:44342/api/DrinkMenu/sorted')
        .then((result) => {
            setData(result.data);
        })
        .catch((error) => {
            console.log(error);
        });
    }
    const getFilteredData = (price) => { 
        axios.get(`https://localhost:44342/api/DrinkMenu/price?price=${price}`)
          .then((result) => {
            setData(result.data);
          })
          .catch((error) => {
            console.log(error);
          });
      };

      const getFilteredTypeData = (type) => {
        axios.get(`https://localhost:44342/api/DrinkMenu/type?type=${type}`)
          .then((result) => {
            setData(result.data);
          })
          .catch((error) => {
            console.log(error);
          });
      };

    const handleApplyFilter = () => {
        const selectElement = document.getElementById('selectMaxPrice');
        if (selectElement) {
            const selectedMaxPrice = selectElement.value;
            getFilteredData(selectedMaxPrice);
           
            
        }
      };

      const handleApplyTypeFilter = () => {
        const selectElement = document.getElementById('selectType');
        if (selectElement) {
            const selectedType = selectElement.value;
            if(selectedType == "Всі")
            getData();
        else
            getFilteredTypeData(selectedType);
            
        }
      };
      const {cartData, getNewData} = useCartContext();
        const addToCart = (id, Name, Price) =>{
                const existingCartItem = cartData.find(item => item.name == Name);
        if (existingCartItem) {
            const newQuantity = existingCartItem.quantity + 1;
            axios.put(`https://localhost:44342/api/Cart/${existingCartItem.id}`, {
                ...existingCartItem,
                quantity: newQuantity,
            })
            .then((response) => {
                getNewData(response.data);
            })
            .catch((error) => {
                console.error('Error updating item quantity in cart:', error);
            });
        } else {
            axios.post(`https://localhost:44342/api/Cart`, {
                drinkId: id,
                foodId: 0,
                quantity: 1, 
                userId: userId,
                name: Name,
                price: Price, 
            })
            .then((response) => {
                getNewData(response.data);
            })
            .catch((error) => {
                console.error('Error adding item to cart:', error);
            });
        }
    }

    return(
       <Fragment>
        <br></br>
        <div style={{display: "flex", flexDirection: "column", alignItems: "flex-start", 
            paddingRight: "10px", width:"100%  ", display:"flex", flexDirection: "row",
            justifyContent: "space-between", alignItems: "flex-end" }}>
            <div style={{display: "flex", flexDirection: "row"}}>
            <div >
                <label>Ціна  </label>
                <select id="selectMaxPrice">
                    <option value="1000">Всі</option>
                    <option value="50">50</option>
                    <option value="70">70</option>
                    <option value="90">90</option>
                </select>
                <button className="buttons" onClick={handleApplyFilter}>Застосувати</button>
            </div>
            <div>
            <label>Тип</label>
            <select id="selectType">
            <option value="Всі">Всі</option>
                <option value="Кава">Кава</option>
            <option value="Чай">Чай</option>
            <option value="Гарячий шоколад">Гарячий шоколад</option>
            <option value="Холодні напої">Холодні напої</option>
            </select>
            <button className="buttons" onClick={handleApplyTypeFilter}>Застосувати</button>
            </div>        
        </div>
        <button className="buttons" onClick={getSortedData}>В алфавітному</button>

        </div>


            <table  className="responsive-table">
            <thead className="table-header">
                <tr>
                <th className="col col-1">#</th>
                <th className="col col-1">Ім'я</th>
                <th className="col col-1">Тип</th>
                <th className="col col-1">Ціна</th>
                <th className="col col-1">Мл</th>
                <th className="col col-1">Дія</th>
                </tr>
            </thead>
            <tbody className="table-row" >
                {
                    data && data.length > 0 ?
                    data.map((item, index) =>{
                        return (
                            
                            <tr key={index}>
                            <td className="col col-1">{item.id}</td>
                            <td className="col col-1">{item.name}</td>
                            <td className="col col-1">{item.type}</td>
                            <td className="col col-1">{item.price}</td>
                            <td className="col col-1">{item.ml}</td>
                            <td className="col col-1" colSpan={1}>
                                <button className="buttons" onClick={()=>addToCart(item.id, item.name, item.price)}>Add</button>
                            </td>
                            </tr>
                        )
                    })
                    :
                    'Loading...'
                }
               
                
            </tbody>
            </table>
       </Fragment>
    )
}

export default Drinks;


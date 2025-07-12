import React, {useState, useEffect, Fragment} from "react";
//import Table from 'react-bootstrap/Table';
import 'bootstrap/dist/css/bootstrap.min.css';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/Container';
import axios from "axios";
import './Styles.css';
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
//import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
//import { useNavigate } from 'react-router-dom';

const MenuPage = () => {
    
    const [data, setData] = useState([]);
    const [showFood, setShowFood] = useState(true);
    const [showDrink, setShowDrink] = useState(false);
    const [Menu, setMenu] = useState('FoodMenu');
    useEffect(()=>{
        getData(Menu);

    },[Menu])

    const handleShowFood = () => {
        setShowFood(true);
        setShowDrink(false);
        setMenu('FoodMenu');
      };
    
      const handleShowDrink = () => {
        setShowFood(false);
        setShowDrink(true);
        setMenu('DrinkMenu');
      };

    const getData= (Menu) =>{
        axios.get(`https://localhost:44342/api/${Menu}`)
        .then((result)=>{
            setData(result.data)
        })
        .catch((error)=>{
            console.log(error)
        })
    };

    const getFilteredData = (menu, price) => {
        axios.get(`https://localhost:44342/api/${menu}/price?price=${price}`)
          .then((result) => {
            setData(result.data);
          })
          .catch((error) => {
            console.log(error);
          });
      };
      const getSortedData = (Menu) => {
        axios.get(`https://localhost:44342/api/${Menu}/sorted`)
        .then((result) => {
            setData(result.data);
        })
        .catch((error) => {
            console.log(error);
        });
};


      const handleApplyFilter = (menu) => {
        const selectElement = document.getElementById('selectMaxPrice');
        if (selectElement) {
            const selectedMaxPrice = selectElement.value;
            getFilteredData(menu, selectedMaxPrice);
            
        }
      };

      const handleApplyTypeFilter = (Menu) => {
        const selectElement = document.getElementById('selectType');
        if (selectElement) {
            const selectedType = selectElement.value;
            if(selectedType == "Всі")
            getData(Menu);
        else
            getFilteredTypeData(Menu, selectedType);
            
        }
      };
      const getFilteredTypeData = ( Menu,type) => {
        axios.get(`https://localhost:44342/api/${Menu}/type?type=${type}`)
          .then((result) => {
            setData(result.data);
          })
          .catch((error) => {
            console.log(error);
          });
      };
      


    return(
       <Fragment>
        <div className="menuButtons">
        <button className="buttons" onClick={handleShowFood}>Їжа</button>
          <button className="buttons" onClick={handleShowDrink}>Напої</button>
          </div>
       
        {showFood && (
        <>
        <div className="foodMenu">
          <div style={{display: "flex", flexDirection: "column", alignItems: "flex-start", 
            paddingRight: "10px", width:"100%  ", display:"flex", flexDirection: "row",
            justifyContent: "space-between", alignItems: "flex-end" }}>  
              <div style={{display: "flex", flexDirection: "row"}}>
                <div >
                <label>Ціна</label>
                <select style={{marginLeft:"5px"}} id="selectMaxPrice">
                  <option value="1000">Всі</option>
                  <option value="20">До 20</option>
                  <option value="25">До 25</option>
                  <option value="30">До 30</option>
                </select>
                <button className="buttons" onClick={()=>handleApplyFilter("FoodMenu")}>Застосувати</button>
                </div>
              </div>
              <button className="buttons" onClick={()=>getSortedData("FoodMenu")}>В алфавітному</button>
          </div>
            <table   className="responsive-table">
            <thead className="table-header">
                <tr>
                <th className="col col-1">Id</th>
                <th className="col col-1">Name</th>
                <th className="col col-1">Price</th>
                </tr>
            </thead>
            <tbody className="table-row">
                {
                    data && data.length > 0 ?
                    data.map((item, index) =>{
                        return (
                            <tr key={index}>
                            <td className="col col-1">{item.id}</td>
                            <td className="col col-1">{item.name}</td>
                            <td className="col col-1">{item.price}</td>
                           
                            </tr>
                        )
                    })
                    :
                    'Loading...'
                }
               
                
            </tbody>
            </table>
            </div>
            </>
      )}

      {showDrink && (
        <>
        <div className="drinkMenu">
        
        <div style={{display: "flex", flexDirection: "column", alignItems: "flex-start", 
        paddingRight: "10px", width:"100%  ", display:"flex", flexDirection: "row",
        justifyContent: "space-between", alignItems: "flex-end" }}>
            
            <div style={{display: "flex", flexDirection: "row"}}>
                <div >
              <label>Ціна</label>
              <select style={{marginLeft:"5px"}} id="selectMaxPrice">
                <option value="1000">Всі</option>
                <option value="50">До 50</option>
                <option value="70">До 70</option>
                <option value="90">До 90</option>
              </select>

              <button className="buttons" onClick={()=>handleApplyFilter("DrinkMenu")}>Застосувати</button>
              </div>
            <div>
              <label>Тип </label> 
              <select style={{marginLeft:"5px"}} id="selectType">
              <option value="Всі">Всі</option>
                  <option value="Кава">Кава</option>
              <option value="Чай">Чай</option>
              <option value="Гарячий шоколад">Гарячий шоколад</option>
              <option value="Холодні напої">Холодні напої</option>
              
              </select>
              <button className="buttons" onClick={()=>handleApplyTypeFilter("DrinkMenu")}>Застосувати</button>
              </div>
            </div>
            <div><button className="buttons" onClick={()=>getSortedData("DrinkMenu")}>В алфавітному</button></div>
        </div>


            <table    className="responsive-table">
            <thead className="table-header">
                <tr>
                <th className="col col-1">#</th>
                <th className="col col-1">Name</th>
                <th className="col col-1">Type</th>
                <th className="col col-1">Price</th>
                <th className="col col-1">Ml</th>
                </tr>
            </thead>
            <tbody className="table-row">
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
                            </tr>
                        )
                    })
                    :
                    'Loading...'
                }
               
                
            </tbody>
            </table>
            </div>
        </>
      )}
       </Fragment>
    )
}

export default MenuPage;


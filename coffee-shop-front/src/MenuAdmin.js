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

const MenuAdmin = () => {
    
    const [data, setData] = useState([]);
    const [showFood, setShowFood] = useState(true);
    const [showDrink, setShowDrink] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedStatus, setSelectedStatus] = useState('');

    const [editingId, setEditingId] = useState('');
    let Menu = "FoodMenu";
    useEffect(()=>{
        getData(Menu);

    },[])

    const handleShowFood = () => {
        setShowFood(true);
        setShowDrink(false);
        Menu = "FoodMenu"
        getData(Menu)
      };
    
      const handleShowDrink = () => {
        setShowFood(false);
        setShowDrink(true);
        Menu = "DrinkMenu"
        getData(Menu)
      };

    const getData= (Menu) =>{
        axios.get(`https://localhost:44342/api/${Menu}/all`)
        .then((result)=>{
            setData(result.data)
        })
        .catch((error)=>{
            console.log(error)
        })
    };

    const getFilteredData = (price) => {
        axios.get(`https://localhost:44342/api/${Menu}/price?price=${price}`)
          .then((result) => {
            setData(result.data);
          })
          .catch((error) => {
            console.log(error);
          });
      };


      const getSortedData = (Menu) => {
        axios.get(`https://localhost:44342/api/${Menu}/all/sorted`)
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
      

      const handleApplyEdit= (menu, id, status) =>{
        if(selectedStatus == '')
        {
            setEditingId(false);
        return;
        }
        axios.put(`https://localhost:44342/api/${menu}/${id}?status=${selectedStatus}`)
        .then((response) => {

            getData(menu);
        })
        .catch((error) => {
            console.error('Error updating item status in menu:', error);
        });    
        setEditingId(false);
      }



    return(
       <Fragment>
        <div className="menuButtons">
        <button className="buttons" onClick={handleShowFood}>Їжа</button>
          <button className="buttons" onClick={handleShowDrink}>Напої</button>
          </div>
          
        {showFood && (
        <>
        <div className="foodMenu">
            <div>
        <input
            type="text"
            placeholder="Пошук продукту"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}/>
    <button className="buttons" onClick={()=>getSortedData("FoodMenu")}>В алфавітному</button>
    </div>
            <table className="responsive-table">
            <thead className="table-header">
                <tr>
                <th className="col col-1">Id</th>
                <th className="col col-1">Ім'я</th>
                <th className="col col-1">Ціна</th>
                <th className="col col-1">Статус</th>
                <th className="col col-1">Дії</th>
                </tr>
            </thead>
            <tbody className="table-row">
                {
                    data && data.length > 0 ?
                    data.filter(item => {
                        return item.name.toLowerCase().startsWith(searchTerm.toLowerCase());
                    }).map((item, index) =>{
                        return (
                            <tr key={index}>
                            <td className="col col-1">{item.id}</td>
                            <td className="col col-1">{item.name}</td>
                            <td className="col col-1">{item.price}</td>
                            {editingId === item.id ? (
                                <div>
                                    <select value={selectedStatus} onChange={(e) => setSelectedStatus(e.target.value === "в наявності" ? "в наявності" : "не в наявності")}>
                                        <option value="в наявності">В наявності</option>
                                        <option value="не в наявності">Не в наявності</option>
                                    </select>
                                    <button className="buttons" onClick={() => handleApplyEdit("FoodMenu", item.id, item.status)}>Застосувати</button>
                                </div>
                            ) : (
                                <span>{item.status}</span>
                            )}
                            <td className="col col-1" style={{ width: '100px' }}>
                                    {editingId === item.id ? (
                                    <button className="btn btn-secondary" onClick={() => setEditingId(null)}>Скасувати</button>
                                ) : (
                                    <button className="buttons" onClick={() => setEditingId(item.id)}>Редагувати статус</button>
                                )}
                            </td>
                           
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
        
        <div style={{display: "flex", flexDirection: "column"}}>
    
            <div><button className="buttons" onClick={()=>getSortedData("DrinkMenu")}>В алфавітному</button></div>
           <div>
            <label>Тип </label> 
            <select id="selectType">
            <option value="Всі">Всі</option>
                <option value="Кава">Кава</option>
            <option value="Чай">Чай</option>
            <option value="Гарячий шоколад">Гарячий шоколад</option>
            <option value="Холодні напої">Холодні напої</option>
            
            </select>
            <button className="buttons" onClick={()=>handleApplyTypeFilter("DrinkMenu")}>Apply</button>
            </div>
        </div>


            <table    className="tableMenu">
            <thead>
                <tr>
                <th>#</th>
                <th>Name</th>
                <th>Type</th>
                <th>Price</th>
                <th>Ml</th>
                <th>Status</th>
                </tr>
            </thead>
            <tbody>
                {
                    data && data.length > 0 ?
                    data.filter(item => {
                        return item.name.toLowerCase().startsWith(searchTerm.toLowerCase());
                    }).map((item, index) =>{
                        return (
                            
                            <tr key={index}>
                            <td>{item.id}</td>
                            <td>{item.name}</td>
                            <td>{item.type}</td>
                            <td>{item.price}</td>
                            <td>{item.ml}</td>
                            {editingId === item.id ? (
                                <div>
                                    <select value={selectedStatus} onChange={(e) => setSelectedStatus(e.target.value === "в наявності" ? "в наявності" : "не в наявності")}>
                                        <option value="в наявності">В наявності</option>
                                        <option value="не в наявності">Не в наявності</option>
                                    </select>
                                    <button className="buttons" onClick={() => handleApplyEdit("DrinkMenu", item.id, item.status)}>Apply</button>
                                </div>
                            ) : (
                                <span>{item.status}</span>
                            )}
                            <td style={{ width: '100px' }}>
                                    {editingId === item.id ? (
                                    <button className="btn btn-secondary" onClick={() => setEditingId(null)}>Cancel</button>
                                ) : (
                                    <button className="buttons" onClick={() => setEditingId(item.id)}>Редагувати</button>
                                )}
                            </td>
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

export default MenuAdmin;


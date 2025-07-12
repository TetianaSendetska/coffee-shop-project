import logo from './logo.svg';
import './App.css';
import './Styles.css';
import React, { useState } from 'react';
import { CartProvider } from './CartContext';
import Clients from './Clients';
import OrderAdmin from './OrdersAdmin';
import {  useAuth  } from './AuthContext';
import Employees from './Employees';
import MenuAdmin from './MenuAdmin';
import Statistic from './Statistic';
function AdminPage() {
  const [showFood, setShowFood] = useState(true);
  const [showDrink, setShowDrink] = useState(false);

  const handleShowFood = () => {
    setShowFood(true);
    setShowDrink(false);
  };

  const handleShowDrink = () => {
    setShowFood(false);
    setShowDrink(true);
  };
  const [showClients, setShowClients] = useState(false);
  const [showOrders, setShowOrders] = useState(true);
  const [showEmployees, setShowEmployees] = useState(false);
  const [showMenu, setShowMenu] = useState(false);
  const [showStatistic, setShowStatistic] = useState(false);
  
  
  const handleToggleClients = () => {
    setShowClients(true);
    setShowOrders(false);
    setShowEmployees(false);
    setShowMenu(false);
    setShowStatistic(false);
  };
  
  const handleToggleOrders= () => {
    setShowClients(false);
    setShowOrders(true);
    setShowEmployees(false);
    setShowMenu(false);
    setShowStatistic(false);
  };

  const handleToggleEmployees= () => {
    setShowClients(false);
    setShowOrders(false);
    setShowEmployees(true);
    setShowMenu(false);
    setShowStatistic(false);
  };

  const handleToggleMenu= () => {
    setShowClients(false);
    setShowOrders(false);
    setShowEmployees(false);
    setShowMenu(true);
    setShowStatistic(false);
  };

  const handleToggleStatistic= () => {
    setShowClients(false);
    setShowOrders(false);
    setShowEmployees(false);
    setShowMenu(false);
    setShowStatistic(true);
  };

  const { LogOut } = useAuth();
  const exit= () => {
    LogOut();
  };


  return (
    <div className="client">
       <header className='header-btn-left'>
        
       
       <div>
          <button className="buttons" onClick={handleToggleClients}>Клієнти</button>
          <button className="buttons" onClick={handleToggleMenu}>Меню</button>
          <button className="buttons" onClick={handleToggleEmployees}>Працівники</button>
          <button className="buttons" onClick={handleToggleOrders}>Замовлення</button>
          <button className="buttons" onClick={handleToggleStatistic}>Статистика</button>
          
         
          </div>
          <button className='buttons' onClick={exit}>Вийти</button>
        </header>
 

        <div className='admin-client-page'>
        {showClients && (
          <>
         
        <Clients></Clients>
        </>
      )}
      
      {showOrders && (
          <>
         
        <OrderAdmin></OrderAdmin>
        </>
      )}
      {showEmployees && (
          <>
         
        <Employees></Employees>
        </>
      )}
      {showMenu && (
          <>
         
        <MenuAdmin></MenuAdmin>
        </>
      )}

    {showStatistic && (
          <>
         
        <Statistic></Statistic>
        </>
      )}
      </div>
    </div>
  );
}

export default AdminPage;

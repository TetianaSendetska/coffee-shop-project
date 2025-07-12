import './App.css';
import Drinks from './Drinks';
import Food from './Food';
import Cart from './Cart';
import Order from './Orders'
import './Styles.css';
import React, { useState } from 'react';
import { CartProvider } from './CartContext';
import {  useAuth  } from './AuthContext';

function UserPage() {
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

  
  const [showOrders, setShowOrders] = useState(true);
  const handleToggleOrders = () => {
    setShowOrders(true);
    setShowOrderings(false);
    
  };
  const [showOrderings, setShowOrderings] = useState(false);
  const handleToggleOrdering= () => {
    setShowOrderings(true);
    setShowOrders(false)
  };

  const { LogOut } = useAuth();
  const exit= () => {
    LogOut();
  };

  return (
    <div className="user">

        <header className='header-btn-left'>
      
        <div > 
          <span className="buttons" onClick={handleToggleOrders}>Замовлення</span>
          <span className="buttons" onClick={handleToggleOrdering}>Замовити</span>
          <button className='buttons' onClick={exit}>Вийти</button>
        
         </div>
        
        </header>
        <div className='user-ordering-page'>
        {showOrderings && (
          <>
          <div className="table-container">
          <button className="buttons" onClick={handleShowFood}>Їжа</button>
          <button className="buttons" onClick={handleShowDrink}>Напої</button>
          {showFood && 
          <CartProvider>
             <Food />
          </CartProvider>}
          {showDrink && 
          <CartProvider>
              <Drinks />
          </CartProvider>}
        </div>
        <div className='table-container'>
        <CartProvider>
          <Cart/>
          </CartProvider>
        </div>
        </>
      )}
      </div>

      <div className='user-orders-page'>
        {showOrders && (
          <>
         
        <Order></Order>
        </>
      )}
      </div>
      <div className='user-orders-page'>
      </div>
      
    </div>
  );
}

export default UserPage;

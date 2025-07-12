import logo from './logo.svg';
import './App.css';
import Drinks from './Drinks';
import Food from './Food';
import Cart from './Cart';
import Order from './Orders'
import './Styles.css';
import React, { useState, useContext, createContext, useEffect } from 'react';
import { CartProvider } from './CartContext';
import UserPage from './UserPage';
import AdminPage from './AdminPage.js';
import LoginPage from './LoginPage.js';
import {  useAuth ,AuthProvider } from './AuthContext';
import { UserIdProvider } from './UserIdContext.js';
// const AuthContext = createContext();
// const useAuth = () => useContext(AuthContext);

function App() {
  // const AuthContext = createContext();
  // const useAuth = () => useContext(AuthContext);

 
 
  const initialState = {
    isAuthenticated: false,
    user: null,
    role: null,
  };

  
  return (
    <AuthProvider>
      <div className="App">
      <UserIdProvider>
      <MainContent></MainContent>
      </UserIdProvider>
       
      </div>
    </AuthProvider>
  );

}

function MainContent() {
  
  const { isAuthenticated, isClient} = useAuth();
  const { LogIn } = useAuth();
 
    useEffect(() => {
      const isAuthenticatedStorage = localStorage.getItem('isAuthenticated');
      const isClientStorage = localStorage.getItem('isClient');
      
        if (isAuthenticatedStorage) {
          if(isClientStorage === 'true'){
           LogIn(true);
            
          }
          else 
          {
          LogIn(false)
          }
        }
    }, [LogIn, isAuthenticated]);

  if (!isAuthenticated) {
   
      return (  <LoginPage  /> );
      
  }

  if (isClient) {
      
      return ( <UserPage />);
  }
  return ( <AdminPage />);
  
}

export default App;

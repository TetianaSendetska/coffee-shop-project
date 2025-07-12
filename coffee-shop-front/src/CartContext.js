import React, { createContext, useContext, useState } from 'react';
import axios from "axios";
const CartContext = createContext();

export const useCartContext = () => {
    return useContext(CartContext);
};

export const CartProvider = ({ children }) => {

    const [cartData, setCartData] = useState([]);
    const getNewData = (data) => {
        var id = 0;
        axios.get(`https://localhost:44342/api/Cart`)
        
        .then((result)=>{
            var isDrink = 0;
            if(data.drinkId == 0)
                isDrink = 0
            else
                isDrink = 1;
            console.log(result.data);
             setCartData(result.data);  
        })
        .catch((error)=>{
            console.log(error)
        })
    };
   

    return (
        <CartContext.Provider value={{ cartData, setCartData, getNewData }}>
            {children}
        </CartContext.Provider>
    );
};

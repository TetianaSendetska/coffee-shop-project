import React, {useState, useEffect, Fragment} from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './Styles.css';
import coffeeBanner from './coffee_banner.jpg';

const MainPage = () => {


    return(
       <Fragment>
        <div className="fullscreen-bg">
        <img src={coffeeBanner} alt="Coffee Banner" className="fullscreen-bg__img" />
            <div className="centered-content">
                   <h1 style={{fontFamily: '"Lucida Handwriting"'}}> Cantare</h1>
                    <h5 style={{fontFamily: '"Courier New"'}}>твоя кав'ярня</h5>
        </div>
        </div>
     
       </Fragment>
    )
}

export default MainPage;


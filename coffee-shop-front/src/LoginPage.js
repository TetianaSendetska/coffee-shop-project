import './App.css';
import './Styles.css';
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import {  useAuth  } from './AuthContext';
import { useUserId } from './UserIdContext';
import MainPage from './MainPage.js';
import MenuPage from './MenuPage.js';


function LoginPage() {
 
    const [showRegister, setShowRegister] = useState(false);

      const [isRegistered, setIsRegistered] = useState(false);
      const [name, setName] = useState('');
    const [username, setUsername] = useState('');
    const [phone, setPhone] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [isNameValid, setIsNameValid] = useState(true);
    const [isPasswordValid, setIsPasswordValid] = useState(true);

    const [login, setLogin] = useState('');
    const [logPassword, setLogPassword] = useState('');
    const [error, setError] = useState('');

    const { setUserId } = useUserId();

    const [showShowMain, setShowMain] = useState(true);
    const [showShowMenu, setShowMenu] = useState(false);
    const [showShowLogin, setShowLogin] = useState(false);
   
      const handleRegistration = async () => {
        const currentTime = new Date().toISOString(); 
        var formattedDateTime = new Date(currentTime).toISOString().slice(0, 19);
        if (!isNameValid || !isPasswordValid) {
            alert('Будь ласка, перевірте правильність введених даних.');
            return;
        }

        try {
            const response = await axios.post('https://localhost:44342/api/Client', {
                Name: name,
                Email: email,
                Phone: phone,
                Username: username,
                Password: password,
                CreatedDate: currentTime
            });
            alert("Регістрація успішна")
            setName('');
            setUsername('');
            setPhone('');
            setEmail('');   
            setPassword('');
            setConfirmPassword('');
        } catch (error) {
            console.error('Помилка при відправленні даних на сервер:', error);
            // Тут ви можете додати логіку для обробки помилки від сервера
        }
        // Логіка реєстрації
        setIsRegistered(true);
    };


    const validateName = () => {
        setIsNameValid(!/\d/.test(name));
    };

    const validatePassword = () => {
        setIsPasswordValid(password.length >= 6);
    };

    const { LogIn } = useAuth();


    const handleLogin = async () => {
      if (!login || !logPassword) {
          alert('Будь ласка, заповніть усі поля');
          return;
      }

      if (logPassword.length < 6) {
         alert('Пароль повинен бути більше 6 символів');
          return;
      }

      try {
          const response = await axios.get(`https://localhost:44342/api/Users/username?username=${login}&password=${logPassword}`);
         
          if (response.status === 200) {
            if (response.data.user.role === 1) {
                LogIn(false);
              } else if (response.data.user.role === 2 && response.data.client !== 'undefined') {
                await LogIn(true);
                 setUserId(response.data.client.id)
              }
        } else if (response.status === 404) { 
            setError('Невірний логін або пароль');
            alert(error)
        } else {
            // Опрацювання інших варіантів відповіді
            console.log("Unexpected response:", response.status);
            setError('Помилка під час відправлення запиту');
        }
      } catch (error) {
          console.error('Помилка під час відправлення запиту:', error);
          console.log("Client Resource not found");
          setError('Помилка під час відправлення запиту');
      }
  };

  const setRegistration= () =>{
    setShowRegister(true);
    setShowMain(false);
    setShowLogin(false);
    setShowMenu(false);
  }
  const setLoginPage= () =>{
    setShowRegister(false);
    setShowMain(false);
    setShowLogin(true);
    setShowMenu(false);
  }
  const setMenu= () =>{
    setShowRegister(false);
    setShowMain(false);
    setShowLogin(false);
    setShowMenu(true);
  }
  const setMain= () =>{
    setShowRegister(false);
    setShowMain(true);
    setShowLogin(false);
    setShowMenu(false)
  }

  return (  
    <div className='login'>

        <header>
        <button className='buttons' onClick={() => setMain()}>Головна сторінка</button>
        
            <div>
            <button className='buttons' onClick={() => setMenu()}>Меню</button>
            <button className='buttons' onClick={() => setLoginPage()}>Увійти</button>
            <button className='buttons'onClick={() => setRegistration()}>Зареєструватись</button>
            </div>
        </header>

        {showRegister && (
        <>
  <div className="registration">
        <h2>Registration Page</h2>
            <div>
                <label>Ім'я</label>
                <input type='text' name='name' value={name} onChange={(e) => setName(e.target.value)} onBlur={validateName}></input>
                {!isNameValid && <span className="error-message">Ім'я не може містити цифри</span>}
            </div>
            <div>
                <label>Ім'я користувача</label>
                <input type='text' name='username' value={username} onChange={(e) => setUsername(e.target.value)}></input>
            </div>
            <div>
                <label>Телефон</label>
                <input type='phone' name='phone' value={phone} onChange={(e) => setPhone(e.target.value)}></input>
            </div>
            <div>
                <label>Email</label>
                <input type='email' name='email' value={email} onChange={(e) => setEmail(e.target.value)}></input>
            </div>
            <div>
                <label>Пароль</label>
                <input type='password' name='password' value={password} onChange={(e) => setPassword(e.target.value)} onBlur={validatePassword}></input><br></br>
                {!isPasswordValid && <span className="error-message">Пароль має бути мінімум 6 символів</span>}
            </div>
            <div>
                <label>Повторіть пароль</label>
                <input type='password' name='confirmPassword' value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)}></input>
               
            </div>
            <button className="buttons" onClick={handleRegistration}>Зареєструватись</button>
            </div>
        </>
      )} 
      {showShowLogin && (
        <>
        <h2>Login Page</h2>
        <div>
            <label>Логін  </label>
            <input type='text' value={login} onChange={(e) => setLogin(e.target.value)}></input>
        </div>
        <div>
            <label>Пароль  </label>
            <input type='password' value={logPassword} onChange={(e) => setLogPassword(e.target.value)}></input>
        </div>
        <button className='buttons' onClick={handleLogin}>Увійти</button>
        </>
      )}

{showShowMenu && (
          <>
         
        <MenuPage></MenuPage>
        </>
      )}

        {showShowMain && (
          <>
         
        <MainPage></MainPage>
        </>
      )}
      
    </div>
    
  );
}

export default LoginPage;

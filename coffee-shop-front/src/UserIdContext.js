import React, { createContext, useEffect, useContext, useState } from 'react';


const UserIdContext = createContext();

export const useUserId = () => useContext(UserIdContext);

export const UserIdProvider = ({ children }) => {
  const [userId, setUserId] = useState(() => {
    const storedUserId = localStorage.getItem('userId');
    return storedUserId || null;
  });


  useEffect(() => {
    localStorage.setItem('userId', userId);
  }, [userId]);
  return (
    <UserIdContext.Provider value={{ userId, setUserId }}>
      {children}
    </UserIdContext.Provider> 
  );
};

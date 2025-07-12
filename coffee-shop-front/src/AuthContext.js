import React, { createContext, useState, useContext } from 'react';

const AuthContext = createContext();

export const useAuth = () => useContext(AuthContext);

export const AuthProvider = ({ children }) => {
    const [isAuthenticated, setIsAuthenticated] = useState(false);
    const [isClient, setIsClient] = useState(false);

    const LogIn = async(is) => {

        setIsAuthenticated(true);
        setIsClient(is)
        localStorage.setItem('isAuthenticated', true);
        localStorage.setItem('isClient', is);
    };

    const LogOut = () => {
        setIsAuthenticated(false);
        setIsClient(false);
        localStorage.removeItem('isAuthenticated');
        localStorage.removeItem('isClient');
    };

    return (
        <AuthContext.Provider value={{ isAuthenticated, isClient, LogIn, LogOut }}>
            {children}
        </AuthContext.Provider>
    );
};

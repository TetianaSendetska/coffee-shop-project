import React, {useState, useEffect, Fragment} from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from "axios";
import {ToastContainer, toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './Styles.css';
import Modal from 'react-bootstrap/Modal';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Button from 'react-bootstrap/Button';

const Clients = () => {
const [clientData, setClientData] = useState(true);
const [searchTerm, setSearchTerm] = useState('');
const [showOrders, setShowOrders] = useState(false);
const [show, setShow] = useState(false);
const handleClose = () => setShow(false);
const handleShow = () => setShow(true);


const[name, setName] = useState('');
const[email, setEmail] = useState('');
const[phone, setPhone] = useState('');
const[username, setUsername] = useState('');

const[editName, setEditName] = useState('');
const[editEmail, setEditEmail] = useState('');
const[editPhone, setEditPhone] = useState('');
const[editUsername, setEditUsername] = useState('');

const[editId, setEditId] = useState('');


useEffect(()=>{
    getData();

},[])


const getData= () =>{
    axios.get('https://localhost:44342/api/Client')
    .then((result)=>{
      setClientData(result.data)
    })
    .catch((error)=>{
        console.log(error)
    })
}
const getSortedData = () => {
    axios.get('https://localhost:44342/api/Client/sorted')
    .then((result) => {
        setClientData(result.data);
    })
    .catch((error) => {
        console.log(error);
    });
};

function formatDateTime(dateTime) {
    const options = {
      year: 'numeric', month: '2-digit', day: '2-digit',
      hour: '2-digit', minute: '2-digit', second: '2-digit',
      hour12: false
    };
    return new Date(dateTime).toLocaleString('en-US', options).replace(/,/g, '');
  }


  const clearEmployee=()=>{
    setName('');
    setEmail('');
    setUsername('');
    setPhone('');
    setEditName('');
    setEditEmail('');
    setEditPhone('');
    setEditUsername('');
}
  const handleClientUpdate=()=>{
    const url = `https://localhost:44342/api/Client/${editId}`;
    console.log(editId)
    const data ={
        "id": editId,
        "name": editName,
        "email": editEmail,
        "phone": editPhone,
        
    };
    

    axios.put(url,data)
    .then((result)=>{
        handleClose();
        getData();
        clearEmployee();
        toast.success('Item updated successfully!');
    })
    .catch((error)=>{
        toast.error(error);
        console.log(error)
    })

}
const handleClientEdit = (id)=>{
    handleShow();
    axios.get(`https://localhost:44342/api/Client/id?id=${id}`)
    .then((result)=>{
        setEditName(result.data.name);
        setEditEmail(result.data.email);
        setEditPhone(result.data.phone);
        setEditUsername(result.data.username);
        setEditId(id);
    })
    .catch((error)=>{
        console.log(error)
    })
}
const handleClientDelete = (usernames)=>{
    if(window.confirm("Are you sure to delete this client?") == true)
    {
        console.log(usernames)
        axios.delete(`https://localhost:44342/api/Client/delete/username?username=${usernames}`)
        .then((result)=>{
            if(result.status===204)
            {
                console.log("this");
                console.log(result.data);
                alert.success('CLient deleted successfully!');
                getData();
            }
        })
        .catch((error)=>{
            toast.error(error);
        })
        console.log("end");
    } 
}
  
    return(
       <Fragment> 
        
        <div className="client">


            
        <h3>Клієнти</h3>
        <button className="buttons" onClick={getSortedData}>В алфавітному</button>
          <input
            type="text"
            placeholder="Пошук клієнта"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
/>

        {clientData && clientData.length > 0 ?
        
            
        <table className="responsive-table">
            <thead className="table-header">
                <tr>
                    <th className="col col-1">Ім'я</th>
                    <th className="col col-4">Email</th>
                    <th className="col col-1">Телефон</th>
                    <th className="col col-2">Username</th>
                    <th className="col col-1">Дата приєднання</th>
                    <th className="col col-1">Дії</th>
                
                </tr>
            </thead>
        

            <tbody className="table-row"> 
            {clientData.filter(item => {
                return item.name.toLowerCase().startsWith(searchTerm.toLowerCase());
            }).map((item, index) =>(
                    <tr >
                        <td className="col col-1">{item.name}</td> 
                        <td className="col col-4">{item.email}</td>
                        <td className="col col-1">{item.phone}</td>
                        <td className="col col-2">{item.username? item.username:"-"}</td>
                        <td className="col col-1">{formatDateTime(item.createdDate? item.createdDate:"-")}</td>
                        <td className="col col-1">
                            <button className="btn btn-secondary" onClick={()=>handleClientEdit(item.id)}>Редагувати</button>
                            {/* <button className="btn btn-danger" onClick={()=>handleClientDelete(item.username)}>Видалити</button> */}
                        </td>
                       
                    </tr>
            ))}
                
            </tbody>

        </table>
            
                : (
                    <div>Немає списку клієнтів</div>
                )}

                <Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                <Modal.Title>Редагувати клієнта</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть ім'я" 
                            value={editName} onChange={(e)=>setEditName(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть Email"
                            value={editEmail} onChange={(e)=>setEditEmail(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть телефон" 
                            value={editPhone} onChange={(e)=>setEditPhone(e.target.value)}/>
                        </Col>
                    </Row>
                </Modal.Body>
                <Modal.Footer>
                <Button variant="secondary" onClick={handleClose}>
                    Закрити
                </Button>
                <Button variant="primary" onClick={handleClientUpdate}>
                    Зберегти
                </Button>
                </Modal.Footer>
            </Modal>
    </div>
       </Fragment>
    )
}

export default Clients;


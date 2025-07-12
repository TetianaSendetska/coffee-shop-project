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
const Employees = () => {
const [employeesData, setEmployeesData] = useState(true);
const [searchTerm, setSearchTerm] = useState('');


const [show, setShow] = useState(false);
const handleClose = () => setShow(false);
const handleShow = () => setShow(true);

const [addShow, setAddShow] = useState(false);
const handleAddClose = () => setAddShow(false);
const handleAddShow = () => setAddShow(true);


const[name, setName] = useState('');
const[birthday, setBirthday] = useState('');
const[position, setPosition] = useState('');
const[salary, setSalary] = useState('');

const[editName, setEditName] = useState('');
const[editBirthday, setEditBirthday] = useState('');
const[editPosition, setEditPosition] = useState('');
const[editSalary, setEditSalary] = useState('');
const[editId, setEditId] = useState('');
useEffect(()=>{
    getData();

},[])


const getData= () =>{
    axios.get('https://localhost:44342/api/Employees')
    .then((result)=>{
        setEmployeesData(result.data)
    })
    .catch((error)=>{
        console.log(error)
    })
}
const getSortedData = () => {
    axios.get('https://localhost:44342/api/Employees/sorted')
    .then((result) => {
        setEmployeesData(result.data);
    })
    .catch((error) => {
        console.log(error);
    });
};


const clearEmployee=()=>{
    setName('');
    setBirthday('');
    setPosition('');
    setSalary('');
    setEditName('');
    setEditBirthday('');
    setEditPosition('');
    setEditSalary('');
}
  const handleEmployeeUpdate=()=>{
    const url = `https://localhost:44342/api/Employees/${editId}`;
    console.log(editId)
    const data ={
        "id": editId,
        "name": editName,
        "birthday": editBirthday,
        "position": editPosition,
        "salary": editSalary,
        
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
const handleEmployeeEdit = (id)=>{
    handleShow();
    axios.get(`https://localhost:44342/api/Employees/id?id=${id}`)
    .then((result)=>{
        setEditName(result.data.name);
        setEditBirthday(result.data.birthday);
        setEditPosition(result.data.position);
        setEditSalary(result.data.salary);
        setEditId(id);
    })
    .catch((error)=>{
        console.log(error)
    })
}

const handleEmployeeDelete = (id)=>{
    if(window.confirm("Are you sure to delete this employee?") == true)
    {
        console.log()
        axios.delete(`https://localhost:44342/api/Employees/${id}`)
        .then((result)=>{
            if(result.status===204)
            {
                getData();  
                alert.success('Employee deleted successfully!');
                
            }
        })
        .catch((error)=>{
            toast.error(error);
        })
        console.log("end");
    } 
}

const handleAddEmployee =()=>{
    handleAddShow();
}

const handleEmployeeAdd=()=>{
   
    axios.post(`https://localhost:44342/api/Employees`, {
                name: name,
                birthday: birthday,
                position: position, 
                salary: salary,
            })
            .then((response) => {
                getData();
                clearEmployee();
                alert('Employee added successfully!');
            })
            .catch((error) => {
                console.error('Error adding employee:', error);
            });  
}
    

function formatDateTime(dateTime) {
    const options = {
      year: 'numeric', month: '2-digit', day: '2-digit'
    };
    return new Date(dateTime).toLocaleString('en-US', options).replace(/,/g, '');
  }

    return(
       <Fragment>
        <div className="employees">
        <h3>Працівники</h3>
        <button className="buttons" onClick={getSortedData}>В алфавітному</button>
          <input
            type="text"
            placeholder="Пошук працівника"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            />

        <button className="btn btn-secondary" onClick={()=>handleAddEmployee()}>Додати</button>


        {employeesData && employeesData.length > 0 ?
        
            
        <table  className="responsive-table">
            <thead className="table-header">
                <tr>
                    <th  className="col col-1">Ім'я</th>
                    <th className="col col-1">Дата народження</th>
                    <th className="col col-1">Посада</th>
                    <th className="col col-1">Зарплата</th>
                    <th className="col col-1">Дії</th>
                    
                </tr>
            </thead>
        

            <tbody className="table-row"> 
            {employeesData.filter(item => {
                return item.name.toLowerCase().startsWith(searchTerm.toLowerCase());
            }).map((item, index) =>(
                    <tr >
                        <td  className="col col-1">{item.name}</td> 
                        <td className="col col-1">{formatDateTime(item.birthday)}</td>
                        <td className="col col-1">{item.position}</td>
                        <td className="col col-1">{item.salary}</td>
                        <td className="col col-1">
                            <button className="btn btn-secondary" onClick={()=>handleEmployeeEdit(item.id)}>Редагувати</button>
                            <button className="btn btn-danger" onClick={()=>handleEmployeeDelete(item.id)}>Видалити</button>
                        </td>
                    </tr>
            ))}
                
            </tbody>

        </table>
            
                : (
                    <div>Немає списку працівників</div>
                )}

<Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                <Modal.Title>Редагувати працівника</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть ім'я" 
                            value={editName} onChange={(e)=>setEditName(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="datetime" className="form-control" placeholder="Введіть день народження"
                            value={editBirthday} onChange={(e)=>setEditBirthday(formatDateTime(e.target.value))}/>
                        </Col>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть посаду" 
                            value={editPosition} onChange={(e)=>setEditPosition(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть зарплату" 
                            value={editSalary} onChange={(e)=>setEditSalary(e.target.value)}/>
                        </Col>
                    </Row>
                </Modal.Body>
                <Modal.Footer>
                <Button variant="secondary" onClick={handleClose}>
                    Закрити
                </Button>
                <Button variant="primary" onClick={handleEmployeeUpdate}>
                    Зберегти
                </Button>
                </Modal.Footer>
            </Modal>
            <Modal show={addShow} onHide={handleAddClose}>
                <Modal.Header closeButton>
                <Modal.Title>Додати працівника</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть ім'я" 
                            value={name} onChange={(e)=>setName(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="date" className="form-control" placeholder="Введіть день народження"
                            value={birthday} onChange={(e)=>setBirthday(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть посаду" 
                            value={position} onChange={(e)=>setPosition(e.target.value)}/>
                        </Col>
                        <Col xs={7}>
                            <input type="text" className="form-control" placeholder="Введіть зарплату" 
                            value={salary} onChange={(e)=>setSalary(e.target.value)}/>
                        </Col>
                    </Row>
                </Modal.Body>
                <Modal.Footer>
                <Button variant="secondary" onClick={handleAddClose}>
                    Закрити
                </Button>
                <Button variant="primary" onClick={handleEmployeeAdd}>
                    Зберегти
                </Button>
                </Modal.Footer>
            </Modal>


    </div>
       </Fragment>
    )
}

export default Employees;


import "./App.css";
import React, { useState, useEffect } from 'react';

function App() {
  const [results, setResults] = useState([]);

  useEffect(() => {
    fetch(`http://${process.env.REACT_APP_API_URL}/users/`)
      .then((res => res.json()))
      .then((results => {
        console.log('results from backend', results);
        setResults(results);
      }))
      .catch(console.log);
  }, []);

  return (
    <div className="App">
      <header className="header">Users list - ({results.server_ip ? results.server_ip : "-"})</header>

      <table>
        <thead>
          <tr>
            <th>User Id</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Delete</th>
          </tr>
        </thead>
        <tbody>
          {
            results.users && results.users.length ?
            results.users.map((user, index) => (
                <tr key={index}>
                  <td>{user.user_id}</td>
                  <td>{user.firstname}</td>
                  <td>{user.lastname}</td>
                  <td>{user.age}</td>
                  <td className="delete" onClick={() => onDeleteUserButton(user.user_id)}>x</td>
                </tr>
              ))
              : <tr><td colSpan="5">No users</td></tr>
          }
        </tbody>
      </table>

      <div className="form">
        <h2>Add a new user</h2>
        <input type="text" name="firstname" placeholder="First name" autoComplete="off" />
        <input type="text" name="lastname" placeholder="Last name" autoComplete="off" />
        <input type="text" name="age" placeholder="Age" autoComplete="off" />
        <button type="button">Add user</button>
      </div>
    </div>
  );
}

const onDeleteUserButton = (userId) => {
  console.log(userId);
}

export default App;

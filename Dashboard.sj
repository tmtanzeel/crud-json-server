import { Component } from 'react';
import axios from 'axios';

class Dashboard extends Component {

    constructor(props) {
        super(props);
        this.state = {
            firstname: "",
            lastname: "",
            description: "",
            address: "",
            records: [],
            id: 0
        }
    }

    // will perform READ operation
    componentDidMount() {
        axios.get('http://localhost:4000/records').then((result) => {
            console.log(result);
            this.setState({
                records: result.data
            })
        })
    }

    handleFirstname = (event) => {
        this.setState({
            firstname: event.target.value
        })
        console.log(this.state.firstname);
    }

    handleLastname = (event) => {
        this.setState({
            lastname: event.target.value
        })
        console.log(this.state.firstname);
    }

    handleDescription = (event) => {
        this.setState({
            description: event.target.value
        })
        console.log(this.state.firstname);
    }

    handleAddress = (event) => {
        this.setState({
            address: event.target.value
        })
        console.log(this.state.firstname);
    }

    // will perform CREATE and UPDATE operation
    addRecord = (event, id) => {
        event.preventDefault();

        if (this.state.id === 0) {
            axios.post('http://localhost:4000/records', {
                firstname: this.state.firstname,
                lastname: this.state.lastname,
                description: this.state.description,
                address: this.state.address
            }).then(() => {
                this.componentDidMount()
            })
        } // Actual update functionality
        else {
            axios.put(`http://localhost:4000/records/${id}`, {
                firstname: this.state.firstname,
                lastname: this.state.lastname,
                description: this.state.description,
                address: this.state.address
            }).then(() => {
                this.componentDidMount()
            })
        }
    }

    // will perform DELETE opeartion
    deleteRecord = (event, id) => {
        axios.delete(`http://localhost:4000/records/${id}`).then(() => {
            this.componentDidMount();
        })
    }

    // will get data of an specific record and show it on tbale fields
    updateRecord = (event, id) => {
        axios.get(`http://localhost:4000/records/${id}`).then(result => {
            this.setState({
                firstname: result.data.firstname,
                lastname: result.data.lastname,
                description: result.data.description,
                address: result.data.address,
                id: result.data.id
            })
        })
    }

    render() {
        return (
            <div>
                <form autoComplete="off" onSubmit={(e) => { this.addRecord(e, this.state.id) }}>
                    <div>
                        <label>
                            First name:
                        </label>
                        <input type="text" placeholder="First name" name="firstname" value={this.state.firstname} onChange={this.handleFirstname} required />
                    </div>
                    <div>
                        <label>
                            Last name:
                        </label>
                        <input type="text" placeholder="Last name" name="lastname" value={this.state.lastname} onChange={this.handleLastname} required />
                    </div>
                    <div>
                        <label>
                            Description:
                        </label>
                        <input type="text" placeholder="Description" name="description" value={this.state.description} onChange={this.handleDescription} required />
                    </div>
                    <div>
                        <label>
                            Address:
                        </label>
                        <input type="text" placeholder="Address" name="address" value={this.state.address} onChange={this.handleAddress} required />
                    </div>
                    <input type="submit" className={this.state.id === 0 ? 'btn btn-primary' : 'btn btn-success'} value={this.state.id === 0 ? 'Add' : 'Update'} />
                </form>

                <hr />

                <table className="table table-border table-bordered text-center table-stripped">
                    <thead>
                        <tr>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>Description</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        {
                            this.state.records.map((record, index) => (
                                <tr key={index}>
                                    <td>
                                        {record.firstname}
                                    </td>
                                    <td>
                                        {record.lastname}
                                    </td>
                                    <td>
                                        {record.description}
                                    </td>
                                    <td>
                                        {record.address}
                                    </td>
                                    <td>
                                        <button onClick={(e) => this.deleteRecord(e, record.id)} className="btn btn-danger btn-sm">Delete</button>
                                    </td>
                                    <td>
                                        <button onClick={(e) => this.updateRecord(e, record.id)} className="btn btn-success btn-sm">Update</button>
                                    </td>
                                </tr>
                            ))
                        }
                    </tbody>
                </table>
            </div>
        )
    }
}

export default Dashboard;

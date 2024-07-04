import React, { useState, useEffect } from 'react';
import axios from 'axios';

const api = axios.create({
    baseURL: 'http://localhost:8080/api', // Ensure this is the correct URL
});

const App = () => {
    const [items, setItems] = useState([]);
    const [newItem, setNewItem] = useState({ name: '', description: '' });
    const [editingItem, setEditingItem] = useState(null);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchItems();
    }, []);

    const fetchItems = async () => {
        try {
            const response = await api.get('/items');
            setItems(response.data);
        } catch (error) {
            console.error("There was an error fetching the items!", error);
            setError("There was an error fetching the items!");
        }
    };

    const createItem = async () => {
        try {
            await api.post('/items', newItem);
            fetchItems();
            setNewItem({ name: '', description: '' });
        } catch (error) {
            console.error("There was an error creating the item!", error);
            setError("There was an error creating the item!");
        }
    };

    const updateItem = async (id) => {
        try {
            await api.put(`/items/${id}`, editingItem);
            fetchItems();
            setEditingItem(null);
        } catch (error) {
            console.error("There was an error updating the item!", error);
            setError("There was an error updating the item!");
        }
    };

    const deleteItem = async (id) => {
        try {
            await api.delete(`/items/${id}`);
            fetchItems();
        } catch (error) {
            console.error("There was an error deleting the item!", error);
            setError("There was an error deleting the item!");
        }
    };

    return (
        <div>
            <h1>CRUD App</h1>
            {error && <p style={{ color: 'red' }}>{error}</p>}
            <div>
                <input
                    type="text"
                    placeholder="Name"
                    value={newItem.name}
                    onChange={(e) => setNewItem({ ...newItem, name: e.target.value })}
                />
                <input
                    type="text"
                    placeholder="Description"
                    value={newItem.description}
                    onChange={(e) => setNewItem({ ...newItem, description: e.target.value })}
                />
                <button onClick={createItem}>Add Item</button>
            </div>
            <div>
                {items.map((item) => (
                    <div key={item.id}>
                        {editingItem?.id === item.id ? (
                            <>
                                <input
                                    type="text"
                                    value={editingItem.name}
                                    onChange={(e) => setEditingItem({ ...editingItem, name: e.target.value })}
                                />
                                <input
                                    type="text"
                                    value={editingItem.description}
                                    onChange={(e) => setEditingItem({ ...editingItem, description: e.target.value })}
                                />
                                <button onClick={() => updateItem(item.id)}>Save</button>
                            </>
                        ) : (
                            <>
                                <h3>{item.name}</h3>
                                <p>{item.description}</p>
                                <button onClick={() => setEditingItem(item)}>Edit</button>
                                <button onClick={() => deleteItem(item.id)}>Delete</button>
                            </>
                        )}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default App;

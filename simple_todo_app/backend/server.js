const express = require('express');
const MongoClient = require('mongodb').MongoClient;
const bodyParser = require('body-parser'); 
const app = express();
const bcrypt = require('bcrypt'); // Install bcrypt
const cors = require("cors");
const port = 8000; 
app.use(cors());
const connectionString = 'mongodb+srv://mallesh73:mallesh73@cluster0.iypusal.mongodb.net/'; 

MongoClient.connect(connectionString, { useUnifiedTopology: true })
  .then(async (client) => { // Use async here for await 
    console.log('Connected to MongoDB');
    const db = client.db('user_data');
    const usersCollection = db.collection('users');
    const taskCollection = db.collection('tasks');

    app.post('/signup', bodyParser.json(), async (req, res) => { // Use async 
      try {
        console.log('Received signup request:', req.body);
        console.log('Username from request:', req.body.username); 
        console.log('Password from request:', req.body.password);
        const saltRounds = 10; // Adjust for security vs. performance tradeoff
        const passwordHash = await bcrypt.hash(req.body.password, saltRounds);

        const newUser = {
          username: req.body.username,
          passwordHash: passwordHash 
        };

        const result = await usersCollection.insertOne(newUser);
        console.log('MongoDB insert result:', result); 
        res.send({ success: true });
      } catch (error) {
        console.error('Signup error:', error);
        res.status(500).send({ error: 'Signup failed' }); // Send error on failure
      }
    });
    app.post('/signin', bodyParser.json(), async (req, res) => {
        try {
          const { username, password } = req.body;
      
          const user = await usersCollection.findOne({ username });
          if (!user) {
            return res.status(401).send({ error: 'Invalid username' }); // 401 Unauthorized
          }
      
          const passwordMatch = await bcrypt.compare(password, user.passwordHash); 
          if (!passwordMatch) {
            return res.status(401).send({ error: 'Incorrect password' });
          }
      
          // Successful authentication (In production, use JWT or sessions)
          res.send({ success: true });
        } catch (error) {
          console.error(error);
          res.status(500).send({ error: 'Signin failed' });
        }
      });
      app.post('/tasks', bodyParser.json(), async (req, res) => {
        try {
          // Placeholder for getting the userId
          const userId = req.body.userId; // Replace with actual logic later
      
          const newTask = { 
            taskTitle: req.body.taskTitle,
            priority: req.body.priority,
            userId: userId 
          };
      
          const result = await taskCollection.insertOne(newTask);
          if (result.acknowledged) {
        res.send({ success: true, taskId: result.insertedId }); 
    } else {
        res.status(500).send({ error: 'Failed to add task' }); 
    }
        } catch (error) { 
          console.error(error);
          res.status(500).send({ error: 'Failed to add task' }); 
        }
      });
      
      // Get tasks 
      app.get('/tasks', bodyParser.json(), async (req, res) => {
        try {
          const userId = req.body.userId; // Replace later 
      
          const user = await taskCollection.findOne({ _id: userId }, { projection: { tasks: 1 } });
      
          res.send(user.tasks); 
        } catch (error) { 
          console.error(error);
          res.status(500).send({ error: 'Failed to fetch tasks' });
        }
      });

    app.listen(port, () => console.log(`Server listening on port ${port}`));
  })
  .catch(error => console.error(error)); 

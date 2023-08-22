//console.log("Hello Wold");//print hello world in js

// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
//IMPORT FROM FILES
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
//INIT
const PORT =3000;

const app =express();
const DB = "mongodb+srv://hassan:sharingan2001@cluster0.c6ohw6i.mongodb.net/?retryWrites=true&w=majority"

//middleware(client-> middleware->server -> Client)
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);



//CREATING AN API
// http://<youripaddress>/hello-world

//Creating a GET request giving ajson response with key: value

//app.get("/name",(request,response)=> {
//response.send("hassan");
//response.json({"name":"hassan"});
//});

//GET,PUT,DELETE,POST,UPDATE->CRUD


/// Connections
 mongoose
   .connect(DB)
   .then(() => {
     console.log("Connection Successful");
   })
   .catch((e) => {
     console.log(e);
   });

 app.listen(PORT, "0.0.0.0", () => {
   console.log(`connected at port ${PORT}`);
 });
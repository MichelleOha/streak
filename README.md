# README

Using tutorial video: https://www.youtube.com/watch?v=FJiIvFoxqsc

Create new rails API: (we use the --api because this will not have a frontEnd)
rails new (file name) --api

router.rb is responsible for taking incoming requests and dispatching them to the controller. E.g. Get/payments

Generate Controller: 
rails g controller (file name) index
This is where the requests are handled. Add head: ok to receive a successful 200 response.

rails s (start server) 
localhost:3000/payments

Now to generate a model with 2 fields:

rails g model (file name) amount:decimal description:string

streak/app/models/payment.rb

This also creates a migrate file (streak/db/migrate/20240122025442_create_payments.rb). It describes the table we want to create as well as the fields and the relevant types.

rails db:migrate

SQL creates DB on our local to create the desired table.

How do these migrations run and where is the DB? Every new Rails app comes pre-configured with SQL Lite (a development.sqlite3 in-build (streak/db/development.sqlite3))  

Now we will update controller to give us a list of payments: 

render json object which is the payment class

start the server:

rails s

open a new terminal and open console:

bin/rails c

add some payments to our table with:

Payment.create!( description: 'coffee', amount: 5)

exit console by typing:

exit

run command:

curl http:/localhost:3000/payment -v

And you can see at the bottom 2 new objects have been created with an id.

(insert screen shot)

We are able to list payments but not create them so let's create an endpoint now POST/payments:

go to routes.rb file and update the existing resource to include create. To find the routes that are available, in your terminal:

rails routes | grep payments

insert screenshot 

remove get 'payments/index' from routes.rb.

Jump back over to the controller file, we need to create a method action.

Using the Payment class we put create on it and inside the method body we can hard code the values. 

Payment.create!(amount: 5, description: 'coffee")

Instead of hard coding the values we can use params, we can think of them as a magic object which Rails populates for us:

Payment.create!(amount: params[:amount], params[:description])

This works if we make a request to POST payments no, it would create a record using the params which we have specified. However this doesn't handle failer very well, if params are incorrect it will raise an exception returning an error to the user.

So we need to change the payment call to an initalize only with .new instead of .create!
Then we will attempt to save payments using an if block and we need to save the object into a holder variable:

payment = Payment.new(amount: params[:amount], description: params[:description])

If payment is saved successfully, then we will render a response 

render json: payment

we are asking rails to return in the json body render out the payment itself and I'll give it a status of created. This created is a HTTP status code so rails will read this and give it the correct HTTP status code. 
Else case if the save is unsuccessful then we will render the errors message. Rails will automatically render errors on an object is you try and populate it and it fails. For the status we will use this time error status so we'll say unprocessable_entity (422)

One last thing to improve with this code, and that is pulling the values directly out of the params hash works,
but the syntax is outdated, and it doesn't work well for large objects. So if this object payment becomes too large we have to remember each time to pull out the field that we want and this line's going to get very long instead it's recommended doing a mass update and using strong params which means we can replace the params with a new method called payment_params. Then we create a private method called payment_params and add the params and values:

 (amount: params[:amount], description: params[:description])

 And we use rails syntax where we describe the object structure correctly. So it must be a payment object at the top level and inside that we can .permit the specific params we want:

 params.require(:payment).permit(:amount, :description)

 Now when an object is posted to our Rails browser application we check that there is a payment object and we permit these two fields build amount :amount, :description.

 Let's test it with a post request to the server in postman with using:

 http://localhost:3000/payments

 add an amount and a string description, status 201 created should be received:

 insert screenshot

* Challenges:
Whilst creating the API, the rails s and other commands weren't working. . . After researching it, I realised I wasn't in the streak directory instead trying to run the commands from Streak_1. Easy fix!

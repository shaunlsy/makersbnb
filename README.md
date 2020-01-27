# Makersbnb
----------

## Overview

Makers Acadamy group project to make an AirBnb Clone


### Team

Asia Ellis
Chris Wood
Shaun Low
Vish Mayer


### Application Overview

- Sinatra based server
- PSQL database accessed through 'pg' gem
- JavaScript front end (jQuery)



## Customer Requirements

### User Stories


#### **Must haves**

##### General Site Features

```
As a user
So that I can rent out a property
I want to be able to list a space
```
```
As a user
So that I can provide an accurate representation of my space
I want to be able to the following to my listing: Name, short description, price per night
```
```
As a user
So that I can manage my letting
I want to be able to select a range of dates where the space is available
```
```
As a user
So that I can rent a space
I want to be able to see all the listed spaces
```
```
As a user
So that I see spaces available over my selected dates
I want to be able to filter spaces by date and duration of stay
```
```
As a user
So that I see when a space is available
I want to be able see all available dates for a specific space
```
```
As a user
So that book a space over a date
I want to be able to request a booking
```
```
As a user
So that I approve lettings
I want to be notified and confirm when a user requests to let my space
```

##### Login / Signup

```
As a user
So I can use the site
I want to be able to sign up
```
```
As a user
So that I can access my account
I want to be able to login
```


#### **Desirable Requirements**

##### Emails

```
As a user
So I know that I've signed up
I want an email confirmation that I've signed up
```
```
As a user
So I know that I've created a space
I want an email confirmation that I've created a space
```
```
As a user
So I know that I've updated my space
I want an email confirmation that I've updated my space
```
```
As a user
So I know that I've made a booking request
I want an email notifying me of the request
```
```
As a user
So I know that I've received a booking request
I want an email notifying me of the request, with a link to confirm or deny
```
```
As a user
So I know that my booking request has been confirmed
I want an email confirmation that my booking secure
```
```
As a user
So I know that my booking request has denied
I want an email confirmation that my booking is rejected
```

##### Text Messages

```
As a user
So I know that I've recieved a booking request on the fly
I want to recieve a text message notifying me of the request
```
```
As a user
So I know that my booking request has been confirmed on the fly
I want an text confirmation that my booking secure
```
```
As a user
So I know that my booking request has been denied on the fly
I want an text confirmation that my booking is rejected
```

##### Chat Functionality

```
As a user
So that I can talk to my client or space owner
I want to be able to create a chat with them online
```
```
As a user
So that I know what I've said to a client or space owner
I want to be able to be able to see previous chat history
```
```
As a user
So that I can chat to a client
I want a online chat to be automatically made after a booking is confirmed
```

##### Payments

```
As a user
So that I can pay for a listing after confirmation
I want to be able to pay through Stripe
```

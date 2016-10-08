# Dove | Payments brought offline to users <img src="/assets/images/dove-and-cross-clipart-diraa694T.png" width="60px">

Dove is **an offline payment service**, built on the top of [PayTM APIs](http://paywithpaytm.com/developer/), which can be used on any mobile device (including legacy mobile devices which don't even have a GUI or provisions for internet connectivity) without installing any additional application.

We intended to target the demographics who don't  own a smartphone or have proper internet access, staying true to "Building for India", the hackathon's theme.

Our efforts also highlighted a way for PayTM to increase their user-base.

This was possible due to SMS capabilities in every mobile device, hence we hacked on that to make and receive payments easily using a simple keyword **dove**.

We built this using :
* [Sinatra](http://www.sinatrarb.com/), Web framework for Ruby.
* [Redis](http://redis.io/), In-memory key-value data store.

We also used the following to imitate an SMS gateway :
* [Twilio](https://www.twilio.com/), cloud platform providing SMS APIs for text-messaging.
* A mobile application to route text-messages to a web-server.

## Current Scope

### Register User
 + Since registering a new user (unique : mobile number) is a 2-step process on PayTM, we implemented a similar logic.
 + User can simply initiate the registration process by sending the following text to a **PayTM dedicated number**

```vim
dove (reg | registration) <email>
```
 + Doing this results in the user receiving a SMS with  an OTP. He/She needs to send this to the dedicated number in the following format.

```vim
dove validate <OTP>
```

Hooray! You successfully registered at PayTM (if you hadn't) and our service as well.

### Check Available Balance
```vim
dove (bal | balance)
```

### Send / Pay Money to another number
```vim
dove (send | pay)  <payee number> <amount>
```

## Impact

According to a [ survey](http://www.thehindu.com/news/national/about-70-per-cent-indians-live-in-rural-areas-census-report/article2230211.ece) conducted by The Hindu in 2011, around 83.3 crore people still live in Rural India. In another [survey](http://www.livemint.com/Consumer/yT14OgtSC7dyywWSynWOKN/Only-17-Indians-own-smartphones-survey.html) by LiveMint, only 45% people in India owned a smartphone in 2013.

It seems we have created a possible user-base of around 83.3 crore people for PayTM. :v:

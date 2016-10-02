# Dove | Payments brought offline to users

According to [a survey](http://www.thehindu.com/news/national/about-70-per-cent-indians-live-in-rural-areas-census-report/article2230211.ece) conducted by The Hindu in 2011, around 83.3 crore people still live in Rural India. Another [survey](http://www.livemint.com/Consumer/yT14OgtSC7dyywWSynWOKN/Only-17-Indians-own-smartphones-survey.html) by LiveMint, only 45% people in India owned a smartphone in 2013. 

Seeing a large market opportunity there, Dove targets the majority population who doesn't have a smart phone or proper internet access. Dove using SMS services to make and recieve payments easily using a simple keyword **dove**.

## Commands Available

### Register User
 + Since registering a new user (unique : mobile number) is a 2-step process on PayTM, we implement similar logic.
 + User can simply iniciate the registration process by sending the following text to **PayTM dedicated number**

```vim
dove reg | registration <email>
```
 + Then user recieves an SMS with OTP, he needs to send this to the name number in following format.

```vim
dove validate <OTP>
```

### Check Available Balance
```vim
dove bal | balance
```
 
### Send / Pay Money to another number
```vim
dove send | pay  <payee number> <amount>
```

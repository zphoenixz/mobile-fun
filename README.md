# Mobile Fun

This is a Multiplatform App that fetches data from **https://jsonplaceholder.typicode.com/** API, it targets Android using Material design and the same for iOS with Cupertino library.

#### Design Features
* List view for the *POSTS* data from the API
* Post Interactions, *Seen, Favorite, Refresh and Delete*.
* *Post Details* for each post.
* *Comments view* for each Post's comments.
* Although it will work relative well on most Device views, atm this is intended for *Mobile Portrait View size*. 

#### Technical Features
* *MVC Provider pattern,* with providers as controllers.
* Hibrid design for *iOS and Android*.
* *Cache management,* Posts are managed in cache once they are downloaded and until the user force a refresh.
* *Flutter Version 3.0.1*
* *Dart Version 3.40.0*
* Tested on Debug only
* Supports *iOS 14+, Android API 24+*

#### Packages
* **provider: 6.0.3**\
&ensp;Used for the state management.
* **bot_toast: 4.0.2**\
&ensp;Used to show some feedback for succesful requests.
* **http: 0.13.4**\
&ensp;Used for the HTTP request service layer, this is in charge of getting the data from the API
* **get_storage: 2.0.3**\
&ensp;This is being used as cache manager for the necessary data that is being cached.

## Running
1. Get the repo
```
git clone git@github.com:zphoenixz/mobile-fun.git
```
2. Go to the repo folder
```
cd mobile_fun
```
3. Get the packages
```
flutter pub get
```
4. Start preferred mobile emulator
```
Use sdk debug run
```
## My comments
The pattern is well (not perfect) developed, you can see all the BL correctly ordered on models, services, providers, the way they interact if like this:
* Views asks for models to the Providers, the Providers act as Controllers and Talk to the services to get them the model thats being required, the services fetch an retreive the required model (if succesful) and give it back to the Providers which updated (if necessary) the widget sub-tree.

* For Android, iOS view factories, I'm using a simple provider that informs to the the tree on which platform is being used and the tree acts in consecuence by building a different set of views. 

Use these project as a fun starter. Plenty of improvements can be donde, some of them are related on the widget heriarchy used, it can be improved, also there some Material feedback being shown on IOS devices.


## License
[MIT](https://choosealicense.com/licenses/mit/)
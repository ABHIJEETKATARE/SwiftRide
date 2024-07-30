# internshala_assignment

A new Flutter project.

## Running Locally
After cloning this repository, migrate to ```
internshala_assignment
``` folder. Then, follow the following steps:
- Create MongoDB Project & Cluster
- Click on Connect, follow the process where you will get the uri.- Replace the MongoDB uri with yours in ```server/index.js```.
- Head to ```lib\global_data\customization_data\customizing_data.dart``` file, replace <yourip> with your IP Address. 
- Enable  ```Go to -https://developers.google.com/maps- Create a new project then enable apis inclucing Maps SDK for Android , Maps SDK for iOS and  Places API .```
-now copy your ```API key``` from googe map platform which can be found under ```credentials section```
-Head to ```android\app\src\main\AndroidManifest.xml``` file,replace <yourip> with your ```GoogleMaps API Key``` copied above.
-Head to ```internshala_assignment\ios\Runner\AppDelegate.swift``` file,replace <yourGoogleAPI> with your ```GoogleMaps API Key``` copied above.
-Head to ```internshala_assignment\lib\features\SearchDestination\search_screen.dart``` file,replace <yourGoogleAPI> with your ```GoogleMaps API Key``` copied above.
Then run the following commands to run your app:

### Server Side
```bash
  cd server
  npm install
  npm run dev (for continuous development)
  OR
  npm start (to run script 1 time)
```

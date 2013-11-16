lunarhaxor-png-data
===================

data backend for medical records


prerequisites
=============

node
npm
mongodb
foreman (part of the heroku dev toolkit)


setup after cloning
===================

npm install


to run in dev
=============

foreman start -f Procfile.dev -p 1337


adding dependencies
===================

npm install <package name> --save
npm shrinkwrap

make sure you include the changes to package.json and npm-shrinkwrap.json in the commit




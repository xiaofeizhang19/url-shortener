# Url Shortener Code Test

## Introduction

This project is a single-page application providing url shortening service. It has been built with Ruby/Sinatra as the backend and React as the frontend. Sinatra was chosen as it provides a lightweight framework ideal for the scale of the application.

There is no external database. The URLs do not persist between restarts, but are shareable between different clients while the server is running.

## Set up

- Clone the repository

### Backend

- Navigate to the ```backend``` folder
- Install Ruby denpendencies: ```bundle install```
- Start the server: ```rackup -p4567```

### Frontend

- Navigate to the ```frontend``` folder
- Install JS denpendencies:   
```
npm install
```
or   
```
brew install yarn
yarn install
```
- Start server:
```
npm start
```
or
```
yarn start
```
- Visit ```http://localhost:3000``` to use the app.

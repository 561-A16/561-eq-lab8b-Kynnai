#!bin/bash
set -ev
dotnet restore
dotnet test ./webapp.unitests
rm -rf $HOME/publish/*
dotnet publish ./webapp --configuration release --output $HOME/publish
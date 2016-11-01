#!bin/bash
set -ev
dotnet restore
dotnet test ./webapp.unittests
#rm -rf $PWD/publish/*
dotnet publish ./webapp --configuration release --output $HOME/publish

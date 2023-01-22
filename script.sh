#!/bin/bash

echo "-------------------------------------------------------------"
read -p "Enter the name of network you want to create with:-> " net
echo "-------------------------------------------------------------"
docker network create --driver bridge $net
echo "-------------------------------------------------------------"
echo "*************** $net:-> Network Is Created. ********************"
echo "-------------------------------------------------------------"
echo "FROM ubuntu" >> Dockerfile
echo "RUN apt-get -y update && apt-get -y install python3" >> Dockerfile
echo "-------------------------------------------------------------"
read -p "Enter the name of image you want to build :->" img
echo "-------------------------------------------------------------"
docker build -t $img .
echo "-------------------------------------------------------------"
echo "*************** Image Build Successfully ********************"
echo "-------------------------------------------------------------"
read -p " Enter the name of container you want to run:-> " con
echo "-------------------------------------------------------------"
docker run -dt --name $con --net $net $img
echo "************* Container Running Successfully ****************"
echo "-------------------------------------------------------------"
read -p "Enter the name of image you want to save container with:->" up_img
echo "--------------------------------------------------------------"
docker commit $con $up_img
echo "************* $up_img:-> Image Saved Successfully ************"
echo "--------------------------------------------------------------"
docker login
docker tag $img simr1kaur/my_network_demo
docker push simr1kaur/my_network_demo
docker logout
truncate -s 0 Dockerfile
echo "--------------------------------------------------------------"
echo "**********Image Pushed Into DockerHub Successfully************"
echo "--------------------------------------------------------------"
echo "************************DONE**********************************"
echo "--------------------------------------------------------------"

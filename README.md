# Whiptail
A DAO for forecasting that harnesses the wisdom of the crowd

brownie_project contains the core commit reveal smart contract where one can submit questions and answers

scaffold-eth is a full example dapp that we should be able to modify with our own contract(s) and front end


### Overview

A well documented fact within the field of forecasting (see the book - Superforecasting: The Art and Science of Prediction) is that the average of a group of forecasters' predictions is, over a long enough time-frame, better than any individual's set of forecasts. The principal cause of this is that forecasters are human and therefore sometimes make mistakes or do not use all the information availble to them. The process of averaging out the forecasts will reduce the affect of any single mistakes leading to a more accurate and robust forecast. 

We therefore propose a forecasting DAO to take advantage of this fact which would work as follows: A group of forecasters all create forecasts for an event and send them to a smart contract. The overall forecast would be the average of all the individuals forecasts. This forecast could then be used to make money in prediction markets or sold off to 3rd parties such as hedge funds, profits would then be distributed to the forecasters through another smart contract. 

To ensure that the forecasters in the DAO are all high quality, we needed a way to test their ability in an on-chain trustless manner. We therefore prepose a forecasting reputation score that is associated with your ethereum address which you can build up over time. We can create a cut off of a reputation score of at least X in order to qualify for the forecasting DAO. 

To allow people to build up their scores, we prepose a series of prediction competitions which users predict various events that will occur in the future and recieve positive or negative points depending on how close they are to the true answer when the event occurs. This will be done through a commit reveal smart contract that works as follows: 
1. f;wkf;
2. 




This idea is motivated by the site Metaculus which does a similar thing but has no way to monetize or keep the data private:
https://www.metaculus.com/questions/

Also the decentralized hedge fund numerai:
https://numer.ai/


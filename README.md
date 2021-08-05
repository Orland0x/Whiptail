# Whiptail
A DAO for forecasting that harnesses the wisdom of the crowd

brownie_project contains the core commit reveal smart contract where one can submit questions and answers

scaffold-eth is a full example dapp that we should be able to modify with our own contract(s) and front end


### Overview

A well documented fact within the field of forecasting (see the book - Superforecasting: The Art and Science of Prediction) is that the average of a group of forecasters' predictions is, over a long enough time-frame, better than any individual's set of forecasts. The principal cause of this is that forecasters are human and therefore sometimes make mistakes or do not use all the information availble to them. The process of averaging out the forecasts will reduce the affect of any single mistakes leading to a more accurate and robust forecast. 

We therefore propose a forecasting DAO to take advantage of this fact which would work as follows: A group of forecasters all create forecasts for an event and send them to a smart contract. The overall forecast would be the average of all the individuals forecasts. This forecast could then be used to make money in prediction markets or sold off to 3rd parties such as hedge funds, profits would then be distributed to the forecasters through another smart contract. 

### Motivation and Philosophy 

We believe that the true value of forecasting goes far beyond point estimates of events. In fact the most value lies in the full distribution (more specifically, a posterior distribution - for the bayesian inclined readers) over event outcomes and not just point prediction that represents the single most likely outcome (which would be the modal value of the curve). An example shown below is from the forecast aggregation site Metaculus for predicting the gas price 1 week after the heavily anticipted Ethereum update EIP-1559. 

![alt text](https://github.com/orlandothefraser/Whiptail/blob/main/media/metaculusgaspred.png)

A modal value of about 30 gwei is predicted by the forecasters but what is more interesting is the long tail on the right of the distribution. This shows that the forecasters assign non-negligible probabilities to gas prices that are far from the point prediction of 30.  This tail information is in many contexts far more valuable than the peak. For example, if you are a protocol that has smart contracts which depend on the gas price remaining below 100, having an estimate on the likelihood of it exceeding 100 would be immensely valuable to you.

Our goal with Whiptail is to create a decentralized forecasting engine that can provide robust and on demand forecasts in a wide range of different domains. We beleive there would be interest in these forecasts from various organizations including hedge funds, bookies, governments, and even other DAOs!. 


### Reputation Score Accumulation 

To ensure that the forecasters in the DAO are all high quality, we needed a way to test their ability in an on-chain trustless manner. We therefore prepose a forecasting reputation score that is associated with your ethereum address which you can build up over time. We can create a cut off of a reputation score of at least X in order to qualify for the forecasting DAO. 

To allow people to build up their scores, we prepose a series of prediction competitions which users predict various events that will occur in the future and recieve positive or negative points depending on how close they are to the true answer when the event occurs. This will be done through a commit reveal smart contract that works as follows: 
1. A question is submitted by the smart contract owners (the Whiptail team). Eg "How many new UK covid cases will the UK government declare on the 17th August."  The creator will also specify a commit period where all hash commits must take place, a reveal period where all reveals must take place, and finally a range for the prediction that will cover the expected range of the answer.  
2. Users will generate hashes of their predictions along with blinding factors and commit it to the smart contract during the commit window.
3. Users will send their predictions and blinding factors to the contract during the reveal window and the hash will be performed on chain to prove that it is identical to their commit.
4. Once the event in question has occured, the contract owner will submit the true answer to the contract, allowing a score to be calculated for each user.

As a team we will continually post competition questions, therefore allowing users to slowly build up (or destroy!) their reputation. Over a long enough time period, we believe that this should be an effective system for differentiating good forecasters from average ones. The chance of qualifying for the paid forecasting team would be a strong motivator in itself for entering these competitions, however we have considered extra incentives like prizes that are paid from the DAO treasury - somewhat like a football team investing in young talent.  


### Notes

This idea is motivated by the site Metaculus which does a similar thing but has no way to monetize or keep the data private:
https://www.metaculus.com/questions/

Also the decentralized hedge fund numerai:
https://numer.ai/


# Whiptail
A DAO for forecasting that harnesses the wisdom of the crowd. 

The Brownie development was used for the creation and testing of the smart contracts used in the project. The contracts have been deployed to Ropsten test net and reside at the following locations: 

PredictionSubmission.sol: 0xa505E0D24Ef6d65cD57ad1c6Bb17EBd3547934Fe //
ReputationScore.sol: 0x825477C09DD57bb72298c3161B26eA577B2D0EDe 



### Overview

A well documented fact within the field of forecasting (see the book - Superforecasting: The Art and Science of Prediction) is that the average of a group of forecasters' predictions is, over a long enough time-frame, better than any individual's set of forecasts. The principal cause of this is that forecasters are human and therefore sometimes make mistakes or do not use all the information availble to them. The process of averaging out the forecasts will reduce the affect of any single mistakes leading to a more accurate and robust forecast. 

We therefore propose a forecasting DAO to take advantage of this fact which would work as follows: A group of forecasters all create forecasts for an event and send them to a smart contract. The overall forecast would be the average of all the individuals forecasts. This forecast could then be used to make money in prediction markets or sold off to 3rd parties such as hedge funds, profits would then be distributed to the forecasters through another smart contract. 

A well documented fact within the field of forecasting is that the average of a group of forecasters' predictions is, over a long enough time-frame, better than any individual's set of forecasts. This is because each forecaster will apply a slightly different mental model when attempting to create the forecast and will therefore assign different likelihoods for the same outcome. The process of averaging out the forecasts will reduce the effect of mistakes in any single forecasters model leading to a more accurate and robust forecast. We belive that a forecasting DAO would be affective at taking advantage of this fact, allowing coordination of a geographically separated group of people in a  decentralized and trustless manner. 

### Motivation and Philosophy 

We believe that the true value of forecasting goes far beyond point estimates of events. In fact the most value lies in the full distribution (more specifically, a posterior distribution - for the bayesian inclined readers) over event outcomes and not just point prediction that represents the single most likely outcome (which would be the modal value of the curve). An example shown below is from the forecast aggregation site Metaculus for predicting the gas price 1 week after the heavily anticipted Ethereum update EIP-1559. 

![alt text](https://github.com/orlandothefraser/Whiptail/blob/main/media/metaculusgaspred.png)

A modal value of about 30 gwei is predicted by the forecasters but what is more interesting is the long tail on the right of the distribution. This shows that the forecasters assign non-negligible probabilities to gas prices that are far from the point prediction of 30.  This tail information is in many contexts far more valuable than the peak. For example, if you are a protocol that has smart contracts which depend on the gas price remaining below 100, having an estimate on the likelihood of it exceeding 100 would be immensely valuable to you.

Our goal with Whiptail is to create a decentralized forecasting engine that can provide robust and on demand forecasts in a wide range of different domains. Metaculus has no way to keep the forecasts private and also no way to monetized them. As we shall explain, Whiptail DAO solves both of those problems in a decentralized and trustless manner. We believe there would be interest in these forecasts from various organizations including hedge funds, bookies, governments, and even other DAOs. Additionally, the information could be used to trade in prediction markets directly to make profit for the DAO, however this would require an in house trading team and would therefore be significantly more difficult to set up initially. Note that our name Whiptail comes from the Whiptail shark which has a tail that looks something like the distribution shown if you tilt your head a bit! 


### Forecast Submission Mechanism

If the forecasts produced by the DAO were public then there would be a free-rider problem that would emerge, as why would an organization pay for a forecast if they can just get someone else to pay and then just extract the forecast from the smart contract anyway. Additionally, some organisations, particularly hedge funds, would like to keep the information private as it is valuable IP for them.

We therefore prepose a private submission mechanism that utilizes Public-key Cryptography. It will work as follows: 
1. A public and private key pair is generated off chain.
2. The public key is sent on chain and the private key is sent to the buyer of the forecast off chain.
3. All forecasters that are participating will encrypt their forecast using the public key and then send the encrypted message on chain. 
4. Once all encrypted forecasts are in, the buyer can then take them all of chain and decrypt them using the private key. 
5. The averaging operation can then occur off chain by the buyer to produce the overall forecast in a private yet trustless way. Note this also allows the buyer to aggregate the distributions in whatever way they choose. The buyer could decide to weight the average by the reputation score of each forecaster for example. 

The forecasts produced by the DAO may be for events long into to future and therefore the DAO would require payement before the event has occured. For this reason the payment to the forecasters cannot be a function of their forecast accuracy. However the buyer would still need confidence that the forecasts they paid for are high quality. This leads us to the concept of a reputation score for forecasters. 
 

### Reputation Accumulation 

To ensure that the forecasters in the DAO are all high quality, we needed a way to test their ability in an on-chain trustless manner. We therefore prepose a forecasting reputation score that is associated with your ethereum address which you can build up over time. We can create a cut-off reputation score of at least X in order to qualify for the forecasting DAO where members are paid for their forecasts. Note that this can be varied and is fully up to the desires of the buyer.

To allow people to build up their scores, we prepose a series of prediction competitions where users predict various events that will occur in the future and recieve positive or negative points depending on how close they are to the true answer when the event occurs. This will be done through a commit reveal smart contract that works as follows: 
1. A question is submitted by the smart contract owners (the Whiptail team). Eg "How many new UK covid cases will the UK government declare on the 17th August."  The creator will also specify a commit period where all hash commits must take place, a reveal period where all reveals must take place, and finally a range for the prediction that will cover the expected range of the answer.  
2. Users will generate hashes of their predictions along with blinding factors and commit it to the smart contract during the commit window.
3. Users will send their predictions and blinding factors to the contract during the reveal window and the hash will be performed on chain to prove that it is identical to their commit.
4. Once the event in question has occured, the contract owner will submit the true answer to the contract, allowing a score to be calculated for each user.

As a team we will continually post competition questions, therefore allowing users to slowly build up (or destroy!) their reputation. Our scoring algorithm will be weakly negative sum which, over a long enough time period, should be an effective system for differentiating good forecasters from average ones. The chance of qualifying for the paid forecasting team would be a strong motivator in itself for entering these competitions, however we have considered extra incentives like prizes that are paid from the DAO treasury - somewhat like a football team investing in young talent. The core idea here is to use verifiable events to find people that are strong at forecasting un-verifiable events and record this through an on chain score.

### Reputation Score ALgorithm 

The gain in reputation that one should gain for a good prediction should be a function of both the difficulty of the prediction and the quality of the prediction. A good measure of the difficulty of prediction is he average distance of all entrants from the true answer. For the quality of a specific prediction, some function of the distance of the prediction from the true answer. The functional family plotted below is one possible option here that can be adjisted to fit the requirements specified above. 
![alt text](https://github.com/orlandothefraser/Whiptail/blob/main/media/predictionCurve.png)

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}) 


$ \sum_{\forall i}{x_i^{2}} $


### Governance Token 

In order to transition to a proper DAO with decentralized governance, we will likely eventually need a token. The reputation score could potentially work something like a token stake, but that does not necessarily align incentives optimally. The emissions for this token could occur through doing well in the DAOs prediction competitions -  Prediction mining if you like. This token could then be used to vote and also accrue some value from profits made by the DAO (eg 70% of profits from selling forecasts go to the forecasters while 30% is used to perform buybacks of the token). 


### Notes

This idea is motivated by the site Metaculus which does a similar thing but has no way to monetize or keep the data private:
https://www.metaculus.com/questions/

Also the decentralized hedge fund numerai:
https://numer.ai/


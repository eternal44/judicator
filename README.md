# README
modules
https://www.rubytapas.com/2013/01/18/episode-048-memoize/

### Description:
This is a POC Rails API for comparing SFRs (Single Family Residents) to
evaluate their long term value as an investment property. My goals for
picking a property keep shifting so I've decided to pause development
on this project until I solidify my goals.

Click here for the DB schema ([diagram](https://github.com/eternal44/judicator/blob/master/judicator.pdf))


### Conventions:
- All money figures are in cents unless stated otherwise
- All interest figures are represented the way you'd say them
  ex:  4.5 percent is represented as 4.5 (not 0.045)

### Resources:
- compound interest ([calculator](https://www.thecalculatorsite.com/articles/finance/compound-interest-formula.php))
- bi-weekly payments ([calculator](https://www.mortgagecalculator.biz/c/additional-payments.php))

### TODO:
- figure out bi-weekly payment formula
- figure out how we want to use this model
- figure out how to forecast earnings for the following:
  appreciation
  vacancies
  building depreciation
  maintenance costs
  scheduled replacements


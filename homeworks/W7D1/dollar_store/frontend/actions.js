import { SWITCH_CURRENCY } from './constants';

const selectCurrency = (baseCurrency, rates) => {
  return {
    type: SWITCH_CURRENCY,
    baseCurrency,
    rates
  };
};

export default selectCurrency;

window.selectCurrency = selectCurrency;

import { SWITCH_CURRENCY } from './constants';

const initialState = {
  baseCurrency: 'Please select',
  rates: {}
};

const reducer = (state = initialState, action) => {
  Object.freeze(state);
  switch (action.type) {
    case 'SWITCH_CURRENCY':
      const newState = {
        baseCurrency: action.baseCurrency,
        rates: action.rates
      };

      return newState;
    default:
      return state;
  }
};

export default reducer;

window.reducer = reducer;

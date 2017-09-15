import { createStore, applyMiddleware } from "redux";
import rootReducer from "../reducers/root_reducer";

import thunk from "../middleware/thunk";
import logger from "redux-logger";

const configureStore = () =>
  createStore(rootReducer, applyMiddleware(thunk, logger));

export default configureStore;
